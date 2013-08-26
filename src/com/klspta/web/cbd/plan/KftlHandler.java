package com.klspta.web.cbd.plan;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class KftlHandler extends AbstractBaseBean {

	/**
	 * 
	 * <br>Description:根据选择的季节获取开发体量
	 * <br>Author:黎春行
	 * <br>Date:2013-8-24
	 * @throws UnsupportedEncodingException 
	 */
	public void getKftlByQuarter() throws UnsupportedEncodingException{
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "utf-8");
		String sql = "select * from plan开发体量 t where t.nd=? and t.jd=? and t.xmmc=?";
		List<Map<String, Object>> resultList = query(sql, YW, new Object[]{year, quarter, xmmc});
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
		String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "utf-8");
		String sql = "delete from plan开发体量 t where t.nd = ? and t.jd= ? and t.xmmc=?";
		update(sql, YW, new Object[]{year, quarter, xmmc});
		response("success");
	}
	
	
}
