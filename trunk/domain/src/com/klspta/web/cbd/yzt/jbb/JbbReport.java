package com.klspta.web.cbd.yzt.jbb;

import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.model.CBDReport.ReportExcel;

public class JbbReport extends ReportExcel {

	@Override
	protected String buildTable(String reportId) {
		StringBuffer tableBuffer = new CBDReportManager().getReport(reportId);
		String tableStyle = tableBuffer.toString();
		tableStyle = tableStyle.replaceAll("class='trtotal'", "style='text-align:center; font-weight:bold;line-height: 30px;'");
		tableStyle = tableStyle.replaceAll("class='trsingle'", "style='background-color: #D1E5FB;line-height: 20px;text-align:center;'");
		tableStyle = tableStyle.replaceAll("class='title'", "style='    font-weight:bold;font-size: 15px;text-align:center;line-height: 50px;margin-top: 3px;'");
		tableStyle = tableStyle.replaceAll("<table", "<table style='font-size: 14px;background-color: #A8CEFF;border-color:#000000;color:#000000;border-collapse: collapse;'");
		tableStyle = tableStyle.replaceAll("<tr", "<tr style=' text-align:center; height:25px;'");
		tableStyle = tableStyle.replaceAll("<td", "<td style='text-align:center;border-color:#000000;'");
		System.out.println(tableStyle);
		return tableStyle;
	}

}
