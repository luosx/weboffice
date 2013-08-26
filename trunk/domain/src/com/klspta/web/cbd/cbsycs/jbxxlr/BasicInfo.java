package com.klspta.web.cbd.cbsycs.jbxxlr;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:成本及收益测算基本信息
 * <br>Description:对成本及收益测算基本信息数据管理
 * <br>Author:黎春行
 * <br>Date:2013-8-15
 */
public class BasicInfo extends AbstractBaseBean {
	//将所有的公式缓存
	private static Map<String, Object>  formula = new HashMap<String, Object>();
	private static Map<String, Object> basic = new HashMap<String, Object>();
	private static List<Map<String,Object>> formField = new ArrayList<Map<String, Object>>();
	
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
			formula.put(String.valueOf(formulaList.get(i).get("fulaname")), String.valueOf(formulaList.get(i).get("fulavalue")));
		}
		formulaSql = "select * from  propertyconfig t";
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
		String basePath = request.getScheme() + "://" + request.getServerName()
							+ ":" + request.getServerPort() + request.getContextPath()
							+ "/";
		String url = basePath + "web/cbd/cbsycs/jbxxlr/jbxxlrSaved.jsp?";
		if(yw_guid == null || yw_guid == ""){
			yw_guid = UtilFactory.getStrUtil().getGuid();
		}
		url = url + "yw_guid=" + yw_guid; 
		//删除表中旧数据
		String deleSql = "delete from basicinfo t where t.yw_guid=?";
		update(deleSql, YW, new Object[]{yw_guid});
		
		String fieldSql = "select * from  propertyconfig t where t.fangshi='录入'";
		List<Map<String, Object>> fieldList = query(fieldSql, YW);
		
		//将基础数据保存到数据库中
		for(int i = 0; i < fieldList.size(); i++){
			String aliasName = String.valueOf(fieldList.get(i).get("bieming"));
			String aliasValue = request.getParameter(aliasName);
			StringBuffer insertSql = new StringBuffer();
			basic.put(aliasName, aliasValue);
			insertSql.append("insert into basicinfo(name, value, yw_guid ) values ('").append(aliasName).append("','");
			insertSql.append(aliasValue).append("','").append(yw_guid).append("')");
			update(insertSql.toString(), YW);
		}
		
		//计算公式数据
		//获取所需计算字段
		String formulaSql = "select * from propertyconfig t where t.fangshi='公式'";
		String insertCaculate = "insert into basicinfo(name, value, yw_guid) values (?, ?, ?)";
		List<Map<String, Object>> formulaList = query(formulaSql, YW);
		for(int i = 0; i < formulaList.size(); i++){
			String fieldName = String.valueOf(formulaList.get(i).get("bieming"));
			String calculate = calculateData(yw_guid, fieldName); 
			update(insertCaculate, YW, new Object[]{fieldName, calculate, yw_guid});
		}
		try {
			response.sendRedirect(url + "&msg=success");
		} catch (IOException e) {
			response("error:保存失败");
		}
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
		String valueSql = "select * from propertyconfig t where  t.bieming ='" + fieldName + "'";
		List<Map<String, Object>> resultList = query(valueSql, YW);
		String formulaName = String.valueOf(resultList.get(0).get("gongshi"));
		String formulaValue = String.valueOf(formula.get(formulaName));
		String countValue = "";
		//获取所有表格中字段
		for(int i = 0; i < formField.size(); i++){
			String formFieldName = String.valueOf(formField.get(i).get("bieming"));
			if(formulaValue.contains(formFieldName)){
				String value = "";
				value = String.valueOf(basic.get(formFieldName));
				if(value == "" || value == null){
					countValue =  calculateData(yw_guid, formFieldName);
				}
				value = countValue;
				basic.put(formFieldName, value);
				formulaValue = formulaValue.replaceAll(formFieldName, value);
			}
		}
		ScriptEngine jse = new ScriptEngineManager().getEngineByName("JavaScript");
		String caculateValue = "";
		try {
			 caculateValue = String.valueOf(jse.eval(formulaValue));
		} catch (ScriptException e) {
			e.printStackTrace();
			error(this, "计算失败");
		}
		return caculateValue;
		
	}
	
	public static void main(String[] args) {
		ScriptEngine jse = new ScriptEngineManager().getEngineByName("JavaScript");
		String caculateValue = "";
		try {
			 caculateValue = String.valueOf(jse.eval("1+2+3+4*5"));
		} catch (ScriptException e) {
			e.printStackTrace();
		}
		System.out.println(caculateValue + "-----------------------------");
	}
}
