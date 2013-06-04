package com.klspta.model.giscomponents.pdastatus;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * <br>Title:PDA状态
 * <br>Description:
 * <br>Author:郭润沛
 * <br>Date:2012-2-14
 */
public class PdaStatusAC extends AbstractBaseBean  {
	
	/**
	 * <br>Description: 根据PDA编号，返回当前坐标。如果在线则返回当前坐标，否则返回最后一次坐标
	 * <br>Author:李如意
	 * <br>Date:2012-7-21
	 * @throws Exception
	 */
    public void getCurrentPositon() throws Exception {    	
        String PDAID = request.getParameter("id");
        String sql = "select t.gps_x,t.gps_y from DEVICE_CURRENT t where t.gps_id=?";
        try {
            Object[] args = { PDAID };
            List<Map<String,Object>>  rows = query(sql, AbstractBaseBean.YW, args);              
            if (rows.size() > 0) {
                Map map = (Map) rows.get(0);
                String x = (String) map.get("gps_x");
                String y = (String) map.get("gps_y");
                response.getWriter().write(x + "," + y);
            }
        } catch (Exception ex) {
            response("false"); 
        }
    }
    
    public void getDownlineGpsId() throws Exception {
        String sql="select t.gps_id,to_char(ROUND(TO_NUMBER(sysdate-t.timestamp) * 24 * 60)) time from device_current t";
        
//        List list=Globals.getYwJdbcTemplate().queryForList(sql);
//        
//        String result="";
//        for(int i=0;i<list.size();i++){
//        	Map map=(Map)list.get(i);
//        	if(Integer.parseInt((String)map.get("time"))>1000){
//        		result+=(String)map.get("gps_id")+"@";
//        	}
//        }
//        response.getWriter().write(result);
    }

    
	/**
	 * <br>Description: 根据行政区的代码获取所有该行政区中的PDA信息
	 * <br>Author:李如意
	 * <br>Date:2012-7-21
	 * @throws Exception
	 */
    public void getAllPDA() throws Exception {
    	String xzqdm = request.getParameter("xzqdm"); 
    	String json = "";
    	String sql = "select t.qt_ctn_code,t.na_ctn_name from code_xzqh t where t.qt_parent_code = ? order by t.qt_ctn_code ";
    	Object[] args = { xzqdm };
    	List<Map<String,Object>>  listMap = query(sql, AbstractBaseBean.CORE, args);
    	
    	List allRows = new ArrayList();
    	for(int i=0;i<listMap.size();i++){
    		List oneRow = new ArrayList();
    		oneRow.add(listMap.get(i).get("QT_CTN_CODE"));
    		oneRow.add((String)listMap.get(i).get("NA_CTN_NAME"));
    		allRows.add(oneRow);
    	} 
		response(UtilFactory.getJSONUtil().objectToJSON(allRows)); 
    }
    


    
	 /**
	  * <br>Description: 获取所有设备id，并根据最后获取坐标的时间，显示设备是否在线
	  * <br>Author:李如意
	  * <br>Date:2012-7-21
	  * @throws Exception
	  */
     public void getAllGpsId() throws Exception {
        String sql="select t.gps_id,to_char(ROUND(TO_NUMBER(sysdate-t.timestamp) * 24 * 60)) time from DEVICE_CURRENT t";
        List<Map<String, Object>> list = query(sql, AbstractBaseBean.YW);
        String result="";
        for(int i=0;i<list.size();i++){
        	Map<String, Object> map=(Map<String, Object>)list.get(i);
        	if(Integer.parseInt((String)map.get("time"))>10){
        		result+=(String)map.get("gps_id")+"@"+"0"+"@";
        	}else{
        		result+=(String)map.get("gps_id")+"@"+"1"+"@";
        	}
        }
        response(result.substring(0,result.length()-1));
    }
     
     
     
    /**
     * <br>Description:获取在线坐标信息
     * <br>Author:王峰
     * <br>Date:2012-2-14
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void getOnlineGpsId() throws Exception { 
        String sql="select t.gps_id,to_char(ROUND(TO_NUMBER(sysdate-t.timestamp) * 24 * 60)) time,t.gps_x,t.gps_y from DEVICE_CURRENT t";
        List<Map<String, Object>> list = query(sql, AbstractBaseBean.YW);
        String gpsIds="";
        String zbs="";
        for(int i=0;i<list.size();i++){
        	Map map=(Map)list.get(i);
        	if(Integer.parseInt((String)map.get("time"))<10){
        		gpsIds+=(String)map.get("gps_id")+"@";
        		zbs+=(String)map.get("gps_x")+"@"+(String)map.get("gps_y")+"@";
        	}
        }
        if(!"".equals(gpsIds)){
          gpsIds=gpsIds.substring(0,gpsIds.length()-1);
          zbs=zbs.substring(0,zbs.length()-1);
        }
        response(gpsIds+";"+zbs); 
    }
    
    /**
     * <br>Description: 获取所有选择的设备编号
     * <br>Author:李如意
     * <br>Date:2012-7-21
     * @throws Exception
     */
    public void getCheckedGpsId() throws Exception {
    	String nodes=request.getParameter("nodes");
    	String[] ids=nodes.split("@");
        String gpsIds="";
        String zbs="";
    	for(int i=0;i<ids.length;i++){
            String sql="select t.gps_id,to_char(ROUND(TO_NUMBER(sysdate-t.timestamp) * 24 * 60)) time,t.gps_x,t.gps_y from DEVICE_CURRENT t where t.gps_id='"+ids[i]+"'";
            List<Map<String, Object>> list = query(sql, AbstractBaseBean.YW);
            Map<String, Object> map=(Map<String, Object>)list.get(0);
            gpsIds+=(String)map.get("gps_id")+"@";
            zbs+=(String)map.get("gps_x")+"@"+(String)map.get("gps_y")+"@";
    	}
        response(gpsIds.substring(0,gpsIds.length()-1)+";"+zbs.substring(0,zbs.length()-1));
    }
    
