package com.klspta.web.cbd.hxxm.jdjh;

import java.util.List;
import java.util.Map;

public class KftlXXTable implements IBuildTable {
	private static String[] kinds = {"户数","地量","规模","投资","住","企","楼面","成交"};
	private static String[] fields = {"hs", "dl", "gm", "tz", "zhu", "qi", "lm", "cj"};
	private static String[] fieldRatio = {"hsz","dlz","gmz","tzz","zhuz","qiz"};
	DataManager dataManager = DataManager.getInstance();

	@Override
	public String buildTable() {
		//获取含有开发体量时序计划的所有项目
		List<Map<String, Object>> kftlList = dataManager.getKFTL_ALLList();
		List<Map<String, Object>> projectList = dataManager.getKFTL_XMList();
		StringBuffer projectsBuffer = new StringBuffer();
		Map betweenYear = dataManager.getPlanYear();
		int num = 0;
		for(int i = 0; i < projectList.size(); i++){
			//记录项目名称
			String	projectName = String.valueOf(projectList.get(i).get("xmmc"));
			//第一行时添加序号
			StringBuffer  projectBuffer = new StringBuffer();
			//确定行参数
			for(int j = 0; j < fields.length; j++){
				boolean isExist = false;
				int kftlNum = num;
				if(j == 0){
					projectBuffer.append("<tr><td width='40' rowspan='").append(fields.length).append("' align='center' ><lable>").append(i + 1).append("</label></td>");
					projectBuffer.append("<td width='100'><lable>").append(kinds[j]).append("</label></td><td style='background: #C0C0C0;' rowspan='");
					projectBuffer.append(fields.length).append("'>").append(projectName).append("</td>");
				}else{
					projectBuffer.append("<tr><td><label>").append(kinds[j]).append("</label></td>");
				}
				for(int year = Integer.parseInt(String.valueOf(betweenYear.get("minyear"))); year <=Integer.parseInt(String.valueOf(betweenYear.get("maxyear"))); year++){
					for(int quarter = 1; quarter <= 4; quarter++){
						if( kftlNum < kftlList.size() && projectName.equals(String.valueOf(kftlList.get(kftlNum).get("xmmc"))) && String.valueOf(year).equals(String.valueOf(kftlList.get(kftlNum).get("nd"))) && String.valueOf(quarter).equals(String.valueOf(kftlList.get(kftlNum).get("jd")))){
							String value = String.valueOf(kftlList.get(kftlNum).get(fields[j]));
							value = "null".equals(value) ? "" : value;
							projectBuffer.append("<td width='125' style='background:#99CC00;'><label>").append(value).append("</label></td>");
							if(j < fieldRatio.length){
								String valueRatio = String.valueOf(kftlList.get(kftlNum).get(fieldRatio[j]));
								valueRatio = "null".equals(valueRatio) ? "" : (valueRatio + "%");
								projectBuffer.append("<td width='125' style='background:#99CC00;' ><label>").append(valueRatio).append("</label></td>");	
							}else{
								projectBuffer.append("<td width='125'></td>");
							}
							kftlNum++;
							isExist = true;
						}else {
							projectBuffer.append("<td width='125'></td>");
							projectBuffer.append("<td width='125'></td>");
						}
					}
				}
				if(j == (fields.length - 1) && isExist){
					num = kftlNum;
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
