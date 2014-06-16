package com.klspta.web.cbd.zxzjgl;

import java.util.Map;

public class XmzjglTreeBean {
	private String treeID = "";
	private String ywGuid = "";
	private String parentID = "";
	private String common = "";
	private String treeName = "";
	private String sort = "";
	private String rq = "";
	private String leval = "";
	
	public XmzjglTreeBean(Map<String, Object> map) {
		setTreeID(getValue(map, "tree_id"));
		setYwGuid(getValue(map, "yw_guid"));
		setParentID(getValue(map, "parent_id"));
		setCommon(getValue(map, "common"));
		setTreeName(getValue(map, "tree_name"));
		setSort(getValue(map, "sort"));
		setRq(getValue(map, "rq"));
		setLeval(getValue(map, "leval"));
	}
	
	private String getValue(Map<String, Object> map, String name){
		String value = String.valueOf(map.get(name));
		value = ("null".equals(value)) ? "" : value;
		return value;
	}
	
	public String getTreeID() {
		return treeID;
	}
	public void setTreeID(String treeID) {
	    this.treeID = treeID;
	}
	public String getYwGuid() {
		return ywGuid;
	}
	public void setYwGuid(String ywGuid) {
	    this.ywGuid = ywGuid;
	}
	public String getParentID() {
		return parentID;
	}
	public void setParentID(String parentID) {
		this.parentID = parentID;
	}
	public String getCommon() {
		return common;
	}
	public void setCommon(String common) {
		this.common = common;
	}
	public String getTreeName() {
		return treeName;
	}
	public void setTreeName(String treeName) {
	    this.treeName = treeName;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getRq() {
		return rq;
	}
	public void setRq(String rq) {
		this.rq = rq;
	}
	
	public String getLeval(){
		return leval;
	}
	
	public void setLeval(String leval){
		this.leval = leval;
	}
}
