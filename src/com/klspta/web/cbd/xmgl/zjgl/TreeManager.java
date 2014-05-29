package com.klspta.web.cbd.xmgl.zjgl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class TreeManager extends AbstractBaseBean {

	/***************************************************************************
	 * 
	 * <br>
	 * Description:资金支出资源树 <br>
	 * Author:李国明 <br>
	 * Date:2014-5-23
	 * 
	 * @param yw_guid
	 * @param type
	 * @return
	 */
	public String getZC_tree(String yw_guid, String year) {
		String sql = "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id  from xmzjgl_zc t where t.yw_guid=? and t.rq=? order by t.parent_id, t.tree_name";
		String  returnString = buildTreeBuffer(getBeanList(yw_guid, year, sql,"ZC"), "0").toString();
		return returnString;
	}
	
	
	/***************************************************************************
	 * 
	 * <br>
	 * Description:资金支出资源树 <br>
	 * Author:李国明 <br>
	 * Date:2014-5-23
	 * 
	 * @param yw_guid
	 * @param type
	 * @return
	 */
	public String getLR_tree(String yw_guid, String year) {
		String sql = "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id  from xmzjgl_lr t where t.yw_guid=? and t.rq=? order by t.parent_id, t.tree_name";
		String  returnString = buildTreeBuffer(getBeanList(yw_guid, year, sql,"LR"), "0").toString();
		return returnString;
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
		return getLR_tree(yw_guid, year) + "," + getZC_tree(yw_guid, year) ;
		
	}


	
	public List<XmzjglTreeBean> getBeanList(String yw_guid , String year, String sql,String type){
		List<XmzjglTreeBean> arrayList = new ArrayList<XmzjglTreeBean>();
		List<Map<String, Object>> queryList = query(sql, YW, new Object[]{yw_guid, year});
		if(queryList!=null && queryList.size()<1){
			if("ZC".equals(type)){
				new ZjglData().setMXZC(yw_guid, year);
				queryList = query(sql, YW, new Object[]{yw_guid, year});
			}else{
				new ZjglData().setMXLR(yw_guid, year);
				queryList = query(sql, YW, new Object[]{yw_guid, year});
			}
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
