package com.klspta.web.cbd.trzqk;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class Trzqk extends AbstractBaseBean{
	
	/**
	 * 
	 * <br>Description:计算本期投资需求
	 * <br>Author:黎春行
	 * <br>Date:2013-8-23
	 */
	private String bqtzxq(String year, String quarter){
		//获取对应季度的储备红线投资值
		String sql = "select t.储备红线投资 as chosevalue from v_开发体量 t where t.年度= ? and t.季度 = ?";
		List<Map<String, Object>> resultList = query(sql, YW, new Object[]{year, quarter});
		String cbhxtz = String.valueOf(resultList.get(0).get("chosevalue"));
		
		//获取对应季度的安置房建设投资值
		sql = "select t.投资 as chosevalue from v_安置房 t where t.年度= ? and t.季度 = ?";
		resultList = query(sql, YW, new Object[]{year, quarter});
		String azftz = String.valueOf(resultList.get(0).get("chosevalue"));
		
		//获取本期投资需求
		String bqtzxqValue = String.valueOf(Float.parseFloat(cbhxtz) - Float.parseFloat(azftz));
		return bqtzxqValue;
	}
	
	/**
	 * 
	 * <br>Description:获取本期投资需求
	 * <br>Author:黎春行
	 * <br>Date:2013-8-23
	 */
	public void getbqtzxq(){
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		response(bqtzxq(year, quarter));
	}
	
	/**
	 * 
	 * <br>Description:获取本期融资需求
	 * <br>Author:黎春行
	 * <br>Date:2013-8-23
	 */
	public void getbqrzxq() {
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		//本期还款需求
		String bqhkxq = request.getParameter("bqhkxq");
		//权益性资金注入
		String qyxzjzr = request.getParameter("qyxzjzr");
		//本期回笼成本
		String bqhlcb = request.getParameter("bqhlcb");
		
		String bqrzxqValue = bqrzxq(year, quarter, bqhkxq, qyxzjzr, bqhlcb);
		response(bqrzxqValue);
	}
	
	private String bqrzxq(String year, String quarter, String bqhkxq, String qyxzjzr, String bqhlcb){
		//获取本期投资需求
		String bqtzxq = bqtzxq(year, quarter);
		//获取上一季度账面余额
		String lastquarter = "";
		String lastyear = "";
		String sjdzmye = "0";
		if("1".equals(quarter)){
			lastquarter = "4";
			lastyear = String.valueOf(Integer.parseInt(year) - 1);
		}else{
			lastyear = year;
			lastquarter = String.valueOf(Integer.parseInt(quarter) - 1);
		}
		String querySql = "select t.bqzmye from plan投融资情况 t where t.nd = ? and t.jd = ?";
		List<Map<String, Object>> lastValue = query(querySql, YW, new Object[]{lastyear, lastquarter});
		if(lastValue.size() > 0){
			sjdzmye = String.valueOf(lastValue.get(0).get("bqzmye"));
		}
		String returnValue = String.valueOf(Float.parseFloat(bqtzxq) + Float.parseFloat(bqhkxq) - Float.parseFloat(sjdzmye) - Float.parseFloat(qyxzjzr) + Float.parseFloat(bqhlcb));
		return returnValue;
	}
	
	/**
	 * 
	 * <br>Description:获取负债余额
	 * <br>Author:黎春行
	 * <br>Date:2013-8-23
	 */
	public void getfzyw() {
		String year= request.getParameter("year");
		String quarter = request.getParameter("quarter");
		String bqrzxq = request.getParameter("bqrzxq");
		String bqhkxq = request.getParameter("bqhkxq");
		String fzye = fzye(year, quarter, bqrzxq, bqhkxq);
		response(fzye);
	}
	
	private String fzye(String year, String quarter, String bqrzxq, String bqhkxq){
		//获取上一季度的负债余额
		String lastquarter = "";
		String lastyear = "";
		String sjdfzye = "0";
		if("1".equals(quarter)){
			lastquarter = "4";
			lastyear = String.valueOf(Integer.parseInt(year) - 1);
		}else{
			lastyear = year;
			lastquarter = String.valueOf(Integer.parseInt(quarter) - 1);
		}
		String querySql = "select t.fzye from plan投融资情况 t where t.nd = ? and t.jd = ?";
		List<Map<String, Object>> lastValue = query(querySql, YW, new Object[]{lastyear, lastquarter});
		if(lastValue.size() > 0){
			sjdfzye = String.valueOf(lastValue.get(0).get("fzye"));
		}
		String returnValue = String.valueOf(Float.parseFloat(sjdfzye) + Float.parseFloat(bqrzxq) - Float.parseFloat(bqhkxq));
		return returnValue;
	}
	
	/**
	 * 
	 * <br>Description:获取储备库融资缺口
	 * <br>Author:黎春行
	 * <br>Date:2013-8-23
	 */
	public void getcbkrzqk(){
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		//获取对应季度的供应体量值
		String sql = "select t.储备库融资能力 as chosevalue from v_供地体量 t  where t.年度= ? and t.季度 = ?";
		List<Map<String, Object>> resultList = query(sql, YW, new Object[]{year, quarter});
		String cbhxtz = String.valueOf(resultList.get(0).get("chosevalue"));
		
	}
	
	

}
