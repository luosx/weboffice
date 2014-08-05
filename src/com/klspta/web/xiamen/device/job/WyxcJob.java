package com.klspta.web.xiamen.device.job;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobHandler;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.wkt.Linestring;

/**
 * 
 * <br>Title:外业巡查轨迹处理
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014年4月28日
 */
public class WyxcJob extends AbstractBaseBean implements Job {
    private int srid;

    private SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public WyxcJob() {
        String sqlString = "select t.srid from sde.st_geometry_columns t where t.table_name='DEVICE_TRACK'";
        List<Map<String, Object>> list = query(sqlString, GIS);
        if (list.size() > 0) {
            srid = ((BigDecimal) list.get(0).get("srid")).intValue();
        }
    }

    @Override
    public void execute(JobExecutionContext arg0) throws JobExecutionException {
//        System.out.println("开始生成外业巡查轨迹路线, 现在是: " + s.format(Calendar.getInstance().getTime()));
        //获取指定时间段内 有坐标的设备
        String sqlString = "select distinct(t.gps_id) from gps_location_log t where t.send_time between (sysdate - 1/24) and sysdate";
        List<Map<String, Object>> list = query(sqlString, YW);
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                String bh = (String) list.get(i).get("GPS_ID");
                addToMap(bh);
            }
        }
        Calendar calendar = Calendar.getInstance();
//        System.out.println("完成外业轨迹生成操作, 现在是: " + s.format(calendar.getTime()));
    }

    /**
     * 
     * <br>Description:轨迹上图
     * <br>Author:陈强峰
     * <br>Date:2014年4月28日
     * @return
     */
    private void addToMap(String bh) {
        String sqlString = "select t.gps_id,t.gps_x,t.gps_y,t.send_time,to_char(t.send_time,'yyyy') nian,to_char(t.send_time,'MM') yue,to_char(t.send_time, 'dd' ) ri,to_char(t.send_time,'hh24') xiaoshi  from gps_location_log t where t.gps_id = ? and t.send_time between (sysdate - 1/24) and sysdate";
        // 根据编号 获取坐标构建wkt
        List<Map<String, Object>> list = query(sqlString, YW, new Object[] { bh });
        if (list.size() > 1) {                                                                          //大于两个点可以进行上图
            Linestring lineString = new Linestring();
            Map<String, Object> map = null;
            Timestamp beginDate = null;
            Timestamp endDate = null;
            int listSize = list.size();
            beginDate = (Timestamp) list.get(0).get("send_time");
            endDate = (Timestamp) list.get(listSize - 1).get("send_time");
            for (int i = 0; i < listSize; i++) {
                map = list.get(i);
                lineString.putPoint(map.get("gps_x").toString(), map.get("gps_y").toString());
                //System.out.println(i);
            }
            //得到行政区代码
            String sqlXzq = "select t.gps_cantoncode from gps_info t where t.gps_id = ?";
            List<Map<String, Object>> listXzq = query(sqlXzq, YW, new Object[] { bh });
            String xzqString = (String)listXzq.get(0).get("gps_cantoncode");
            String wktString = lineString.toWKT();
            String year = map.get("nian").toString();
            String month = map.get("yue").toString();
            String day = map.get("ri").toString();
            String hour = map.get("xiaoshi").toString();
            //上图信息包括 编号  设备名  以及   轨迹时间 年 月 日  时
            sqlString = "call GJSAVE(?,?,?,?,?,?,?,?)";
            
            InsertToSDEBean bean = new InsertToSDEBean();
            bean.setSqlString(sqlString);
            bean.setBh(bh);
            bean.setYear(year);
            bean.setMonth(month);
            bean.setDay(day);
            bean.setHour(hour);
            bean.setSrid(srid);
            bean.setWktString(wktString);
            bean.setXzqString(xzqString);
            bean.setBeginDate(beginDate);
            bean.setEndDate(endDate);
            
            if(addGj(bean)){
                //判断成功与否删除
                //delete(year, month, day, hour, bh);
            }
        }
    }
    
    public boolean addGj(InsertToSDEBean bean) {
        final LobHandler lobHandler = new DefaultLobHandler();
        JdbcTemplate opTemplate = findTemplate(GIS);
        try{
            opTemplate.execute(bean.getSqlString(), new InsertToSDE(lobHandler, bean));
            return true;
        }catch(BadSqlGrammarException e){
             if(e.getMessage().indexOf("ORA-06576") > 0){
                 System.out.println("================================================================");
                 System.out.println("==========生成轨迹时, 缺少存储过程, 请在giser下新建以下存储过程:===");
                 System.out.println("================================================================");
                 System.out.println("create or replace procedure GJSAVE (gps_id in VARCHAR2,gps_y in VARCHAR2,gps_m in VARCHAR2,gps_d in VARCHAR2,gps_h in VARCHAR2,line in clob,srid in integer,xzq in VARCHAR2) is");
                 System.out.println("geo sde.st_geometry;");
                 System.out.println("begin");
                 System.out.println("geo := sde.st_geometry(line,srid);");
                 System.out.println("insert into device_track(objectid,gps_id,year,month,day,hour,track_length,xzq,shape) values((select nvl(max(OBJECTID)+1,1) from device_track),gps_id,gps_y,gps_m,gps_d,gps_h,sde.st_length(geo),xzq,geo);");
                 System.out.println("end GJSAVE;");
                 System.out.println("================================================================");
                 System.out.println("================================================================");
                 System.out.println("================================================================");
             }
             return false;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 
     * <br>Description:删除时间段的坐标信息
     * <br>Author:陈强峰
     * <br>Date:2014年5月12日
     * @param year
     * @param month
     * @param day
     * @param hour
     * @param bh
     * @return
     */
    private boolean delete(String year, String month, String day, String hour, String bh) {
        String sqlString = "select gps_id from device_track t where t.year=? and t.month=? and t.day=? and t.hour=? and  t.gps_id=?";
        List<Map<String, Object>> list = query(sqlString, GIS, new Object[] { year, month, day, hour, bh });
        //上图成功
        if (list.size() > 0) {
            sqlString = "delete from gps_location_log t where t.gps_id=? and t.send_time between (sysdate-1/24) and sysdate";
            int count = update(sqlString, YW, new Object[] { bh });
            return count == 1 ? true : false;
        }
        return false;
    }
}
