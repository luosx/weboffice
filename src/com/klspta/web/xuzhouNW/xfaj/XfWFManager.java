package com.klspta.web.xuzhouNW.xfaj;

import java.util.Calendar;

import com.klspta.web.xuzhouNW.lacc.laccWorkflow.WorkFlowManager;


public class XfWFManager extends WorkFlowManager {

	@Override
	public void buildWorkflow() throws Exception {
		// TODO Auto-generated method stub
		super.buildWorkflow();
		
		//信访添加线索号
		String xsh = buildXSH();
		String sql = "update wfxsfkxx set bh='" + xsh +"' where yw_guid='" + yw_guid + "'";
		update(sql, YW);
		
	}

	private String buildXSH(){
		String year = String.valueOf(Calendar.getInstance().getTime().getYear() + 1900);
		String sql = "select count(*) num from wfxsfkxx t where  t.buildyear > to_date('" + year + "-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')";
		int num = Integer.parseInt(String.valueOf(query(sql, YW).get(0).get("num"))) + 1;
		String labh = "执立徐国土资【" + year + "】" + String.valueOf(num) + "号";
		return labh;
	}
	
	public int getNum(String yw_guid, String tableName){
		String sql = "select count(*) num from " + tableName + " where yw_guid like '" + yw_guid + "'";
		return Integer.parseInt(String.valueOf(query(sql, YW).get(0).get("num")));
	}
	
}
