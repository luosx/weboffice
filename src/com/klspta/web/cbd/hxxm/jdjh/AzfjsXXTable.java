package com.klspta.web.cbd.hxxm.jdjh;

import java.util.List;
import java.util.Map;

/**
 * 
 * <br>Title:安置房建设详细
 * <br>Description:生成安置房建设详细Table
 * <br>Author:黎春行
 * <br>Date:2013-10-15
 */
public class AzfjsXXTable implements IBuildTable {

	@Override
	public String buildTable() {
		DataManager dataManager = DataManager.getInstance();
		List<Map<String, Object>> azfList = dataManager.getAZFJCXXList();
		List<Map<String, Object>> proList = dataManager.getAzfProList();
		Map betweenYear = dataManager.getPlanYear();
		StringBuffer azfProBuffer = new StringBuffer();
		int azfjsNum = 0;
		for(int i = 0; i < proList.size(); i++){
			StringBuffer kgBuffer = new StringBuffer();
			StringBuffer tzBuffer = new StringBuffer();
			kgBuffer.append("<tr><td></td><td ><label>开工</lable></td>");
			kgBuffer.append("<td style='background: #C0C0C0;'><label>").append(proList.get(i).get("kg")).append("</label></td>");
			tzBuffer.append("<tr><td></td><td><label>投资</lable></td>");
			tzBuffer.append("<td style='background: #C0C0C0;'><label>").append(proList.get(i).get("tz")).append("</label></td>");
			
			String projectName = String.valueOf(proList.get(i).get("kg"));
			for(int year = Integer.parseInt(String.valueOf(betweenYear.get("minyear"))); year <=Integer.parseInt(String.valueOf(betweenYear.get("maxyear"))); year++){
				for(int quarter = 1; quarter <= 4; quarter++){
					if(azfjsNum < azfList.size() && projectName.equals(String.valueOf(azfList.get(azfjsNum).get("kg"))) && String.valueOf(quarter).equals(String.valueOf(azfList.get(azfjsNum).get("jd"))) && 
							String.valueOf(year).equals(String.valueOf(azfList.get(azfjsNum).get("nd")))){
						String kgvalue = String.valueOf(azfList.get(azfjsNum).get("kgz"));
						String kgbfbvalue = String.valueOf(azfList.get(azfjsNum).get("kgbfb"));
						kgvalue = "null".equals(kgvalue) ? "" : kgvalue;
						kgbfbvalue = "null".equals(kgbfbvalue)? "" : kgbfbvalue; 
						kgBuffer.append("<td><label>").append(kgvalue).append("</label></td>");
						kgBuffer.append("<td><label>").append(kgbfbvalue).append("%</label></td>");
						String tzvalue = String.valueOf(azfList.get(azfjsNum).get("tzz"));
						tzvalue = "null".equals(tzvalue) ? "" : tzvalue;
						tzBuffer.append("<td><label>").append(tzvalue).append("</label></td>");
						tzBuffer.append("<td></td>");
						azfjsNum++;
					}else {
						kgBuffer.append("<td></td><td></td>");
						tzBuffer.append("<td></td><td></td>");
					}
				}
			}
			kgBuffer.append("<td></td></tr>");
			tzBuffer.append("<td></td></tr>");
			azfProBuffer.append(kgBuffer).append(tzBuffer);	
		}
		return azfProBuffer.toString();
	}

}
