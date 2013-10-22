package com.klspta.model.CBDReport;

import java.util.Map;

import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;

public class CBDReportManager {
	
	private FirstWorker firstWorker = new FirstWorker();
	
    public String getReport(String reportId, Object[] where, ITableStyle its){
        Map<String, TRBean> c = firstWorker.build("TEST", where);
        TableBuilder tableBuilder = new TableBuilder();
        String s = tableBuilder.prase(c, its);
        System.out.println(s);
    	return s;
    }
}
