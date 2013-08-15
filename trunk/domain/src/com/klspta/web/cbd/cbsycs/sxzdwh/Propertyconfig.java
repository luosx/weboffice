package com.klspta.web.cbd.cbsycs.sxzdwh;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:CBD属性字段管理类
 * <br>Description:对CBD属性字段进行管理
 * <br>Author:黎春行
 * <br>Date:2013-8-15
 */
public class Propertyconfig extends AbstractBaseBean {
	/**
	 * 
	 * <br>Description:获取列表中所有的字段名和别名
	 * <br>Author:黎春行
	 * <br>Date:2013-8-15
	 */
	public void getAllAlias(){
		String aliasSql = "select distinct t.bieming, t.ziduanming, t.sort from propertyconfig t where t.status = '1' order by t.sort";
		List<Map<String, Object>> resultList = query(aliasSql, YW);
		response(resultList);
	}
	
	

}
