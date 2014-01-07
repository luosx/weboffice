package com.klspta.web.cbd.xmgl.xmbg;


import org.apache.poi.hslf.usermodel.SlideShow;

import com.klspta.base.AbstractBaseBean;

public class XmbgManager extends AbstractBaseBean {
	
	public void getPPT() throws Exception{
		//String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"),"utf-8");
		//String file_ids = new String(request.getParameter("file_id").getBytes("iso-8859-1"),"utf-8"); 
		ReportPPT reportPPT = new ReportPPT();
		SlideShow ppt = reportPPT.getPPT();
		response.setContentType("application/x-msdownload");
		response.setHeader( "Content-Disposition", "attachment; filename=reportPPT.ppt");
		ppt.write(response.getOutputStream());
		response.getOutputStream().close();
	}

}
