package com.klspta.model.CBDReport.bean;

import java.util.Map;

public class ThirdBean {

	public static final String DATA_TYPE_STATIC = "STATIC";
	public static final String DATA_TYPE_DYNAMIC = "DYNAMIC";

	private String YWGuid = "";
	private String thirdKey = "";
	private String colsPan = "";
	private String rowsPan = "";
	private String dataType = "";
	private String data = "";

	public ThirdBean(Map<String, Object> map) {
		this.YWGuid = (String) map.get("YW_GUID");
		this.thirdKey = (String) map.get("SECOND_KEY");
		this.colsPan = (String) map.get("COLSPAN_COUNT");
		this.rowsPan = (String) map.get("ROWSPAN_COUNT");
		this.dataType = (String) map.get("DATA_TYPE");
		this.data = (String) map.get("DATA");
	}

	public String getYWGuid() {
		return YWGuid;
	}
	
	public String getThirdKey() {
		return thirdKey;
	}

	public String getColsPan() {
		return colsPan;
	}

	public String getRowsPan() {
		return rowsPan;
	}

	public String getDataType() {
		return dataType;
	}

	public String getData() {
		return data;
	}

}
