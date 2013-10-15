package com.klspta.web.cbd.hxxm.jdjh;

import java.util.List;
import java.util.Map;

public class GdtlXXTable implements IBuildTable {
	private static String[] kinds = {"地量","规模","成本","收益","总价","租金"};
	private static String[] fields = {"dl", "gm", "cb", "sy", "zj", "zuj"};
	private static String[] fieldRatio = {"dlz","gmz","cbz","syz","zjz"};
	DataManager dataManager = DataManager.getInstance();
	
	@Override
	public String buildTable() {
		List<Map<String, Object>> gdtlList = dataManager.getGDTL_ALLList();
		List<Map<String, Object>> projectList = dataManager.getGDTL_XMList();
		StringBuffer projectsBuffer = new StringBuffer();
		Map betweenYear = dataManager.getPlanYear();
		int gdtlNum = 0;
		for(int i = 0; i < projectList.size(); i++){
			String projectName = String.valueOf(projectList.get(i).get("xmmc"));
			StringBuffer projectBuffer = new StringBuffer();
			for(int j = 0; j < fields.length; j++){
				if(0 == j){
					projectBuffer.append("<tr><td width='40' rowspan='").append(fields.length).append("' align='center' ><lable>").append(i + 1).append("</label></td>");
					projectBuffer.append("<td width='100'><lable>").append(kinds[j]).append("</label></td><td style='background: #C0C0C0;' rowspan='");
					projectBuffer.append(fields.length).append("'>").append(projectName).append("</td>");						
				}else{
					projectBuffer.append("<tr><td><label>").append(kinds[j]).append("</label></td>");
				}
				gdtlNum = 0;
				for(int year = Integer.parseInt(String.valueOf(betweenYear.get("minyear"))); year <=Integer.parseInt(String.valueOf(betweenYear.get("maxyear"))); year++){
					for(int quarter = 1; quarter <= 4; quarter++){
						if(gdtlNum < gdtlList.size() && projectName.equals(String.valueOf(gdtlList.get(gdtlNum).get("xmmc"))) &&
								String.valueOf(year).equals(String.valueOf(gdtlList.get(gdtlNum).get("nd"))) && String.valueOf(quarter).equals(String.valueOf(gdtlList.get(gdtlNum).get("jd")))){
							String value = String.valueOf(gdtlList.get(gdtlNum).get(fields[j]));
							value = "null".equals(value) ? "" : value;
							projectBuffer.append("<td width='125' style='background:#FFFF00'><label>").append(value).append("</label></td>");
							if(j < fieldRatio.length){
								String valueRatio = String.valueOf(gdtlList.get(gdtlNum).get(fieldRatio[j]));
								valueRatio = "null".equals(valueRatio) ? "" : (valueRatio + "%");
								projectBuffer.append("<td width='125' style='background:#FFFF00' ><label>").append(valueRatio).append("</label></td>");	
							}else{
								projectBuffer.append("<td width='125'></td>");
							}
							
							gdtlNum++;
						}else {
							projectBuffer.append("<td width='125'></td>");
							projectBuffer.append("<td width='125'></td>");
						}
					}
				}
				projectBuffer.append("<td></td>");
				projectBuffer.append("</tr>");
				projectsBuffer.append(projectBuffer);
				projectBuffer.delete(0, projectBuffer.length());
			}
		}
		return projectsBuffer.toString();
	}

}
