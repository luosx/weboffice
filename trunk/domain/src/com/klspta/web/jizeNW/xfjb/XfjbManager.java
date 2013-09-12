package com.klspta.web.jizeNW.xfjb;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class XfjbManager extends AbstractBaseBean{
	
	/**
	 * 
	 * <br>Description:生成线索号
	 * <br>Author:姚建林
	 * <br>Date:2013-9-10
	 * @return
	 */
	public String buildXSH(){
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", new DateFormatSymbols());
		String dateString = df.format(Calendar.getInstance().getTime());
				
		String numsql = "select max(t.xsh) num from wgwfxsdjb t where t.xsh like '" + dateString + "%'";
		String num;
		List<Map<String, Object>> result = query(numsql, YW);
		String nestNum = String.valueOf(result.get(0).get("num"));
		if(nestNum.equals("null") || nestNum.equals("")){
			num = dateString + "001";
		}else{
			String temp = nestNum.substring(nestNum.length() - 3, nestNum.length());
            temp=String.valueOf(Integer.parseInt(temp)+1);   
            temp = "00" + temp;
            num = dateString + temp.substring(temp.length() - 3);
		}
		return num;
	}
	
	/**
	 * 
	 * <br>Description:判断此yw_guid是否在数据库中存在
	 * <br>Author:姚建林
	 * <br>Date:2013-9-10
	 * @param strKey时需要判断的yw_guid
	 * @return
	 */
	public String checkGuid(String strKey){
		String newForm = "true";
		String sql = "select t.yw_guid from wgwfxsdjb t where t.yw_guid = ?";
		List<Map<String, Object>> resultList = query(sql, YW ,new Object[]{strKey});
		if(resultList.size() == 1){
			newForm = "false";
		}
		return newForm;
	}
	
	/**
	 * 
	 * <br>Description:获取所有未反馈的信访
	 * <br>Author:姚建林
	 * <br>Date:2013-9-10
	 */
	public void getAllDCLList(){
		List<Map<String, Object>> resultList = getList("0", "");
		response(resultList);
	}
	
	/**
	 * 
	 * <br>Description:根据关键字获取未反馈的信访
	 * <br>Author:姚建林
	 * <br>Date:2013-9-10
	 */
	public void getDCLListByKeyWords() throws Exception{
		String keywords = request.getParameter("keyword");
		keywords = UtilFactory.getStrUtil().unescape(keywords);
		List<Map<String, Object>> resultList = getList("0", keywords);
		response(resultList);
	}
	
	/**
	 * 
	 * <br>Description:获取所有已处理信访案件
	 * <br>Author:黎春行
	 * <br>Date:2013-9-2
	 */
	public void getAllYCLList(){
		List<Map<String, Object>> resultList = getList("1", "");
		response(resultList);
	}
	
	/**
	 * 
	 * <br>Description:根据关键字获取已处理信访案件
	 * <br>Author:黎春行
	 * <br>Date:2013-9-2
	 */
	public void getYCLListByKeyWords(){
		String keywords = request.getParameter("keyword");
		keywords = UtilFactory.getStrUtil().unescape(keywords);
		List<Map<String, Object>> resultList = getList("1", keywords);
		response(resultList);
	}
	
	private List<Map<String, Object>> getList(String status, String keywords){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.YW_GUID,t.XSH,t.XSLX, t.BLFS, t.JBR, t.BJBDW, t.DJSJ  from WGWFXSDJB t where t.STATUS ='").append(status).append("'");
		//添加关键字查询
		if((!"".equals(keywords)) || keywords != null){
			sqlBuffer.append(" and (t.XSH||t.XSLX||t.BLFS||t.JBR||t.BJBDW like '%");
			sqlBuffer.append(keywords);
			sqlBuffer.append("%')");
		}
		sqlBuffer.append(" order by t.BUILDYEAR DESC"); 
		List<Map<String, Object>> returnList = query(sqlBuffer.toString(), YW);
		return returnList;
	}
}
