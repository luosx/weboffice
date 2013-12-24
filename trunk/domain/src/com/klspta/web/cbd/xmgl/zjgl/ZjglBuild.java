package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;



public class ZjglBuild {
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
       		"<tr class='title' >" +
       		"<td rowspan='3' align='center' width='200px' >类别</td>" +
       		"<td rowspan='3'  align='center' width='50px'>预算费用</td>" +
       		"<td rowspan='3' colspan='2' align='center' width='120px'>累计已缴纳/已审批资金</td>" +
       		"<td rowspan='2' colspan='2' align='center' width='200'>累计发生(或返还)费用</td><td rowspan='3'  align='center' width='80'><h3>期初余额</h3></td>" +
       		"<td colspan='12'  align='center' width='600' >xx年资金审批</td>" +
       		"<td  rowspan='3'  align='center' width='80px'>XX年度流入/审批</td>" +
       		"</tr>" +
       	   "<tr class='title'>" +
       	   "<td colspan='3' align='center' width='150px'><h3>一季度</h3></td>" +
       	   "<td colspan='3' align='center' width='150'><h3>二季度</h3></td>" +
       	   "<td colspan='3' align='center' width='150'><h3>三季度</h3></td>" +
       	   "<td colspan='3' align='center' width='150px'><h3>四季度</h3></td>" +
       	   "</tr>" +
       		"<tr class='title'>" +
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
   public static  StringBuffer buildZjlr(List<Map<String, Object>> list){
      StringBuffer stringBuffer = new StringBuffer();
       if (list!=null) {
       for (int i=0;i<list.size();i++){
         stringBuffer.append("<tr>"+
         "<td ><input type='text' style='width:180px;'   value='"+
         delNull(String.valueOf( list.get(i).get("lb")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@1'/></td>"+
        "<td ><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("ysfy")))+ "'  id='lr@"+String.valueOf( list.get(i).get("status"))+"@2'/></td>"+
        "<td colspan='2'><input type='text' style='width:45px;' onchange='addzjlr(this); return false' value='" +
        delNull( String.valueOf( list.get(i).get("lj")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@3'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@4'/></td>"+
        "<td><input type='text' style='width:45px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("ZJJD")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@5'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("CQYE")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@6'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("YY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@7'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("EY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@8'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SANY")))+  "' id='lr@"+String.valueOf( list.get(i).get("status"))+"@9'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SIY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@10'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("WY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@11'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("LY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@12'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("QY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@13'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("BAY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@14'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("JY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@15'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull( String.valueOf( list.get(i).get("SIYUE")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@16'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SYY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@17'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SEY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@18'/></td>"+
        "<td><input type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("LRSP")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+"@19'/></td>"+
        "</tr>" );
         
       }
       }
       return stringBuffer;
       
   }
   
  public static StringBuffer buildZjzc_father(List<Map<String, Object>> list){
      StringBuffer  stringBuffer=  new StringBuffer();
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
        stringBuffer.append("<tr>"+
        "<td  rowspan='8'><input type='text' style='width:180px;'  value='"+
        delNull(String.valueOf(list.get(i).get("LB")))+  "' id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@1'/></td>"+
       "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("YSFY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@2'/></td>"+
       "<td ><input type='text' style='width:90px;'  value='" +
       delNull(String.valueOf(list.get(i).get("LJ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@3'/></td>"+
      "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
      delNull(String.valueOf(list.get(i).get("LJ2")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@4'/></td>"+
       "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@5'/></td>"+
       "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@6'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@7'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb"))+"@"+String.valueOf( list.get(i).get("sort")) +"@8'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@9'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@10'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@11'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@12'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@13'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@14'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@15'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@16'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@17'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@18'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@19'/></td>"+
       "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@20'/></td>"+
       "</tr>");
      }else{
          stringBuffer.append("<tr>"+
                  delNull(String.valueOf(list.get(i).get("YSFY")))+ "</td>"+
                 "<td ><input type='text' style='width:90px;'  value='" +
                 delNull(String.valueOf(list.get(i).get("LJ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@3'/></td>"+
                 "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("LJ1")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@4'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@7'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@8'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@9'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@10'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@11'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@12'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@13'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@14'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@15'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@16'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@17'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull(  String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@18'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@19'/></td>"+
                 "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                 delNull( String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@20'/></td>"+
                 "</tr>");
      }
      }
      }
      
      return stringBuffer;
  } 
 
  public static StringBuffer buildZjzc_child(List<Map<String, Object>> list){
       StringBuffer stringBuffer = new StringBuffer();
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
              stringBuffer.append("<tr>"+
                      "<td  rowspan='8'><input type='text' style='width:90px;'  value='"+
                      delNull(String.valueOf(list.get(i).get("LB")))+  " 'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@1'/></td>"+
                     "<td rowspan='8'><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("YSFY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@2'/></td>"+
                     "<td ><input type='text' style='width:90px;'  value='" +
                     delNull(String.valueOf(list.get(i).get("LJ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@3'/></td>"+
                    "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                    delNull(String.valueOf(list.get(i).get("LJ2")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@4'/></td>"+
                     "<td  ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@5'/></td>"+
                     "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@6'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@7'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@8'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@9'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@10'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@11'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@12'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@13'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@14'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@15'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@16'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@17'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@18'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@19'/></td>"+
                     "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@20'/></td>"+
                     "</tr>");
                    }else{
                        stringBuffer.append("<tr>"+
                                "<td ><input type='text' style='width:90px;'  value='" +
                                delNull(String.valueOf(list.get(i).get("LJ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@3'/></td>"+
                               "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("LJ2")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@4'/></td>"+
                                "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@5'/></td>"+
                                "<td ><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@6'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +"@7'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@8'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@9'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@10'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@11'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@12'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@13'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@14'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@15'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@16'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@17'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@18'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@19'/></td>"+
                                "<td><input type='text' style='width:90px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +"@20'/></td>"+
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
