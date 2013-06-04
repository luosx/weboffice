package com.klspta.model.analysis;


import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Polygon;
/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息：
 * <bean name="simpleExample" class="com.klspta.model.SimpleExample" scope="prototype"/>
 * @author wang
 *
 */
@Component
public class AnalysisXZ extends AbstractBaseBean{
    
    private static final DecimalFormat   df = new java.text.DecimalFormat("#.##");
    DecimalFormat a = new DecimalFormat("0.00");
    public void doit(){
        String string = request.getParameter("geometry");
        Polygon pol = UtilFactory.getWKTUtil().stringToWKTObject(string);
        String wkt = pol.toWKT();
        List<Map<String,Object>> list=query(this.getClass(), GIS, new Object[]{wkt, wkt});
        if(list.size()>0){
        	for(int i=0;i<list.size();i++){
        		Map<String,Object> map=list.get(i);
        		 Vector<String> v = new Vector<String>();
                 v.add((String)map.get("objectid"));
                 v.add((String)map.get("dldm"));
                 v.add((String)map.get("dlmc"));
                 v.add((String)map.get("tbbh"));
                 v.add((String)map.get("qsdwmc"));
                 String area=(String)map.get("area");
                 if("EMPTY".equals(area)){
                 	continue;
                 }
                 v.add(df.format(Double.parseDouble(CountArea(area))));
                 putParameter(v);
        	}
        }
        response();
    }
    
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
            area = String.valueOf(a.format(dd[0]*0.0015));
            return area;
        }
     
     
 	public void getXzArea(){
		double nyd=0;
		double gend=0;
		double jsyd=0;
		double wlyd=0;
		String ysydtb = "051,052,053,054,061,062,063,071,072,081,082,083,084,085,086,087,088,091,092,093,094,095,101,102,103,105,106,107,113,118,121,201,202,203,204,205";
		String nydtb = "011,012,013,021,022,023,031,032,033,041,042,043,104,114,117,123";
		String gdtb = "011,012,013";
		String wlydtb = "111,112,115,116,119,122,124,125,126,127";
		String[] ysydtbs=ysydtb.split(",");
		String[] nydtbs=nydtb.split(",");
		String[] gdtbs=gdtb.split(",");
		String[] wlydtbs=wlydtb.split(",");
 		String wkt = request.getParameter("wkt");
 		String sid="";
        String querySrid = "select srid from sde.st_geometry_columns  where table_name='DC_TDLY'";
        List<Map<String,Object>> list= query(querySrid, SDE);
        if(list.size()>0){
       	 Map<String,Object> map=list.get(0);
       	 sid=(String)map.get("srid");
        }
        int srid = Integer.parseInt(sid);
        //wkt="POLYGON  (( 114.20291852 30.50470377, 114.20270712 30.50480614, 114.20245474 30.50492521, 114.20222418 30.50504142, 114.20206194 30.50514287, 114.20180636 30.50528702, 114.20157641 30.50538886, 114.20131402 30.50554740, 114.20111853 30.50565432, 114.19873115 30.50273115, 114.19959231 30.50212519, 114.20136836 30.50109734, 114.20090468 30.50197350, 114.20110251 30.50205104, 114.20103990 30.50235618, 114.20083144 30.50291802, 114.20077887 30.50340993, 114.20085817 30.50386469, 114.20021865 30.50416409, 114.20056149 30.50455123, 114.20106718 30.50408905, 114.20133957 30.50398164, 114.20188611 30.50397339, 114.20207898 30.50422405, 114.20238212 30.50411730, 114.20247338 30.50388607, 114.20279051 30.50355975, 114.20326149 30.50269705, 114.20362328 30.50269150, 114.20368352 30.50219975, 114.20354778 30.50210356, 114.20323378 30.50178368, 114.20279808 30.50222072, 114.20287409 30.50252217, 114.20240037 30.50321157, 114.20231121 30.50336956, 114.20205726 30.50337077, 114.20183693 30.50327276, 114.20174384 30.50303090, 114.20174581 30.50242465, 114.20158266 30.50186802, 114.20172246 30.50144462, 114.20227514 30.50125118, 114.20228238 30.50099865, 114.20205266 30.50074103, 114.20460907 30.49935876, 114.20408908 30.49904753, 114.19853276 30.50248822, 114.19803983 30.50188464, 114.19523557 30.49855517, 114.19627321 30.49719168, 114.19632780 30.49671906, 114.19640498 30.49641277, 114.19615172 30.49618227, 114.19617864 30.49572090, 114.19620488 30.49528322, 114.19662786 30.49484222, 114.19727125 30.49434674, 114.19767377 30.49414220, 114.19786548 30.49413448, 114.19797992 30.49395927, 114.19787634 30.49375568, 114.19828632 30.49329071, 114.19823606 30.49313565, 114.19867677 30.49255290, 114.19865452 30.49237475, 114.19836026 30.49214337, 114.19832119 30.49159767, 114.19853301 30.49136534, 114.19887473 30.49137268, 114.19922333 30.49161707, 114.20017787 30.49219429, 114.20022305 30.49252691, 114.20048320 30.49299444, 114.20101799 30.49294671, 114.20157096 30.49321917, 114.20216494 30.49349251, 114.20238850 30.49380528, 114.20257479 30.49398695, 114.20304541 30.49426948, 114.20318832 30.49453313, 114.20353931 30.49469465, 114.20375720 30.49511567, 114.20413614 30.49534707, 114.20425476 30.49550360, 114.20430029 30.49582438, 114.20464791 30.49610427, 114.20499959 30.49624211, 114.20512071 30.49678956, 114.20553938 30.49697622, 114.20571133 30.49718126, 114.20595197 30.49737594, 114.20611025 30.49758070, 114.20639393 30.49770523, 114.20724335 30.49717858, 114.20748739 30.49749010, 114.20707403 30.49783826, 114.20692955 30.49810759, 114.20671706 30.49836362, 114.20794233 30.50000076, 114.20847302 30.50064616, 114.20839819 30.50064895, 114.20824323 30.50063989, 114.20808438 30.50064607, 114.20792518 30.50063928, 114.20767583 30.50063883, 114.20737408 30.50064775, 114.20707593 30.50066740, 114.20678044 30.50070733, 114.20652263 30.50071084, 114.20630423 30.50072725, 114.20622301 30.50080462, 114.20620132 30.50086272, 114.20617030 30.50097101, 114.20614619 30.50111820, 114.20613055 30.50126114, 114.20609407 30.50140440, 114.20605207 30.50156203, 114.20596062 30.50172286, 114.20585100 30.50182997, 114.20580643 30.50186097, 114.20576185 30.50189196, 114.20574699 30.50189972, 114.20569880 30.50199163, 114.20567231 30.50208722, 114.20563355 30.50223245, 114.20553856 30.50241499, 114.20540743 30.50260630, 114.20527309 30.50280948, 114.20514848 30.50299769, 114.20503165 30.50317067, 114.20491131 30.50338115, 114.20472419 30.50356411, 114.20456367 30.50370727, 114.20437871 30.50383694, 114.20419736 30.50397789, 114.20404200 30.50409484, 114.20385738 30.50423354, 114.20363884 30.50434183, 114.20342292 30.50445662, 114.20317574 30.50456947, 114.20291852 30.50470377))";
        //Polygon pol = new Polygon(wkt);
        //wkt = pol.toWKT();
		String sql="select d.objectid,d.dlbm,d.dlmc,d.tbbh,d.qsdwmc,sde.st_astext(sde.st_intersection(d.shape, sde.st_geometry(?, "+srid+")))as area,d.shape.srid sid from dc_tdly d where sde.st_intersects(d.shape, sde.st_geometry(?, "+srid+")) =1";
		List<Map<String,Object>> r=query(sql,GIS,new Object[]{wkt,wkt});
		if(r.size()>0){
			for(int j=0;j<r.size();j++){
				Map<String,Object> map=r.get(j);
				 for(int i=0;i<ysydtbs.length;i++){
					 if(ysydtbs[i].equals(map.get("dlbm"))){
						 jsyd+=Double.parseDouble(CountArea((String)map.get("area")));
					 }
				 }
				 for(int i=0;i<nydtbs.length;i++){
					 if(nydtbs[i].equals(map.get("dlbm"))){
						 nyd+=Double.parseDouble(CountArea((String)map.get("area")));
					 }
				 }
				 for(int i=0;i<gdtbs.length;i++){
					 if(gdtbs[i].equals(map.get("dlbm"))){
						 gend+=Double.parseDouble(CountArea((String)map.get("area")));
					 }
				 }
				 for(int i=0;i<wlydtbs.length;i++){
					 if(wlydtbs[i].equals(map.get("dlbm"))){
						 wlyd+=Double.parseDouble(CountArea((String)map.get("area")));
					 }
				 } 
			}
		}
		putParameter(a.format(nyd));
		putParameter(a.format(gend));
		putParameter(a.format(jsyd));
		putParameter(a.format(wlyd));
		response();
    } 
     
}
