package com.klspta.model.CBDReport;

import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.model.CBDReport.tablestyle.TableStyleDefault;

public class TableBuilder {
    
    public String prase(Map<String, TRBean> c, ITableStyle its) {
        String html = its.getTable1();
        Iterator<Map.Entry<String, TRBean>> iter = c.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry<String, TRBean> entry = (Map.Entry<String, TRBean>) iter.next();
            TRBean val = (TRBean) entry.getValue();
            html = html + buildTR(val, its);
        }
        return html + its.getTable2();
    }

    public String prase(Map<String, TRBean> c) {
        return prase(c, new TableStyleDefault());
    }

    private String buildTR(TRBean trBean, ITableStyle its) {
        if (trBean != null) {
            Vector<TDBean> tdBeans = trBean.getTDBeans();
            String tds = its.getTR1();
            for (int j = 0; j < tdBeans.size(); j++) {
                String s = buildTD(tdBeans.get(j), its);
                tds = tds + s;
            }
            tds = tds.replace("#TRCSS", trBean.getCssStyle());
            return tds + its.getTR2();
        }
        return "";
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
}
