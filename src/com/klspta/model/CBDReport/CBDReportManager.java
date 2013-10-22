package com.klspta.model.CBDReport;

import java.util.Map;

import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.model.CBDReport.tablestyle.TableStyleDefault;

public class CBDReportManager {
	
	private FirstWorker firstWorker = new FirstWorker();
	
	private static TableStyleDefault tableStyleDefault = new TableStyleDefault();
    
    public String getReport(String reportId){
        return getReport(reportId, null, tableStyleDefault);
    }
    
    public String getReport(String reportId, Object[] where){
        return getReport(reportId, where , tableStyleDefault);
    }
    
    public String getReport(String reportId, Object[] where, ITableStyle its){
        Map<String, TRBean> c = firstWorker.build("TEST", where);
        TableBuilder tableBuilder = new TableBuilder();
        String s = tableBuilder.prase(c, its);
        System.out.println(s);
        return s;
    }
}
