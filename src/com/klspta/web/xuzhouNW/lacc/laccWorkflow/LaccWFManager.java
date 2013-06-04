package com.klspta.web.xuzhouNW.lacc.laccWorkflow;

import java.util.Calendar;
import java.util.List;

public class LaccWFManager extends WorkFlowManager {

	@Override
	public void buildWorkflow() throws Exception {
		super.buildWorkflow();
		
		//徐州立案查处用，给立案呈批表加上立案编号
		String labh = buildlabh();
		String sql = "update lacpb set bh='" + labh +"' where yw_guid='" + yw_guid + "'";
		update(sql, YW);
		
	}
	
	/**
	 * 
	 * <br>Description:生成立案编号，有空闲时改用正则表达式生成
	 * <br>Author:黎春行
	 * <br>Date:2013-4-3
	 * @return
	 */
	private String buildlabh(){
		String year = String.valueOf(Calendar.getInstance().getTime().getYear() + 1900);
		String sql = "select count(*) num from lacpb t where  t.buildyear > to_date('" + year + "-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')";
		int num = Integer.parseInt(String.valueOf(query(sql, YW).get(0).get("num"))) + 1;
		String labh = "执立徐国土资【" + year + "】" + String.valueOf(num) + "号";
		return labh;
	}
	
	
	public int getNum(String yw_guid, String tableName){
		String sql = "select count(*) num from " + tableName + " where yw_guid like '" + yw_guid + "'";
		return Integer.parseInt(String.valueOf(query(sql, YW).get(0).get("num")));
	}
	
}
