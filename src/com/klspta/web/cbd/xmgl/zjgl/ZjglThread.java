package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;
/***
 * 
 * <br>Title:资金管理
 * <br>Description:资金管理线程处理类
 * <br>Author:朱波海
 * <br>Date:2013-12-26
 */
public class ZjglThread implements Runnable{
  
  private String yw_guid="";
  private String type="";
  private String year="";
  private StringBuffer buffer=new StringBuffer();

  public ZjglThread(String yw_guid,String type,String year){
      this.yw_guid=yw_guid;
      this.type=type;
      this.year=year;
      
  }
    @Override
   public void run() {
  TreeManager Manager = new  TreeManager();
  List<Map<String, Object>> zc_zjzc = Manager.getZC_tree(this.yw_guid,type,this.year);
  this.buffer = TrFactory.getmodel(zc_zjzc,this.yw_guid, type,this.year);
    }
    public StringBuffer getBuffer() {
        return this.buffer;
    }

}
