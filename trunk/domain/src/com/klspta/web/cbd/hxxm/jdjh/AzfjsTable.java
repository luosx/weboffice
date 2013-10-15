package com.klspta.web.cbd.hxxm.jdjh;

import java.util.List;
import java.util.Map;

public class AzfjsTable implements IBuildTable {
	
	private static String[] kinds = { "开工及购房量<br/>（万㎡）", "投资<br/>(亿元)", "使用量<br/>（万㎡）", "安置房存量<br>（万㎡）" };
	private static String[] fileds = { "KGJGFL", "AZFTZ", "AZFSYL", "AZFCL"};
	@Override
	public String buildTable() {
		StringBuffer code = new StringBuffer();
		DataManager dataManager = DataManager.getInstance();
		List<Map<String, Object>> sxList = dataManager.getJDList();
		List<Map<String, Object>> totalList = dataManager.getAZFJC_ZHList();
		Map betweenYear = dataManager.getPlanYear();
		code.append("<tr style='background: #CCFFFF;' ><td rowspan='4' width='40' align='center'><label>安置房建设</label></td>");
		for (int j = 1; j <= 4; j++) {
			if(j != 1){
				code.append("<tr style='background: #CCFFFF;'>");
			}
			code.append("<td width='100'><label>"+ j +"</label></td>");
			code.append("<td><label>" + kinds[j - 1] + "</label></td>");
			StringBuffer kfsx = new StringBuffer();
			for(int i = Integer.parseInt(String.valueOf(betweenYear.get("minyear"))); i <=Integer.parseInt(String.valueOf(betweenYear.get("maxyear"))); i++){
				int num = 0;
				for(int t = 1; t <= 4; t++){
					if((num < sxList.size())&&(String.valueOf(i).equals(String.valueOf(sxList.get(num).get("nd"))) && String.valueOf(t).equals(String.valueOf(sxList.get(num).get("jd"))))){
						String value = String.valueOf(sxList.get(num).get(fileds[j-1]));
						value = "null".equals(value) ? "" : value;
						kfsx.append("<td width='250' colspan='2' >").append(value).append("</td>");
						num++;
					}else{
						kfsx.append("<td width='250' colspan='2' ></td>");
					}		
				}
			}
			code.append(kfsx);
			String totalValue = String.valueOf(totalList.get(0).get(fileds[j - 1]));
			totalValue = "null".equals(totalValue) ? "" : totalValue;
			code.append("<td>").append(totalValue).append("</td>");
			code.append("</tr>");
			kfsx.delete(0, kfsx.length());
		}
		return code.toString();
	}

}
