package com.klspta.model.CBDReport;

import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.model.CBDReport.tablestyle.TableStyleDefault;

public class TableBuilder {
    
    public StringBuffer prase(String tableWidth, Map<String, TRBean> c, ITableStyle its) {
        StringBuffer html = new StringBuffer(its.getTable1().replace("#TABLEWIDTH", tableWidth));
        Iterator<Map.Entry<String, TRBean>> iter = c.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry<String, TRBean> entry = (Map.Entry<String, TRBean>) iter.next();
            TRBean val = (TRBean) entry.getValue();
            html.append(buildTR(val, its));
        }
        return html.append(its.getTable2());
    }

    public StringBuffer prase(String tableWidth, Map<String, TRBean> c) {
        return prase(tableWidth, c, new TableStyleDefault());
    }

    private StringBuffer buildTR(TRBean trBean, ITableStyle its) {
        if (trBean != null) {
            Vector<TDBean> tdBeans = trBean.getTDBeans();
            StringBuffer tds = new StringBuffer(its.getTR1().replace("#TRCSS", trBean.getCssStyle()));
            for (int j = 0; j < tdBeans.size(); j++) {
                tds.append(buildTD(tdBeans.get(j), its));
            }
            return tds.append(its.getTR2());
        }
        return null;
    }

    private String buildTD(TDBean tdBean, ITableStyle its) {
        String html = its.getTD1();
        html = html.replace("#HEIGHT", null2String(tdBean.getHeight()));
        html = html.replace("#WIDTH", null2String(tdBean.getWidth()));
        html = html.replace("#COLSPAN", null2String(tdBean.getColspan()));
        html = html.replace("#ROWPAN", null2String(tdBean.getRowspan()));
        html = html.replace("#TEXT", null2String(tdBean.getText()));
        return html;
    }
    
    private String null2String(String input){
        if(input == null){
            return "";
        }else{
            return input;
        }
    }
    
    public StringBuffer getErrorMsg(Exception e, ITableStyle its){
        return its.getErrorMsg(e);
    }
}
