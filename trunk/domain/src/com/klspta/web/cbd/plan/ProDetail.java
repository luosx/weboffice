package com.klspta.web.cbd.plan;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * <br>
 * Title:项目具体信息 <br>
 * Description:生成具体项目的具体信息 <br>
 * Author:赵伟 <br>
 * Date:2013-8-26
 */
public class ProDetail extends AbstractBaseBean {
	/**
	 * <br>
	 * Description:获取具体项目的年度计划信息 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-23
	 */
	public String getKFTLDetail() {
		String code = "";
		// 从基础数据数据中取到所有的项目名称
		String sql = "select t.xmname from xminfo t group by t.xmname";
		List<Map<String, Object>> proKinds = query(sql, YW);

		String[] kinds = { "户数", "地量", "规模", "投资", "住", "企", "楼面", "成交" };
		String[][] fileds = { { "hs", "hsz" }, { "dl", "dlz" }, { "gm", "gmz" }, { "tz", "tzz" }, { "zhu", "zhuz" },
				{ "qi", "qiz" }, { "lm", "lm" }, { "cj", "cj" } };
		for (int i = 0; i < proKinds.size(); i++) {
			String proName = proKinds.get(i).get("xmname").toString();
			String tempSql = "select * from PLAN开发体量 t where t.xmmc=? order by t.nd,t.jd";
			List<Map<String, Object>> result = query(tempSql, YW, new String[] { proName });
			code += getKindsCode(proKinds.get(i).get("xmname").toString(), result, kinds, fileds, i + 1);
		}
		return code;
	}

	/**
	 * <br>
	 * Description:获取供地体量的具体信息 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-26
	 * 
	 * @return
	 */
	public String getGDTLDetail() {
		String code = "";
		// 从基础数据数据中取到所有的项目名称
		String sql = "select t.xmname from xminfo t group by t.xmname";
		List<Map<String, Object>> proKinds = query(sql, YW);

		String[] kinds = { "地量", "规模", "成本", "收益", "总价", "租金" };
		String[][] fileds = { { "dl", "dlz" }, { "gm", "gmz" }, { "cb", "cbz" }, { "sy", "syz" }, { "zj", "zjz" },
				{ "zuj", "zuj" } };
		for (int i = 0; i < proKinds.size(); i++) {
			String proName = proKinds.get(i).get("xmname").toString();
			String tempSql = "select * from PLAN供地体量 t where t.xmmc=? order by t.nd,t.jd";
			List<Map<String, Object>> result = query(tempSql, YW, new String[] { proName });
			code += getKindsCode(proKinds.get(i).get("xmname").toString(), result, kinds, fileds, i + 1);
		}
		return code;
	}

	// //////////////////////////////////////////////////////////////////
	/**
	 * <br>
	 * Description:生成各个字段各个季度的代码 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-26
	 * 
	 * @param proName
	 *            当前信息的项目名称
	 * @param result
	 *            当前项目的所有信息
	 * @param kinds
	 *            所要显示字段名称
	 * @param fileds
	 *            所要显示的字段数据库字段名[cj][cjz]
	 * @return
	 */
	private String getKindsCode(String proName, List<Map<String, Object>> result, String[] kinds, String[][] fileds,
			int index) {
		String code = "";
		// 生成第一行td的代码时，要额外加上序号以及当前项目的名称
		code = "<tr><td rowspan=" + kinds.length + ">" + index + "</td><td>" + kinds[0] + "</td><td rowspan="
				+ kinds.length
				+ " style='background: #C0C0C0;' onclick=window.open('kftl/kftlmodel.jsp?xmmc="
				+ proName + "')>" + proName + "</td>";
		code += getDeatailCode(result, fileds[0][0], fileds[0][1]);
		code += "<td></td></tr>";

		for (int i = 1; i < kinds.length; i++) {
			code += "<tr><td>" + kinds[i] + "</td>" + getDeatailCode(result, fileds[i][0], fileds[i][1])
					+ "<td></td></tr>";
		}
		return code;
	}

	/**
	 * <br>
	 * Description:生成指定字段各个季度的td代码 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-26
	 * 
	 * @param result
	 *            所要显示当前项目的所有信息
	 * @param filed1
	 *            字段百分比数值
	 * @param filed2
	 *            百分比对应的数值
	 * @return
	 */
	private String getDeatailCode(List<Map<String, Object>> result, String filed1, String filed2) {
		String code = "";
		String[] temp = new String[36];
		// 将各个季度的数值填入到数组temp中
		for (int j = 0; j < result.size(); j++) {
			int nd;
			int jd;
			try {
				nd = Integer.parseInt(result.get(j).get("ND").toString());
				jd = Integer.parseInt(result.get(j).get("JD").toString());
			} catch (Exception e) {
				continue;
			}
			Object value1 = result.get(j).get(filed1);
			Object value2 = result.get(j).get(filed2);
			if (value2 != null && value2.toString() != "") {
				int position = (nd - 2012) * 4 + jd - 1;
				value1 = (value1 == null || value1.toString() == "") ? "--" : value1;
				String value = value2.toString() + "/" + value1;
				temp[position] = value;
			}
		}
		// 根据数组temp中的值来构成html <td>代码
		for (int k = 0; k < temp.length; k++) {
			String subcode = (temp[k] == null || temp[k] == "") ? ("<td></td>") : ("<td style='background: #FFCC00;'>"
					+ temp[k] + "</td>");
			code += subcode;
		}
		return code;
	}
}
