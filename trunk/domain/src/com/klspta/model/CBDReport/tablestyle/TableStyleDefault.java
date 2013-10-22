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
        return "<table width=\"1000\" border=\"1\" cellpadding=\"1\" cellspacing=\"0\">";
    }

    @Override
    public String getTable2() {
        return "</table>";
    }

}
