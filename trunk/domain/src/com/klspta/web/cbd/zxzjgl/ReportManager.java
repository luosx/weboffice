 package com.klspta.web.cbd.zxzjgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class ReportManager extends AbstractBaseBean{
    
    
	
	static ZjglData zjglData = new ZjglData();
	
	static String[] items = { "YY", "EY", "SANY", "SIY", "WY", "LY", "QY", "BQY", "JY", "SIYUE", "SYY", "SEY" };
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
		buffer.append(ZjglBuild.buildTitle(year));
		List<Map<String, Object>> list = zjglData.getFatherData(year,zjglData.SQL_ZJZC_FATHER );
		buffer.append(ZjglBuild.buildZjlr_father_sum_view(list));
//		StringBuffer title = ZjglBuild.buildTitle(year);
//		buffer.append(title);
//		String sql_lr = "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval from xmzjgl_lr t where t.rq=? order by t.parent_id, t.tree_name";
//		String sql_zc = "select distinct t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval from xmzjgl_zc t where t.rq=? order by t.parent_id, t.tree_name";
//		buffer.append(buildTreeBuffer(getBeanList( year, sql_lr), "0", rolename, "LR").toString());
//		buffer.append(buildTreeBuffer(getBeanList( year, sql_zc), "0", rolename, "ZC").toString());
//		buffer.append(ZjglBuild.buildSum());
		return buffer.toString();
	}
	
//	public List<XmzjglTreeBean> getBeanList( String year,String sql){
//		List<XmzjglTreeBean> arrayList = new ArrayList<XmzjglTreeBean>();
//		List<Map<String, Object>> queryList = query(sql, YW, new Object[]{ year});
//		for(int i = 0; i < queryList.size(); i++){
//			arrayList.add(new XmzjglTreeBean(queryList.get(i)));
//		}
//		return arrayList;
//	}
//	
//	public StringBuffer buildTreeBuffer(List<XmzjglTreeBean> treeList, String key, String rolename, String type){
//		StringBuffer stringBuffer = new StringBuffer();
//		for(int i = 0; i < treeList.size(); i++){
//			XmzjglTreeBean xmBean = treeList.get(i);
//			if(xmBean.getParentID().equals(key)){
//				StringBuffer childString = buildTreeBuffer(treeList, xmBean.getTreeID(), rolename, type); 
//				if(childString.length() != 0){
//					String year = xmBean.getRq();
//					String treeID = xmBean.getTreeID();
//					if("ZC".equals(type)){
//						List<Map<String, Object>> list = zjglData.getFatherData( treeID, year,zjglData.SQL_ZJZC_FATHER );
//						stringBuffer.append(ZjglBuild.buildZjzc_father_sum_view(list, Integer.parseInt(xmBean.getLeval())));
//					}else{
//						List<Map<String, Object>> list = zjglData.getFatherData( treeID, year,zjglData.SQL_ZJLR_FATHER );
//						stringBuffer.append(ZjglBuild.buildZjlr_father_sum_view(list, Integer.parseInt(xmBean.getLeval())));
//					}
//					stringBuffer.append(childString);
//				}else{
//					String treeName =  xmBean.getTreeName();
//					String parentID = xmBean.getParentID();
//					String year = xmBean.getRq();
//					int leval = Integer.parseInt(xmBean.getLeval());
//					
//					if("ZC".equals(type)){
//						List<Map<String, Object>> list = zjglData.getZJZCChild(treeName, parentID, year );
//						stringBuffer.append(ZjglBuild.buildZjzc_father_view(list, rolename, leval));
//					}else{
//						List<Map<String, Object>> list = zjglData.getZJLR_child(treeName, parentID, year );
//						stringBuffer.append(ZjglBuild.buildZjlr_father_view(list, rolename, leval));
//					}
//				}
//			}else{
//				continue;
//			}
//		}
//		return stringBuffer;
//	}

	
}
