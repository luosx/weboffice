package com.klspta.web.cbd.yzt.jbb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.zrb.ZrbData;

public class JbbManager extends AbstractBaseBean{
	
	public void getJbb() {
		HttpServletRequest request = this.request;
		response(new JbbData().getAllList(request));
	}
	
	public void getQuery(){
		HttpServletRequest request = this.request;
		response(new JbbData().getQuery(request));
	}
	
	 public void updateJbb() {
	        HttpServletRequest request = this.request;
	        if (new JbbData().updateJbb(request)) {
	            response("{success:true}");
	        } else {
	            response("{success:false}");
	        }
	}
	 
	 
	    /**
	     * 
	     * <br>Description:基本斑上图
	     * <br>Author:黎春行
	     * <br>Date:2013-12-10
	     * @throws Exception 
	     */
	    public void drawZrb() throws Exception{
	    	String tbbh = request.getParameter("tbbh");
	    	String polygon = request.getParameter("polygon");
	    	if (tbbh != null) {
	    		tbbh = UtilFactory.getStrUtil().unescape(tbbh);
	    	}else{
	    		response("{error:not primary}");
	    	}
	    	boolean draw = new JbbData().recordGIS(tbbh, polygon);
	    	response(String.valueOf(draw)); 
	    }
	 
	/*public void getExcel(){
		HttpServletRequest request = this.request;
		HttpServletResponse response = this.response;
		JbbReport jbbReport = new JbbReport();
		jbbReport.getExcel(request, response);
	}*/

}
