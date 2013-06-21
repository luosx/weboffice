package com.klspta.web.xuzhouNW.xfjb.manager;

import com.klspta.base.AbstractBaseBean;
/**
 * 
 * <br>Title:信访举报服务
 * <br>Description:提供信访举报各个状态实例
 * <br>Author:黎春行
 * <br>Date:2013-6-21
 */
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
	 * <br>Description:获取所有信访办理中案件，案件查询时使用
	 * <br>Author:王峰
	 * <br>Date:2013-6-20
	 */
	public void getXFblzList(){
		String keyWord = request.getParameter("keyWord");
		response(new XfManager().getXFblzList(keyWord));
	}
	
	/**
	 * 
	 * <br>Description:获取所有信访已办结案件，案件查询时使用
	 * <br>Author:王峰
	 * <br>Date:2013-6-20
	 */
	public void getXFEndList(){
		String keyWord = request.getParameter("keyWord");
		response(new XfManager().getXFEndList(keyWord));
	}
	
}
