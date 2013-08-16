package com.klspta.web.cbd.cbsycs.jbxxlr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title: 基本信息录入管理类
 * <br>Description: 
 * <br>Author: 姚建林
 * <br>Date: 2013-8-15
 */
public class EnterManager extends AbstractBaseBean {

	/**
	 * 
	 * <br>Description:TODO 获得需要的字段
	 * <br>Author:姚建林
	 * <br>Date:2013-8-15
	 */
	public List<List<Map<String, Object>>> getNeedFields(){
		//取得类型种类sql
		String sqlString = "select distinct(t.shuxing) from propertyconfig t";
		String sqlQuery = "select t.*, t.rowid from propertyconfig t where t.shuxing = ? order by sort";
		List<Map<String, Object>> result;
		List<Map<String, Object>> resultString = query(sqlString, YW);
		//用于封装返回结果
		List<List<Map<String, Object>>> resultList = new ArrayList<List<Map<String,Object>>>();
		//封装
		for (int i = 0; i < resultString.size(); i++) {
			result = query(sqlQuery, YW, new Object[]{resultString.get(i).get("shuxing")});
			resultList.add(result);
		}
		return resultList;
	}
	
	public static void main(String[] args) {
		EnterManager em = new EnterManager();
		em.getSavedFields("zhandi");
	}
	
	/**
	 * 
	 * <br>Description:TODO 保存填写的基本信息
	 * <br>Author:姚建林
	 * <br>Date:2013-8-15
	 */
	public void saveData(){
		String tString = request.getParameter("zhandi");
		System.out.println(tString);
	}
	
	/**
	 * 
	 * <br>Description:TODO 获得保存的字段
	 * <br>Author:姚建林
	 * <br>Date:2013-8-15
	 */
	public List<List<Map<String, Object>>> getSavedFields(String yw_guid){
		//取得类型种类sql
		String sqlString = "select distinct(t.shuxing) from propertyconfig t";
		//根据属性参数取得同类的一组数据
		String sqlQuery = "select t.*, t.rowid from propertyconfig t where t.shuxing = ? order by sort";
		//根据yw_guid获得要展现的数据
		String sqlDataQuery = "select t.*, t.rowid from basicinfo t where yw_guid = ?";
		
		//用于封装数据的中间变量
		List<Map<String, Object>> result;
		//种类
		List<Map<String, Object>> resultString = query(sqlString, YW);
		//要展现的数据
		List<Map<String, Object>> resultDataQuery = query(sqlDataQuery, YW ,new Object[]{yw_guid});
		//用于封装返回结果
		List<List<Map<String, Object>>> resultList = new ArrayList<List<Map<String,Object>>>();
		//封装
		for (int i = 0; i < resultString.size(); i++) {
			result = query(sqlQuery, YW, new Object[]{resultString.get(i).get("shuxing")});
			for (int j = 0; j < result.size(); j++) {//向result中添加一个map用于存放value
				for (int k = 0; k < resultDataQuery.size(); k++) {
					if (result.get(j).get("bieming").toString().equals(resultDataQuery.get(k).get("name").toString())) {
						result.get(j).put("value", resultDataQuery.get(k).get("value").toString());
					}
				}
			}
			resultList.add(result);
		}
		return resultList;
	}
}
