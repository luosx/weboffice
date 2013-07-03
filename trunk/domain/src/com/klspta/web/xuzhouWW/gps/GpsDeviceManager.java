package com.klspta.web.xuzhouWW.gps;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class GpsDeviceManager extends AbstractBaseBean{
    
    private static Map<String, GpsDeviceBean> GPSBeanMap = new HashMap<String, GpsDeviceBean>();
    public static Map<String, Object> cacheMap=new HashMap<String,Object>();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    public GpsDeviceManager(){
    	initGPSBeanMap(); 	
    }
    
    private void initGPSBeanMap(){
    	String sql="select t.car_name,t.car_flag, t.car_un" +
    			"it,t.car_person,t.car_person_phone,t.car_cantoncode,t.car_number,t.car_info_xzqh_name,t.car_id,t.car_style,t.car_gmrq from car_info t";
    	List<Map<String,Object>> list= query(sql,YW);
        String selsql = "select t.carid,t.x,t.y from car_location_history t where t.carid = ?  and rownum=1 order by t.history_date desc";
    	if(list.size()>0){
    		for(int i=0;i<list.size();i++){
    			Map<String,Object> rs=list.get(i);
            	GpsDeviceBean bean = new GpsDeviceBean();
            	bean.setName((String)rs.get("car_name"));
            	bean.setPerson((String)rs.get("car_person"));
            	bean.setPersonphone((String)rs.get("car_person_phone"));
            	bean.setCantoncode((String)rs.get("car_cantoncode"));
            	bean.setNumber((String)rs.get("car_number"));
            	bean.setInfoxzqhname((String)rs.get("car_info_xzqh_name"));
            	bean.setId((String)rs.get("car_id"));
            	bean.setLx((String)rs.get("car_flag"));
            	bean.setStyle((String)rs.get("car_style"));
            	bean.setGmrq(new Date());
            	List<Map<String,Object>> history= query(selsql,YW,new Object[]{(String)rs.get("car_id")});
            	if(history.size()>0){
            		Map<String,Object> his=history.get(0);
            		bean.setX((String)his.get("x"));
            		bean.setY((String)his.get("y"));
            	}else{
            		bean.setX("117.181688333333");
            		bean.setY("34.1625683333333");
            	}
              	GPSBeanMap.put((String)rs.get("car_id"), bean);
    		}
    	}
    }
 
    public void getCarInfoByCarName(){
    	String carname="";
		try {
			carname = URLDecoder.decode(request.getParameter("carname"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    	String sql="select * from car_info where car_name='"+carname+"'";
    	List<Map<String, Object>> list = query(sql,YW);
    	response(list);
    }
    
    public void getPositons() {
        clearParameter();
        String id = request.getParameter("ids");
        String[] ids = id.split(",");
        for(int i = 0; i < ids.length; i++){
            if(isExitsBean(ids[i])){
                putParameter(getBean(ids[i]).getInfo());
            }else{
                putParameter("error 不存在的设备id:" + ids[i]);
            }
        }
        response();
    }
    
	@SuppressWarnings("unchecked")
	public void getCarInfo() {
		String ids =request.getParameter("carids");
		String []carid=ids.split(",");
		List list =new ArrayList();
		for(int i=0;i<carid.length;i++){
	     Map map=new HashMap();
		 Iterator it = GPSBeanMap.entrySet().iterator();
    	 while (it.hasNext()){
    	  Map.Entry entry = (Map.Entry) it.next();
    	  String  key = (String)entry.getKey();
    	  GpsDeviceBean value = (GpsDeviceBean)entry.getValue();
    	  if(key.equals(carid[i])){		  
    		double x1=Double.valueOf(value.getX());
    	    double y1=Double.valueOf(value.getY());
    		double x0=0;
    		double y0=0;
    		double angle=0;
    		if(cacheMap.get(carid[i])!=null){
    			String zb=(String)cacheMap.get(carid[i]);
    			String[] zbs=zb.split(",");
    			x0=Double.valueOf(zbs[0]);
    			y0=Double.valueOf(zbs[1]);	
    			angle=this.OffsetAngle(x0, y0, x1, y1);
    		}
    		cacheMap.put(carid[i],value.getX()+","+value.getY()); 
    		 map.put("CARNAME",value.getname());
    		 map.put("CARFLAG",value.getLx());
      	     map.put("carX",value.getX());
    	     map.put("carY",value.getY());
    	     map.put("ANGLE", angle);
    	  }
    	}
    	list.add(map);
	  }
	  response(list);
	}
	
	public double OffsetAngle(double x0, double y0, double x1, double y1) {
		double Angle = 0.001;
		double molecular = x1 - x0;// 分子
		double denominator = y1 - y0;
		if (molecular > 0 & denominator > 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180;
		}
		else if (molecular > 0 & denominator < 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180 + 90;

		}
		else if (molecular < 0 & denominator < 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180 + 180;
		}
		else if (molecular < 0 & denominator > 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180 + 270;
		} else {
			Angle = 0.0000;
		}
		return Angle;
	}
	
    @SuppressWarnings("unchecked")
	public void countAllCar(){
    	String sql="select distinct(t.car_cantoncode) as xzqh,t.car_info_xzqh_name as xzqmc from car_info t";
    	List list=query(sql,YW);
    	List resList=new ArrayList();
    	int onlineCount=0;
    	int allCount=0;
    	for(int i=0;i<list.size();i++){
    		Map map=(Map)list.get(i);
    		String xzqh=(String)map.get("xzqh");
    		String xzqmc=(String)map.get("xzqmc");
    		int childCount=0;
    		int parentCount=0;
    	    Map resmap=new HashMap();
    		Iterator it = GPSBeanMap.entrySet().iterator();
    		while (it.hasNext()){
    		Map.Entry entry = (Map.Entry) it.next();
    		  //String  key = (String)entry.getKey();
    		  GpsDeviceBean value = (GpsDeviceBean)entry.getValue();
    		  if(xzqh.equals(value.getCantoncode())){
    			  parentCount++;
    			  boolean engine=value.isEngine();
    			  if(engine){
    				  childCount++;
    			  }
    		  }
    		}
    		onlineCount+=childCount;
    		allCount+=parentCount;
			resmap.put("xzqcode", xzqh);
			resmap.put("xzqname", xzqmc);
			resmap.put("child", childCount);
			resmap.put("parent", parentCount);
			resList.add(resmap);
    	}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("xzqcode", "320300");
		map.put("xzqname", "全 市");
		map.put("child", onlineCount);
		map.put("parent", allCount);
		resList.add(map);
		response(resList);
    }
    
    @SuppressWarnings("unchecked")
	public void getCarTree(){
      String xzqdm=request.getParameter("xzqdm");
      if("".equals(xzqdm)){
    	  xzqdm="320300/";
      }
      String[] xzqs=xzqdm.split("/");
     // String status=request.getParameter("status");
      List list=new ArrayList();
      for(int i=0;i<xzqs.length;i++){
    	List oneList=new ArrayList();
  		Iterator it = GPSBeanMap.entrySet().iterator();
		while (it.hasNext()){
		  Map map=new HashMap();
		  Map.Entry entry = (Map.Entry) it.next();
		  GpsDeviceBean value = (GpsDeviceBean)entry.getValue();
		  if(xzqs[i].equals(value.getCantoncode())||xzqs[i].equals("320300")){
			  if(xzqs[i].equals("320300")){
				  map.put("xzqcode","320300");
				  map.put("xzqname","全市"); 
			  }else{
				  map.put("xzqcode", value.getCantoncode());
				  map.put("xzqname", value.getinfoxzqhname()); 
			  }
			  map.put("carid", value.getId());
			  map.put("carname", value.getname());
			  map.put("carlx", value.getLx());
			  boolean engine=value.isEngine();
			  if(engine){
			  //   if("2".equals(status)||"1".equals(status)){
				 map.put("carstatus","going");
				 oneList.add(map);
			    // }
			  }else{
				// if("2".equals(status)||"0".equals(status)){
				 map.put("carstatus","stop");
				 oneList.add(map);
				// }
			  }
		  }
		}
		list.add(oneList);
      }
	 response(list);
    }
    
    public void gpsInfo() {
        clearParameter();
        String id = request.getParameter("id");
        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String flag=request.getParameter("engine");
        boolean engine=true;
        if("--".equals(flag)){
        	engine=false;
        }
        if(isExitsBean(id)){
            getBean(id).setGPSInfo(x, y);
            getBean(id).setEngine(engine);
            getBean(id).setGmrq(new Date());
            response("true");
        }else{
            response("false");
        }
    }

    public void flushGps(){
    	Iterator it = GPSBeanMap.entrySet().iterator();
		while (it.hasNext()){
		  Map map=new HashMap();
		  Map.Entry entry = (Map.Entry) it.next();
		  GpsDeviceBean value = (GpsDeviceBean)entry.getValue();
		  Date nowDate=new Date();
	      Date receiveDate=value.getGmrq();
	      long mins=(nowDate.getTime()-receiveDate.getTime())/(60*1000);
	      if(mins>10){
	    	 value.setEngine(false);
	      } 
		}	
    }
    
    private boolean isExitsBean(String id){
        if(getBean(id) == null){
            return false;
        }else{
            return true;
        }
    }
    
    private GpsDeviceBean getBean(String id){
        try {
            return GPSBeanMap.get(id);
        } catch (Exception e) {
            System.out.println("没有设备ID为：  " + id);
        }
        return null;
    }
 
}
