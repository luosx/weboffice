package com.klspta.web.cbd.zcgl.zcfz;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.web.cbd.xmgl.zjgl.ZjglBuild;
import com.klspta.web.cbd.xmgl.zjgl.ZjglData;

public class ReportManager extends AbstractBaseBean{

	
	static ZjglData zjglData= new ZjglData();
	
	static String[] items = { "YY", "EY", "SANY", "SIY", "WY", "LY", "QY",
		"BQY", "JY", "SIYUE", "SYY", "SEY" };
	/***************************************************************************
	 * 
	 * <br>
	 * Description:制作表格 <br>
	 * Author:朱波海 <br>
	 * Date:2014-1-16
	 * 
	 * @param yw_guid
	 * @param year
	 * @return
	 */
	public String getTree(String yw_guid, String year ,String rolename) {
		StringBuffer  buffer = new StringBuffer();
		StringBuffer title = ZcfzBuild.buildTitle(year);
		buffer.append(title);
		buffer.append(buildTreeBuffer(getBeanList(yw_guid, year), "0",rolename).toString());
		return buffer.toString();
	}
	
	public List<XmzjglTreeBean> getBeanList(String yw_guid , String year){
		String sql = "select distinct t.yw_guid ,t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from zcfz_zc t  order by t.parent_id, t.tree_name";
		List<XmzjglTreeBean> arrayList = new ArrayList<XmzjglTreeBean>();
		List<Map<String, Object>> queryList = query(sql, YW, new Object[]{yw_guid, year});
		if(queryList!=null && queryList.size()<1){
			//new ZjglData().setMX(yw_guid, year);
			queryList = query(sql, YW, new Object[]{yw_guid, year});
		}
		for(int i = 0; i < queryList.size(); i++){
			arrayList.add(new XmzjglTreeBean(queryList.get(i)));
		}
		return arrayList;
	}
	
	public StringBuffer buildTreeBuffer(List<XmzjglTreeBean> treeList, String key,String rolename){
		StringBuffer stringBuffer = new StringBuffer();
		for(int i = 0; i < treeList.size(); i++){
			XmzjglTreeBean xmBean = treeList.get(i);
			if(xmBean.getParent_id().equals(key)){
				StringBuffer childString = buildTreeBuffer(treeList, xmBean.getTree_id(),rolename); 
				if(childString.length() != 0){
					String yw_guid = xmBean.getYw_guid();
					String tree_name =  xmBean.getTree_name();
					String parent_id = xmBean.getParent_id();
					String year = xmBean.getRq();
					String tree_id = xmBean.getTree_id();
					//List<Map<String, Object>> list = zjglData.getZJGL_father(yw_guid,  tree_id, year );
					//stringBuffer.append(ZjglBuild.buildZjzc_father_sum(list, Integer.parseInt(xmBean.getLeval())));
					stringBuffer.append(childString);
				}else{
					String yw_guid = xmBean.getYw_guid();
					String tree_name =  xmBean.getTree_name();
					String parent_id = xmBean.getParent_id();
					String year = xmBean.getRq();
				//	List<Map<String, Object>> list = zjglData.getZJGL_child(yw_guid, tree_name, parent_id, year );
					//stringBuffer.append(ZjglBuild.buildZjzc_child(list, rolename,Integer.parseInt(xmBean.getLeval())));
				}
			}else{
				continue;
			}
		}
		return stringBuffer;
	}
	
}
