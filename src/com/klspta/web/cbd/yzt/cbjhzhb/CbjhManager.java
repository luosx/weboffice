package com.klspta.web.cbd.yzt.cbjhzhb;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.klspta.base.AbstractBaseBean;


public class CbjhManager extends AbstractBaseBean {
	
    public void update() throws Exception{
    	String xmmc =new String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
    	String index = request.getParameter("vindex");
    	String value = new String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
    	String field = Cbjhzhb.fields[Integer.parseInt(index) - 1][0];
    	//boolean result = new CbjhData().update(xmmc, field, value);
    	CbjhData cbjhData = new CbjhData();
    	cbjhData.setChange(xmmc, field, value);
    	ExecutorService exec = Executors.newCachedThreadPool();
    	exec.execute(cbjhData);
    	exec.shutdown();
    }
	
}
