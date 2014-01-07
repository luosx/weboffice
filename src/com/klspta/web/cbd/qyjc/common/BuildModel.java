package com.klspta.web.cbd.qyjc.common;

import java.util.List;
import java.util.Map;

public class BuildModel {
    public static  String []  Month={"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"};
    
    public String  getTitle(String [] year){
        StringBuffer buffer = new StringBuffer();
        buffer.append("<tr class='tr11'>");
        buffer.append("<td align='center' width='80px' height='50px'><h3>序号</h3></td><td align='center' width='120px'><h3>写字楼名称</h3></td>");
        for(int i=0;i<year.length;i++){
           for(int j=1;j<13;j++){
               buffer.append("<td align='center' width='90px'><h3>"+year[i]+"年"+j+"月</h3></td>");
           }
        }
        buffer.append("</tr >");
        return  buffer.toString();
    }
    
    /*****
     * 
     * <br>Description:一年查看状态
     * <br>Author:朱波海
     * <br>Date:2014-1-2
     */
    public String  build_One_year(List<Map<String, Object>> list,String type,String year){
        StringBuffer buffer = new StringBuffer();
        buffer.append("<table>");
        String []years={year};
        String title = getTitle(years);
        buffer.append(title);
        for(int i=0;i<list.size();i++){
            buffer.append("<tr><td>");
            buffer.append( delNull(String.valueOf(list.get(i).get("BH"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("XZLMC"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("YY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("EY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("SY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("SIY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("WY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("LY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("QY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("BAY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("JY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("SHIY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("SYY"))));
            buffer.append("</td><td> ");
            buffer.append( delNull(String.valueOf(list.get(i).get("SRY"))));
            buffer.append("</td><td> </tr>");
        }
        buffer.append("</table>");
        return  buffer.toString();
    }
  
    /***
     * 
     * <br>Description:带你bh和名称的
     * <br>Author:朱波海
     * <br>Date:2014-1-3
     * @return
     */
    public String getMode1(List<Map<String, Object>> list,List<Map<String, Object>> list2,String []year){
        StringBuffer buffer = new StringBuffer();
        buffer.append("<table id='firstTable'>");
        String title = getTitle(year);
        buffer.append(title);

        for(int i=0;i<list.size();i++){
            buffer.append("<tr><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("BH"))));
            buffer.append("</td><td width='120px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("XZLMC"))));
            buffer.append("</td></td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("YY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("EY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("SY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("SIY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("WY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("LY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("QY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("BAY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("JY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("SHIY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("SYY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("SRY"))));
            buffer.append("</td><td>");
          
            buffer.append( delNull(String.valueOf(list2.get(i).get("YY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("EY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("SY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("SIY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("WY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("LY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("QY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("BAY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("JY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("SHIY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("SYY"))));
            buffer.append("</td><td width='90px'>");
            buffer.append( delNull(String.valueOf(list2.get(i).get("SRY"))));
            buffer.append("</td></tr>");
        }
        buffer.append(" </table>");
        return buffer.toString();
    }
    
    public String delNull(String str){
        if(str.equals("null")){
            return "";
        }else {
            return str;
        }
        
        
    }
   
 /******
  * 
  * <br>Description:租金情况展现
  * <br>Author:朱波海
  * <br>Date:2014-1-6
  */
  public String getZjqkTable(List<Map<String, Object>> list){
      StringBuffer buffer = new StringBuffer();
      buffer.append("<table width='100%' id='firstTable'><tr id='title' class='tr01'><td >编号</td><td >写字楼名称</td><td >地址</td><td >城区</td><td >商圈</td><td >地铁</td><td >出租价格</td><td >售价</td><td >租售比</td><td  >可租售面积</td> <td >信息</td></tr>");
     for(int i=0;i<list.size();i++){
       buffer.append("<tr>");
       buffer.append("<td> ");
       buffer.append(delNull(String.valueOf(list.get(i).get("BH"))));
       buffer.append("</td> ");
       buffer.append("<td> ");
       buffer.append(delNull(String.valueOf(list.get(i).get("XZLMC"))));
       buffer.append("</td> ");
       buffer.append("<td> <input id='"+list.get(i).get("yw_guid")+"_DZ' onchange='chang(this)' value=' ");
       buffer.append(delNull(String.valueOf(list.get(i).get("DZ"))));
       buffer.append("' /></td> ");
       buffer.append("<td> <input id='"+list.get(i).get("yw_guid")+"_CQ' onchange='chang(this)' value='  ");
       buffer.append(delNull(String.valueOf(list.get(i).get("CQ"))));
       buffer.append("' /></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SQ' onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("SQ"))));
       buffer.append("' /></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_DT' onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("DT"))));
       buffer.append("' /></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_CZJG' onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("CZJG"))));
       buffer.append("'/></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SJ' onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("SJ"))));
       buffer.append("' /></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_ZSB' onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("ZSB"))));
       buffer.append("' /></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_KZSMJ' onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("KZSMJ"))));
       buffer.append("' /></td> ");
       buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_XX'  onchange='chang(this)' value='");
       buffer.append(delNull(String.valueOf(list.get(i).get("XX"))));
       buffer.append("' /></td> ");
       buffer.append("</tr>");
     }
      
      buffer.append("</table>");
      return  buffer.toString();
      
  }
  public String getZjqkNd(List<Map<String, Object>> list,List<Map<String, Object>> list2){
      StringBuffer buffer = new StringBuffer();
      buffer.append("<table width='900px' id='firstTable'><tr id='title' class='tr01'><td width='50px'>编号</td><td width='50px' colspan='2'>写字楼名称</td><td width='50px'>一月</td><td width='50px'>二月</td><td width='50px'>三月</td><td width='50px'>四月</td><td width='50px'>五月</td><td  width='50px'>六月</td><td width='50px'>七月</td><td  width='50px'>八月</td> <td width='50px'>九月</td><td width='50px'>十月</td><td width='50px'>十一月</td><td width='50px'>十二月</td></tr>");
      for(int i=0;i<list.size();i++){
          buffer.append("<tr>");
          buffer.append("<td rowspan='2'> ");
          buffer.append(delNull(String.valueOf(list.get(i).get("BH"))));
          buffer.append("</td> ");
          buffer.append("<td rowspan='2'> ");
          buffer.append(delNull(String.valueOf(list.get(i).get("XZLMC"))));
          buffer.append("</td> ");
          buffer.append("<td> 租金</td>");
          buffer.append("<td> <input id='"+list.get(i).get("yw_guid")+"_YY' onchange='chang(this)' value=' ");
          buffer.append(delNull(String.valueOf(list.get(i).get("YY"))));
          buffer.append("'/></td> ");
          buffer.append("<td> <input id='"+list.get(i).get("yw_guid")+"_EY' onchange='chang(this)' value='  ");
          buffer.append(delNull(String.valueOf(list.get(i).get("EY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SY' onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("SY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SIY' onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("SIY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_WY' onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("WY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_LY' onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("LY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_QY' onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("QY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_BAY' onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("BAY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_JY'  onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("JY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SHIY'  onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("SHIY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SYY'  onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("SYY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list.get(i).get("yw_guid")+"_SEY'  onchange='chang(this)' value='");
          buffer.append(delNull(String.valueOf(list.get(i).get("SEY"))));
          buffer.append("'/></td> ");
          buffer.append("</tr>");
          
          buffer.append("<tr>");
          buffer.append("<td>均价</td>");
          buffer.append("<td> <input id='"+list2.get(i).get("yw_guid")+"_YY' onchange='cha(this)' value=' ");
          buffer.append(delNull(String.valueOf(list2.get(i).get("YY"))));
          buffer.append("'/></td> ");
          buffer.append("<td> <input id='"+list2.get(i).get("yw_guid")+"_EY' onchange='cha(this)' value='  ");
          buffer.append(delNull(String.valueOf(list2.get(i).get("EY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_SY' onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("SY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_SIY' onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("SIY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_WY' onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("WY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_LY' onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("LY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_QY' onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("QY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_BAY' onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("BAY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_JY'  onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("JY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_SHIY'  onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("SHIY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_SYY'  onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("SYY"))));
          buffer.append("'/></td> ");
          buffer.append("<td>  <input id='"+list2.get(i).get("yw_guid")+"_SEY'  onchange='cha(this)' value='");
          buffer.append(delNull(String.valueOf(list2.get(i).get("SEY"))));
          buffer.append("'/></td> ");
          
          buffer.append("</tr>");
        }
         
         buffer.append("</table>");
         return  buffer.toString();
  }
    
    
    

}
