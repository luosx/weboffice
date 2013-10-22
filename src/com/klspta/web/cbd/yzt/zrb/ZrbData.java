package com.klspta.web.cbd.yzt.zrb;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.utilList.IData;

public class ZrbData extends AbstractBaseBean implements IData {
	private static final String formName = "JC_ZIRAN";
	/**
	 * 
	 * <br>Description:获取所有自然斑列表
	 * <br>Author:黎春行
	 * <br>Date:2013-10-18
	 * @param request
	 */
	public List<Map<String, Object>> getAllList(HttpServletRequest request){
		String sql = "select * from " + formName + " t order by to_number(t.yw_guid)";
		return query(sql, YW);
	}
	
	/**
	 * 
	 * <br>Description:查询自然斑
	 * <br>Author:黎春行
	 * <br>Date:2013-10-21
	 * @param request
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getQuery(HttpServletRequest request){
		String keyWord = request.getParameter("keyWord");
		StringBuffer querySql = new StringBuffer();
		querySql.append("select * from ").append(formName).append(" t ");
		if(keyWord != null){
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			querySql.append("where t.yw_guid||t.zrbbh||t.zdmj||t.lzmj||t.cqgm||t.zzlzmj||t.zzcqgm||t.yjhs||t.fzzlzmj||t.fzzcqgm||t.bz like '%");
			querySql.append(keyWord).append("%'");
		}
		querySql.append(" order by to_number(t.yw_guid)");
		return query(querySql.toString(), YW);
	}
	
	/**
	 * 
	 * <br>Description:更新自然斑数据
	 * <br>Author:黎春行
	 * <br>Date:2013-10-21
	 * @param request
	 * @return
	 */
	public String updateZrb(HttpServletRequest request){
		return null;
	}
}
