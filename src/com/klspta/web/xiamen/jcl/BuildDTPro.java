package com.klspta.web.xiamen.jcl;

/**
 * 
 * <br>Title:图层定位
 * <br>Description:根据图层名称和关键字实现图层定位
 * <br>Author:黎春行
 * <br>Date:2013-11-20
 */
public class BuildDTPro {
	public static final int CKLX_WP = 1;
	//public static final String MODEL_WP = "initFunction=[{\"name\":\"findFeature\",\"parameters\":\"jctb,0,yw_guid,OBJECTID\"},{\"name\":\"drawPoint\",\"parameters\":\"jctb,0,yw_guid,OBJECTID\"}]";
	public static final String MODEL_WP = "initFunction=[{\"name\":\"findFeature\",\"parameters\":\"jctb,0,yw_guid,OBJECTID\"}]";
	public static String getPar(String yw_guid, int type){
		String pro = "";
		switch (type) {
		case CKLX_WP:
			pro = MODEL_WP.replace("yw_guid", yw_guid);
			break;
		default:
			break;
		}
		return pro;
	}
	
	
	
}
