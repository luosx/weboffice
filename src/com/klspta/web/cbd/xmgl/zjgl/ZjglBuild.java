package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

/***
 * 
 * <br>Title:资金管理前台展现处理类
 * <br>Description:
 * <br>Author:朱波海
 * <br>Date:2013-12-26
 */

public class ZjglBuild {
    /****
     * 
     * <br>Description:构建title
     * <br>Author:朱波海
     * <br>Date:2013-12-19
     * @return
     */
   public static StringBuffer  buildTitle(String year){
       StringBuffer Buffer = new StringBuffer();
       Buffer.append("<table  width='1900px'>" +
       		"<tr class='tr01' style='text-align:center' >" +
       		"<td rowspan='3' align='center' width='20%' class='tr01'><div  width='200px'>类别<div></td>" +
       		"<td rowspan='3'  align='center' width='80px' class='tr01'>预算费用</td>" +
       		"<td rowspan='3' colspan='2' align='center' width='260px' class='tr01'>累计已缴纳/已审批资金</td>" +
       		"<td rowspan='2' colspan='2' align='center' width='200' class='tr01'>累计发生(或返还)费用</td>" +
       		"<td rowspan='3'  align='center' width='80px' class='tr01'>期初余额</td>" +
       		"<td colspan='12'  align='center' width='1000px' class='tr01'>"+year+"年资金审批</td>" +
       		"<td  rowspan='3'  align='center' width='80px' class='tr01'>"+year+"年度流入/审批</td>" +
       		"</tr>" +
       		
       	   "<tr class='tr01'>" +
       	   "<td colspan='3' align='center' width='250px' class='tr01'>一季度</td>" +
       	   "<td colspan='3' align='center' width='250px' class='tr01'>二季度</td>" +
       	   "<td colspan='3' align='center' width='250px' class='tr01'>三季度</td>" +
       	   "<td colspan='3' align='center' width='250px' class='tr01'>四季度</td>" +
       	   "</tr>" +
       	   
       		"<tr class='tr01'>" +
       		"<td align='center' width='130px' class='tr01'>已发生/到账</td>" +
       		"<td align='center' width='130px' class='tr01'>资金进度</td>" +
       		"<td align='center' width='83px' class='tr01'>一月</td>" +
       		"<td align='center' width='83px' class='tr01'>二月</td>" +
       		"<td align='center' width='83px' class='tr01'>三月</td>" +
       		"<td align='center' width='83px' class='tr01'>四月</td><" +
       		"td align='center' width='83px' class='tr01'>五月</td>" +
       		"<td align='center' width='83px' class='tr01'>六月</td> " +
       		"<td align='center' width='83px' class='tr01'>七月</td>" +
       		"<td align='center' width='83px' class='tr01'>八月</td>" +
       		"<td align='center' width='83px' class='tr01'>九月</td>" +
       		"<td align='center' width='83px' class='tr01'>十月</td>" +
       		"<td align='center' width='83px' class='tr01'>十一月</td>" +
       		"<td align='center' width='83px' class='tr01'>十二月</td> " +
       		"</tr>");
       return Buffer;
   }
   
