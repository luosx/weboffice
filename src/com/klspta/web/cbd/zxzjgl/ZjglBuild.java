package com.klspta.web.cbd.zxzjgl;

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
	            .append("<td rowspan='3' align='center' width='150px' class='title'>累计已缴纳<br>/已审批资金</td>")
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
	   
	   public static StringBuffer buildZjlr_father_sum_view(List<Map<String, Object>> list) {
			StringBuffer stringBuffer = new StringBuffer();
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
						String sytle = levelToStyle(Integer.parseInt(list.get(i).get("leval").toString()));
						stringBuffer.append("<tr><td class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("tree_name")))
						+ "</td><td class='"+sytle+"' >" 
						+ delNull(String.valueOf(list.get(i).get("ysfy")))
						+ "</td><td class='"+sytle+"'>" 
						+ delNull(String.valueOf(list.get(i).get("jl2")))
						+ "</td><td  class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("yfsdz")))
						+ "</td><td class='"+sytle+"'>" 
						+ delNull(String.valueOf(list.get(i).get("zjjd")))
						+ "</td><td class='"+sytle+"'>"
						+ delNull(String.valueOf(list.get(i).get("cqye"))));
						for (int j = 0; j < items.length; j++) {
							stringBuffer.append("</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get(items[j]))));
						}
						stringBuffer.append("</td><td class='"+sytle+"'>" + delNull(String.valueOf(list.get(i).get("lrsp"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("leval"))));
						stringBuffer.append("</td><td class='"+sytle+"' style='display:none'  >" + delNull(String.valueOf(list.get(i).get("sort"))));
						stringBuffer.append("</td></tr>");
					
				}
			}

			return stringBuffer;
		}
	   


	public static String delNull(String str) {
		if (str.equals("null") || str.equals("0")) {
			return "0";
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
