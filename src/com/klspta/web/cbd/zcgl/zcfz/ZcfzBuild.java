package com.klspta.web.cbd.zcgl.zcfz;

import java.util.ArrayList;
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

public class ZcfzBuild {

	static String[] items = { "YY", "EY", "SANY", "SIY", "WY", "LY", "QY",
			"BQY", "JY", "SIYUE", "SYY", "SEY" };

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
		StringBuffer Buffer = new StringBuffer();
		Buffer
				.append("<table  width='1900px' id='table'>"
						+ "<tr class='title' style='text-align:center' >"
						+ "<td rowspan='3' align='center' width='150px' class='title'><div  width='200px'>类别<div></td>"
						+ "<td rowspan='3'  align='center' width='80px' class='title'>预算费用</td>"
						+ "<td rowspan='3' colspan='2' align='center' width='300px' class='title'>累计已缴纳<br>/已审批资金</td>"
						+ "<td rowspan='2' colspan='2' align='center' width='160' class='title'>累计发生<br>(或返还)费用</td>"
						+ "<td rowspan='3'  align='center' width='80px' class='title'>期初余额</td>"
						+ "<td colspan='12'  align='center' width='1000px' class='title'>"
						+ year
						+ "年资金审批</td>"
						+ "<td  rowspan='3'  align='center' width='80px' class='title'>"
						+ year
						+ "年度流入/审批</td>"
						+ "</tr>"
						+

						"<tr class='title'>"
						+ "<td colspan='3' align='center' width='250px' class='title'>一季度</td>"
						+ "<td colspan='3' align='center' width='250px' class='title'>二季度</td>"
						+ "<td colspan='3' align='center' width='250px' class='title'>三季度</td>"
						+ "<td colspan='3' align='center' width='250px' class='title'>四季度</td>"
						+ "</tr>"
						+

						"<tr class='title'>"
						+ "<td align='center' width='130px' class='title'>已发生<br>/到账</td>"
						+ "<td align='center' width='130px' class='title'>资金<br>进度</td>"
						+ "<td align='center' width='83px' class='title'>一月</td>"
						+ "<td align='center' width='83px' class='title'>二月</td>"                                           
						+ "<td align='center' width='83px' class='title'>三月</td>"
						+ "<td align='center' width='83px' class='title'>四月</td><"
						+ "td align='center' width='83px' class='title'>五月</td>"
						+ "<td align='center' width='83px' class='title'>六月</td> "
						+ "<td align='center' width='83px' class='title'>七月</td>"
						+ "<td align='center' width='83px' class='title'>八月</td>"
						+ "<td align='center' width='83px' class='title'>九月</td>"
						+ "<td align='center' width='83px' class='title'>十月</td>"
						+ "<td align='center' width='83px' class='title'>十一月</td>"
						+ "<td align='center' width='83px' class='title'>十二月</td> "
						+ "</tr>");
		return Buffer;
	}

	public static StringBuffer buildZjlr(List<Map<String, Object>> list) {
		StringBuffer stringBuffer = new StringBuffer();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				stringBuffer
						.append("<tr><td width='200px' class='tr04'>"
								+ delNull(String.valueOf(list.get(i).get("tree_name")))
								+ "</td><td class='tr04'><input class='tr04' type='text' style='width:70px;hight:15px;' onchange='addzjlr(this); return false' value='"
								+ delNull(String.valueOf(list.get(i)
										.get("ysfy")))
								+ "'  id='lr@"
								+ String.valueOf(list.get(i).get("tree_id"))
								+ "@2'/></td><td colspan='2' class='tr04'><input class='tr04' type='text' style='width:180px;hight:15px;' onchange='addzjlr(this); return false' value='"
								+ delNull(String.valueOf(list.get(i).get("lj")))
								+ " ' id='lr@"
								+ String.valueOf(list.get(i).get("tree_id"))
								+ "@3'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;hight:15px;' onchange='addzjlr(this); return false' value='"
								+ delNull(String.valueOf(list.get(i).get(
										"YFSDZ")))
								+ " ' id='lr@"
								+ String.valueOf(list.get(i).get("tree_id"))
								+ "@4'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;hight:15px;' onchange='addzjlr(this); return false' value='"
								+ delNull(String.valueOf(list.get(i)
										.get("ZJJD")))
								+ " ' id='lr@"
								+ String.valueOf(list.get(i).get("tree_id"))
								+ "@5'/></td><td class='tr04'><input class='tr04' type='text' style='width:90px;hight:15px;' onchange='addzjlr(this); return false' value='"
								+ delNull(String.valueOf(list.get(i)
										.get("CQYE"))) + " ' id='lr@"
								+ String.valueOf(list.get(i).get("tree_id"))
								+ "@6'/></td>");

				for (int j = 0; j < items.length; j++) {
					stringBuffer
							.append("<td class='tr04'><input class='tr04' type='text' style='width:90px;hight:15px;' onchange='addzjlr(this); return false' value='"
									+ delNull(String.valueOf(list.get(i).get(
											items[j])))
									+ " ' id='lr@"
									+ String.valueOf(list.get(i).get("tree_id"))
									+ "@" + i + 7 + "'/></td>");
				}

				stringBuffer
						.append("<td class='tr04'><input class='tr04' type='text' style='width:90px;hight:15px;' onchange='addzjlr(this); return false' value='"
								+ delNull(String.valueOf(list.get(i)
										.get("LRSP")))
								+ " ' id='lr@"
								+ String.valueOf(list.get(i).get("tree_id"))
								+ "@19'/></td></tr>");
			}
		}
		return stringBuffer;

	}

	/**
	 * 
	 * <br>
	 * Description:根据动态树结构生成资金流入节点 <br>
	 * Author:黎春行 <br>
	 * Date:2014-2-21
	 * 
	 * @param list
	 *            数据源
	 * @param key
	 *            根节点
	 * @param status
	 *            类型（只读（read） 、编辑（write））
	 * @return
	 */
	public static List<Object> buildZjlrTR(List<Map<String, Object>> list,
			String key, String status) {
		StringBuffer stringBuffer = new StringBuffer();
		List<Object> returnObject = new ArrayList<Object>();
		List<Map<String, Object>> getMapList = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> resuMap = list.get(i);
			if ((key.equals(getValue(resuMap, "parent_id")))) {
				String childkey = getValue(resuMap, "tree_id");
				List<Object> childList = buildZjlrTR(list, childkey, status);
				StringBuffer childString = (StringBuffer) childList.get(0);
				if (childString.length() == 0) {
					getMapList.add(resuMap);
					stringBuffer.append(buildTr(resuMap, status));
				} else {
					String[] names = { "ysfy", "lj", "YFSDZ", "ZJJD", "CQYE",
							"yy", "ey", "sany", "siy", "wy", "ly", "qy", "bay",
							"jy", "siyue", "syy", "sey", "lrsp" };
					Map<String, Object> sumMap = new HashMap<String, Object>();
					List<Map<String, Object>> child = (List) childList.get(1);
					sumMap.put("tree_name", getValue(resuMap, "tree_name"));
					for (int j = 0; j < child.size(); j++) {
						Map<String, Object> childMap = child.get(j);
						for (int t = 0; t < names.length; t++) {
							String beginValue = getValue(sumMap, names[t]);
							String childValue = getValue(childMap, names[t]);
							String value = String.valueOf(Long
									.parseLong(beginValue)
									+ Long.parseLong(childValue));
							sumMap.put(names[t], value);
						}
					}
					getMapList.add(sumMap);
					stringBuffer.append(buildTr(sumMap, "read"));
					stringBuffer.append(childString);
				}
			}
		}
		returnObject.add(stringBuffer);
		returnObject.add(getMapList);
		return returnObject;
	}

	private static StringBuffer buildTr(Map<String, Object> trMap, String status) {
		String[] names = { "tree_name", "ysfy", "lj", "YFSDZ", "ZJJD", "CQYE",
				"yy", "ey", "sany", "siy", "wy", "ly", "qy", "bay", "jy",
				"siyue", "syy", "sey", "lrsp" };
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("<tr>");
		for (int i = 0; i < names.length; i++) {
			if ("read".equals(status)) {
				if ("lj".equals(names[i])) {
					stringBuffer.append("<td class='tr02' colspan='2'>")
							.append(getValue(trMap, names[i])).append("</td>");
				} else {
					stringBuffer.append("<td class='tr02' >").append(
							getValue(trMap, names[i])).append("</td>");
				}
			} else if (i == 0) {
				if ("lj".equals(names[i])) {
					stringBuffer.append("<td class='tr04' colspan='2'>")
							.append(getValue(trMap, names[i])).append("</td>");
				} else {
					stringBuffer.append("<td class='tr04' >").append(
							getValue(trMap, names[i])).append("</td>");
				}
			} else {
				if ("lj".equals(names[i])) {
					stringBuffer
							.append("<td class='tr04' colspan='2' >")
							.append(
									"<input class='tr04' width=1%  type='text' ");
					stringBuffer.append(
							"onchange='addzjlr(this); return false;' value='")
							.append(getValue(trMap, names[i])).append(
									"' id='lr@");
					stringBuffer.append(getValue(trMap, "tree_id")).append("@")
							.append(i).append("'/></td>");
				} else {
					stringBuffer.append("<td class='tr04' >").append(
							"<input class='tr04' type='text' width=100%  ");
					stringBuffer.append(
							"onchange='addzjlr(this); return false;' value='")
							.append(getValue(trMap, names[i])).append(
									"' id='lr@");
					stringBuffer.append(getValue(trMap, "tree_id")).append("@")
							.append(i).append("'/></td>");
				}
			}
		}
		stringBuffer.append("</tr>");
		return stringBuffer;
	}

	private static String getValue(Map<String, Object> map, String key) {
		String value = String.valueOf(map.get(key));
		value = ("null".equals(value)) ? "0" : value;
		return value;
	}

	/***************************************************************************
	 * view
	 */
	public static StringBuffer buildZjlr_sum(List<Map<String, Object>> list) {
		StringBuffer stringBuffer = new StringBuffer();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				stringBuffer.append("<tr><td width='200px' class='tr02'>"
						+ delNull(String.valueOf(list.get(i).get("tree_name")))
						+ " </td><td class='tr02'>"
						+ delNull(String.valueOf(list.get(i).get("ysfy")))
						+ " </td><td colspan='2' class='tr02'>"
						+ delNull(String.valueOf(list.get(i).get("lj")))
						+ " </td><td class='tr02'>"
						+ delNull(String.valueOf(list.get(i).get("YFSDZ")))
						+ " </td><td class='tr02' >"
						+ delNull(String.valueOf(list.get(i).get("ZJJD")))
						+ " </td><td class='tr02'>"
						+ delNull(String.valueOf(list.get(i).get("CQYE")))
						+ " </td><td class='tr02'>");
				for (int j = 0; j < items.length; j++) {
					stringBuffer.append(delNull(String.valueOf(list.get(i).get(
							items[j])))
							+ " </td><td class='tr02'>");
				}
				stringBuffer.append(delNull(String.valueOf(list.get(i).get(
						"LRSP")))
						+ "</td></tr>");
			}
		}
		return stringBuffer;

	}


	public static StringBuffer buildZjzc_father(List<Map<String, Object>> list, String rolename,int leval) {
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		StringBuffer stringBuffer = new StringBuffer();
		String sytle = "";
		if(leval == 1){
			sytle = "tr01";
		}else if(leval == 2){
			sytle = "tr02";
		}else if(leval == 3){
			sytle = "tr03";
		}
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					stringBuffer.append("<tr><td  rowspan='8' class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("tree_name")))
							+ "</td><td rowspan='8' class='"+sytle+"'><input class='"+sytle+"' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
							+ delNull(String.valueOf(list.get(i).get("YSFY")))
							+ "'id='" + String.valueOf(list.get(i).get("tree_id")) + "@"
							+ String.valueOf(list.get(i).get("tree_name")) + "@"
							+ String.valueOf(list.get(i).get("sort")) + "@2'/></td><td width:'200px' class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td  class='"+sytle+"'>"
							+ delZer(String.valueOf(list.get(i).get("JL2")))
							+ "</td><td rowspan='8' class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("YFSDZ")))
							+ "</td><td rowspan='8' class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("ZJJD")))
							+ "</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("CQYE"))) + "</td>");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
					}
					stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
				} else if(i != list.size() - 1){
					stringBuffer.append("<tr><td class='"+sytle+"' width='200px'>"
					+ delNull(String.valueOf(list.get(i).get("LJ")))
					+ "</td><td class='"+sytle+"'>"
					+ delZer(String.valueOf(list.get(i).get( "JL2"))) + "</td>"
					+ "<td class='"+sytle+"'><input class='"+sytle+"' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
					+ delNull(String.valueOf(list.get(i).get("CQYE"))) + "'id='"
					+ String.valueOf(list.get(i).get("tree_id"))
					+ "@" + String.valueOf(list.get(i).get("tree_name"))
					+ "@" + String.valueOf(list.get(i).get("sort"))
					+ "@5'/></td>");
					for (int j = 0; j < items.length; j++) {
						if (j + 1 == month || "市场部".equals(rolename) || "市场部部长".equals(rolename)) {
							stringBuffer.append("<td class='"+sytle+"'><input class='"+sytle+"' type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
							+ delNull(String.valueOf(list.get(i).get(items[j])))
							+ "'id='" + String.valueOf(list.get(i).get("tree_id"))
							+ "@" + String.valueOf(list.get(i).get("tree_name"))
							+ "@" + String.valueOf(list.get(i).get("sort"))
							+ "@" + (j + 6) + "'/></td>");
						} else {
							stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
						}
					}
					stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
				}else{
					stringBuffer.append("<tr><td class='"+sytle+"' width='200px'>"
					+ delNull(String.valueOf(list.get(i).get("LJ")))
					+ "</td><td class='"+sytle+"'>"
					+ delZer(String.valueOf(list.get(i).get( "JL2"))) + "</td>"
					+ "<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("CQYE"))) + "</td>");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
					}
					stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
				}
			}
		}

		return stringBuffer;
	}

	  
	   public static StringBuffer buildZjzc_father_sum(List<Map<String, Object>> list,int leval) {
			StringBuffer stringBuffer = new StringBuffer();
			String sytle = "";
			if(leval == 1){
				sytle = "tr01";
			}else if(leval == 2){
				sytle = "tr02";
			}else if(leval == 3){
				sytle = "tr03";
			}
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					if (i == 0) {
						stringBuffer.append("<tr><td  rowspan='8' class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("tree_name")))
								+ "</td><td rowspan='8' class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("YSFY")))
								+ "</td><td width:'240px' class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("LJ")))
								+ "</td><td  class='"+sytle+"'>"
								+ delZer(String.valueOf(list.get(i).get("JL2")))
								+ "</td><td rowspan='8' class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("YFSDZ")))
								+ "</td><td rowspan='8' class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("ZJJD")))
								+ "</td><td class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("CQYE")))
								+ "</td><td class='"+sytle+"'>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append(delNull(String.valueOf(list.get(i)
									.get(items[j])))
									+ "</td><td class='"+sytle+"'>");
						}
						stringBuffer.append(delNull(String.valueOf(list.get(i).get(
								"LRSP")))
								+ "</td></tr>");
					} else {
						stringBuffer.append("<tr><td width:'240px'  class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("LJ")))
								+ "</td><td class='"+sytle+"'>"
								+ delZer(String.valueOf(list.get(i).get("JL2")))
								+ "</td> <td class='"+sytle+"'>"
								+ delNull(String.valueOf(list.get(i).get("CQYE")))
								+ " </td><td class='"+sytle+"'>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append(delNull(String.valueOf(list.get(i)
									.get(items[j])))
									+ " </td><td class='"+sytle+"'>");
						}

						stringBuffer.append(delNull(String.valueOf(list.get(i).get(
								"LRSP")))
								+ "</td></tr>");
					}
				}
			}

			return stringBuffer;
		}
	   
	
	public static StringBuffer buildZjzc_father_view(
			List<Map<String, Object>> list) {
		StringBuffer stringBuffer = new StringBuffer();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					stringBuffer.append("<tr><td  rowspan='8' class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("tree_name")))
							+ "</td><td rowspan='8' class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("YSFY")))
							+ "</td><td width:'200px' class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td  class='tr04'>"
							+ delZer(String.valueOf(list.get(i).get("JL2")))
							+ "</td><td rowspan='8' class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("YFSDZ")))
							+ "</td><td rowspan='8' class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("ZJJD")))
							+ "</td><td class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("CQYE")))
							+ "</td><td class='tr04'>");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append(delNull(String.valueOf(list.get(i).get(items[j]))) + "</td><td class='tr04'>");
					}
					stringBuffer.append(delNull(String.valueOf(list.get(i).get("LRSP"))) + " </td></tr>");
				} else {
					stringBuffer.append("<tr><td class='tr04'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td class='tr04'>"
							+ delZer(String.valueOf(list.get(i).get("JL2")))
							+ "</td>" + " <td class='tr04'> "
							+ delNull(String.valueOf(list.get(i).get("CQYE")))
							+ "</td><td class='tr04'>");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append(delNull(String.valueOf(list.get(i).get(items[j]))) + "</td><td class='tr04'>");
					}
					stringBuffer.append(delNull(String.valueOf(list.get(i).get("LRSP"))) + " </td></tr>");
				}
			}
		}
		return stringBuffer;
	}
	
	   public static StringBuffer buildZjzc_child(List<Map<String, Object>> list,String rolename,int leval) {
			int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
			StringBuffer stringBuffer = new StringBuffer();
			String sytle = "";
			if(leval == 1){
				sytle = "tr01";
			}else if(leval == 2){
				sytle = "tr02";
			}else if(leval == 3){
				sytle = "tr03";
			}
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					if (i == 0) {
						stringBuffer.append("<tr><td  rowspan='8' class='"+sytle+"'>"
										+ delNull(String.valueOf(list.get(i).get("tree_name")))
										+ " </td><td rowspan='8' class='"+sytle+"'><input t"+sytle+"'text' style='width:70px;' onchange='addrzxq(this); return false' value='"
										+ delNull(String.valueOf(list.get(i).get("YSFY")))
										+ "'id='" + String.valueOf(list.get(i).get("tree_id"))
										+ "@" + String.valueOf(list.get(i).get("tree_name"))
										+ "@" + String.valueOf(list.get(i).get("sort"))
										+ "@2'/></td><td width='240px' class='"+sytle+"'>"
										+ delNull(String.valueOf(list.get(i).get("LJ")))
										+ "</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("JL2")))
										+ "</td><td class='"+sytle+"' >" + delNull(String.valueOf(list.get(i).get("YFSDZ")))
										+ "</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("ZJJD")))
										+ "</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("CQYE"))) + "</td>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
						}
						stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
					} else if(i != list.size() - 1){
						stringBuffer.append("<tr><td width='240px' class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LJ2")))
							+ "</td><td class='"+sytle+"'></td><td class='"+sytle+"' ></td><td class='"+sytle+"'><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
							+ delNull(String.valueOf(list.get(i).get("CQYE"))) + "'id='"
							+ String.valueOf(list.get(i).get("tree_id"))
							+ "@" + String.valueOf(list.get(i).get("tree_name"))
							+ "@" + String.valueOf(list.get(i).get("sort"))
							+ "@5'/></td>");
						for (int j = 0; j < items.length; j++) {
							if (j + 1 == month || "市场部".equals(rolename) || "市场部部长".equals(rolename)) {
								stringBuffer.append("<td class='"+sytle+"'><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
												+ delNull(String.valueOf(list.get(i).get(items[j])))
												+ "'id='" + String.valueOf(list.get(i).get("tree_id"))
												+ "@" + String.valueOf(list.get(i).get("tree_name"))
												+ "@" + String.valueOf(list.get(i).get("sort"))
												+ "@" + (j + 6)
												+ "'/></td>");
							} else {
								stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
							}
						}
						stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
					}else{
						stringBuffer.append("<tr><td width='240px' class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td class='"+sytle+"'> " + delNull(String.valueOf(list.get(i).get("LJ2")))
							+ "</td><td class='"+sytle+"'></td><td class='"+sytle+"'></td><td class='"+sytle+"'>"
							+ delNull(String.valueOf(list.get(i).get("CQYE"))) + "</td>");
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
						}
						stringBuffer.append("<td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
					}
				}
			}
			return stringBuffer;
		}

	public static StringBuffer buildZjzc_child(List<Map<String, Object>> list,
			String rolename) {
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		StringBuffer stringBuffer = new StringBuffer();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					stringBuffer.append("<tr><td  rowspan='8' class='tr04'>"
									+ delNull(String.valueOf(list.get(i).get("tree_name")))
									+ " </td><td rowspan='8' class='tr04'><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
									+ delNull(String.valueOf(list.get(i).get("YSFY")))
									+ "'id='" + String.valueOf(list.get(i).get("tree_id"))
									+ "@" + String.valueOf(list.get(i).get("tree_name"))
									+ "@" + String.valueOf(list.get(i).get("sort"))
									+ "@2'/></td><td width='200px' class='tr04'>"
									+ delNull(String.valueOf(list.get(i).get("LJ")))
									+ "</td><td class='tr04'>" + delNull(String.valueOf(list.get(i).get("JL2")))
									+ "</td><td class='tr04' >" + delNull(String.valueOf(list.get(i).get("YFSDZ")))
									+ "</td><td class='tr04'>" + delNull(String.valueOf(list.get(i).get("ZJJD")))
									+ "</td><td class='tr04'>" + delNull(String.valueOf(list.get(i).get("CQYE"))) + "</td>");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append("<td class='tr04'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
					}
					stringBuffer.append("<td class='tr04'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
				} else if(i != list.size() - 1){
					stringBuffer.append("<tr><td width='200px' class='tr04'>"
						+ delNull(String.valueOf(list.get(i).get("LJ")))
						+ "</td><td class='tr04'>" + delNull(String.valueOf(list.get(i).get("LJ2")))
						+ "</td><td class='tr04'></td><td class='tr04' ></td><td class='tr04'><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
						+ delNull(String.valueOf(list.get(i).get("CQYE"))) + "'id='"
						+ String.valueOf(list.get(i).get("tree_id"))
						+ "@" + String.valueOf(list.get(i).get("tree_name"))
						+ "@" + String.valueOf(list.get(i).get("sort"))
						+ "@5'/></td>");
					for (int j = 0; j < items.length; j++) {
						if (j + 1 == month || "市场部".equals(rolename) || "市场部部长".equals(rolename)) {
							stringBuffer.append("<td class='tr04'><input type='text' style='width:70px;' onchange='addrzxq(this); return false' value='"
											+ delNull(String.valueOf(list.get(i).get(items[j])))
											+ "'id='" + String.valueOf(list.get(i).get("tree_id"))
											+ "@" + String.valueOf(list.get(i).get("tree_name"))
											+ "@" + String.valueOf(list.get(i).get("sort"))
											+ "@" + (j + 6)
											+ "'/></td>");
						} else {
							stringBuffer.append("<td class='tr04'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
						}
					}
					stringBuffer.append("<td class='tr04'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
				}else{
					stringBuffer.append("<tr><td width='200px' class='tr04'>"
						+ delNull(String.valueOf(list.get(i).get("LJ")))
						+ "</td><td class='tr04'> " + delNull(String.valueOf(list.get(i).get("LJ2")))
						+ "</td><td class='tr04'></td><td class='tr04'></td><td class='tr04'>"
						+ delNull(String.valueOf(list.get(i).get("CQYE"))) + "</td>");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append("<td class='tr04'>" + delNull(String.valueOf(list.get(i).get(items[j]))) + "</td>");
					}
					stringBuffer.append("<td class='tr04'>" + delNull(String.valueOf(list.get(i).get("LRSP"))) + "</td></tr>");
				}
			}
		}
		return stringBuffer;
	}

	public static StringBuffer buildZjzc_child_view(
			List<Map<String, Object>> list) {
		StringBuffer stringBuffer = new StringBuffer();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					stringBuffer.append("<tr><td  rowspan='8'>"
							+ delNull(String.valueOf(list.get(i).get("tree_name")))
							+ " </td><td rowspan='8'> "
							+ delNull(String.valueOf(list.get(i).get("YSFY")))
							+ "</td><td width='200px'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td> "
							+ delNull(String.valueOf(list.get(i).get("JL2")))
							+ "</td><td  > "
							+ delNull(String.valueOf(list.get(i).get("YFSDZ")))
							+ "</td><td > "
							+ delNull(String.valueOf(list.get(i).get("ZJJD")))
							+ "</td><td> "
							+ delNull(String.valueOf(list.get(i).get("CQYE")))
							+ " </td><td> ");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append(delNull(String.valueOf(list.get(i)
								.get(items[j])))
								+ " </td><td> ");
					}

					stringBuffer.append(delNull(String.valueOf(list.get(i).get(
							"LRSP")))
							+ " </td></tr>");
				} else {
					stringBuffer.append("<tr><td width='200px'>"
							+ delNull(String.valueOf(list.get(i).get("LJ")))
							+ "</td><td> "
							+ delNull(String.valueOf(list.get(i).get("LJ2")))
							+ " </td><td > "
							+ delNull(String.valueOf(list.get(i).get("YFSDZ")))
							+ " </td><td > "
							+ delNull(String.valueOf(list.get(i).get("ZJJD")))
							+ " </td><td> "
							+ delNull(String.valueOf(list.get(i).get("CQYE")))
							+ " </td><td> ");
					for (int j = 0; j < items.length; j++) {
						stringBuffer.append(delNull(String.valueOf(list.get(i)
								.get(items[j])))
								+ " </td><td> ");
					}
					stringBuffer.append(delNull(String.valueOf(list.get(i).get(
							"LRSP")))
							+ " </td></tr>");
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
