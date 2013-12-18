package com.klspta.web.cbd.yzt.jbb;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class JbbManager extends AbstractBaseBean{
	private String[] fields = new String[]{"dkmc","zzsgm","zzzsgm","zzzshs","hjmj","fzzzsgm","fzzjs","zd","jsyd","rjl","jzgm","ghyt","gjjzgm","jzjzgm","szjzgm","kfcb","lmcb","dmcb","yjcjj","yjzftdsy","cxb","cqqd","cbfgl"};
	public void getJbb() {
		HttpServletRequest request = this.request;
		response(new JbbData().getAllList(request));
	}
	
	public void getQuery(){
		HttpServletRequest request = this.request;
		response(new JbbData().getQuery(request));
	}
	
	public void updateJbb() {
	        HttpServletRequest request = this.request;
	        if (new JbbData().updateJbb(request)) {
	            response("{success:true}");
	        } else {
	            response("{success:false}");
	        }
	}
	
	public void update() throws Exception{
    	String dkmc =new String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
    	String index = request.getParameter("vindex");
    	String value = new String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
    	String field = fields[Integer.parseInt(index)];
    	response(String.valueOf(new JbbData().modifyValue(dkmc, field, value)));
	}
	 
	 
	    /**
	     * 
	     * <br>Description:基本斑上图
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
	    	boolean draw = new JbbData().recordGIS(tbbh, polygon);
	    	response(String.valueOf(draw)); 
	    }
	    
	    public static Map<String, String> getDKMCMap(){
	        JbbData jbbData = new JbbData();
	        Set<String> leftSet = new TreeSet<String>();
	        List<Map<String, Object>> dkmcList = jbbData.getDkmcList();
	        for(int i = 0; i < dkmcList.size(); i++){
	            String name = String.valueOf(dkmcList.get(i).get("DKMC"));
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
	 
	/*public void getExcel(){
		HttpServletRequest request = this.request;
		HttpServletResponse response = this.response;
		JbbReport jbbReport = new JbbReport();
		jbbReport.getExcel(request, response);
	}*/

}
