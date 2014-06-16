package com.klspta.web.cbd.zxzjgl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*******************************************************************************
 * 
 * <br>
 * Title:资金管理前台展现处理类 <br>
 * Description: <br>
 * Author:朱波海 <br>
 * Date:2013-12-26
 */

public class ZjglBuild {

	private static String[] items = { "YY", "EY", "SANY", "SIY", "WY", "LY", "QY", "BQY", "JY", "SIYUE", "SYY", "SEY" };
    private static Map<String, StringBuffer> titleMap = new HashMap<String, StringBuffer>();
    private static StringBuffer sumStringBuffer = null;
	/***************************************************************************
	 * 
	 * <br>
	 * Description:构建title <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-19
	 * 
	 * @return
	 */
	public static StringBuffer buildTitle(String year) {
	    if(!titleMap.containsKey(year)){
	        StringBuffer buffer = new StringBuffer();
	        buffer.append("<table  width='1900px' id='table'>")
	            .append("<tr class='title' style='text-align:center' >")
	            .append("<td rowspan='3' align='center' width='150px' class='title'><div  width='200px'>类别<div></td>")
	            .append("<td rowspan='3'  align='center' width='80px' class='title'>预算费用</td>")
	            .append("<td rowspan='3' colspan='2'  align='center' width='300px' class='title'>累计已缴纳<br>/已审批资金</td>")
	            .append("<td rowspan='2' colspan='2' align='center' width='160' class='title'>累计发生<br>(或返还)费用</td>")
	            .append("<td rowspan='3'  align='center' width='80px' class='title'>期初余额</td>")
	            .append("<td colspan='12'  align='center' width='1000px' class='title'>")
	            .append(year)
	            .append("年资金审批</td>")
	            .append("<td  rowspan='3'  align='center' width='80px' class='title'>")
	            .append(year)
	            .append("年度流入/审批</td>")
	            .append("</tr>")
	            .append("<tr class='title'>")
	            .append("<td colspan='3' align='center' width='250px' class='title'>一季度</td>")
	            .append("<td colspan='3' align='center' width='250px' class='title'>二季度</td>")
	            .append("<td colspan='3' align='center' width='250px' class='title'>三季度</td>")
	            .append("<td colspan='3' align='center' width='250px' class='title'>四季度</td>")
	            .append("</tr>")
	            .append("<tr class='title'>")
	            .append("<td align='center' width='130px' class='title'>已发生<br>/到账</td>")
	            .append("<td align='center' width='130px' class='title'>资金<br>进度</td>")
	            .append("<td align='center' width='83px' class='title'>一月</td>")
	            .append("<td align='center' width='83px' class='title'>二月</td>")
	            .append("<td align='center' width='83px' class='title'>三月</td>")
	            .append("<td align='center' width='83px' class='title'>四月</td><")
	            .append("td align='center' width='83px' class='title'>五月</td>")
	            .append("<td align='center' width='83px' class='title'>六月</td> ")
	            .append("<td align='center' width='83px' class='title'>七月</td>")
	            .append("<td align='center' width='83px' class='title'>八月</td>")
	            .append("<td align='center' width='83px' class='title'>九月</td>")
	            .append("<td align='center' width='83px' class='title'>十月</td>")
	            .append("<td align='center' width='83px' class='title'>十一月</td>")
	            .append("<td align='center' width='83px' class='title'>十二月</td> ")
	            .append("</tr>");
	        titleMap.put(year, buffer);
	    }
	    return titleMap.get(year);
	}
	
