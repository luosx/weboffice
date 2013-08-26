package com.klspta.web.cbd.cbsycs;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:成本及收益测算基本信息
 * <br>Description:对成本及收益测算基本信息数据管理
 * <br>Author:姚建林
 * <br>Date:2013-8-20
 */
public class BasicInfo extends AbstractBaseBean {
	
	/**
	 * 
	 * <br>Description:TODO 方法功能描述
	 * <br>Author:姚建林
	 * <br>Date:2013-8-20
	 */
	public void getXZQ(){
		String strSelect = request.getParameter("strSelect");
		String sql = "";
		if(strSelect == null || strSelect.equals("")){
			sql = "select t.code,t.name from dkxzq t where t.parent_code = 0";
		}else{
			sql = "select t.code,t.name from dkxzq t where t.parent_code = " + strSelect;
		}
		List<Map<String, Object>> result = query(sql, YW);
		response(result);
	}
	
	/**
	 * 
	 * <br>Description:TODO 方法功能描述
	 * <br>Author:姚建林
	 * <br>Date:2013-8-20
	 */
	public void bindData(){
		String yw_guid = request.getParameter("yw_guid");
		String sql = "select t.dkxzq from dkinfo t where t.yw_guid = ?";
		List<Map<String, Object>> result = query(sql, YW, new Object[]{yw_guid});
		response(String.valueOf(result.get(0).get("dkxzq")));
	}
	
}
