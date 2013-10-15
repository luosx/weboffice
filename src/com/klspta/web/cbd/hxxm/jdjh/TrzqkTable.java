package com.klspta.web.cbd.hxxm.jdjh;

import java.util.List;
import java.util.Map;

public class TrzqkTable implements IBuildTable {
	private static String[] kinds = { "本期投资需求<br/>(亿元)", "本期回笼成本<br/>(亿元)", "政府土地收益<br/>(亿元)", "本期融资需求<br>(亿元)","本期还款需求<br/>(亿元)","权益性资金注入<br/>(亿元)","负债余额<br/>(亿元)","储备库融资缺口<br/>(亿元)","资金风险<br/>(亿元)","本期账面余额<br/>(亿元)"};
	private static String[] fields = { "BQTZXQ", "BQHLCB", "ZFTDSY", "BQRZXQ" , "BQHKXQ", "QYXZJZR", "FZYE","CBKRZQK","ZJFX","BQZMYE"};
	private static String[] sequences = {"15", "13", "14", "18", "16", "17", "19","20", "21", "22"};
	
	@Override
	public String buildTable() {
		StringBuffer code = new StringBuffer();
		DataManager dataManager = DataManager.getInstance();
		List<Map<String, Object>> sxList = dataManager.getJDList();
		List<Map<String, Object>> totalList = dataManager.getTrzqk_ZHList();
		Map<String, Object> betweenYear = dataManager.getPlanYear();
		code.append("<tr style='background:#FFCC99'><td rowspan='10' width='40' align='center'><label>投融资情况</label></td>");		
		for(int j = 0; j < fields.length; j++){
			if(j != 0){
				code.append("<tr style='background:#FFCC99'>");
			}
			code.append("<td width='100'><label>"+ sequences[j] +"</label></td>");
			code.append("<td><label>" + kinds[j] + "</label></td>");
			StringBuffer trzqk = new StringBuffer();
			for(int i = Integer.parseInt(String.valueOf(betweenYear.get("minyear"))); i <=Integer.parseInt(String.valueOf(betweenYear.get("maxyear"))); i++){
				int num = 0;
				for(int t = 1; t<=4; t++ ){
					if(num < sxList.size() && String.valueOf(i).equals(String.valueOf(sxList.get(num).get("nd"))) && String.valueOf(t).equals(String.valueOf(sxList.get(num).get("jd")))){
						String value = String.valueOf(sxList.get(num).get(fields[j]));
						value = "null".equals(value) ? "" : value;
						trzqk.append("<td width='250' colspan='2' >").append(value).append("</td>");
						num++;
					}else{
						trzqk.append("<td width='250' colspan='2' ></td>");
					}
				}
			}
			code.append(trzqk);
			String totalValue = String.valueOf(totalList.get(0).get(fields[j]));
			totalValue = "null".equals(totalValue) ? "" : totalValue;
			code.append("<td>").append(totalValue).append("</td>");
			code.append("</tr>");
			trzqk.delete(0, trzqk.length());
		}
		return code.toString();
	}

}
