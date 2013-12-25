package com.klspta.web.cbd.yzt.hxxm;



import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.zrb.ZrbData;

public class HxxmManager extends AbstractBaseBean {
	
	public void getHxxm() {
		HttpServletRequest request = this.request;
		response(new HxxmData().getAllList(request));
	}
	
	public void getQuery(){
		HttpServletRequest request = this.request;
		response(new HxxmData().getQuery(request));
	}
	
	public void updateHxxm() {
        HttpServletRequest request = this.request;
        if (new HxxmData().updateHxxm(request)) {
            response("{success:true}");
        } else {
            response("{success:false}");
        }
    }
	
	/**
	 * 
	 * <br>Description:TODO 方法功能描述
	 * <br>Author:黎春行
	 * <br>Date:2013-12-24
	 * @throws Exception 
	 */
	public void update() throws Exception{
    	String xmmc =new String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
    	String index = request.getParameter("vindex");
    	String value = new String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
    	String field = HxxmReport.shows[Integer.parseInt(index)][0];
    	response(String.valueOf(new HxxmData().modifyValue(xmmc, field, value)));
	}
	/**
	 * 
	 * <br>Description:添加一个新的红线项目
	 * <br>Author:黎春行
	 * <br>Date:2013-12-24
	 * @throws Exception 
	 */
	public void insert() throws Exception{
		String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "UTF-8");
    	if (xmmc != null) {
    		xmmc = UtilFactory.getStrUtil().unescape(xmmc);
	        if (new HxxmData().insertHxxm(xmmc)) {
	            response("{success:true}");
	        } else {
	            response("{success:false}");
	        }
    	}else{
    		response("{success:false}");
    	}
	}
	
	/**
	 * 
	 * <br>Description:删除红线项目
	 * <br>Author:黎春行
	 * <br>Date:2013-12-25
	 * @throws Exception
	 */
    public void delete() throws Exception{
    	boolean result = false;
    	HxxmData hxxmData = new HxxmData();
    	String hxxms =new String(request.getParameter("xmmc").getBytes("iso-8859-1"),"utf-8");
    	String[] hxxmArray = hxxms.split(",");
    	for(int i = 0; i < hxxmArray.length; i++){
    		result = result && hxxmData.delete(hxxmArray[i]);
    	}
    	response(String.valueOf(result));
    }
	
	
	public void draw() throws Exception{
    	String guid = request.getParameter("guid");
    	String polygon = request.getParameter("polygon");
    	if (guid != null) {
    		guid = UtilFactory.getStrUtil().unescape(guid);
    	}else{
    		response("{error:not primary}");
    	}
    	boolean draw = new HxxmData().recordGIS(guid, polygon);
    	response(String.valueOf(draw)); 
	}
	
	

}
