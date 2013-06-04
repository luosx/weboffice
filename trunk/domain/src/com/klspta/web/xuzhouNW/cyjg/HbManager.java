package com.klspta.web.xuzhouNW.cyjg;

import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;

public class HbManager extends AbstractBaseBean{
	
	

	public List<Map<String , Object>> gethbListByKeyword(String keyWord){
		StringBuffer sql = new StringBuffer("select (rownum-1) RUNNUM1, t.* from showhb t where 1=1 ");
		if(keyWord != ""){
			sql.append(" and (t.pc||t.pfwh||t.gd||t.tdyt||t.gdmj||t.srr||t.hbsj||t.hbjdsbh||t.bz) like '%" + keyWord + "%' ");
		}
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return resultList;
	}
	public List<Map<String , Object>> getAllhbList(){
		StringBuffer sql = new StringBuffer("select (rownum-1) RUNNUM1, t.* from showhb t where 1=1 ");
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return resultList;
	}
}
