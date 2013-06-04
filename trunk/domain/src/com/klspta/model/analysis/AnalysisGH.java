package com.klspta.model.analysis;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Polygon;

/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息： <bean name="simpleExample"
 * class="com.klspta.model.SimpleExample" scope="prototype"/>
 * 
 * @author wang
 * 
 */
@Component
public class AnalysisGH extends AbstractBaseBean {

    DecimalFormat a = new DecimalFormat("0.00");
 
    /**
     * 
     * <br>Description:经纬度面积计算
     * <br>Author:陈强峰
     * <br>Date:2012-4-3
     * @param wkt
     * @param sid
     * @return
     */
     private String CountArea(String wkt){
         String area="0"; 
            if(wkt.equals("EMPTY")){
                return area;
            }
            
            Polygon polygon = new Polygon(wkt);
            double[] dd = UtilFactory.getCalculateAreasAndLengthsUtil().getAreasAndLengths(polygon);
            area = String.valueOf(dd[0]);
            return area;
        }
         
     public void getGhArea(){ 
    	 String geo = request.getParameter("geometry");
         Polygon pol = UtilFactory.getWKTUtil().stringToWKTObject(geo);
         String wkt = pol.toWKT();
         double[] ss = UtilFactory.getCalculateAreasAndLengthsUtil().getAreasAndLengths(pol);
         putParameter(a.format(ss[0]*0.0015));
         putParameter(getJsydArea(wkt));
         double d=ss[0]*0.0015-Double.parseDouble(getJsydArea(wkt));
         if(d<0){
        	 d=0;
         }
         putParameter(a.format(d));
         putParameter(getJbntArea(wkt));
         response();
     }
     public String getJsydArea(String wkt){
 		double jsyd=0;
  		String sid="";
         String querySrid = "select srid from sde.st_geometry_columns  where table_name='DC_GHYT'";
         List<Map<String,Object>> list= query(querySrid, SDE);
         if(list.size()>0){
        	 Map<String,Object> map=list.get(0);
        	 sid=(String)map.get("srid");
         }
         int srid = Integer.parseInt(sid);
 		String sql="select sde.st_astext(sde.st_intersection(d.shape, sde.st_geometry('"+wkt+"', "+srid+")))as area from dc_ghyt d where (d.TDYTFQDM='030' or d.TDYTFQDM='040' or d.TDYTFQDM='050') and sde.st_intersects(d.shape, sde.st_geometry('"+wkt+"', "+srid+")) =1";
 		List<Map<String,Object>> r=query(sql,GIS);
 		if(r.size()>0){
 			for(int i=0;i<r.size();i++){
 			   	Map<String,Object> map=r.get(i);
 			    jsyd+=Double.parseDouble(CountArea((String)map.get("area")));
 			}
 		}
 		return a.format(jsyd*0.0015);
     } 
     
     public String getJbntArea(String wkt){
  		double jbnt=0;
   		String sid="";
          String querySrid = "select srid from sde.st_geometry_columns  where table_name='DC_GHYT'";
          List<Map<String,Object>> list= query(querySrid, SDE);
          if(list.size()>0){
         	 Map<String,Object> map=list.get(0);
         	 sid=(String)map.get("srid");
          }
          int srid = Integer.parseInt(sid);
  		String sql="select sde.st_astext(sde.st_intersection(d.shape, sde.st_geometry('"+wkt+"', "+srid+")))as area from dc_ghyt d where d.TDYTFQDM='010' and sde.st_intersects(d.shape, sde.st_geometry('"+wkt+"', "+srid+")) =1";
  		List<Map<String,Object>> r=query(sql,GIS);
 		if(r.size()>0){
 			for(int i=0;i<r.size();i++){
 			   	Map<String,Object> map=r.get(i);
 			    jbnt+=Double.parseDouble(CountArea((String)map.get("area")));
 			}
 		}
  		return a.format(jbnt*0.0015);
      }
     
     public void getGhAreas(){
    	 String wkt = request.getParameter("wkt");
         putParameter(getJsydArea(wkt));
         putParameter(getJbntArea(wkt));
         response();
     }
}
