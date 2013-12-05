package com.klspta.web.cbd.yzt.table;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class TableFields extends AbstractBaseBean implements ITableFields {

	private String template  = YW;
	
	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	@Override
	public boolean addField(String formName, String fieldName, String type,
			String defaultValue) {
		StringBuffer alterSql = new StringBuffer();
		alterSql.append("alter table ").append(formName).append(" add ( ");
		alterSql.append(fieldName).append(" ").append(type);
		if(defaultValue != null){
			alterSql.append(" default ").append(defaultValue);
		}
		int i = update(alterSql.toString(), template);
		return Boolean.parseBoolean(String.valueOf(i));
	}

	@Override
	public boolean addField(String formName, String fieldName, String type) {
		return addField(formName, fieldName, type, null);
	}

	@Override
	public boolean dropField(String formName, String field) {
		return dropFields(formName, new String[]{field});
	}

	@Override
	public boolean dropFields(String formName, String[] fields) {
		StringBuffer alterSql = new StringBuffer();
		alterSql.append("alter table ").append(formName).append(" drop (");
		for(int i = 0; i < fields.length - 1; i++){
			alterSql.append(fields).append(",");
		}
		alterSql.append(fields[fields.length - 1]).append(") CASCADE CONSTRAINTS");
		int i = update(alterSql.toString(), template);
		return Boolean.parseBoolean(String.valueOf(i));
	}

	@Override
	public boolean setFieldUnused(String formName, String field) {
		return setFieldsUnused(formName, new String[]{field});
	}

	@Override
	public boolean setFieldsUnused(String formName, String[] fields) {
		StringBuffer alterSql = new StringBuffer();
		alterSql.append("alter table ").append(formName).append(" set unused (");
		for(int i = 0; i < fields.length - 1; i++){
			alterSql.append(fields).append(",");
		}
		alterSql.append(fields[fields.length - 1]).append(") CASCADE CONSTRAINTS");
		int i = update(alterSql.toString(), template);
		return Boolean.parseBoolean(String.valueOf(i));
	}

	@Override
	public List<Map<String, Object>> getFormInf(String formName) {
		StringBuffer formSql = new StringBuffer();
		formSql.append("select t.TABLE_NAME as tablename, t.COLUMN_NAME as field, t.DATA_TYPE as datatype, j.comments as annotation, k.showname as showname,k.isdelete as isdelete, k.isshow as isshow  from dba_tab_columns t, user_col_comments j, jc_canshu_extent k where t.TABLE_NAME = j.table_name and t.COLUMN_NAME = j.column_name and t.TABLE_NAME= k.tablename and t.COLUMN_NAME = k.columnname and ");
		formSql.append("t.TABLE_NAME=").append(formName);
		List<Map<String, Object>> tableList = query(formSql.toString(), template);
		return tableList;
	}

}