    /**
     * <br>Description: 根据设备编号获取坐标
     * <br>Author:李如意
     * <br>Date:2012-7-21
     * @throws Exception
     */
    public void getPositionById() throws Exception {
    	String gpsId=request.getParameter("gpsId");
        String sql="select t.gps_x,t.gps_y from DEVICE_CURRENT t where t.gps_Id='"+gpsId+"'";
        List<Map<String, Object>> list = query(sql, AbstractBaseBean.YW);
        Map map=(Map)list.get(0);
        String result=(String)map.get("gps_x")+"@"+(String)map.get("gps_y");
        response(result);
    }
    
    
    /**
     * <br>Description: 轨迹回放，根据选择的条件返回坐标
     * <br>Author:李如意
     * <br>Date:2012-7-21
     * @return
     * @throws IOException 
     */
    public void getHistoryPointsByCondition() throws IOException{
    	String gpsId = request.getParameter("gpsId");
    	String startTime = request.getParameter("startTime");
    	String endTime = request.getParameter("endTime");
    	String sql = "select t.gps_id, t.gps_x, t.gps_y, t.send_date from DEVICE_LOCATION t where t.gps_id = ? and (t.send_date between to_date(?, 'yyyy-mm-dd hh24:mi:ss') and to_date(?, 'yyyy-mm-dd hh24:mi:ss')) order by t.send_date asc";
    	Object[] args = { gpsId,startTime, endTime};
    	List<Map<String,Object>>  listMap = query(sql, AbstractBaseBean.YW, args); 
    	String pointString = "[[";
    	for(int i=0;i<listMap.size();i++){
    		Map<String,Object> map = listMap.get(i);
    		pointString += "{x:"+map.get("gps_x") +",y:"+ map.get("gps_y")+"}";
    		if(i != listMap.size()-1){
    			pointString += ",";
    		}
    	}
    	pointString += "]]";
    	response(pointString);
    }
    
    
	/**
	 * <br>Description: 根据设备ID获取设备的名称
	 * <br>Author:李如意
	 * <br>Date:2012-7-22
	 * @throws Exception
	 */
    public void getGpsNameById() throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String sql = "select t.gps_name from DEVICE_INFO t where t.gps_id = ?";
        try {
            Object[] args = { id };
            List<Map<String, Object>> rows = query(sql, AbstractBaseBean.YW,args);
            if (rows.size() > 0) {
                Map<String, Object> map = (Map<String, Object>) rows.get(0);
                String gps_name = (String) map.get("gps_name");
                response.getWriter().write(gps_name);
            }
        } catch (Exception ex) {
            response("false");
        }
    }
    
    
	/**
	 * <br>Description: 根据设备ID获取设备采集回传的成果
	 * <br>Author:李如意
	 * <br>Date:2012-7-22
	 * @throws Exception
	 */
    public void getGpsResultById() throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime"); 
        String json = ""; 
        String sql = "select t.gpsid,t.Guid,t.RWBH,t.XMMC,t.DWMC,t.RWLX,t.wfdd,t.rwms,t.sfwf,t.xcqkmc,t.xcr,t.xcrq,t.jwzb from DEVICE_DATA t where t.gpsid = ? and t.xcrq between to_date(?,'yyyy-mm-dd hh24:mi:ss') and to_date(?,'yyyy-mm-dd hh24:mi:ss')"; 
        try {
        	String[] ids = id.split("@");
            List allRows = new ArrayList();
        	for(int i=0; i<ids.length;i++){
                Object[] args = { ids[i],startTime,endTime };
                List<Map<String,Object>>  rows = query(sql, AbstractBaseBean.YW, args);         		
        		for (int j = 0; j < rows.size(); j++) {
        			List oneRow = new ArrayList();
        			Map map = (Map) rows.get(j);
                    oneRow.add((String) map.get("gpsid")); 
                    oneRow.add((String) map.get("Guid")); 
                    oneRow.add((String) map.get("RWBH")== null?"":(String) map.get("RWBH")); 
                    oneRow.add((String) map.get("XMMC")== null?"":(String) map.get("XMMC")); 
                    oneRow.add((String) map.get("DWMC")== null?"":(String) map.get("DWMC")); 
                    oneRow.add((String) map.get("RWLX")== null?"":(String) map.get("RWLX")); 
                    oneRow.add((String) map.get("wfdd")== null?"":(String) map.get("wfdd")); 
                    oneRow.add((String) map.get("rwms")== null?"":(String) map.get("rwms")); 
                    oneRow.add((String) map.get("sfwf")== null?"":(String) map.get("sfwf")); 
                    oneRow.add((String) map.get("xcqkmc")== null?"":(String) map.get("xcqkmc")); 
                    oneRow.add((String) map.get("xcr")== null?"":(String) map.get("jwzb"));
                    oneRow.add(((Date)map.get("xcrq")).toString().split(" ")[0]);  
                    oneRow.add((String) map.get("jwzb")== null?"":(String) map.get("jwzb")); 
        			allRows.add(oneRow);
        		}
        	}
    		response.setCharacterEncoding("UTF-8");//字符转换
    		response.getWriter().print(UtilFactory.getJSONUtil().objectToJSON(allRows));
        }catch (Exception ex) {
            response("false"); 
        }
    }
    
}
