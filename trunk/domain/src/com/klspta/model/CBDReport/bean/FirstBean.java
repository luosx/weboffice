package com.klspta.model.CBDReport.bean;

import java.util.Map;

public class FirstBean {
	private String YWGuid;
	private String ReportName;
	private int ColCOunt;
	private String ReportDescrition;
	
	public FirstBean(Map<String, Object> map){
		this.YWGuid = (String)map.get("YW_GUID");
		this.ReportName = (String)map.get("RP_NAME");
		this.ColCOunt = Integer.parseInt((String)map.get("COL_COUNT"));
		this.ReportDescrition = (String)map.get("RP_DESCRIBE");
	}

	public String getYWGuid() {
		return YWGuid;
	}

	public void setYWGuid(String guid) {
		YWGuid = guid;
	}

	public String getReportName() {
		return ReportName;
	}

	public void setReportName(String reportName) {
		ReportName = reportName;
	}

	public int getColCOunt() {
		return ColCOunt;
	}

	public void setColCOunt(int colCOunt) {
		ColCOunt = colCOunt;
	}

	public String getReportDescrition() {
		return ReportDescrition;
	}

	public void setReportDescrition(String reportDescrition) {
		ReportDescrition = reportDescrition;
	}

}
