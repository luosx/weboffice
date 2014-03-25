package com.klspta.model.CBDReport.tablestyle.old;
public class TableStylePlan {



    public String getTD1() {
        return "<td height='#HEIGHT' width='#WIDTH' colspan='#COLSPAN' rowspan='#ROWPAN' style='#STYLE' >#TEXT</td>";
    }


    public String getTD2() {
        return "</td>";
    }

    public String getTR1() {
        return "<tr class='#TRCSS'>";
    }

    public String getTR2() {
        return "</tr>";
    }


    public String getTable1() {
        return "<table width='#TABLEWIDTH' border=\"1\" cellpadding=\"1\" cellspacing=\"0\">";
    }


    public String getTable2() {
        return "</table>";
    }
}