	public static StringBuffer buildSum(){
		StringBuffer Buffer = new StringBuffer();
		Buffer.append("<tr class='title'>"
		+ "<td align='center' width='130px' class='tr01'>Ⅲ.账面余额</td>"
		+ "<td align='center' width='130px' id='ysfy' class='tr01'>0</td>"
		+ "<td align='center' width='300px' colspan='2' id='jl2' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='yfsdz' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='zjjd' class='tr01'>--</td>"
		+ "<td align='center' width='83px' id='cqye' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='yy' class='tr01'>0</td>"	
		+ "<td align='center' width='83px' id='ey' class='tr01'>0</td> "
		+ "<td align='center' width='83px' id='sany' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='siy' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='wy' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='ly' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='qy' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='bay' class='tr01'>0</td> "
		+ "<td align='center' width='83px' id='jy' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='shiy' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='syy' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='sey' class='tr01'>0</td>"
		+ "<td align='center' width='83px' id='lrsp' class='tr01'>0</td> "
		+ "<td align='center' width='83px' style='display:none'   class='tr01'>1</td> "
		+ "</tr>");
		return Buffer;
	}

	
	private static String levelToStyle(int level){
	    switch (level){
	    case 1:
	        return "tr01";
	    case 2:
	        return "tr02";
	    case 3:
	        return "tr03";
	    case 4:
	        return "tr04";
	    default:
	        return "";
	    }
	}


