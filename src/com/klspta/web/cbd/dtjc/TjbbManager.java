package com.klspta.web.cbd.dtjc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.dtjc.tjbb.Gdtl;
import com.klspta.web.cbd.dtjc.tjbb.Kftl;
import com.klspta.web.cbd.dtjc.trzqk.TrzqkThread;
import com.klspta.web.cbd.hxxm.jdjh.KftlTable;

/**
 * 
 * <br>Title:时序管理类
 * <br>Description:实现与前台jsp数据交互，并实现数据库中实施时序的增删改查
 * <br>Author:黎春行
 * <br>Date:2013-10-29
 */
public class TjbbManager extends AbstractBaseBean {
	
	/**
	 * 
	 * <br>Description:获取实施计划
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 */
	public static StringBuffer getPlan(){
		return TjbbBuild.buildTable();
	}
	
	public static StringBuffer getPlan(String userId){
		return TjbbBuild.buildTable(userId);
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
		//通过线程实现数据更新。
		Thread newThread = new Thread(new TjbbThread(formName, setValues, conditions));
		newThread.start();
		
		//通过线程实现投融资情况更新
		Thread trzqkThread = new Thread(new TrzqkThread());
		trzqkThread.start();
	}
	
	/**
	 * 
	 * <br>Description:投融资情况数据修改
	 * <br>Author:黎春行
	 * <br>Date:2013-11-13
	 */
	public void changeTrzqk(){
		String type = request.getParameter("type");
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		String value = request.getParameter("value");
		if (type.equals("rzxq")) {
			new TjbbData().addRzxq(year, quarter, value);
		}else if(type.equals("zjzr")){
			new TjbbData().addQyxzjzr(year, quarter, value);
		}
		
		//通过线程实现投融资情况更新
		Thread trzqkThread = new Thread(new TrzqkThread());
		trzqkThread.start();
	}
	
	/**
	 * 
	 * <br>Description:保存用户选择的项目
	 * <br>Author:黎春行
	 * <br>Date:2013-11-5
	 */
	public void setProjectsByUserId(){
		String userId = request.getParameter("userId");
		String beginYear = request.getParameter("beginYear");
		String endYear = request.getParameter("endYear");
		String projects = UtilFactory.getStrUtil().unescape(request.getParameter("itemselector"));
		TjbbData tjbbData = new TjbbData();
		tjbbData.saveProjectsByUserid(userId, beginYear, endYear, projects);
	}
	/**
	 * 
	 * <br>Description:获取当前用户项目处理状态
	 * <br>Author:黎春行
	 * <br>Date:2013-11-5
	 * @param userId
	 * @return
	 */
	public static Map<String, String> getProjectByUserId(String userId){
		TjbbData tjbbData = new TjbbData();
		Set<String> leftSet = tjbbData.getGDTLProject();
		Set<String> rightSet = new TreeSet<String>();
		List<Map<String, Object>> userInfo = tjbbData.getPlanByUserId(userId);
		if(userInfo.size()> 0){
			Map<String, Object> userMap= userInfo.get(0);
			String[] pros = String.valueOf(userMap.get("PROJECTS")).split(",");
			for(int i = 0; i < pros.length; i++){
				rightSet.add(pros[i]);
				leftSet.remove(pros[i]);
			}
		}
		Map<String, String> proMap = new HashMap<String, String>();
		proMap.put("left", toJson(leftSet));
		proMap.put("right", toJson(rightSet));
		return proMap;
	}
	
	private static String toJson(Set<String> set){
		StringBuffer jsonBuffer = new StringBuffer();
		jsonBuffer.append("[");
		for(String project : set){
			jsonBuffer.append("['").append(project).append("','");
			jsonBuffer.append(project).append("'],");
		}
		if(!set.isEmpty())
			jsonBuffer = jsonBuffer.deleteCharAt(jsonBuffer.length() - 1);
		jsonBuffer.append("]");
		return jsonBuffer.toString();
		
	}
	
	public static String getxmNumByUserId(String userId){
		TjbbData tjbbData = new TjbbData();
		List<Map<String, Object>> userInfo = tjbbData.getPlanByUserId(userId);
		if(userInfo.size()> 0){
			Map<String, Object> userMap= userInfo.get(0);
			String[] pros = String.valueOf(userMap.get("PROJECTS")).split(",");
			return String.valueOf(pros.length);
		}else{
			return String.valueOf(tjbbData.getKFTLProject().size());
			
		}
		
	}

}
