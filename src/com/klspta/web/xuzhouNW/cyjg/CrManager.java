package com.klspta.web.xuzhouNW.cyjg;

import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;

public class CrManager extends AbstractBaseBean{
	
	

	public List<Map<String , Object>> getcrListByKeyword(String keyWord){
		StringBuffer sql = new StringBuffer("select (rownum-1) RUNNUM1, t.* from showcr t where 1=1 ");
		if(keyWord != ""){
			sql.append(" and (t.pc||t.pfwh||t.gd||t.fs||t.tdyt||t.syqx||t.gdmj||t.crj||t.srr||t.cjsj||t.crhtbh||t.bz) like '%" + keyWord + "%' ");
		}
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return resultList;
	}
	public List<Map<String , Object>> getAllcrList(){
		StringBuffer sql = new StringBuffer("select (rownum-1) RUNNUM1, t.* from showcr t where 1=1 ");
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return resultList;
	}
}
