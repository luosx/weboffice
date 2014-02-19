package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class TreeManager extends AbstractBaseBean {

	/***************************************************************************
	 * 
	 * <br>
	 * Description:树关联 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-22
	 * 
	 * @param yw_guid
	 * @param type
	 * @return
	 */

	public List<Map<String, Object>> getZC_tree(String yw_guid, String type,
			String year) {
		String sql = "select *  from zjgl_tree where yw_guid=? and parent_id=? and rq=?";
		List<Map<String, Object>> list = query(sql, YW, new Object[] { yw_guid,
				type, year });
		return list;
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:获取全部树——old <br>
	 * Author:朱波海 <br>
	 * Date:2014-1-16
	 * 
	 * @param yw_guid
	 * @param year
	 * @return
	 */
	public String getTree(String yw_guid, String year) {
		StringBuffer buffer = new StringBuffer();
		//add by 黎春行   2014-02-20
		//buffer.append("{text:'Ⅰ.资金流入',leaf:1,id:'ZJLR',children:[");
		StringBuffer zjlr = getChaild_tree(yw_guid, "Ⅰ.资金流入", "ZJLR", year);
		buffer.append(zjlr).append(",");
		
		buffer.append("{text:'Ⅱ.资金支出',leaf:0,id:'1',");
		buffer.append("children:[{text:'2.1 一级开发支出',leaf:0,id:'101',");
		buffer.append("children:[");
		StringBuffer qqfy = getChaild_tree(yw_guid, "2.1.1 前期费用", "QQFY", year);
		buffer.append(qqfy);
		buffer.append(",");
		StringBuffer cqfy = getChaild_tree(yw_guid, "2.1.2 拆迁费用", "CQFY", year);
		buffer.append(cqfy);
		buffer.append(",");
		StringBuffer scfy = getChaild_tree(yw_guid, "2.1.3 收储费用", "SCFY", year);
		buffer.append(scfy);
		buffer.append(",");
		StringBuffer szfy = getChaild_tree(yw_guid, "2.1.4 市政费用", "SZFY", year);
		buffer.append(szfy);
		buffer.append(",");
		StringBuffer cwfy = getChaild_tree(yw_guid, "2.1.5 财务费用", "CWFY", year);
		buffer.append(cwfy);
		buffer.append(",");
		StringBuffer qlfy = getChaild_tree(yw_guid, "2.1.6 管理费用", "GLFY", year);
		buffer.append(qlfy);
		buffer.append("]},");
		StringBuffer cyzjfh = getChaild_tree(yw_guid, "2.2 筹融资金返还", "CRZJFH",
				year);
		buffer.append(cyzjfh);
		buffer.append(",");
		StringBuffer qtzc = getChaild_tree(yw_guid, "2.3 其他支出", "QTZC", year);
		buffer.append(qtzc);
		buffer.append("]}");
		return buffer.toString();
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:获取部分节点树——new <br>
	 * Author:朱波海 <br>
	 * Date:2014-1-16
	 * 
	 * @param yw_guid
	 * @param year
	 * @return
	 */
	public String getTree(String yw_guid, String year, String[] treeType) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("{text:'Ⅱ.资金支出',leaf:0,id:'1',");
		buffer.append("children:[{text:'2.1 一级开发支出',leaf:0,id:'101',");
		buffer.append("children:[");
		boolean status = false;
		for (int i = 0; i < treeType.length; i++) {
			if (treeType[i].equals("QQFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer qqfy = getChaild_tree(yw_guid, "2.1.1 前期费用",
						"QQFY", year);
				buffer.append(qqfy);
				status = true;
			} else if (treeType[i].equals("CQFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer cqfy = getChaild_tree(yw_guid, "2.1.2 拆迁费用",
						"CQFY", year);
				buffer.append(cqfy);
				status = true;
			} else if (treeType[i].equals("SCFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer scfy = getChaild_tree(yw_guid, "2.1.3 收储费用",
						"SCFY", year);
				buffer.append(scfy);
				status = true;
			} else if (treeType[i].equals("SZFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer szfy = getChaild_tree(yw_guid, "2.1.4 市政费用",
						"SZFY", year);
				buffer.append(szfy);
				status = true;
			}else if (treeType[i].equals("CWFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer cwfy = getChaild_tree(yw_guid, "2.1.5 财务费用",
						"CWFY", year);
				buffer.append(cwfy);
				status = true;
			} else if (treeType[i].equals("GLFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer qlfy = getChaild_tree(yw_guid, "2.1.6 管理费",
						"GLFY", year);
				buffer.append(qlfy);
				buffer.append("]}");
				status = true;
			} else if (treeType[i].equals("GLFY")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer qlfy = getChaild_tree(yw_guid, "2.1.7 管理费用",
						"GLFY", year);
				buffer.append(qlfy);
				buffer.append("]}");
				status = true;
			} else if (treeType[i].equals("CRZJFH")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer cyzjfh = getChaild_tree(yw_guid, "2.2 筹融资金返还",
						"CRZJFH", year);
				buffer.append(cyzjfh);
				status = true;
			} else if (treeType[i].equals("QTZC")) {
				if (status) {
					buffer.append(",");
				}
				StringBuffer qtzc = getChaild_tree(yw_guid, "2.3 其他支出", "QTZC",
						year);
				buffer.append(qtzc);
				
				status = true;
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:父节点 <br>
	 * Author:朱波海 <br>
	 * Date:2014-1-16
	 * 
	 * @param list
	 * @return
	 */
	public StringBuffer getFather_tree(List<Map<String, Object>> list) {
		StringBuffer buffer = new StringBuffer();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					buffer.append("\n{text:'");
				} else {
					buffer.append(",\n{text:'");
				}
				buffer.append(list.get(i).get("tree_name").toString());
				buffer.append("',leaf:'0',id:'");
				buffer.append(list.get(i).get("tree_id").toString());
				buffer.append("',children:[");
				if (i == (list.size() - 1)) {
					buffer.append("]}");
				}
			}
		}
		return buffer;
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:子节点 <br>
	 * Author:朱波海 <br>
	 * Date:2014-1-16
	 * 
	 * @param yw_guid
	 * @param name
	 * @param type
	 * @param year
	 * @return
	 */

	public StringBuffer getChaild_tree(String yw_guid, String name,
			String type, String year) {
		StringBuffer buffer = new StringBuffer();
		String sql_qqfy = " select * from zjgl_tree where yw_guid=? and parent_id=? and rq=?";
		List<Map<String, Object>> list = query(sql_qqfy, YW, new Object[] {
				yw_guid, type, year });
		if (list.size() > 0) {
			buffer.append("{text:'" + name + "',leaf:0,id:'" + type
					+ "',children:[");
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					buffer.append("\n{text:'");
				} else {
					buffer.append(",\n{text:'");
				}
				buffer.append(list.get(i).get("tree_name").toString());
				buffer.append("',leaf:'0',id:'");
				buffer.append(list.get(i).get("tree_id").toString());
				buffer.append("'}");
			}
			buffer.append("]}");
		} else {
			buffer.append("{text:'" + name + "',leaf:1,id:'" + type + "'}");

		}
		return buffer;
	}

}
