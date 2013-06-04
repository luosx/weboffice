package com.klspta.model.giscomponents.gpsstatusmonitor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.wkt.Point;
import com.klspta.model.giscomponents.gpsequipmentmanage.GpsInfoBean;


/**
 * 
 * <br>Title:GPS状态信息工具类
 * <br>Description:
 * <br>Author:王峰
 * <br>Date:2011-5-24
 */
public class GpsStatusUtil extends AbstractBaseBean{
    
    
    private static GpsStatusUtil gpsStatusUtil;

    private GpsStatusUtil() {

    }

    /**
     * <br>Description:获取实例
     * <br>Author:王峰
     * <br>Date:2011-5-14
     * @return
     */
    public static GpsStatusUtil getInstance() {
        if (gpsStatusUtil == null) {
            gpsStatusUtil = new GpsStatusUtil();
        }
        return gpsStatusUtil;
    }
    
    /**
     * 
     * <br>Description:根据GPSID,时间获取GPS历史坐标
     * <br>Author:王峰
     * <br>Date:2011-5-24
     * @param gpsId
     * @param starttime
     * @param endtime
     * @return
     */
    public List<Point> getHistoryLocation(String gpsId, String starttime,
            String endtime) {
        String sql="select gps_x,gps_y,send_date from device_location where gps_id=? and send_date>=to_date(?,'rrrr-mm-dd hh24:mi:ss') and send_date<=to_date(?,'rrrr-mm-dd hh24:mi:ss') order by send_date";
        Object[] args={gpsId,starttime,endtime};
        List<Map<String,Object>> list=query(sql,YW,args);
        if(list.size()==0)return null;
        List<Point> newList=new ArrayList<Point>();
        for(int i=0;i<list.size();i++){
            Map<String,Object> map=(Map<String,Object>)list.get(i);
            Point p=new Point((String)map.get("gps_x"),(String)map.get("gps_y"));
            newList.add(p);
        }
        return newList;
    }

    
	/**
	 * <br>Description:获得运行统计的查处结果
	 * <br>Author:尹
	 * <br>Date:2011-5-24
	 */
	public List<GpsInfoBean> getGpsInfo(String gpsType, String gpsName, String beginTime, String endTime) {
		String sql = "select GPS_TYPE,GPS_NAME,GPS_X,GPS_Y,TIMESTAMP,SPEED,DIRECTION from DEVICE_INFO t ,DEVICE_CURRENT g where t.gps_id = g.gps_id and to_char(TIMESTAMP,'yyyy-mm-dd') between ? and ? ";		
		SimpleDateFormat sf = new SimpleDateFormat( "yyyy-MM-dd ");
		Date date = new Date();                                                              
		String today = sf.format(date);		
		if(beginTime==""){
			beginTime = "1949-10-01";
		}
		if(endTime==""){
			endTime = today;
		}
		List<String> args_list = new ArrayList<String>();
		args_list.add(beginTime);
		args_list.add(endTime);
		if(!(gpsType.equals("all")||gpsType.equals(""))){
			sql = sql + " and GPS_TYPE = ?";
			args_list.add(gpsType);
			if(!(gpsName.equals("all")||gpsName.equals(""))){
				sql = sql+" and GPS_NAME = ?";
				args_list.add(gpsName);
			}
		}
		Object[] args = new Object[args_list.size()];
		for(int i=0;i<args_list.size();i++){
			args[i] = args_list.get(i);
		}
		sql = sql + "ORDER BY GPS_TYPE";
		List<Map<String,Object>> list = query(sql,YW,args);
		List<GpsInfoBean> gpsInfoBeanList = new ArrayList<GpsInfoBean>();
		for(int i=0;i<list.size();i++){
			Map<String,Object> map = (Map<String,Object>)list.get(i);
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String type = (String)map.get("GPS_TYPE");
			String name = (String)map.get("GPS_NAME");
			String x = (String)map.get("GPS_X");
			String y = (String)map.get("GPS_Y");
			String time = df.format(map.get("TIMESTAMP"));
			String speed = (String)map.get("SPEED");
			String direction = (String)map.get("DIRECTION");
			GpsInfoBean gib = new GpsInfoBean(type,name,x,y,time,speed,direction);
			gpsInfoBeanList.add(gib);			
		}
		return gpsInfoBeanList;
	}

	/**
	 * <br>Description:获得GPS设备类型
	 * <br>Author:尹
	 * <br>Date:2011-5-24
	 */
	public List<String> getGpsType() {
		String sql = "select distinct GPS_TYPE from DEVICE_INFO";
		Object[] args = {};
		List<Map<String,Object>> list = query(sql,YW,args);
		List<String> gpsTypeList = new ArrayList<String>();
		for(int i=0;i<list.size();i++){
			Map<String,Object> map = (Map<String,Object>)list.get(i);
			gpsTypeList.add((String)map.get("GPS_TYPE"));
		}
		return gpsTypeList;
	}

	/**
	 * <br>Description:获得GPS某种设备类型下的设备
	 * <br>Author:尹
	 * <br>Date:2011-5-24
	 */
	public List<String> getGpsNameByType(String gpsType) {
		String sql = "select GPS_NAME from DEVICE_INFO where GPS_TYPE = ?";
		Object[] args = {gpsType};
		List<Map<String,Object>> list = query(sql,YW,args);
		List<String> gpsNameList = new ArrayList<String>();
		for(int i=0;i<list.size();i++){
			Map<String,Object> map = (Map<String,Object>)list.get(i);
			gpsNameList.add((String)map.get("GPS_NAME"));
		}
		return gpsNameList;
	}    
}
