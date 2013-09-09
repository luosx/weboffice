package com.klspta.web.sanya.lacc;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:立案查处管理类
 * <br>Description:处理立案查处相关信息
 * <br>Author:陈强峰
 * <br>Date:2013-6-21
 */
public class LaccManager extends AbstractBaseBean {
    /**
     * <br>
     * Description:获取立案查处待办案件 <br>
     * Author:赵伟 <br>
     * Date:2012-9-7
     */

    public void getProcessList() {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        String fullName = UtilFactory.getStrUtil().unescape(request.getParameter("fullName"));
        String sql = "select t.yw_guid,t.bh as ajbh ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd') as slrq,to_char(t.jzrq,'yyyy-MM-dd') as jzrq,j.activity_name_ as bazt,j.wfInsId,to_char(j.create_ ,'yyyy-MM-dd') as jssj,j.wfinsid from lacpb t join workflow.v_active_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.ay)||upper(t.ajly)||upper(t.grxm)||upper(t.slrq)||upper(j.create_)||upper(j.activity_name_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by j.create_ desc";
        List<Map<String, Object>> result = query(sql, YW, new String[] { fullName });

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            if(map.get("jzrq") == null){
                map.put("YJ", "365");
            }else{
                map.put("YJ", getWorkaDayAmount(map.get("jzrq").toString()));
            }         
            map.put("INDEX", i++);
        }
        response(result);
    }
    
     private String getWorkaDayAmount(String blqx){
            
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
            
            String systemDate= df.format(new Date());//系统时间
            
            Calendar startTime=Calendar.getInstance();
            
            Calendar endTime=Calendar.getInstance();
           
            
            try {
                
               startTime.setTime(df.parse(systemDate));
               endTime.setTime(df.parse(blqx));
               
           } catch (ParseException e) {
               
               e.printStackTrace();
               
           }
            
            int xzsj=getWorkingDay(startTime,endTime);
            
            return String.valueOf(xzsj);
            
        }
    
      public int getWorkingDay(java.util.Calendar d1, java.util.Calendar d2) {
         int result = -1;
         if (d1.after(d2)) { 
         }else{
             int charge_start_date = 0;//开始日期的日期偏移量
             int charge_end_date = 0;//结束日期的日期偏移量
             // 日期不在同一个日期内
             int stmp;
             int etmp;
             stmp = 7 - d1.get(Calendar.DAY_OF_WEEK);
             etmp = 7 - d2.get(Calendar.DAY_OF_WEEK);
             if (stmp != 0 && stmp != 6) {// 开始日期为星期六和星期日时偏移量为0
                 charge_start_date = stmp - 1;
             }
             if (etmp != 0 && etmp != 6) {// 结束日期为星期六和星期日时偏移量为0
                 charge_end_date = etmp - 1;
             }
             result = (getDaysBetween(this.getNextMonday(d1), this.getNextMonday(d2)) / 7)
             * 5 + charge_start_date - charge_end_date;
           }
           return result;
        }
  
        private int getDaysBetween(java.util.Calendar d1, java.util.Calendar d2) {
             if (d1.after(d2)) { 
              java.util.Calendar swap = d1;
              d1 = d2;
              d2 = swap;
             }
             int days = d2.get(java.util.Calendar.DAY_OF_YEAR)
               - d1.get(java.util.Calendar.DAY_OF_YEAR);
             int y2 = d2.get(java.util.Calendar.YEAR);
             if (d1.get(java.util.Calendar.YEAR) != y2) {
              d1 = (java.util.Calendar) d1.clone();
              do {
               days += d1.getActualMaximum(java.util.Calendar.DAY_OF_YEAR);
               d1.add(java.util.Calendar.YEAR, 1);
              } while (d1.get(java.util.Calendar.YEAR) != y2);
             }
             return days;
       }
      
        private Calendar getNextMonday(Calendar date) {
         Calendar result = null;
         result = date;
         do {
          result = (Calendar) result.clone();
          result.add(Calendar.DATE, 1);
         } while (result.get(Calendar.DAY_OF_WEEK) != 2);
         return result;
        }  
        
    /**
     * <br>
     * Description:获取案件查询待办案件列表 <br>
     * Author:赵伟 <br>
     * Date:2012-9-8
     * 
     * @throws Exception
     */
    public void getajglProcessList() throws Exception {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        // 获取数据
        String sql = "select t.yw_guid,t.bh as ajbh,t.qy ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd') as slrq,j.activity_name_ as bazt,to_char(j.create_ ,'yyyy-MM-dd') as jssj,j.assignee_,j.wfinsid from lacpb t join workflow.v_active_task j on t.yw_guid=j.yw_guid";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.qy)||upper(t.ay)||upper(t.ajly)||upper(j.assignee_)||upper(t.slrq)||upper(j.create_)||upper(j.activity_name_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by j.create_ desc";
        List<Map<String, Object>> result = null;
        result = query(sql, YW);

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.put("INDEX", i++);
        }
        response(result);
    }

    /**
     * <br>
     * Description:获取当前登陆人员已办案件 <br>
     * Author:赵伟 <br>
     * Date:2012-9-7
     * 
     * @throws Exception
     */
    public void getCompleteList() throws Exception {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        String fullName = UtilFactory.getStrUtil().unescape(request.getParameter("fullName"));
        // 获取数据
        String sql = "select t.yw_guid,t.bh as ajbh ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd') as slrq,j.activityname as bazt,j.wfInsId,to_char(j.create_ ,'yyyy-MM-dd') as jssj,to_char(j.end_,'yyyy-MM-dd') as yjsj,j.wfinsid from lacpb t join workflow.v_hist_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.qy)||upper(t.ay)||upper(t.ajly)||upper(t.grxm)||upper(t.slrq)||upper(j.activityname)||upper(j.end_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by j.create_ desc";
        List<Map<String, Object>> result = query(sql, YW, new String[] { fullName });

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.put("CREATE_", map.get("jssj"));
            map.put("SLRQ", map.get("slrq"));
            map.put("INDEX", i++);
        }
        response(result);
    }

    /**
     * <br>
     * Description:获取立案查处，案件查询已办结案件 <br>
     * Author:赵伟 <br>
     * Date:2012-9-25
     */
    public void getajdcCompleteList() {
        // 获取参数
        String keyWord = request.getParameter("keyWord");

        // 获取数据
        String sql = "select t.yw_guid,t.bh as ajbh ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd') as slrq,j.wfInsId,to_char(j.end_,'yyyy-MM-dd') as yjsj,j.wfinsid from lacpb t join workflow.v_end_wfins j on t.yw_guid=j.yw_guid";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.ay)||upper(t.ajly)||upper(t.grxm)||upper(t.slrq)||upper(j.end_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by t.slrq desc";
        List<Map<String, Object>> result = null;
        result = query(sql, YW);

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.put("END_", map.get("yjsj"));
            map.put("SLRQ", map.get("slrq"));
            map.put("INDEX", i++);
        }
        response(result);
    }
    /**
     * 
     * <br>Description:保存立案呈批表的案由等信息到结案呈批表中
     * <br>Author:王雷
     * <br>Date:2013-6-21
     */
    public void saveBhAy() {
        String yw_guid = request.getParameter("yw_guid");
        
        String sql="update jacpb j set (j.bh,j.ay,j.lasj,j.dwmc,j.fddbr,j.dwdz,j.dwdh,j.grxm,j.grxb,j.grnl,j.grdw,j.grzw,j.grdz,j.grdh,j.ajly,j.zywfss)= "
                  +" (select t.bh,t.ay,t.slrq,t.dwmc,t.fddbr,t.dwdz,t.dwdh,t.grxm,t.grxb,t.grnl,t.grdw,t.grzw,t.grdz,t.grdh,t.ajly,t.zywfss from lacpb t where t.yw_guid=j.yw_guid and t.yw_guid=?)"
                  +" where j.yw_guid=?";  
        int i=update(sql,YW,new Object[]{yw_guid,yw_guid});
        if(i==1){
            response("true");
        }else{
            response("false");
        }
       
    }

    /**
     * 
     * <br>Description:获取指定表中相同guid的个数（法律文书呈批表）
     * <br>Author:陈强峰
     * <br>Date:2013-6-20
     * @param yw_guid
     * @param tableName
     * @return
     */
    public int getNum(String yw_guid, String tableName) {
        String sql = "select count(*) num from " + tableName + " where yw_guid =?";
        return Integer.parseInt(String.valueOf(query(sql, YW, new Object[] { yw_guid }).get(0).get("num")));
    }

}