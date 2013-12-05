package com.klspta.web.cbd.yzt.table;

import java.util.List;
import java.util.Map;

public class CBDtableFields extends TableFields {
	
	private static String extentName = "JC_CANSHU_EXTENT";

	/**
	 * 
	 * <br>Description:针对CBD项目实现数据表字段的管理
	 * <br>Author:黎春行
	 * <br>Date:2013-12-5
	 * @param formName
	 * @param fieldName
	 * @param type
	 * @param defaultValue
	 * @param showname
	 * @param isshow
	 * @return
	 */
	public boolean addField(String formName, String fieldName, String type, String showname, String isshow) {
		boolean jc = super.addField(formName, fieldName, type);
		boolean modify = modifyField(formName, fieldName, showname, isshow);
		return jc&&modify;
	}

	
	
	@Override
	public boolean dropField(String formName, String field) {
		boolean jc = super.dropField(formName, field);
		StringBuffer deleteSql = new StringBuffer();
		deleteSql.append("delete from ").append(extentName).append(" t ");
		deleteSql.append(" where t.tablename=? and t.columnname=?");
		int i = update(deleteSql.toString(), template, new Object[]{formName, field});
		return jc;
	}



	@Override
	public List<Map<String, Object>> getFormInf(String formName) {
		StringBuffer formSql = new StringBuffer();
		formSql.append("select t.TABLE_NAME as tablename, t.COLUMN_NAME as field, t.DATA_TYPE as datatype, j.comments as annotation, k.showname as showname,k.isdelete as isdelete, k.isshow as isshow  from dba_tab_columns t, user_col_comments j left join jc_canshu_extent k on j.table_name = k.tablename and j.column_name = k.columnname where t.TABLE_NAME = j.table_name and t.COLUMN_NAME = j.column_name and ");
		formSql.append("t.TABLE_NAME='upper(").append(formName).append(")'");
		List<Map<String, Object>> tableList = query(formSql.toString(), template);
		return tableList;
	}
	
	public boolean modifyField(String formName, String fieldName, String showname, String isshow){
		StringBuffer extendSql = new StringBuffer();
		extendSql.append("merge into ").append(extentName).append(" t using (select distinct '").append(formName).append("' as tablename, '");
		extendSql.append(fieldName).append("' as columnname from ").append(extentName).append(" ");
		extendSql.append(") s on (s.tablename = t.tablename and s.columnname = t.columnname) when ");
		extendSql.append("matched then update set t.showname = ?, t.isshow=? when not matched then insert(t.tablename, t.columnname, t.showname, t.isshow) values(?,?,?,?)");
		boolean result = true;
		try {
			update(extendSql.toString(), template, new Object[]{showname,isshow, formName, fieldName, showname, isshow});
		} catch (Exception e) {
			result = false;
			System.out.println("属性更新失败");
		}
		return result;
	}
}
