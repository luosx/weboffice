package com.klspta.model.signlog;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class SignlogOperation extends AbstractBaseBean{

	/**
	 * 
	 * <br>Description:设定线索处理日志
	 * <br>Author:黎春行
	 * <br>Date:2012-6-19
	 */
	public void setLog(){
		WfxsdjbllogBean signBean = new WfxsdjbllogBean();
		try {
			String blms = new String(request.getParameter("blms").getBytes("iso-8859-1"),"UTF-8");
			String blr= new String(request.getParameter("blr").getBytes("iso-8859-1"),"UTF-8");
			String bljb = new String(request.getParameter("bljb").getBytes("iso-8859-1"), "UTF-8");
			signBean.setBljb(bljb);
			signBean.setBlms(blms);
			signBean.setBlr(blr);
			signBean.setYw_guid(request.getParameter("yw_guid"));
			WlogUtil.getInstance().addLog(signBean);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * <br>Description:获取线索处理日志
	 * <br>Author:黎春行
	 * <br>Date:2012-6-19
	 */
	public void getLog(){
		String yw_guid = request.getParameter("yw_guid");
		List<WfxsdjbllogBean> worklogList = WlogUtil.getInstance().getWfxsdjbllogBean(yw_guid);
		String msg;
		try {
			msg = UtilFactory.getJSONUtil().objectToJSON(worklogList);
			clearParameter();
	    	putParameter(msg);
	    	response();
		} catch (Exception e) {
			e.printStackTrace();
			msg = UtilFactory.getJSONUtil().format("error");
			clearParameter();
	    	putParameter(msg);
	    	response();
		}
	}
	
	
	
	
	
}
