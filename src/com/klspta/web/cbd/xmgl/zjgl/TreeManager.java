package com.klspta.web.cbd.xmgl.zjgl;

import java.util.ArrayList;
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
		String sql = "";
		List<Map<String, Object>> list = null;
		if("1".equals(yw_guid)){
			sql = "select *  from zjgl_tree where rq='all'";
			list = query(sql, YW);
		}else{
			sql = "select distinct tree_name from xmzjgl_zc where yw_guid=? and parent_id=? and rq=?";
			list = query(sql, YW, new Object[] { yw_guid,type, year });
		}
		
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
		String  returnString = buildTreeBuffer(getBeanList(yw_guid, year), "0").toString();
		return returnString;
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

//	public StringBuffer getChaild_tree(String yw_guid, String name,
//			String type, String year) {
//		StringBuffer buffer = new StringBuffer();
//		String sql_qqfy = " select * from xmzjgl_zc where yw_guid=? and parent_id=? and rq=?";
//		List<Map<String, Object>> list = query(sql_qqfy, YW, new Object[] {
//				yw_guid, type, year });
//		if (list.size() > 0) {
//			buffer.append("{text:'" + name + "',leaf:0,id:'" + type
//					+ "',children:[");
//			for (int i = 0; i < list.size(); i++) {
//				if (i == 0) {
//					buffer.append("\n{text:'");
//				} else {
//					buffer.append(",\n{text:'");
//				}
//				buffer.append(list.get(i).get("tree_name").toString());
//				buffer.append("',leaf:'0',id:'");
//				buffer.append(list.get(i).get("tree_id").toString());
//				buffer.append("'}");
//			}
//			buffer.append("]}");
//		} else {
//			buffer.append("{text:'" + name + "',leaf:1,id:'" + type + "'}");
//		}
//		return buffer;
//	}
	
	public List<XmzjglTreeBean> getBeanList(String yw_guid , String year){
		String sql = "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id  from xmzjgl_zc t where t.yw_guid=? and t.rq=? order by t.parent_id, t.tree_name";
		List<XmzjglTreeBean> arrayList = new ArrayList<XmzjglTreeBean>();
		List<Map<String, Object>> queryList = query(sql, YW, new Object[]{yw_guid, year});
		if(queryList!=null && queryList.size()<1){
			new ZjglData().setMX(yw_guid, year);
			queryList = query(sql, YW, new Object[]{yw_guid, year});
		}
		for(int i = 0; i < queryList.size(); i++){
			arrayList.add(new XmzjglTreeBean(queryList.get(i)));
		}
		return arrayList;
	}
	
	public StringBuffer buildTreeBuffer(List<XmzjglTreeBean> treeList, String key){
		StringBuffer stringBuffer = new StringBuffer();
		for(int i = 0; i < treeList.size(); i++){
			XmzjglTreeBean xmBean = treeList.get(i);
			if(xmBean.getParent_id().equals(key)){
				StringBuffer childString = buildTreeBuffer(treeList, xmBean.getTree_id()); 
				if(childString.length() != 0){
					stringBuffer.append("{text:'").append(xmBean.getTree_name()).append("',leaf:0,id:'").append(xmBean.getTree_id()).append("'");
					stringBuffer.append(",children:[").append(childString.toString()).append("]");
				}else{
					stringBuffer.append("{text:'").append(xmBean.getTree_name()).append("',leaf:1,id:'").append(xmBean.getTree_id()).append("'");
				}
				stringBuffer.append("},");
			}else{
				continue;
			}
		}
		if(stringBuffer.length() > 1){
			return new StringBuffer(stringBuffer.substring(0, stringBuffer.length() - 1));
		}else{
			return stringBuffer;
		}
	}

}
