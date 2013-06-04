package com.klspta.web.xuzhouNW.dtxc;

import java.io.UnsupportedEncodingException;
import java.rmi.server.UID;

import com.klspta.base.AbstractBaseBean;

public class Dtxc extends AbstractBaseBean{

	public void buildXcrq(){
		String yw_guid = buildyw_guid();
		String sql = "insert into xcrz(yw_guid) values ('"+ yw_guid +"')";
		update(sql, YW);
		String basePath = request.getScheme() + "://" + request.getServerName()
			+ ":" + request.getServerPort() + request.getContextPath() + "/";
		StringBuffer url = new StringBuffer();
		url.append(basePath);
		url.append("/web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=");
		url.append(yw_guid);
		redirect(url.toString()); 
	}
	
	private String buildyw_guid(){
		return new UID().toString().replaceAll(":", "-");
	}
	
	public void getXcrzListByUserId(){
		String userId = request.getParameter("userId");
		response(XcrzManager.getInstance().getXcrzListByUserId(userId));
	}
	
	public void getXcrzListByXzqh() throws UnsupportedEncodingException{
		String xzqh = request.getParameter("xzqh");
		String keyWord = new String(request.getParameter("keyword").getBytes("iso-8859-1"), "utf-8");
		response(XcrzManager.getInstance().getXcrzListByXzqhAndKeyWord(xzqh, keyWord));
	}
}
