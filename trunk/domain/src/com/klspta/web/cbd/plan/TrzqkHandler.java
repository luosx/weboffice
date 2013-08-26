package com.klspta.web.cbd.plan;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class TrzqkHandler extends AbstractBaseBean {

	/**
	 * 
	 * <br>Description:根据选择的季节获取开发体量
	 * <br>Author:黎春行
	 * <br>Date:2013-8-24
	 * @throws UnsupportedEncodingException 
	 */
	public void getAzfjsByQuarter() throws UnsupportedEncodingException{
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		String sql = "select * from plan投融资情况 t where t.nd=? and t.jd=?";
		List<Map<String, Object>> resultList = query(sql, YW, new Object[]{year, quarter});
		response(resultList);
	}
	
	
	/**
	 * 
	 * <br>Description:保存之前删除已经保存过的记录
	 * <br>Author:黎春行
	 * <br>Date:2013-8-25
	 * @throws UnsupportedEncodingException 
	 */
	public void deleteExist() throws UnsupportedEncodingException{
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		String sql = "delete from plan投融资情况 t where t.nd = ? and t.jd= ?";
		update(sql, YW, new Object[]{year, quarter});
		response("success");
	}
	
	
}
