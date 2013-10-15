package com.klspta.web.cbd.hxxm.jdjh;

import java.util.List;
import java.util.Map;

public class GdtlTable implements IBuildTable {
	private static String[] kinds = {"供应土地<br/>(公顷)", "供应规模<br/>(万㎡)", "储备库库存<br/>(万㎡)","储备库融资能力<br/>(亿元)"};
	private static String[] fields = {"GYTD","GYGM","CBKKC","CBKRZNL"}; 
	DataManager dataManager = DataManager.getInstance();
	@Override
	public String buildTable() {
		StringBuffer code = new StringBuffer();
		List<Map<String, Object>> sxList = dataManager.getJDList();
		List<Map<String, Object>> totalList = dataManager.getGDTL_ZHList();
		Map betweenYear = dataManager.getPlanYear();
		code.append("<tr style='background: #99CC00;' ><td rowspan='4' width='40' align='center'><label>供地体量</label></td>");
		for (int j = 1; j <= 4; j++) {
			if(j != 1){
				code.append("<tr style='background: #99CC00;'>");
			}
			code.append("<td width='100'><label>"+ j +"</label></td>");
			code.append("<td><label>" + kinds[j - 1] + "</label></td>");
			StringBuffer kfsx = new StringBuffer();
			for(int i = Integer.parseInt(String.valueOf(betweenYear.get("minyear"))); i <=Integer.parseInt(String.valueOf(betweenYear.get("maxyear"))); i++){
				int num = 0;
				for(int t = 1; t <= 4; t++){
					if((num < sxList.size())&&(String.valueOf(i).equals(String.valueOf(sxList.get(num).get("nd"))) && String.valueOf(t).equals(String.valueOf(sxList.get(num).get("jd"))))){
						String value = String.valueOf(sxList.get(num).get(fields[j-1]));
						value = "null".equals(value) ? "" : value;
						kfsx.append("<td width='250' colspan='2' >").append(value).append("</td>");
						num++;
					}else{
						kfsx.append("<td width='250' colspan='2' ></td>");
					}		
				}
			}
			code.append(kfsx);
			String totalValue = String.valueOf(totalList.get(0).get(fields[j - 1]));
			totalValue = "null".equals(totalValue) ? "" : totalValue;
			code.append("<td>").append(totalValue).append("</td>");
			code.append("</tr>");
			kfsx.delete(0, kfsx.length());
		}
		return code.toString();
	}

}
