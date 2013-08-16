package com.klspta.web.cbd.cbsycs.jbxxlr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.management.Query;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:成本及收益测算基本信息
 * <br>Description:对成本及手机测算基本信息数据管理
 * <br>Author:黎春行
 * <br>Date:2013-8-15
 */
public class BasicInfo extends AbstractBaseBean {
	//将所有的公式缓存
	private Map<String, Object> formula = new HashMap<String, Object>();
	Map<String, Object> basic = new HashMap<String, Object>();
	List<Map<String,Object>> formField = new ArrayList<Map<String, Object>>();
	/**
	 * 
	 * <br>Description:初始化，将公式存入缓存。
	 * <br>Author:黎春行
	 * <br>Date:2013-8-16
	 */
	public BasicInfo() {
		String formulaSql = "select * from formulaconfig where yw_guid = 'cbdqyjcb'";
		List<Map<String, Object>> formulaList = query(formulaSql, YW);
		for(int i = 0; i < formulaList.size(); i++){
			formula.put(String.valueOf(formulaList.get(i).get("fulaname")), String.valueOf("fulavalue"));
		}
		formulaSql = "select * from  propertyconfig t where t.status='1'";
		formField = query(formulaSql, YW);
	}

	/**
	 * 
	 * <br>Description:基本数据保存
	 * <br>Author:黎春行
	 * <br>Date:2013-8-15
	 */
	public void saveData(){
		String yw_guid = request.getParameter("yw_guid");
		if(yw_guid != null && yw_guid != ""){
			yw_guid = UtilFactory.getStrUtil().getGuid();
		}
		String fieldSql = "select * from  propertyconfig t where t.status='1' and t.fangshi='1'";
		List<Map<String, Object>> fieldList = query(fieldSql, YW);
		
		//将基础数据保存到数据库中
		for(int i = 0; i < fieldList.size(); i++){
			String aliasName = String.valueOf(fieldList.get(i).get("bieming"));
			String aliasValue = request.getParameter(aliasName.toLowerCase());
			StringBuffer insertSql = new StringBuffer();
			basic.put(aliasName, aliasValue);
			insertSql.append("insert into basicinfo(name, value, yw_guid ) values ('").append(aliasName).append("','");
			insertSql.append(aliasValue).append("','").append(yw_guid).append("')");
			update(insertSql.toString(), YW);
		}
		
		//计算公式数据
		//获取所需计算字段
		String formulaSql = "select * form propertconfig t where t.status='1' and t.fangshi='2'";
		List<Map<String, Object>> formulaList = query(formulaSql, YW);
	}
	
	/**
	 * 
	 * <br>Description:计算公式数据
	 * <br>Author:黎春行
	 * <br>Date:2013-8-16
	 * @param yw_guid
	 * @return
	 */
	private String calculateData(String yw_guid, String fieldName){
		//获取公式
		String valueSql = "select * form propertconfig t where t.status='1' and t.bieming ='" + fieldName + "'";
		List<Map<String, Object>> resultList = query(valueSql, YW);
		String formulaName = String.valueOf(resultList.get(0).get("gongshi"));
		String formulaValue = String.valueOf(formula.get(formulaName));
		//获取所有表格中字段
		for(int i = 0; i < formField.size(); i++){
			String formFieldName = String.valueOf(formField.get(i).get("bieming"));
			//if(formulaValue)
			
			
		}
		

		
		
		
		
		
		return null;
	}
	

}
