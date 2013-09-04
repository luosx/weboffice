package com.klspta.web.sanya.ajdb;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class CaseSupervision extends AbstractBaseBean {
    
    public void getXfdbList(){
        String keyWord = request.getParameter("keyWord");
        String sql = "select t.yw_guid,t.xfsx,t.xflx,t.blsx,t.blks,t.blzt,t.blqk from xfajdjb t where t.blzt='未处理'";
        if(keyWord!=null){
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and upper(t.yw_guid)||upper(t.xfsx)||upper(t.xflx)||upper(t.blsx)||upper(t.blks)||upper(t.blzt)||upper(t.blqk) like '%"+keyWord+"%'";
        }        
        
        List<Map<String,Object>> list = query(sql,YW);
        if(list!=null && list.size()>0){
            int i=1;
            for(Map<String, Object> map : list){
                map.put("YJ", getWorkaDayAmount((String)map.get("blsx")));
                map.put("SYTS", getWorkaDayAmount((String)map.get("blsx"))+"天");
                map.put("INDEX", i++);
            }
        }
        
        
        response(list);
    }
    
    public void getLadbList(){
        String keyWord = request.getParameter("keyWord");
        String sql = "select t.yw_guid,t.bh,t.ay,(case when t.dwmc is not null then t.dwmc when t.grxm is not null then t.grxm end) wfdw,t.ajly,to_char(t.slrq,'yyyy-mm-dd') slrq,to_char(t.jzrq,'yyyy-mm-dd') jzrq,t.zywfss,j.activity_name_ blzt,j.wfInsId from lacpb t join workflow.v_active_task j on t.yw_guid=j.yw_guid";
        if(keyWord!=null){
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " where upper(t.yw_guid)||upper(t.bh)||upper(t.ay)||upper(t.dwmc)||upper(t.grxm)||upper(t.ajly)||upper(t.slrq)||upper(t.zywfss) like '%"+keyWord+"%'";
        }          
        List<Map<String,Object>> list = query(sql,YW);
        if(list!=null && list.size()>0){
            int i=0;
            for(Map<String, Object> map : list){
                map.put("YJ", getWorkaDayAmount(map.get("jzrq").toString()));
                map.put("SYTS", getWorkaDayAmount(map.get("jzrq").toString())+"天");
                map.put("INDEX", i++);
            }
        }
        
        
        response(list);        
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
}
