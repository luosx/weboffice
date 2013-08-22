package com.klspta.web.cbd.plan;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.rest.RestRequest;

/**
 * 
 * <br>Title:计划表管理类
 * <br>Description:管理数据库中PLAN供地体量的增删改查
 * <br>Author:黎春行
 * <br>Date:2013-8-21
 */
public class PlanHandle extends AbstractBaseBean{
	/**
	 * 
	 * <br>Description:获取PLAN表中对应项目的基本数据
	 * <br>Author:黎春行
	 * <br>Date:2013-8-21
	 */
	public void getplanList(){
		String xmmc = request.getParameter("xmmc");
		String sql = "";
		
		
	}
	/**
	 * 
	 * <br>Description:根据季度获取开发体量信息
	 * <br>Author:黎春行
	 * <br>Date:2013-8-22
	 */
	public void getPlanQuertly(){
		String querySql = "select * from v_开发体量 t order by t.年度, t.季度";
		List<Map<String, Object>> queryList = query(querySql, YW);
		response(queryList);
	}
}