	   public static StringBuffer buildZjzc_father_view(List<Map<String, Object>> list, String rolename,int leval) {
			int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
			StringBuffer stringBuffer = new StringBuffer();
			String sytle = levelToStyle(leval);
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					if (i == 0) {
						stringBuffer.append("<tr><td  rowspan='8' class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("tree_name")))
						+ " </td><td rowspan='8' class='"+sytle+"'"
						+ " id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id")) 
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@ysfy'>" + delNull(String.valueOf(list.get(i).get("YSFY"))) 
						+ "</td><td  class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@jl2'>"+ delNull(String.valueOf(list.get(i).get("JL2")))+"</td><td rowspan='8' class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@yfsdz'>"+ delNull(String.valueOf(list.get(i).get("YFSDZ")))+"</td><td rowspan='8' class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@zjjd'>"+ delNull(String.valueOf(list.get(i).get("ZJJD")))
						+ "</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@cqye'>"+ delNull(String.valueOf(list.get(i).get("CQYE"))));
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@"+ items[j] +"'>" + delNull(String.valueOf(list.get(i).get(items[j]))));
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@lrsp'>" + delNull(String.valueOf(list.get(i).get("LRSP"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					} else if(i != list.size() -1){
						stringBuffer.append("</span></td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@jl2'>" + delNull(String.valueOf(list.get(i).get("JL2")))+"</td><td class='"+sytle+"'"
								+ "id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@cqye'>"+ delNull(String.valueOf(list.get(i).get("CQYE"))));
						for (int j = 0; j < items.length; j++) {
							if (j + 1 == month || "市场部".equals(rolename) || "市场部部长".equals(rolename)) {
							stringBuffer.append(" </td><td class='"+sytle+"'"
													+ " id='" + String.valueOf(list.get(i).get("tree_id"))
													+ "@" + String.valueOf(list.get(i).get("tree_name"))
													+ "@"+String.valueOf(list.get(i).get("parent_id"))
													+ "@" + String.valueOf(list.get(i).get("sort"))
													+ "@" + items[j] + "'>" + delNull(String.valueOf(list.get(i).get(items[j]))));
							}else{
								stringBuffer.append(" </td><td class='"+sytle+"'  id='" + String.valueOf(list.get(i).get("tree_id"))
													+ "@" + String.valueOf(list.get(i).get("tree_name"))
													+ "@"+String.valueOf(list.get(i).get("parent_id"))
													+ "@" + String.valueOf(list.get(i).get("sort"))
													+ "@" + items[j] + "'>" + delNull(String.valueOf(list.get(i).get(items[j]))));
							}
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@lrsp'>" + delNull(String.valueOf(list.get(i).get("LRSP"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					}else{
						stringBuffer.append("<tr><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@jl2'>" + delNull(String.valueOf(list.get(i).get("JL2")))+"</td><td class='"+sytle+"'  id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@cqye'>"
								+ delNull(String.valueOf(list.get(i).get("CQYE"))));
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append(" </td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@"+ items[j] +"'>" + delNull(String.valueOf(list.get(i).get(items[j]))));
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@lrsp'>" + delNull(String.valueOf(list.get(i).get("LRSP"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					}
				}
			}

			return stringBuffer;
		}
	   
	   
	   public static StringBuffer buildZjlr_father_view(List<Map<String, Object>> list, String rolename,int leval) {
			StringBuffer stringBuffer = new StringBuffer();
			String sytle = levelToStyle(leval);
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					if (i == 0) {
						stringBuffer.append("<tr><td  class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("tree_name")))
						+ " </td><td class='"+sytle+"' "
						+ " id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))+"@ysfy'>" 
						+ delNull(String.valueOf(list.get(i).get("YSFY"))) 
						+ "</td><td class='"+sytle+"'"
						+ " id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))+"@lj'>" 
						+  delNull(String.valueOf(list.get(i).get("lj")))
						+ "</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))+"@yfsdz'>"+ delNull(String.valueOf(list.get(i).get("YFSDZ")))+"</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))+"@zjjd'>"+ delNull(String.valueOf(list.get(i).get("ZJJD")))+"</td><td class='"+sytle+"'"
						+ " id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))+"@cqye'>" + delNull(String.valueOf(list.get(i).get("CQYE"))));
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("</td><td class='"+sytle+"'"
						+ " id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+"@"+String.valueOf(list.get(i).get("parent_id"))+ "@"+ items[j] +"'>"
							+ delNull(String.valueOf(list.get(i).get(items[j]))));
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))+"@lrsp'>" + delNull(String.valueOf(list.get(i).get("LRSP"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					}
				}
			}

			return stringBuffer;
		}

	   public static StringBuffer buildZjzc_father_sum_view(List<Map<String, Object>> list,int leval) {
			StringBuffer stringBuffer = new StringBuffer();
			String sytle = levelToStyle(leval);
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					if (i == 0) {
						stringBuffer.append("<tr><td  rowspan='8' class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("tree_name")))
						+ "</td><td rowspan='8' class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@ysfy'></td><td  class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@jl2'></td><td rowspan='8' class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@yfsdz'></td><td rowspan='8' class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@zjjd'></td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@cqye'>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@"+ items[j] +"'>");
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@lrsp'>");
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					} else {
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@jl2'></td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@cqye'>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append(" </td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@"+ items[j] +"'>");
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@" + String.valueOf(list.get(i).get("sort"))
								+ "@lrsp'>");
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					}
				}
			}

			return stringBuffer;
		}
	   
	   public static StringBuffer buildZjlr_father_sum_view(List<Map<String, Object>> list,int leval) {
			StringBuffer stringBuffer = new StringBuffer();
			String sytle = levelToStyle(leval);
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					if (i == 0) {
						stringBuffer.append("<tr><td class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("tree_name")))
						+ "</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@ysfy'></td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@lj'></td><td  class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@yfsdz'></td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@zjjd'></td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@"+String.valueOf(list.get(i).get("parent_id"))
						+ "@cqye'>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@"+ items[j] +"'>");
						}
						stringBuffer.append("</td><td class='"+sytle+"' id='" + String.valueOf(list.get(i).get("tree_id"))
								+ "@" + String.valueOf(list.get(i).get("tree_name"))
								+ "@"+String.valueOf(list.get(i).get("parent_id"))
								+ "@lrsp'>");
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					} 
				}
			}

			return stringBuffer;
		}
	   


	public static String delNull(String str) {
		if (str.equals("null") || str.equals("0")) {
			return "";
		} else {
			return str;
		}
	}

	public static String delZer(String str) {
		if (str.equals("null") || str.equals("")) {
			return "0";
		} else {
			return str;
		}
	}

}
