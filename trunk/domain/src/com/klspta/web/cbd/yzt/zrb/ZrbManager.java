package com.klspta.web.cbd.yzt.zrb;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.support.StaticApplicationContext;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.dtjc.TjbbData;
import com.klspta.web.cbd.yzt.table.CBDtableFields;
import com.sun.org.apache.bcel.internal.generic.RETURN;

/**
 * 
 * <br>Title:自然斑管理类
 * <br>Description:管理自然斑数据
 * <br>Author:黎春行
 * <br>Date:2013-10-18
 */
public class ZrbManager extends AbstractBaseBean {

    /**
     * 
     * <br>Description:获取所有自然斑列表
     * <br>Author:黎春行
     * <br>Date:2013-10-18
     */
    public void getZrb() {
        HttpServletRequest request = this.request;
        response(new ZrbData().getAllList(request));
    }

    /**
     * 
     * <br>Description:根据关键字查询自然斑列表
     * <br>Author:黎春行
     * <br>Date:2013-10-21
     */
    public void getQuery() {
        HttpServletRequest request = this.request;
        response(new ZrbData().getQuery(request));
    }

    /**
     * 
     * <br>Description:更新自然斑
     * <br>Author:黎春行
     * <br>Date:2013-10-22
     */
    public void updateZrb() {
        HttpServletRequest request = this.request;
        if (new ZrbData().updateZrb(request)) {
            response("{success:true}");
        } else {
            response("{success:false}");
        }
       
    }
    
    /**
     * 
     * <br>Description:自然斑上图
     * <br>Author:黎春行
     * <br>Date:2013-12-10
     * @throws Exception 
     */
    public void drawZrb() throws Exception{
    	String tbbh = request.getParameter("tbbh");
    	String polygon = request.getParameter("polygon");
    	if (tbbh != null) {
    		tbbh = UtilFactory.getStrUtil().unescape(tbbh);
    	}else{
    		response("{error:not primary}");
    	}
    	boolean draw = new ZrbData().recordGIS(tbbh, polygon);
    	response(String.valueOf(draw)); 
    }
    
    public static Map<String, String> getZRBBHMap(){
    	ZrbData zrbData = new ZrbData();
    	Set<String> leftSet = new TreeSet<String>();
    	List<Map<String, Object>> zRBBHList = zrbData.getZRBNameList();
    	for(int i = 0; i < zRBBHList.size(); i++){
    		String name = String.valueOf(zRBBHList.get(i).get("ZRBBH"));
    		leftSet.add(name);
    	}
    	Map<String, String> proMap = new HashMap<String, String>();
    	proMap.put("left", toJson(leftSet));
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
}
