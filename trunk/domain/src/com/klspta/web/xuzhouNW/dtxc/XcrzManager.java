package com.klspta.web.xuzhouNW.dtxc;

import java.util.List;
import java.util.Map;


import com.klspta.base.AbstractBaseBean;
import com.klspta.console.ManagerFactory;

public class XcrzManager extends AbstractBaseBean{
	
	private static XcrzManager xcrzManager;
	
	public static XcrzManager getInstance(){
		if(xcrzManager == null){
			xcrzManager = new XcrzManager();
		}
		return xcrzManager;
	}
	
	public List<Map<String, Object>> getXcrzListByUserId(String userId){
		try {
			String xzqh = ManagerFactory.getRoleManager().getRoleWithUserID(userId).get(0).getXzqh();
			return getXcrzListByXzqh(xzqh);
		} catch (Exception e) {
			System.out.println("userId wrong");
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Map<String, Object>> getXcrzListByXzqh(String xzqh){
		if(xzqh.endsWith("00")){
			xzqh = xzqh.substring(0, 4);
		}
		String sql = "select (rownum-1) RUNNUM1, t.* from xcrz t where t.writexzqh like '" + xzqh + "%' order by t.xcrq desc ";
		List<Map<String, Object>> resultList = query(sql, YW);
		return resultList;
	}
	
	public List<Map<String , Object>> getXcrzListByXzqhAndKeyWord(String xzqh, String keyWord){
		StringBuffer sql = new StringBuffer("select (rownum-1) RUNNUM1, t.* from xcrz t where 1=1 ");
		if(xzqh != ""){
			if(xzqh.endsWith("00")){
				xzqh = xzqh.substring(0, 4);
			}
			sql.append("and t.writexzqh like '" + xzqh + "'");
		}
		if(keyWord != ""){
			sql.append(" and (t.xcbh||t.xcdw||t.xcrq||t.xcqy||t.xcry||t.xclx||t.jsmj||t.jsdw||t.dgsj||t.jsqk||t.zdmj||t.zdwz||t.psqk||t.clyj||t.bz) like '%" + keyWord + "%' order by t.xcrq desc");
		}
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return resultList;
	}
	
	
	
	
	
	
	
	public List getAllXcrzList(){
		
		return null;
	}
	
	
	
}
