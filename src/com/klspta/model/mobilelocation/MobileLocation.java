package com.klspta.model.mobilelocation;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:号码归属地
 * <br>Description:确定电话号码的归属地（精确到市级）
 * <br>Author:黎春行
 * <br>Date:2012-6-27
 */
public class MobileLocation extends AbstractBaseBean{
	
    
    /**
     * 
     * <br>Description:根据号码获取号码所在地(目前仅支持手机，待添加固话)
     * <br>Author:黎春行
     * <br>Date:2012-6-27
     */
    public void getMobileLocation(){
    	String number = request.getParameter("number");
    	String msg = "";
    	//判断电话号码的类型
    	if(judgeType(number)){
    		// 当为固定电话时，获取电话区号
    		String location = number.split("-")[0];
    		
    		
    	}else{
	    	//提取手机号码（去除前缀）
	    	number = number.substring(number.length() - 11 );
	    	StringBuffer URL = new StringBuffer();
	        URL.append("http://www.yodao.com/smartresult-xml/search.s?jsFlag=true&type=mobile&q=");
	        URL.append(number);
	        HttpClient httpClient = new HttpClient();
	        GetMethod getMethod = new GetMethod(URL.toString());
	        getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());
	        int statusCode;
			try {
				statusCode = httpClient.executeMethod(getMethod);
				// 获取失败时
		        if(statusCode != HttpStatus.SC_OK){
		        	msg =UtilFactory.getJSONUtil().format("Method failed" + getMethod.getStatusLine());
		        }else{
			        byte[] responseBody = getMethod.getResponseBody();
			        // 获取所在号码地
			        String responseValue = new String(responseBody);
			        //String[] response = responseValue.split("{");
			        responseValue = responseValue.split("'location':'")[1];
			        responseValue = responseValue.split("'}")[0];
			        String[] args = responseValue.split(" ");
			        //获取所在地的json串
			        msg = UtilFactory.getXzqhUtil().generateOptionByList(UtilFactory.getXzqhUtil().getListByName(args));
		        }
		    } catch (HttpException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
    	}
		clearParameter();
		putParameter(msg);
	  	response();
    }
    /**
     * 
     * <br>Description:判断举报的号码是否是固定电话
     * <br>Author:黎春行
     * <br>Date:2012-7-3
     * @param number
     * @return
     */
    private boolean judgeType(String number){
    	//固定电话类型正则表达式
    	String phone = "\\d[3,4]-\\d[7,8]";
    	Pattern pattern = Pattern.compile(phone);
    	Matcher matcher = pattern.matcher(number);
    	return matcher.matches();
    }
    
    

}
