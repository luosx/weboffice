package com.klspta.web.cbd.yzt.jbb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.ReportExcel;

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
	 
	public void getExcel(){
		HttpServletRequest request = this.request;
		HttpServletResponse response = this.response;
		ReportExcel jbbReport = new JbbReport();
		jbbReport.getExcel(request, response);
	}

}
