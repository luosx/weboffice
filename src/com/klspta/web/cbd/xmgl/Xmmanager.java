package com.klspta.web.cbd.xmgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class Xmmanager extends AbstractBaseBean {
    
    
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
    
    
}
