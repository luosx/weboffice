package com.klspta.web.cbd.dtjc;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:开发时序管理类
 * <br>Description:实现与前台jsp数据交互，并实现数据库中实施时序的增删改查
 * <br>Author:黎春行
 * <br>Date:2013-10-29
 */
public class TjbbManager extends AbstractBaseBean {
	
	/**
	 * 
	 * <br>Description:获取开发体量实施计划
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 */
	public static String getKFTLPlan(){
		return java.net.URLDecoder.decode(TjbbBuild.buildTable());
	}
	
	/**
	 * 
	 * <br>Description:增加开发体量实施计划
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 */
	public void addKFTLPlan(){
		
		
	}
	
	/**
	 * 
	 * <br>Description:删除开发体量实施计划
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 */
	public void delKftlPlan(){
		
		
	}
	
	/**
	 * 
	 * <br>Description:修改实施计划
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 */
	public void changePlan(){
		String formName = request.getParameter("formname");
		String oldYear = request.getParameter("oldyear");
		String oldQuarter = request.getParameter("oldquarter");
		String newYear = request.getParameter("newyear");
		String newQuarter = request.getParameter("newquarter");
		String projectName = UtilFactory.getStrUtil().unescape(request.getParameter("projectname"));
		Map<String, String> setValues = new HashMap<String, String>();
		setValues.put("nd", newYear);
		setValues.put("jd", newQuarter);
		Map<String, String> conditions = new HashMap<String, String>();
		conditions.put("nd", oldYear);
		conditions.put("jd", oldQuarter);
		conditions.put("xmmc", projectName);
		TjbbData tjbbData = new TjbbData();
		int i = tjbbData.changeQuarter(formName, setValues, conditions);
		response(String.valueOf(i));
	}
	
	/**
	 * 
	 * <br>Description:获取供地体量实施计划
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 */
	public void getGDTLPlan(){
		
		
	}
	

}
