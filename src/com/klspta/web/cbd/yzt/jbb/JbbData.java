package com.klspta.web.cbd.yzt.jbb;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.utilList.IData;

public class JbbData extends AbstractBaseBean implements IData  {
	private static final String formName = "JC_JIBEN";
	private static final String zrformName = "JC_ZIRAN";
	
	@Override
	public List<Map<String, Object>> getAllList(HttpServletRequest request) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(formName).append(" t order by t.dkmc");
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return addZrb(resultList);
	}

	@Override
	public List<Map<String, Object>> getQuery(HttpServletRequest request) {
		String keyWord = request.getParameter("keyWord");
		StringBuffer querySql = new StringBuffer();
		querySql.append("select * from ").append(formName).append(" t");
		if(keyWord != null){
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			querySql.append("where t.yw_guid||t.zrbbh||t.zdmj||t.lzmj||t.cqgm||t.zzlzmj||t.zzcqgm||t.yjhs||t.fzzlzmj||t.fzzcqgm||t.bz like '%");
			querySql.append(keyWord).append("%'");
		}
		querySql.append(" order by t.dkmc");
		List<Map<String, Object>> resultList = query(querySql.toString(), YW);
		return addZrb(resultList);
	}
	
	
	private List<Map<String, Object>> addZrb(List<Map<String, Object>> resultList){
		String zrb = "select t.zrbbh from " + zrformName + " t where t.jbguid = ?";
		for(int i = 0; i < resultList.size(); i++){
			String zrbbh = "";
			Map<String, Object> resultMap = resultList.get(i);
			String jbGuid = String.valueOf(resultMap.get("YW_GUID"));
			List<Map<String, Object>> zrList = query(zrb, YW, new Object[]{jbGuid});
			for(int j = 0; j < zrList.size(); j++){
				zrbbh += String.valueOf(zrList.get(j).get("zrbbh"));
			}
			resultList.get(i).put("zrbbh", zrbbh);
		}
		return resultList;
	}

}
