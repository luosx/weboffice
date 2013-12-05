package com.klspta.web.cbd.yzt.table;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:
 * <br>Description:
 * <br>Author:黎春行
 * <br>Date:2013-12-4
 */
public class TableFieldManager extends AbstractBaseBean {
	/**
	 * 表字段管理类显示内容
	 */
	public static String[][] TABLE_INF = new String[][]{{"TABLENAME", "0.1","表名"},{"FIELD", "0.1","字段名"},{"DATATYPE", "0.1","数据类型"},{"ISSHOW", "0.1","是否展现"},{"SHOWNAME", "0.1","别名"},{"ANNOTATION", "0.1","注释"}}; 
	private TableFields tableFields = new TableFields();
	
	/**
	 * 
	 * <br>Description:根据前台传递的tablename,获取可编辑的字段
	 * <br>Author:黎春行
	 * <br>Date:2013-12-5
	 */
	public void getTableInf(){
		String userid = request.getParameter("userid");
		String tablename = request.getParameter("tablename");
		List<Map<String, Object>> returnList = tableFields.getFormInf(tablename);
		response(returnList);
	}
	
}
