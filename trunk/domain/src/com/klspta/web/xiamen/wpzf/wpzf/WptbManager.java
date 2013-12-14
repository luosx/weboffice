package com.klspta.web.xiamen.wpzf.wpzf;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.sun.jndi.url.corbaname.corbanameURLContextFactory;

public class WptbManager extends AbstractBaseBean {
	public static final String[][] showList_BG = new String[][]{{"YW_GUID", "0.1","hiddlen"},{"JCBH", "0.1","监测编号"},{"XMC", "0.1","项目名称"},{"TBLX", "0.1","图斑类型"},{"XZQMC", "0.1","行政区名称"},{"WPND","0.1","卫片年度"},{"JCMJ","0.1","监测面积"},{"SPMJ","0.1","审批面积"},{"GDMJ","0.1","供地面积"},{"HCMJ","0.1","巡查核查面积"}};
	public static final String[][] showList_WCL = new String[][]{{"OBJECTID", "0.1","卫片编号"},{"XMC", "0.1","项目名称"},{"JCBH", "0.1","监测编号"},{"TBLX", "0.1","图斑类型"},{"JCMJ", "0.1","监测面积"}};
	
	public void getWFlist(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		WptbData wptbData = new WptbData();
		List<Map<String, Object>> wptbList = wptbData.getWFlist(userId, keyword);
		response(wptbList);	
	}
	
	
	public void getHFlist(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		WptbData wptbData = new WptbData();
		List<Map<String, Object>> wptbList = wptbData.getHFlist(userId, keyword);
		response(wptbList);
		
	}
	
	
	public void getWCLlist(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		WptbData wptbData = new WptbData();
		List<Map<String, Object>> wptbList = wptbData.getWCLlist(userId, keyword);
		response(wptbList);
	}
	
	public void getWPList(){
		String keyword =  request.getParameter("keyword");
		String where = null;
		if(keyword != null){
            keyword = UtilFactory.getStrUtil().unescape(keyword);
			where = " where (upper(t.tbbh)||upper(t.xjxzqhmc) like '%" +keyword +"%')";
		}
		WptbData wptbData = new WptbData();
		List<Map<String, Object>> wptbList = wptbData.getWPList(where);
		response(wptbList);
	}
	
	public void getZXDList(){
		String objectId = request.getParameter("objectId");
		String where = null;
		if(objectId != null){
			where = "where t.objectid =" + objectId;
		}
		WptbData wptbData = new WptbData();
		List<Map<String, Object>> wptbList = wptbData.getWPList(where);
		response(wptbList);
	}
	
	public void getReport(){
        String xzq = UtilFactory.getStrUtil().unescape(request.getParameter("xzq"));
        String start = request.getParameter("start");
        String end = request.getParameter("end");  
        
        StringBuffer sb = new StringBuffer("<table id='title' border='0' cellpadding='0' cellspacing='0' width='800' height='60' style='text-align:center; vertical-align:middle;font-family: 宋体, Arial; font-size: 18px;'><tr><td>厦门市2012年度卫片执法检查土地违法案件查处整改情况统计表</td></tr></table>"
        +"<table id='report' border='1' cellpadding='0' cellspacing='0' width='800'  style='text-align:center; vertical-align:middle;font-family: 宋体, Arial; font-size: 16px;border-collapse:collapse;border:1px #000 solid;' >");        
        sb.append("<tr></tr>");        
	    
	}
	
}
