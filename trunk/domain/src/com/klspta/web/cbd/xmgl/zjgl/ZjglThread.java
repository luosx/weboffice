package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

public class ZjglThread implements Runnable{
  
  private String yw_guid="";
  private String type="";
  private StringBuffer buffer=new StringBuffer();
  
  public ZjglThread(String yw_guid,String type){
      this.yw_guid=yw_guid;
      this.type=type;
      
  }
    @Override
   public void run() {
  TreeManager Manager = new  TreeManager();
  List<Map<String, Object>> zc_zjzc = Manager.getZC_tree(this.yw_guid,type);
  this.buffer = TrFactory.getmodel(zc_zjzc,this.yw_guid, type);
    }
    public StringBuffer getBuffer() {
        return this.buffer;
    }

}
