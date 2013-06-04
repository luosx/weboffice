package com.klspta.base.job.xcstatistic;

import java.util.List;
import java.util.Map;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IChangeCoordsSysUtil;
import com.klspta.base.wkt.Point;
import com.klspta.base.AbstractBaseBean;

public class InsertGPSStatistic extends AbstractBaseBean{
	 private static InsertGPSStatistic insertGps = null;
	 
	 private InsertGPSStatistic(){
		 
	 }
	 
	 public static InsertGPSStatistic getInstance(){
		 if(insertGps==null){
			 insertGps=new InsertGPSStatistic();
		 }
		 return insertGps;

	 }
	  
	 
	 public void insertGPSStatistic(){
		String sql="select t.gps_id from gps_info t";
		List<Map<String,Object>> list=query(sql, YW);
		String insertSql="insert into XCTJ (XCTJID,CISHU,WEIFAGE,SHIJIAN) values(?,?,?,sysdate)";
		String sql2="select t.gps_id,t.gps_x,t.gps_y from WY_GPS_LOCATION_LOG t where t.gps_id=? and trunc(t.send_date)= trunc(sysdate)  order by t.send_date";
		int count=0;
 		double mileage=0.0;
 		Map<String,Object> map2=null;
 		Map<String,Object> map3=null;
 		double temp_A, temp_B;
		double C;  // 用来储存算出来的斜边距离
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
                count=0;
				Map<String,Object> map=(Map<String,Object>)list.get(i);
				String gpsid=(String)map.get("gps_id");						
					List<Map<String,Object>> list2=query(sql2, YW,new Object[]{gpsid});
					if(list2!=null&&list2.size()>0){
						for(int j=0;j<list2.size()-1;j++){					
							map2=(Map<String,Object>)list2.get(j);
							map3=(Map<String,Object>)list2.get(j+1);														
							double gps_x=Double.parseDouble((String)map2.get("gps_x"));
							double gps_y=Double.parseDouble((String)map2.get("gps_y"));
							double gps_x2=Double.parseDouble((String)map3.get("gps_x"));
							double gps_y2=Double.parseDouble((String)map3.get("gps_y"));
							
							IChangeCoordsSysUtil util=UtilFactory.getChangeCoordsSysUtil();
							Point point1=new Point(gps_x,gps_y);
							Point point2=new Point(gps_x2,gps_y2);	
							
							Point point3=util.changeMe(point1, IChangeCoordsSysUtil.GPS84_TO_BALIN80);
							Point point4=util.changeMe(point2, IChangeCoordsSysUtil.GPS84_TO_BALIN80);							
							
							double x1=point3.getX();
							double y1=point3.getY();
							double x2=point4.getX();
							double y2=point4.getY();
							
						
							temp_A =  x2-x1;  // 横向距离 (取正数，因为边长不能是负数)
							temp_B =  y2-y1;  // 竖向距离 (取正数，因为边长不能是负数)
							C=java.lang.Math.sqrt(temp_A*temp_A + temp_B*temp_B);  // 计算
							mileage+=C;
							mileage=Math.round(mileage * 10000) / 10000;							
							
						}
						if(mileage>=10000){
							count=1;
						}
						update(insertSql,YW,new Object[]{Integer.parseInt(gpsid),count,mileage/1000});	
					}else{
						update(insertSql,YW,new Object[]{Integer.parseInt(gpsid),0,0.0});	
					}
			}
		}
		}

}
