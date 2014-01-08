package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;
/*****
 * 
 * <br>Title:工厂类
 * <br>Description:根据数据提供前台展现页面
 * <br>Author:朱波海
 * <br>Date:2013-12-26
 */
public class TrFactory {
    static ZjglData zjglData= new ZjglData();
   
//资金指出-入口
   public static StringBuffer getmodel(List<Map<String, Object>> list, String yw_guid, String type) {
        StringBuffer buffer = new StringBuffer();
        if(type.equals("ZJZC")){
            List<Map<String, Object>> li = zjglData.getZC_sum(yw_guid);
            StringBuffer stringBuffer = ZjglBuild.buildZjzc_father_sum(li);
            buffer.append(stringBuffer);
            return buffer;
        }else if(type.equals("YIKFZC")){
            List<Map<String, Object>> ls = zjglData.getZC_YJZC_sum(yw_guid);
            StringBuffer stringBuffer = ZjglBuild.buildZjzc_father_sum(ls);
            buffer.append(stringBuffer);
            return buffer;
        }else{
        if (list != null||list.size()>0) {
            StringBuffer fatehr = buildFather(yw_guid, type);
            StringBuffer chaild = buildChild(yw_guid, list, type);
            buffer.append(fatehr);
            buffer.append(chaild);
            return buffer;
        } else {
            StringBuffer fatehr = buildFather(yw_guid, type);
            buffer.append(fatehr);
            return buffer;
        }
        }
    }
  //资金流入-入口
   public static StringBuffer getmod(String yw_guid){
        StringBuffer buffer = new StringBuffer();
        //总计
        List<Map<String, Object>> query=zjglData.getLR_sum(yw_guid);
        List<Map<String, Object>> list = zjglData. getZJGL_ZJLR(yw_guid);
        StringBuffer stringBufZJ = ZjglBuild.buildZjlr_sum(query);
        buffer.append(stringBufZJ);
        StringBuffer stringBuffer = ZjglBuild.buildZjlr(list);
        buffer.append(stringBuffer);
        return buffer;
        
    }
   /*****
    * 
    * <br>Description:构建父类tr
    * <br>Author:朱波海
    * <br>Date:2013-12-18
    */
   public static StringBuffer buildFather(String yw_guid, String type) {
       List<Map<String, Object>> list = zjglData. getZJGL_father(yw_guid, type);
       StringBuffer stringBuffer = ZjglBuild.buildZjzc_father(list);
       return stringBuffer;
   }

   /*****
    * 
    * <br>Description:构建子类tr
    * <br>Author:朱波海
    * <br>Date:2013-12-18
    */
   public static StringBuffer buildChild(String yw_guid, List<Map<String, Object>> list, String type) {
       StringBuffer buffer = new StringBuffer();
       if (list != null) {
           for (int i = 0; i < list.size(); i++) {
               String tree_name = list.get(i).get("tree_name").toString();
               List<Map<String, Object>> query = zjglData. getZJGL_child(yw_guid,tree_name,type);
               StringBuffer stringBuffer = ZjglBuild.buildZjzc_child(query);
               buffer.append(stringBuffer);
           }
       }
       return buffer;
   }
}
