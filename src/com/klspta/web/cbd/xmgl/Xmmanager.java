package com.klspta.web.cbd.xmgl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class Xmmanager extends AbstractBaseBean {
    public static String ZJGL_ZJZC;
    public static Xmmanager instens;
    private Xmmanager(){}
    
    public Xmmanager getXmmanager(){
        if (instens==null){
            return new Xmmanager ();
        }else{
            return  instens;
        }
    }
    /***
     * 
     * <br>Description:刷新缓存
     * <br>Author:朱波海
     * <br>Date:2013-12-17
     */
    public void refresh(){
        
        
    }
    public void init(){
     // ArrayList<?> arrayList = new ArrayList<?>();
        //获取全部支出yw_guid
        String  sql="select distinct yw_guid  from  xmzjgl where status='zc'";
        List<Map<String, Object>> list = query(sql, YW);
        //t.zcstatus 
        for (int i=0;i<list.size();i++){
            String yw_guid = list.get(i).get("yw_guid").toString();
            //一个项目的所有lb
            String lxsql="select distinct lb  from  xmzjgl where status='zc' and yw_guid=?";
            List<Map<String, Object>> lblist = query(lxsql, YW,new Object []{yw_guid});
            for(int j=0;j<lblist.size();j++){
                
                
            }
            
        }
        
        
        
    }
   /***
    * 
    * <br>Description:项目管理中——办理过程
    * <br>Author:朱波海
    * <br>Date:2013-12-16
    */
    public  List<Map<String, Object>> getBLGC(String yw_guid){
      //String yw_guid = request.getParameter("yw_GUID");
      String sql="select * from xmblgc where yw_guid=? ";
      List<Map<String, Object>> list = query(sql, YW,new Object[]{yw_guid});
      return list;
    }
    /*******
     * 
     * <br>Description:项目管理——保存办理过程
     * <br>Author:朱波海
     * <br>Date:2013-12-16
     */
  public void saveBLGC(){
      String xh = request.getParameter("xh");
      String sj = request.getParameter("sj");
      String sjbl = request.getParameter("sjbl");
      String bmjbr = request.getParameter("bmjbr");
      String bz = request.getParameter("bz");
      String yw_guid = request.getParameter("yw_guid");
      String insertString="insert into xmblgc (xh,sj,sjbl,bmjbr,bz,yw_guid )values(?,?,?,?,?,?)";
      int i = update(insertString, YW,new Object[]{xh,sj,sjbl,bmjbr,bz,yw_guid});
      if(i>0){
         response("success");
      }else{
          response("failure");
      }
  }
  /****
   * 
   * <br>Description:获取红线项目
   * <br>Author:朱波海
   * <br>Date:2013-12-16
   */
    public  List<Map<String, Object>> getHXXM(){
        String sql="select xmname,yw_guid,rownum from jc_xiangmu ";
        List<Map<String, Object>> list = query(sql, YW);
        return  list;
        
    }
    /****
     * 
     * <br>Description:项目管理——资金管理——资金流入
     * <br>Author:朱波海
     * <br>Date:2013-12-17
     */
 public List<Map<String, Object>> getZJGL_ZJLR( String yw_guid){
     String  sql="select * from  xmzjgl where status='lr' and yw_guid=?";
     List<Map<String, Object>> list = query(sql, YW,new Object []{yw_guid});
     return list;
 }  
 /******
  * 
  * <br>Description:保存资金管理——资金流入
  * <br>Author:朱波海
  * <br>Date:2013-12-17
  */
 public  void saveZJGL_ZJLR(){
     
     
     
     
     
     
 }
 
 /****
  * 
  * <br>Description:项目管理——资金管理——资金支出
  * <br>Author:朱波海
  * <br>Date:2013-12-17
  */
public List<Map<String, Object>> getZJGL_ZJZC(String yw_guid){
   // ArrayList<?> arrayList = new ArrayList<?>();
    String  sql="select distinct lb,yw_guid  from  xmzjgl where status='zc' and yw_guid=?";
    List<Map<String, Object>> list = query(sql, YW,new Object []{yw_guid});
    //t.zcstatus 
    for (int i=0;i<list.size();i++){
        list.get(i).get("lb").toString();
        
    }
    
    
    
    
    return list;
 }
/******
 * 
 * <br>Description:保存资金管理——资金支出
 * <br>Author:朱波海
 * <br>Date:2013-12-17
 */
public void saveZJGL_ZJZC(){
    
    
    
}    



}
