package com.klspta.model.giscomponents.play;

import java.util.ArrayList;
import java.util.List;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.wkt.Point;
import com.klspta.model.giscomponents.gpsstatusmonitor.GpsStatusUtil;
import net.sf.json.JSONArray;

/**
 * 
 * <br>Title:PlayManageAC
 * <br>Description:PlayManageAC
 * <br>Author:王雷
 * <br>Date:2012-2-7
 */
public class PlayManageAC extends AbstractBaseBean{
    /**
     * 
     * <br>Description:历史回放AC
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void playback()throws Exception {
         String gpsId = request.getParameter("gpsid");
         String starttime=request.getParameter("starttime");
         String endtime=request.getParameter("endtime");
         List<Point> list=GpsStatusUtil.getInstance().getHistoryLocation(gpsId, starttime, endtime); 
         List<List<Double>> list3=new ArrayList<List<Double>>();
         if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++){
                List<Double> list2=new ArrayList<Double>();
                Point point=list.get(i);
                Double x=point.getX();
                Double y=point.getY();
                list2.add(x);
                list2.add(y);
                list3.add(list2);
            }          
         }
         String string=JSONArray.fromObject(list3).toString();
         response.getWriter().write("{success:true,msg:'"+string+"'}");                       
         //return null;
    }
    
    /**
     * 
     * <br>Description:里程统计AC
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void mileageStatistics()throws Exception {
         String gpsId = request.getParameter("gpsid");
         String starttime=request.getParameter("starttime1");
         String endtime=request.getParameter("endtime1");
         List<Point> list=GpsStatusUtil.getInstance().getHistoryLocation(gpsId, starttime, endtime); 
         List<List<Double>> list3=new ArrayList<List<Double>>();
         if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++){
                List<Double> list2=new ArrayList<Double>();
                Point point=list.get(i);
                Double x=point.getX();
                Double y=point.getY();
                list2.add(x);
                list2.add(y);
                list3.add(list2);
            }          
         }
         String string=JSONArray.fromObject(list3).toString();
         response.getWriter().write("{success:true,msg:'"+string+"'}");                       
        // return null;
    }
}
