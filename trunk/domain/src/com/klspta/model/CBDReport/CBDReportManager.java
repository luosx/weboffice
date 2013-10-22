package com.klspta.model.CBDReport;

import java.util.Map;

import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.model.CBDReport.tablestyle.TableStyleDefault;
public class CBDReportManager {
	
	private FirstWorker firstWorker = new FirstWorker();
	
	private static TableStyleDefault tableStyleDefault = new TableStyleDefault();
    
    public StringBuffer getReport(String reportId){
        return getReport(reportId, null, tableStyleDefault, null);
    }
    
    public StringBuffer getReport(String reportId, String tableWidth){
        return getReport(reportId, null, tableStyleDefault, tableWidth);
    }
    
    public StringBuffer getReport(String reportId, Object[] where){
        return getReport(reportId, where, tableStyleDefault, null);
    }
    
    public StringBuffer getReport(String reportId, ITableStyle its){
        return getReport(reportId, null,tableStyleDefault, null);
    }
    
    public StringBuffer getReport(String reportId, Object[] where, String tableWidth){
        return getReport(reportId, where, tableStyleDefault, tableWidth);
    }
    
    public StringBuffer getReport(String reportId, Object[] where, ITableStyle its){
        return getReport(reportId, where, tableStyleDefault, null);
    }
    
    public StringBuffer getReport(String reportId, ITableStyle its, String tableWidth){
        return getReport(reportId, null, tableStyleDefault, tableWidth);
    }
    
    public StringBuffer getReport(String reportId, Object[] where, ITableStyle its, String tableWidth){
        TableBuilder tableBuilder = new TableBuilder();
        try{
            Map<String, TRBean> c = firstWorker.build(reportId, where);
            if(tableWidth == null){
                tableWidth = firstWorker.getBean(reportId).getTableWidth();
            }
            return tableBuilder.prase(tableWidth, c, its);
        }catch(Exception e){
            return tableBuilder.getErrorMsg(e, its);
        }
    }
}