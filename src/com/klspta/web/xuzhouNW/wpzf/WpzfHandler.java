package com.klspta.web.xuzhouNW.wpzf;


import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
/**
 * 
 * <br>Title:卫片执法管理类
 * <br>Description：对空间库中的卫片图斑实现查看处理
 * <br>Author:黎春行
 * <br>Date:2013-9-10
 */
public class WpzfHandler extends AbstractBaseBean {
	/**
	 * 
	 * <br>Description:获取所有未处理的图斑
	 * <br>Author:黎春行
	 * <br>Date:2013-9-10
	 */
	public void getwclTb(){
		//获取所有卫片已核查的yw_guid
		String sql = "select distinct yw_guid from wphcqk ";
		List<Map<String, Object>> hcList = query(sql, YW);
		StringBuffer yhc = new StringBuffer();
		yhc.append(" ( ");
		for(int i = 0; i < hcList.size(); i++){
			yhc.append(String.valueOf(hcList.get(i).get("yw_guid"))).append(",");
		}
		yhc.append("'0')");
		
		//获取所有未处理的卫片
		String keyword = request.getParameter("keyword");
		StringBuffer sqlBuffer = new StringBuffer();
		String wpFormName = UtilFactory.getConfigUtil().getConfig("wpname");
		sqlBuffer.append("select to_char(t.objectid) objectid, to_char(t.jcbh) jcbh, t.xmc, to_char(trunc(t.shape.area, 2)) as area, to_char(substr(t.hsx, 0, 4)) as year, to_char(t.tblx) tblx from ");
		sqlBuffer.append(wpFormName).append(" t ");
		sqlBuffer.append("where (not ( t.objectid in ").append(yhc.toString()).append("))");
		if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
             sqlBuffer.append(" and (upper(t.jcbh)||upper(t.xmc)||upper(t.shape.area)||upper(t.hsx)||upper(t.tblx) like '%");
             sqlBuffer.append(keyword);
             sqlBuffer.append("%')");
        }
		sqlBuffer.append(" order by cast(t.jcbh As int)");
		List<Map<String, Object>> wclList = query(sqlBuffer.toString(), GIS);
		response(wclList);
	}
	
	/**
	 * 
	 * <br>Description:获取所有处理中卫片
	 * <br>Author:黎春行
	 * <br>Date:2013-9-10
	 */
	public void getclzTab(){
		//获取所有卫片已核查的yw_guid
		String sql = "select distinct yw_guid from wphcqk where type='违法' and status='0'";
		List<Map<String, Object>> hcList = query(sql, YW);
		StringBuffer yhc = new StringBuffer();
		yhc.append(" ( ");
		for(int i = 0; i < hcList.size(); i++){
			yhc.append(String.valueOf(hcList.get(i).get("yw_guid"))).append(",");
		}
		yhc.append("'0')");
		
		//获取所有未处理的卫片
		String keyword = request.getParameter("keyword");
		StringBuffer sqlBuffer = new StringBuffer();
		String wpFormName = UtilFactory.getConfigUtil().getConfig("wpname");
		sqlBuffer.append("select to_char(t.objectid) objectid, to_char(t.jcbh) jcbh, t.xmc, to_char(trunc(t.shape.area, 2)) as area, to_char(substr(t.hsx, 0, 4)) as year, to_char(t.tblx) tblx from ");
		sqlBuffer.append(wpFormName).append(" t ");
		sqlBuffer.append("where  ( t.objectid in ").append(yhc.toString()).append(")");
		if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
             sqlBuffer.append(" and (upper(t.jcbh)||upper(t.xmc)||upper(t.shape.area)||upper(t.hsx)||upper(t.tblx) like '%");
             sqlBuffer.append(keyword);
             sqlBuffer.append("%')");
        }
		sqlBuffer.append(" order by cast(t.jcbh As int)");
		List<Map<String, Object>> wclList = query(sqlBuffer.toString(), GIS);
		response(wclList);
	}
	
	/**
	 * 
	 * <br>Description:获取所有已处理卫片
	 * <br>Author:黎春行
	 * <br>Date:2013-9-10
	 * @throws Exception 
	 */
	public void getyclTab() throws Exception{
		//获取所有卫片已核查的yw_guid
		String type = new String(request.getParameter("type").getBytes("ISO-8859-1"), "UTF-8");
		String status = request.getParameter("status");
		String sql = "select distinct yw_guid from wphcqk where type='"+ type +"' and status='"+status+"'";
		List<Map<String, Object>> hcList = query(sql, YW);
		StringBuffer yhc = new StringBuffer();
		yhc.append(" ( ");
		for(int i = 0; i < hcList.size(); i++){
			yhc.append(String.valueOf(hcList.get(i).get("yw_guid"))).append(",");
		}
		yhc.append("'0')");
		
		//获取所有未处理的卫片
		String keyword = request.getParameter("keyword");
		StringBuffer sqlBuffer = new StringBuffer();
		String wpFormName = UtilFactory.getConfigUtil().getConfig("wpname");
		sqlBuffer.append("select to_char(t.objectid) objectid, to_char(t.jcbh) jcbh, t.xmc, to_char(trunc(t.shape.area, 2)) as area, to_char(substr(t.hsx, 0, 4)) as year, to_char(t.tblx) tblx from ");
		sqlBuffer.append(wpFormName).append(" t ");
		sqlBuffer.append("where  ( t.objectid in ").append(yhc.toString()).append(")");
		if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
            sqlBuffer.append(" and (upper(t.jcbh)||upper(t.xmc)||upper(t.shape.area)||upper(t.hsx)||upper(t.tblx) like '%");
            sqlBuffer.append(keyword);
            sqlBuffer.append("%')");
        }
		sqlBuffer.append(" order by cast(t.jcbh As int)");
		List<Map<String, Object>> wclList = query(sqlBuffer.toString(), GIS);
		response(wclList);	
	}
	
	/**
	 * 
	 * <br>Description:修改处理中卫片的处理状态
	 * <br>Author:黎春行
	 * <br>Date:2013-9-10
	 */
	public void changeStatus(){
		String objectId = request.getParameter("objectid");
		String sql = "update wphcqk t set t.status = '1' where t.yw_guid = ?";
		update(sql, YW, new Object[]{objectId});
	}
	
}
