package com.klspta.web.cbd.yzt.jbb;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;

public class JbbManager extends AbstractBaseBean{
	
	public void getJbb() {
		HttpServletRequest request = this.request;
		response(new JbbData().getAllList(request));
	}
	
	public void getQuery(){
		HttpServletRequest request = this.request;
		response(new JbbData().getQuery(request));
	}

}
