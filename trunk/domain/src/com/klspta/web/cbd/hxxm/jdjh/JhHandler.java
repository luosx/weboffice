package com.klspta.web.cbd.hxxm.jdjh;

/**
 * 
 * <br>Title:季度计划管理类
 * <br>Description:生成季度计划表数据
 * <br>Author:黎春行
 * <br>Date:2013-10-14
 */
public class JhHandler {
	public static final int JD_KFTL = 1;
	public static final int JD_KFTL_XX = 2;
	public static final int JD_AZFJC = 3;
	public static final int JD_AZFJC_XX = 4;
	public static final int JD_GDTL = 5;
	public static final int JD_GDTL_XX = 6;
	public static final int JD_TRZQK = 7;
	public static final int JD_CHANGE = 8;
	private static IBuildTable buildTable;
	
	public static String getTable(int type){	
		switch (type) {
		case JD_KFTL:
			buildTable = new KftlTable();
			break;
		case JD_KFTL_XX:
			buildTable = new KftlXXTable();
			break;
		case JD_AZFJC:
			buildTable = new AzfjsTable();
			break;
		case JD_AZFJC_XX:
			buildTable = new AzfjsXXTable();
			break;
		case JD_GDTL:
			buildTable = new GdtlTable();
			break;
		case JD_GDTL_XX:
			buildTable = new GdtlXXTable();
			break;
		case JD_TRZQK:
			buildTable = new TrzqkTable();
			break;
		case JD_CHANGE:
			buildTable = new KFTLBJ();
		default:
			break;
		}
		return buildTable.buildTable();
	}

}
