package com.klspta.web.cbd.qyjc.common;

import java.util.List;
import java.util.Map;

public class BuildModel {
    public static  String []  Month={"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"};
    
    public void getTitle(String [] year){
        StringBuffer buffer = new StringBuffer();
        buffer.append("<table width='95%' cellpadding='0' cellspacing='0' id='esftable'>");
        buffer.append("<tr class='tr11'>");
        buffer.append("<td align='center' width='80px' height='50px'><h3>序号</h3></td><td align='center' width='120px'><h3>信息</h3></td>");
        for(int i=0;i<year.length;i++){
           for(int j=1;j<13;j++){
               buffer.append("<td align='center' width='90px'><h3>"+year[i]+"年"+j+"月</h3></td>");
           }
        }
        buffer.append("</tr ></table>");
    }
    
    /*****
     * 
     * <br>Description:一年可编辑状态
     * <br>Author:朱波海
     * <br>Date:2014-1-2
     */
    public void build_One_year(List<Map<String, Object>> list,String type){
        StringBuffer buffer = new StringBuffer();
        for(int i=0;i<list.size();i++){
            buffer.append("<tr><td width='90px'>");
            buffer.append( delNull(String.valueOf(list.get(i).get("BH"))));
            buffer.append("</td>");
            buffer.append("<td width='120px'><input type='text' style='width:110px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("XZLMC"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("YY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("EY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("SY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("SIY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("WY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("LY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("QY"))));
            buffer.append("'");
            buffer.append("</td>"); 
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("BAY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("JY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("SHIY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("SYY"))));
            buffer.append("'");
            buffer.append("</td>");
            buffer.append("<td width='90px'><input type='text' style='width:80px;' onchange='addzjlr(this); return false' value='");
            buffer.append( delNull(String.valueOf(list.get(i).get("SRY"))));
            buffer.append("'");
            buffer.append("</td>");
        }
        
    }
    
    
    public String delNull(String str){
        if(str.equals("null")){
            return "";
        }else {
            return str;
        }
        
        
    }
    
    
    
    
    

}
