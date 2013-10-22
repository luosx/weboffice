package com.klspta.model.CBDReport.tablestyle;

public class TableStyleDefault implements ITableStyle {

    @Override
    public String getTD1() {
        return "<td height='#HEIGHT' width='#WIDTH' colspan='#COLSPAN' rowspan='#ROWPAN'>#TEXT</td>";
    }

    @Override
    public String getTD2() {
        return "</td>";
    }

    @Override
    public String getTR1() {
        return "<tr class='#TRCSS'>";
    }

    @Override
    public String getTR2() {
        return "</tr>";
    }

    @Override
    public String getTable1() {
        return "<table width='#TABLEWIDTH' border=\"1\" cellpadding=\"1\" cellspacing=\"0\">";
    }

    @Override
    public String getTable2() {
        return "</table>";
    }
    
    public String getErrorMsg(Exception e){

        String s = "<font size='5' color='#990900'>数据生成失败，请稍后重试或联系管理员！</font><br>------<br>";
        StackTraceElement[] ele = e.getStackTrace();
        for(int i = 0; i < ele.length; i++){
            s = s + "<font size='1' color='#000001'><input style='display:none' value='aaa'><br>" + ele[i].getClassName() + "." + ele[i].getMethodName() + "&nbsp&nbsp&nbsp" + ele[i].getLineNumber() +"</font>";
        }
        s = s+ "</input>";
        return s;
    }

}
