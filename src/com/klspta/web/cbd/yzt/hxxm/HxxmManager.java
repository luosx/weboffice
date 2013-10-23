package com.klspta.web.cbd.yzt.hxxm;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;

public class HxxmManager extends AbstractBaseBean {
	
	public void getHxxm() {
		HttpServletRequest request = this.request;
		response(new HxxmData().getAllList(request));
	}
	
	public void getQuery(){
		HttpServletRequest request = this.request;
		response(new HxxmData().getQuery(request));
	}

}
