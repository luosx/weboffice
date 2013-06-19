package com.klspta.web.xuzhouNW.dtxc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class DtxcManager extends AbstractBaseBean {
	
	/**
	 * 
	 * <br>Title: 生成巡查日志
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public void buildXcrq() {
		String yw_guid= UtilFactory.getStrUtil().getGuid();
		String sql = "insert into xcrz(yw_guid) values ('" + yw_guid + "')";
		update(sql, YW);
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + request.getContextPath()
				+ "/";
		StringBuffer url = new StringBuffer();
		url.append(basePath);
		url.append("/web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=");
		url.append(yw_guid);
		redirect(url.toString());
	}
	
	/**
	 * 
	 * <br>Title: 生成巡查编号
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public String buildXcbh(){
		StringBuffer xcbh = new StringBuffer();
		//添加编号头"XC"
		xcbh.append("XC");
		//添加日期
		
		//添加流水号
		String sql = "select count(yw_guid) cou from xcrz";
		List<Map<String, Object>> result = query(sql, YW);
		String strCou = result.get(0).get("cou").toString();//数据库中日志条数
		int intCou = Integer.parseInt(strCou) + 1;//新生成日志是数据库中日志条数+1
		String strtemp = intCou + "";
		int i = strtemp.length();
		int j = 6 - i;
		for (int n = 0; n < j; n++) {
			xcbh.append("0");
		}
		xcbh.append(strtemp);
		
		return xcbh.toString();
	}
	
	public static void main(String[] args) {
		DtxcManager dm = new DtxcManager();
		System.out.println(dm.buildXcbh());
	}
}