   public static  StringBuffer buildZjlr(List<Map<String, Object>> list){
      StringBuffer stringBuffer = new StringBuffer();
       if (list!=null) {
       for (int i=0;i<list.size();i++){
         stringBuffer.append("<tr><td width='200px' class='tr04'>"+
         delNull(String.valueOf( list.get(i).get("lb")))+
        "</td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("ysfy")))+ "'  id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@2'/></td><td colspan='2' class='tr04'><input class='tr04' type='text' style='width:180px;' onchange='addzjlr(this); return false' value='" +
        delNull( String.valueOf( list.get(i).get("lj")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
       "@3'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@4'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("ZJJD")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@5'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("CQYE")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@6'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf( list.get(i).get("YY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@7'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("EY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@8'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SANY")))+  "' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@9'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SIY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@10'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("WY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@11'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("LY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@12'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("QY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@13'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("BAY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@14'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("JY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@15'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull( String.valueOf( list.get(i).get("SIYUE")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@16'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SYY")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@17'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("SEY")))+  " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@18'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;' onchange='addzjlr(this); return false' value='" +
        delNull(String.valueOf(list.get(i).get("LRSP")))+ " ' id='lr@"+String.valueOf( list.get(i).get("status"))+
        "@19'/></td></tr>" );
       }
       }
       return stringBuffer;
       
   }
   /*****
    * view
    */
   public static  StringBuffer buildZjlr_sum(List<Map<String, Object>> list){
       StringBuffer stringBuffer = new StringBuffer();
        if (list!=null) {
        for (int i=0;i<list.size();i++){
          stringBuffer.append("<tr><td width='200px' class='tr02'>"+
          delNull(String.valueOf( list.get(i).get("lb")))+ 
          " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("ysfy")))+ 
         " </td><td colspan='2' class='tr02'>" +
         delNull( String.valueOf( list.get(i).get("lj")))+ 
         " </td><td class='tr02'>" +
        delNull(String.valueOf(list.get(i).get("YFSDZ")))+ 
        " </td><td class='tr02' >" +
         delNull(String.valueOf( list.get(i).get("ZJJD")))+
         " </td><td class='tr02'>" +
         delNull(String.valueOf( list.get(i).get("CQYE")))+
         " </td><td class='tr02'>" +
         delNull(String.valueOf( list.get(i).get("YY")))+
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("EY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("SANY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("SIY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("WY")))+
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("LY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("QY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("BAY")))+ 
         " </td><td class='tr02' >" +
         delNull(String.valueOf(list.get(i).get("JY")))+ 
         " </td><td class='tr02'>" +
         delNull( String.valueOf( list.get(i).get("SIYUE")))+
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("SYY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("SEY")))+ 
         " </td><td class='tr02'>" +
         delNull(String.valueOf(list.get(i).get("LRSP")))+ 
         "</td></tr>" );
        }
        }
        return stringBuffer;
        
    }
  public static StringBuffer buildZjzc_father_sum(List<Map<String, Object>> list){
      StringBuffer  stringBuffer=  new StringBuffer();
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
        stringBuffer.append("<tr><td  rowspan='8' class='tr03'>"+
        delNull(String.valueOf(list.get(i).get("LB")))+ 
       "</td><td rowspan='8' class='tr03'>" +
       delNull( String.valueOf(list.get(i).get("YSFY")))+ 
       "</td><td width:'200px' class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("LJ")))+
      "</td><td  class='tr03'>" +
      delZer(String.valueOf(list.get(i).get("JL2")))+ 
       "</td><td rowspan='8' class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+ 
       "</td><td rowspan='8' class='tr03'>" +
       delNull( String.valueOf(list.get(i).get("ZJJD")))+
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("CQYE")))+
       "</td><td class='tr03'>" +
       delNull( String.valueOf(list.get(i).get("YY")))+
       "</td><td class='tr03'>"+
       delNull( String.valueOf(list.get(i).get("EY")))+ 
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("SANY")))+  
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("SIY")))+ 
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("WY")))+  
       "</td><td class='tr03'>" +
       delNull( String.valueOf(list.get(i).get("LY")))+ 
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("QY")))+  
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("BAY")))+ 
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("JY")))+
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("SIYUE")))+
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("SYY")))+ 
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("SEY")))+ 
       "</td><td class='tr03'>" +
       delNull(String.valueOf(list.get(i).get("LRSP")))+ 
       "</td></tr>");
      }else{
          stringBuffer.append("<tr><td class='tr03'>"+
                  delNull(String.valueOf(list.get(i).get("LJ")))+ "</td><td class='tr03'>"+
                  delZer(String.valueOf(list.get(i).get("JL2")))+ "</td> <td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("CQYE")))+ 
                     " </td><td class='tr03'>" +
                     delNull( String.valueOf(list.get(i).get("YY")))+ 
                     " </td><td class='tr03'>" +
                     delNull( String.valueOf(list.get(i).get("EY")))+  
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("SANY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("SIY")))+  
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("WY")))+  
                     " </td><td class='tr03'>" +
                     delNull( String.valueOf(list.get(i).get("LY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("QY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("BAY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("JY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("SIYUE")))+
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("SYY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("SEY")))+ 
                     " </td><td class='tr03'>" +
                     delNull(String.valueOf(list.get(i).get("LRSP")))+ 
                     "</td></tr>");
      }
      }
      }
      
      return stringBuffer;
  } 
 
  public static StringBuffer buildZjzc_father(List<Map<String, Object>> list){
      StringBuffer  stringBuffer=  new StringBuffer();
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
        stringBuffer.append("<tr><td  rowspan='8' class='tr04'>"+
        delNull(String.valueOf(list.get(i).get("LB")))+ 
       "</td><td rowspan='8' class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("YSFY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) 
       +"@2'/></td><td width:'200px' class='tr04'>" +
       delNull(String.valueOf(list.get(i).get("LJ")))+
      "</td><td  class='tr04'>" +
      delZer(String.valueOf(list.get(i).get("JL2")))+ 
       "</td><td rowspan='8' class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@5'/></td><td rowspan='8' class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@6'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@7'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb"))+"@"+String.valueOf( list.get(i).get("sort")) +
       "@8'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@9'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@10'/></td><td class='tr04'><input type='text' class='tr04' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@11'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@12'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@13'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@14'/></td><td class='tr04'><input class='tr04'  type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@15'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@16'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@17'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@18'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@19'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
       delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
       "@20'/></td></tr>");
      }else{
          stringBuffer.append("<tr><td class='tr04' width='200px'>"+
                 // delNull(String.valueOf(list.get(i).get("YSFY")))+ "</td><td class='tr04'>"+
                  delNull(String.valueOf(list.get(i).get("LJ")))+ "</td><td class='tr04'>"+
                  delZer(String.valueOf(list.get(i).get("JL2")))+ "</td>"+
                    "  <td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@7'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb"))+"@"+String.valueOf( list.get(i).get("sort")) +
                     "@8'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@9'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@10'/></td><td class='tr04'><input type='text' class='tr04' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@11'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@12'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@13'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@14'/></td><td class='tr04'><input class='tr04'  type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@15'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@16'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@17'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@18'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@19'/></td><td class='tr04'><input class='tr04' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@20'/></td></tr>");
      }
      }
      }
      
      return stringBuffer;
  } 
  
  public static StringBuffer buildZjzc_father_view(List<Map<String, Object>> list){
      StringBuffer  stringBuffer=  new StringBuffer();
      if (list!=null) {
      for (int i=0;i<list.size();i++){
          if(i==0){
        stringBuffer.append("<tr><td  rowspan='8' class='tr04'>"+
        delNull(String.valueOf(list.get(i).get("LB")))+ 
       "</td><td rowspan='8' class='tr04'>"+
       delNull( String.valueOf(list.get(i).get("YSFY")))+
       "</td><td width:'200px' class='tr04'>" +
       delNull(String.valueOf(list.get(i).get("LJ")))+
      "</td><td  class='tr04'>" +
      delZer(String.valueOf(list.get(i).get("JL2")))+ 
       "</td><td rowspan='8' class='tr04'>"+
       delNull(String.valueOf(list.get(i).get("YFSDZ")))+
       "</td><td rowspan='8' class='tr04'>"+
       delNull( String.valueOf(list.get(i).get("ZJJD")))+ 
       "</td><td class='tr04'>"+
       delNull(String.valueOf(list.get(i).get("CQYE")))+
       "</td><td class='tr04'>"+
       delNull( String.valueOf(list.get(i).get("YY")))+ 
       "</td><td class='tr04'>"+
       delNull( String.valueOf(list.get(i).get("EY")))+ 
       "</td><td class='tr04'>"+
       delNull(String.valueOf(list.get(i).get("SANY")))+
       "</td><td class='tr04'>"+
       delNull(String.valueOf(list.get(i).get("SIY")))+ 
       "</td><td class='tr04'>" +
       delNull(String.valueOf(list.get(i).get("WY")))+ 
       "</td><td class='tr04'>" +
       delNull( String.valueOf(list.get(i).get("LY")))+ 
       "</td><td class='tr04'>" +
       delNull(String.valueOf(list.get(i).get("QY")))+
       "</td><td class='tr04'>" +
       delNull(String.valueOf(list.get(i).get("BAY")))+  
       "</td><td class='tr04'>" +
       delNull(String.valueOf(list.get(i).get("JY")))+ 
       " </td><td class='tr04'> " +
       delNull(String.valueOf(list.get(i).get("SIYUE")))+
       " </td><td class='tr04'> " +
       delNull(String.valueOf(list.get(i).get("SYY")))+ 
       " </td><td class='tr04'> " +
       delNull(String.valueOf(list.get(i).get("SEY")))+ 
       " </td><td class='tr04'> " +
       delNull(String.valueOf(list.get(i).get("LRSP")))+ 
       " </td></tr>");
      }else{
          stringBuffer.append("<tr><td class='tr04'>"+
                 // delNull(String.valueOf(list.get(i).get("YSFY")))+ "</td><td class='tr04'>"+
                  delNull(String.valueOf(list.get(i).get("LJ")))+ "</td><td class='tr04'>"+
                  delZer(String.valueOf(list.get(i).get("JL2")))+ "</td>"+
                    " <td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("CQYE")))+ 
                     "</td><td class='tr04'> " +
                     delNull( String.valueOf(list.get(i).get("YY")))+  
                     " </td><td class='tr04'> " +
                     delNull( String.valueOf(list.get(i).get("EY")))+  
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("SANY")))+  
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("SIY")))+   
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("WY")))+  
                     " </td><td class='tr04'> " +
                     delNull( String.valueOf(list.get(i).get("LY")))+  
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("QY")))+   
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("BAY")))+  
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("JY")))+  
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("SIYUE")))+ 
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("SYY")))+  
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("SEY")))+ 
                     " </td><td class='tr04'> " +
                     delNull(String.valueOf(list.get(i).get("LRSP")))+  
                     " </td></tr>");
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
              stringBuffer.append("<tr><td  rowspan='8'>"+
                      delNull(String.valueOf(list.get(i).get("LB")))+
                      " </td><td rowspan='8'><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("YSFY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) 
                     +"@2'/></td><td width='200px'>" +
                     delNull(String.valueOf(list.get(i).get("LJ")))+
                     "</td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                    delNull(String.valueOf(list.get(i).get("JL2")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                    "@4'/></td><td  ><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@5'/></td><td ><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@6'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@7'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@8'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@9'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@10'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@11'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@12'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@13'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@14'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@15'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@16'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@17'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@18'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@19'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                     delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                     "@20'/></td></tr>");
                    }else{
                        stringBuffer.append("<tr><td width='200px'>" +
                                delNull(String.valueOf(list.get(i).get("LJ")))+ "</td>"+
                               "<td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                               delNull(String.valueOf(list.get(i).get("LJ2")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                               "@4'/></td><td ><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("YFSDZ")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@5'/></td><td ><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("ZJJD")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@6'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("CQYE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb")) +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@7'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("YY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@8'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("EY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@9'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SANY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@10'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SIY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@11'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("WY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@12'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull( String.valueOf(list.get(i).get("LY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@13'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("QY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@14'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("BAY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@15'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("JY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@16'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SIYUE")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@17'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SYY")))+  "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@18'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("SEY")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@19'/></td><td><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='" +
                                delNull(String.valueOf(list.get(i).get("LRSP")))+ "'id='"+String.valueOf( list.get(i).get("status"))+"@"+ String.valueOf( list.get(i).get("lb"))  +"@"+String.valueOf( list.get(i).get("sort")) +
                                "@20'/></td></tr>");
      }
      }
      } 
      return stringBuffer;
  } 
  
  public static StringBuffer buildZjzc_child_view(List<Map<String, Object>> list){
      StringBuffer stringBuffer = new StringBuffer();
     if (list!=null) {
     for (int i=0;i<list.size();i++){
         if(i==0){
             stringBuffer.append("<tr><td  rowspan='8'>"+
                     delNull(String.valueOf(list.get(i).get("LB")))+
                     " </td><td rowspan='8'> " +
                    delNull( String.valueOf(list.get(i).get("YSFY")))+ 
                    "</td><td width='200px'>" +
                    delNull(String.valueOf(list.get(i).get("LJ")))+
                    "</td><td> " +
                   delNull(String.valueOf(list.get(i).get("JL2")))+  
                   "</td><td  > " +
                    delNull(String.valueOf(list.get(i).get("YFSDZ")))+  
                    "</td><td > " +
                    delNull( String.valueOf(list.get(i).get("ZJJD")))+  
                    "</td><td> " +
                    delNull(String.valueOf(list.get(i).get("CQYE")))+  
                    " </td><td> " +
                    delNull( String.valueOf(list.get(i).get("YY")))+ 
                    " </td><td> " +
                    delNull( String.valueOf(list.get(i).get("EY")))+ 
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("SANY")))+ 
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("SIY")))+  
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("WY")))+  
                    " </td><td> " +
                    delNull( String.valueOf(list.get(i).get("LY")))+ 
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("QY")))+  
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("BAY")))+ 
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("JY")))+ 
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("SIYUE")))+
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("SYY")))+  
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("SEY")))+ 
                    " </td><td> " +
                    delNull(String.valueOf(list.get(i).get("LRSP")))+ 
                    " </td></tr>");
                   }else{
                       stringBuffer.append("<tr><td width='200px'>" +
                               delNull(String.valueOf(list.get(i).get("LJ")))+
                               "</td><td> " +
                              delNull(String.valueOf(list.get(i).get("LJ2")))+   
                              " </td><td > " +
                               delNull(String.valueOf(list.get(i).get("YFSDZ")))+ 
                               " </td><td > " +
                               delNull( String.valueOf(list.get(i).get("ZJJD")))+ 
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("CQYE")))+ 
                               " </td><td> " +
                               delNull( String.valueOf(list.get(i).get("YY")))+  
                               " </td><td> " +
                               delNull( String.valueOf(list.get(i).get("EY")))+   
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("SANY")))+  
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("SIY")))+  
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("WY")))+   
                               " </td><td> " +
                               delNull( String.valueOf(list.get(i).get("LY")))+  
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("QY")))+  
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("BAY")))+   
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("JY")))+ 
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("SIYUE")))+  
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("SYY")))+   
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("SEY")))+  
                               " </td><td> " +
                               delNull(String.valueOf(list.get(i).get("LRSP")))+  
                               " </td></tr>");
     }
     }
     } 
     return stringBuffer;
 } 
  
  public static String delNull(String str){
      if(str.equals("null")||str.equals("0")){
          return "";
      }else {
        return str;
    }
  }
  
  public static String delZer(String str){
      if(str.equals("null")||str.equals("")){
          return "0";
      }else {
        return str;
    }
  }
  
  
}
