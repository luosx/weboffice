package com.klspta.model.CBDReport.bean;

public class TDBean {
	private String colspan = "1";
	private String rowspan = "1";
	private String data = "";
	private String dataType = "";
	private String text = "";
	private String thirdKey = "";
	private String YWGuid = "";
	private String width = "10";
	private String height = "10";
	
    public TDBean(ThirdBean tb) {
        this.colspan = tb.getColsPan();
        this.rowspan = tb.getRowsPan();
        this.data = tb.getData();
        this.dataType = tb.getDataType();
        this.thirdKey = tb.getThirdKey();
        this.YWGuid = tb.getYWGuid();
        this.text = tb.getData();
        this.width = tb.getWidth();
        this.height = tb.getHeight();
        width = width.equals("") ? "10": width;
        height = height.equals("") ? "10": height;
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
        return width;
    }

    public String getHeight() {
        return height;
    }
}
