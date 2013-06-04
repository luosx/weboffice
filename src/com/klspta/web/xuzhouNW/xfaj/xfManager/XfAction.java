package com.klspta.web.xuzhouNW.xfaj.xfManager;

import com.klspta.base.AbstractBaseBean;

public class XfAction extends AbstractBaseBean {
	
	/**
	 * 
	 * <br>Description:根据登陆人员获取对应的待处理信访案件
	 * <br>Author:黎春行
	 * <br>Date:2013-5-21
	 * @throws Exception
	 */
	public void getDBListByUserId() throws Exception{
		String userId = request.getParameter("userId");
		String keyWord = request.getParameter("keyWord");
		response(new XfManager().getDCLListByUserId(userId, keyWord));
	}
	
	/**
	 * 
	 * <br>Description:获取登陆人员已处理的信访案件
	 * <br>Author:黎春行
	 * <br>Date:2013-5-21
	 * @throws Exception
	 */
	public void getYBListByUserId() throws Exception{
		String userId = request.getParameter("userId");
		String keyWord = request.getParameter("keyWord");
		response(new XfManager().getYCLListByUserId(userId, keyWord));
	}
	
	/**
	 * 
	 * <br>Description:获取所有案件，案件查询时使用
	 * <br>Author:黎春行
	 * <br>Date:2013-5-22
	 */
	public void getAllList(){
		String keyWord = request.getParameter("keyWord");
		response(new XfManager().getAllList(keyWord));
	}
	
	
	
	
}
