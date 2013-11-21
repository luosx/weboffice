package com.klspta.web.xiamen.wpzf.tdbgdc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:土地变更调查管理类
 * <br>Description:土地调查管理类
 * <br>Author:黎春行
 * <br>Date:2013-11-19
 */
public class TdbgdcManager extends AbstractBaseBean {
	public static final String[][] showList_WHC = new String[][]{{"YW_GUID", "0.1","hiddlen"},{"JCBH", "0.1","监测编号"},{"JCMJ", "0.1","监测面积"},{"XZQMC", "0.1","行政区名称"},{"WPND","0.1","卫片年度"},{"SPMJ","0.1","审批面积"},{"GDMJ","0.1","供地面积"},{"HCMJ","0.1","巡查核查面积"},{"YGQK","0.1","压盖情况"},{"XF","0.1","下发"}};

	public void getyshf(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		ItdbgdcData tdbgdc = new TdbgdcData();
		List<Map<String, Object>> queryList = tdbgdc.getDhcHF(userId, keyword);
		response(queryList);
	}
	
	public void getyswf(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		ItdbgdcData tdbgdc = new TdbgdcData();
		List<Map<String, Object>> queryList = tdbgdc.getDhcWF(userId, keyword);
		response(queryList);
	}
	
	public void gethf(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		ItdbgdcData tdbgdc = new TdbgdcData();
		List<Map<String, Object>> queryList = tdbgdc.getYhcHf(userId, keyword);
		response(queryList);
		
	}
	
	public void getwf(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		ItdbgdcData tdbgdc = new TdbgdcData();
		List<Map<String, Object>> queryList = tdbgdc.getYhcWF(userId, keyword);
		response(queryList);
		
	}
	
	public void changefxqk(){
		String yw_guid = request.getParameter("yw_guid");
		String value = request.getParameter("value");
		ItdbgdcData tdbgdc = new TdbgdcData();
		String result = tdbgdc.changeFxqk(yw_guid, value);
		response(result);
	}
	
}
