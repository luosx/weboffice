package com.klspta.web.cbd.yzt.hxxm;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.utilList.IData;

public class HxxmData extends AbstractBaseBean implements IData {
	private static final String formName = "JC_XIANGMU";
	private static final String jbformName = "JC_JIBEN";
	
	@Override
	public List<Map<String, Object>> getAllList(HttpServletRequest request) {
		StringBuffer sql = new StringBuffer();
		sql.append("select rownum xh,t.* from ").append(formName).append(" t") ;
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return addJbb(resultList);	
	}

	@Override
	public List<Map<String, Object>> getQuery(HttpServletRequest request) {
		String keyWord = request.getParameter("keyWord");
		StringBuffer querySql = new StringBuffer();
		querySql.append("select  rownum xh,t.* from ").append(formName).append(" t");
		if(keyWord != null){
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			querySql.append(" where dkmc like '%");
			querySql.append(keyWord).append("%'");
		}
		List<Map<String, Object>> resultList = query(querySql.toString(), YW);
		return addJbb(resultList);
	}
	
	
	private List<Map<String, Object>> addJbb(List<Map<String, Object>> resultList){
		String zrb = "select t.zrbbh from " + jbformName + " t where t.jbguid = ?";
		for(int i = 0; i < resultList.size(); i++){
			String zrbbh = "";
			Map<String, Object> resultMap = resultList.get(i);
			String jbGuid = String.valueOf(resultMap.get("YW_GUID"));
			List<Map<String, Object>> zrList = query(zrb, YW, new Object[]{jbGuid});
			for(int j = 0; j < zrList.size(); j++){
				zrbbh += String.valueOf(zrList.get(j).get("jbbbh"));
			}
			resultList.get(i).put("jbbbh", zrbbh);
		}
		return resultList;
	}

}
