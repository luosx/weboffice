package com.klspta.model.CBDReport.bean;

public class TDBean {
	private String colspan = "1";
	private String rowspan = "1";
	private String data = "";
	private String dataType = "";
	private String text = "";
	private String thirdKey = "";
	private String YWGuid = "";
	private String Width = "";
	private String height = "";
	
    public TDBean(ThirdBean tb) {
        this.colspan = tb.getColsPan();
        this.rowspan = tb.getRowsPan();
        this.data = tb.getData();
        this.dataType = tb.getDataType();
        this.thirdKey = tb.getThirdKey();
        this.YWGuid = tb.getYWGuid();
        this.text = tb.getData();
	}
	
	public TDBean(String text){
	    this.text = text;
	}

    public String getColspan() {
        return colspan;
    }

    public String getRowspan() {
        return rowspan;
    }

    public String getData() {
        return data;
    }

    public String getDataType() {
        return dataType;
    }

    public String getText() {
        return text;
    }

    public String getThirdKey() {
        return thirdKey;
    }

    public String getYWGuid() {
        return YWGuid;
    }
    
    public String getWidth() {
        return Width;
    }

    public String getHeight() {
        return height;
    }
}
