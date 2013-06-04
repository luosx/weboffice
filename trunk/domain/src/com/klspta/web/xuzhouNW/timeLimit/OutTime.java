package com.klspta.web.xuzhouNW.timeLimit;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import com.klspta.base.AbstractBaseBean;

public class OutTime extends AbstractBaseBean {
	public void getTimeOverByUserId(){
		String userId = request.getParameter("userId");
		try {
			response(new OuttimeBean().getByUserId(userId));
		} catch (Exception e) {
			response("error");
		}
	}
	
	
	public void getAll(){
		try {
			response(new OuttimeBean().getAll());
		} catch (Exception e) {
			e.printStackTrace();
			response("error");
		}	
	}
	
	public void getQuery() throws Exception{
		String keyWord = new String(request.getParameter("keyWord").getBytes("iso-8859-1"),"UTF-8");
		String compare = request.getParameter("compare");
		response(new OuttimeBean().getQuery(keyWord, compare));
	}
	
	/**
	 * <br>Description:根据用户ID获取超时案件
	 * <br>Author:姚建林
	 * <br>Date:2013-4-3
	 * @param userId
	 * @return
	 * @throws Exception 
	 */
	public void getCaseByUserId(){
		String userId = request.getParameter("userId");
		try {
			response(new OuttimeBean().getCaseByUserId(userId));
		} catch (Exception e) {
			e.printStackTrace();
			response("error");
		}	
	}
}
