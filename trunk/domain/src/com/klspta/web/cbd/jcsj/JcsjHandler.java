package com.klspta.web.cbd.jcsj;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:基础数据管理类
 * <br>Description:管理基础数据张项目的数据管理
 * <br>Author:黎春行
 * <br>Date:2013-8-21
 */
public class JcsjHandler extends AbstractBaseBean{
	/**
	 * 
	 * <br>Description:获取所有项目的基本信息
	 * <br>Author:黎春行
	 * <br>Date:2013-8-21
	 */
	public void getjcsjList(){
		String sql = "select t.* from xminfo t";
		List<Map<String, Object>> projectList = query(sql, YW);
		response(projectList);
	}
	
	/**
	 * 
	 * <br>Description:获取给定项目名称的基本数据
	 * <br>Author:黎春行
	 * <br>Date:2013-8-21
	 */
	public void getProjectList(){
		String sql = "select t.* from xminfo t where t.xmname=?";
		String xmmc = "";
		try {
			xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<Map<String, Object>> projectList = query(sql, YW, new Object[]{xmmc});
		response(projectList);
	}
	
	
}
