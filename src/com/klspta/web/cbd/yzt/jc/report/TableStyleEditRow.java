package com.klspta.web.cbd.yzt.jc.report;

import com.klspta.model.CBDReport.tablestyle.TableStyleDefaultEdit;

/**
 * 
 * <br>Title:报表编辑类
 * <br>Description:增加行点击事件触发（单击：showMap(); 双击：editMap();）
 * <br>Author:黎春行
 * <br>Date:2013-12-17
 */
public class TableStyleEditRow extends TableStyleDefaultEdit {

	@Override
	public String getTR1() {
		return "<tr class='#TRCSS' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'>";
	}

	@Override
	public String getTR2() {
		return "</tr>";
	}

	
	

}
