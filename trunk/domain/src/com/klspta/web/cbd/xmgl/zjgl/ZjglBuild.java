package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;




public class ZjglBuild {
    static ZjglData zjglData= new ZjglData();
    /****
     * 
     * <br>Description:构建title
     * <br>Author:朱波海
     * <br>Date:2013-12-19
     * @return
     */
   public static StringBuffer  buildTitle(){
       StringBuffer Buffer = new StringBuffer();
       Buffer.append("<table  width='1350px'>" +
       		"<tr bgcolor='#C0C0C0' >" +
       		"<td rowspan='3'  align='center' width='200px' ><h3>类别</h3></td>" +
       		"<td rowspan='3'  align='center' width='50px'><h3>预算费用</h3></td>" +
       		"<td rowspan='3' colspan='2' align='center' width='120px'><h3>累计已缴纳/已审批资金</h3></td>" +
       		"<td rowspan='2' colspan='2' align='center' width='200'><h3>累计发生(或返还)费用</h3></td><td rowspan='3'  align='center' width='80'><h3>期初余额</h3></td>" +
       		"<td colspan='12'  align='center' width='600' ><h3>xx年资金审批</h3></td>" +
       		"<td  rowspan='3'  align='center' width='80px'><h3>XX年度流入/审批</h3></td>" +
       		"</tr>" +
       	   "<tr bgcolor='#C0C0C0'>" +
       	   "<td colspan='3' align='center' width='150px'><h3>一季度</h3></td>" +
       	   "<td colspan='3' align='center' width='150'><h3>二季度</h3></td>" +
       	   "<td colspan='3' align='center' width='150'><h3>三季度</h3></td>" +
       	   "<td colspan='3' align='center' width='150px'><h3>四季度</h3></td>" +
       	   "</tr>" +
       		"<tr bgcolor='#C0C0C0'>" +
       		"<td align='center' width='60px'><h3>已发生/到账</h3></td>" +
       		"<td align='center' width='60px'><h3>资金进度</h3></td>" +
       		"<td align='center' width='50px'><h3>一月</h3></td>" +
       		"<td align='center' width='50px'><h3>二月</h3></td>" +
       		"<td align='center' width='50'><h3>三月</h3></td>" +
       		"<td align='center' width='50'><h3>四月</h3></td><" +
       		"td align='center' width='50px' height='50px'><h3>五月</h3></td>" +
       		"<td align='center' width='50px'><h3>六月</h3>" +
       		"</td> <td align='center' width='50px'><h3>七月</h3></td>" +
       		"<td align='center' width='50px'><h3>八月</h3></td>" +
       		"<td align='center' width='50px'><h3>九月</h3></td>" +
       		"<td align='center' width='50px'><h3>十月</h3></td>" +
       		"<td align='center' width='70px'><h3>十一月</h3></td>" +
       		"<td align='center' width='70px'><h3>十二月</h3></td> " +
       		"</tr>");
       return Buffer;
   }
   public static  StringBuffer buildZjlr(String yw_guid){
      StringBuffer stringBuffer = new StringBuffer();
       List<Map<String, Object>> list = zjglData. getZJGL_ZJLR(yw_guid);
       if (list!=null) {
       for (int i=0;i<list.size();i++){
         stringBuffer.append("<tr>"+
         "<td ><input type='text' style='width:150px;' onchange='addrzxq(this); return false' value='"+
         delNull(String.valueOf( list.get(i).get("lb")))+  "'/></td>"+
        "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("ysfy")))+ "'/></td>"+
        "<td colspan='2'><input type='text' style='width:45px;' onchange='addrzxq(this); return false' value='" +
        delNull( String.valueOf( list.get(i).get("lj")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+  "'/></td>"+
        "<td><input type='text' style='width:45px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("ZJJD")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("CQYE")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("YY")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("EY")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SANY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SIY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("WY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("LY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("QY")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("BAY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("JY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull( String.valueOf( list.get(i).get("SIYUE")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SYY")))+ "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SEY")))+  "'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("LRSP")))+ "'/></td>"+
        "</tr>" );
         
       }
       }
       return stringBuffer;
       
   }
   
  public static StringBuffer buildZjzc_father(String yw_guid,String type){
      List<Map<String, Object>> list = zjglData. getZJGL_father(yw_guid, type);
      StringBuffer  stringBuffer=  new StringBuffer();
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
        stringBuffer.append("<tr>"+
        "<td  rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='"+
        delNull(String.valueOf(list.get(i).get("LB")))+  "'/></td>"+
       "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("YSFY")))+ "'/></td>"+
       "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("LJ")))+ "'/></td>"+
      "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
      delNull(String.valueOf(list.get(i).get("LJ2")))+  "'/></td>"+
       "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'/></td>"+
       "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("CQYE")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("YY")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("EY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SANY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SIY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("WY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("LY")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("QY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("BAY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("JY")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SYY")))+  "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SEY")))+ "'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("LRSP")))+ "'/></td>"+
       "</tr>");
      }else{
          stringBuffer.append("<tr>"+
                  delNull(String.valueOf(list.get(i).get("YSFY")))+ "</td>"+
                 "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("LJ")))+ "'/></td>"+
                 "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("LJ1")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("CQYE")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("YY")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("EY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SANY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SIY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("WY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("LY")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("QY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("BAY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("JY")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SIYUE")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(  String.valueOf(list.get(i).get("SYY")))+  "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SEY")))+ "'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("LRSP")))+ "'/></td>"+
                 "</tr>");
      }
      }
      }
      
      return stringBuffer;
  } 
 
  public static StringBuffer buildZjzc_child(String yw_guid ,String tree_name,String type){
       StringBuffer stringBuffer = new StringBuffer();
      List<Map<String, Object>> list = zjglData. getZJGL_child(yw_guid,tree_name,type);
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
              stringBuffer.append("<tr>"+
                      "<td  rowspan='8'><input type='text' style='width:150px;' onchange='addrzxq(this); return false' value='"+
                      delNull(String.valueOf(list.get(i).get("LB")))+  "'/></td>"+
                     "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("YSFY")))+ "'/></td>"+
                     "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("LJ")))+ "'/></td>"+
                    "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                    delNull(String.valueOf(list.get(i).get("LJ2")))+  "'/></td>"+
                     "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'/></td>"+
                     "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("ZJJD")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("CQYE")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("YY")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("EY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("SANY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("SIY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("WY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("LY")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("QY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("BAY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("JY")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("SIYUE")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("SYY")))+  "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SEY")))+ "'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("LRSP")))+ "'/></td>"+
                     "</tr>");
                    }else{
                        stringBuffer.append("<tr>"+
                               "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("LJ")))+ "'/></td>"+
                              "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                              delNull( String.valueOf(list.get(i).get("LJ2")))+  "'/></td>"+
                               "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("YFSDZ")))+ "'/></td>"+
                               "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("CQYE")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("YY")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("EY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("SANY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("SIY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("WY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("LY")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("QY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("BAY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("JY")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("SYY")))+  "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull( String.valueOf(list.get(i).get("SEY")))+ "'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("LRSP")))+ "'/></td>"+
                               "</tr>");
      }
      }
      } 
      return stringBuffer;
  } 
  
  public static String delNull(String str){
      if(str.equals("null")){
          return "";
      }else {
        return str;
    }
      
  }
 
}
