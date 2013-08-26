package com.klspta.web.cbd.plan;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * <br>
 * Title:生成项目综合信息类 <br>
 * Description:生成项目综合数据code <br>
 * Author:赵伟 <br>
 * Date:2013-8-26
 */
public class ProData extends AbstractBaseBean {
	/**
	 * <br>
	 * Description:生成开发体量综合信息 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-26
	 * 
	 * @return
	 */
	public String getKFTLData() {
		String code = "";
		// 读取到开发体量的综合数据
		String sql = "select * from V_开发体量 t ";
		List<Map<String, Object>> result = query(sql, YW);

		String[] kinds = { "征收户数", "完成开发体量<br/>(公顷)", "完成开发规模<br/>（万㎡）", "储备红线投资<br>（亿元）" };
		String[] fileds = { "征收户数", "完成开发体量", "完成开发规模", "储备红线投资" };
		String color = "#FFFF99";
		code = getKindsCode(result, "开<br>发<br>体<br>量", color, 1, kinds, fileds);
		return code;
	}

	public String getAZFJSData() {
		String code = "";
		return code;
	}

	/**
	 * <br>
	 * Description:生成各个字段各个季度的代码 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-26
	 * 
	 * @param result
	 *            当前项目的所有信息
	 * @param itemName
	 *            当前项目的名称
	 * @param color
	 *            当前项目表格的背景颜色
	 * @param fromIndex
	 *            当前项目前方的起始序号
	 * @param kinds
	 *            当前项目所要显示各个字段名称
	 * @param fileds
	 *            当前项目所要显示各个字段对应的数据库字段
	 * @return
	 */
	private String getKindsCode(List<Map<String, Object>> result, String itemName, String color, int fromIndex,
			String[] kinds, String[] fileds) {
		String code = "";
		// 生成第一行td的代码时，要额外加上当前统计的项目名称
		code = "<tr style='background:" + color + ";'><td rowspan=" + kinds.length + ">" + itemName + "</td><td>"
				+ fromIndex + "</td><td>" + kinds[0] + "</td>";
		code += getDeatailCode(result, fileds[0]);
		code += "<td></td></tr>";

		for (int i = 1; i < kinds.length; i++) {
			code += "<tr style='background:" + color + ";'><td>" + (fromIndex + i) + "</td><td>" + kinds[i] + "</td>"
					+ getDeatailCode(result, fileds[i]) + "<td></td></tr>";
		}
		return code;
	}

	/**
	 * <br>
	 * Description:生成指定字段各个季度的代码 <br>
	 * Author:赵伟 <br>
	 * Date:2013-8-26
	 * 
	 * @param result
	 *            当前项目的所有信息
	 * @param filed
	 *            当前字段对应的数据库字段
	 * @return
	 */
	private String getDeatailCode(List<Map<String, Object>> result, String filed) {
		String code = "";
		String[] temp = new String[36];
		// 将各个季度的数值填入到数组temp中
		for (int j = 0; j < result.size(); j++) {
			int nd = Integer.parseInt(result.get(j).get("年度").toString());
			int jd = Integer.parseInt(result.get(j).get("季度").toString());
			Object value = result.get(j).get(filed);
			if (value != null && value.toString() != "") {
				int position = (nd - 2012) * 4 + jd - 1;
				temp[position] = value.toString();
			}
		}
		// 根据数组temp中的值来构成html <td>代码
		for (int k = 0; k < temp.length; k++) {
			String subcode = (temp[k] == null || temp[k] == "") ? ("<td></td>") : ("<td>" + temp[k] + "</td>");
			code += subcode;
		}
		return code;
	}
}
