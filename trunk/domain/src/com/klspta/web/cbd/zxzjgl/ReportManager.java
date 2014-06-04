 package com.klspta.web.cbd.zxzjgl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class ReportManager extends AbstractBaseBean{

	
	static ZjglData zjglData= new ZjglData();
	
	static String[] items = { "YY", "EY", "SANY", "SIY", "WY", "LY", "QY",
		"BQY", "JY", "SIYUE", "SYY", "SEY" };
	/***************************************************************************
	 * 
	 * <br>
	 * Description:制作表格 <br>
	 * Author:李国明 <br>
	 * Date:2014-5-22
	 * 
	 * @param yw_guid
	 * @param year
	 * @return
	 */
	public String getReport(String year ,String rolename) {
		StringBuffer  buffer = new StringBuffer();
		StringBuffer title = ZjglBuild.buildTitle(year);
		buffer.append(title);
		String sql_zc = "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from xmzjgl_zc t where  t.rq=?  order by t.parent_id, t.tree_name";
		String sql_lr =  "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from xmzjgl_lr t where  t.rq=? order by t.parent_id, t.tree_name";
		buffer.append(buildTreeBuffer(getBeanList( year, sql_lr), "0", rolename, "LR").toString());
		buffer.append(buildTreeBuffer(getBeanList( year, sql_zc), "0", rolename, "ZC").toString());
		buffer.append(ZjglBuild.buildSum());
		return buffer.toString();
	}
	
	public List<XmzjglTreeBean> getBeanList( String year,String sql){
		List<XmzjglTreeBean> arrayList = new ArrayList<XmzjglTreeBean>();
		List<Map<String, Object>> queryList = query(sql, YW, new Object[]{ year});
		for(int i = 0; i < queryList.size(); i++){
			arrayList.add(new XmzjglTreeBean(queryList.get(i)));
		}
		return arrayList;
	}
	
	public StringBuffer buildTreeBuffer(List<XmzjglTreeBean> treeList, String key,String rolename, String type){
		StringBuffer stringBuffer = new StringBuffer();
		for(int i = 0; i < treeList.size(); i++){
			XmzjglTreeBean xmBean = treeList.get(i);
			if(xmBean.getParent_id().equals(key)){
				StringBuffer childString = buildTreeBuffer(treeList, xmBean.getTree_id(),rolename, type); 
				if(childString.length() != 0){
					String year = xmBean.getRq();
					String tree_id = xmBean.getTree_id();
					if("ZC".equals(type)){
						List<Map<String, Object>> list = zjglData.getZJZC_father(  tree_id, year );
						stringBuffer.append(ZjglBuild.buildZjzc_father_sum(list, Integer.parseInt(xmBean.getLeval())));
					}else{
						List<Map<String, Object>> list = zjglData.getZJLR_father(  tree_id, year );
						stringBuffer.append(ZjglBuild.buildZjlr_father_sum(list, Integer.parseInt(xmBean.getLeval())));
					}
					stringBuffer.append(childString);
				}else{
					String tree_name =  xmBean.getTree_name();
					String parent_id = xmBean.getParent_id();
					String year = xmBean.getRq();
					int leval = Integer.parseInt(xmBean.getLeval());
					
					if("ZC".equals(type)){
						List<Map<String, Object>> list = zjglData.getZJZC_child(tree_name, parent_id, year );
						if(leval > 3){
							stringBuffer.append(ZjglBuild.buildZjzc_child(list, rolename,Integer.parseInt(xmBean.getLeval())));
						}else{
							stringBuffer.append(ZjglBuild.buildZjzc_father(list, rolename, leval));
						}
					}else{
						List<Map<String, Object>> list = zjglData.getZJLR_child(tree_name, parent_id, year );
						if(leval > 3){
							stringBuffer.append(ZjglBuild.buildZjlr_child(list, rolename,Integer.parseInt(xmBean.getLeval())));
						}else{
							stringBuffer.append(ZjglBuild.buildZjlr_father(list, rolename, leval));
						}
					}
				}
			}else{
				continue;
			}
		}
		return stringBuffer;
	}

	
}
