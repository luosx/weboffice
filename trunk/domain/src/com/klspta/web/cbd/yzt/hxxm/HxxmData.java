package com.klspta.web.cbd.yzt.hxxm;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.utilList.IData;

public class HxxmData extends AbstractBaseBean implements IData {
	private static final String formName = "JC_XIANGMU";

	private static final String jbformName = "JC_JIBEN";

	/**
	 * 项目数据列表
	 */
	public static List<Map<String, Object>> xmList;

	@Override
	public List<Map<String, Object>> getAllList(HttpServletRequest request) {
		//if (xmList == null) {
			StringBuffer sql = new StringBuffer();
			sql.append("select rownum xh,t.* from ").append(formName).append(
					" t");
			List<Map<String, Object>> resultList = query(sql.toString(), YW);
			for (Map<String, Object> map : resultList) {
				if (map.containsKey("LMCB")) {
					if (map.get("LMCB") != "" && map.get("LMCB")!=null) {
						double lmcbtemp = Double.parseDouble(map.get("LMCB").toString());
						String lmcb = String.format("%.1f", lmcbtemp);
						map.remove("LMCB");
						map.put("LMCB", lmcb);
					}
				}
			}
			xmList = addJbb(resultList);
		//}
		return xmList;
	}

	@Override
	public List<Map<String, Object>> getQuery(HttpServletRequest request) {
		String keyWord = request.getParameter("keyWord");
		StringBuffer querySql = new StringBuffer();
		querySql.append("select  rownum xh,t.* from ").append(formName).append(
				" t");
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			querySql.append(" where xmname like '%");
			querySql.append(keyWord).append("%'");
		} else if (xmList != null) {
			return xmList;
		}
		List<Map<String, Object>> resultList = query(querySql.toString(), YW);
		return addJbb(resultList);
	}

	private List<Map<String, Object>> addJbb(
			List<Map<String, Object>> resultList) {
		String zrb = "select t.dkbh from " + jbformName
				+ " t where t.xmguid= ?";
		for (int i = 0; i < resultList.size(); i++) {
			String zrbbh = "";
			Map<String, Object> resultMap = resultList.get(i);
			String jbGuid = String.valueOf(resultMap.get("YW_GUID"));
			List<Map<String, Object>> zrList = query(zrb, YW,
					new Object[] { jbGuid });
			for (int j = 0; j < zrList.size(); j++) {
				zrbbh += String.valueOf(zrList.get(j).get("dkbh"));
			}
			resultList.get(i).put("dkbh", zrbbh);
		}
		return resultList;
	}

	public boolean updateHxxm(HttpServletRequest request) {
		String yw_guid = request.getParameter("tbbh");
		String dbChanges = request.getParameter("tbchanges");
		JSONArray js = JSONArray.fromObject(UtilFactory.getStrUtil().unescape(
				dbChanges));
		System.out.println(js);
		Iterator<?> it = js.getJSONObject(0).keys();
		StringBuffer sb = new StringBuffer("update jc_xiangmu set ");
		List<Object> list = new ArrayList<Object>();
		while (it.hasNext()) {
			String key = (String) it.next().toString();
			String value = js.getJSONObject(0).getString(key);
			sb.append(key).append("=?,");
			list.add(value);
		}
		list.add(yw_guid);
		sb.replace(sb.length() - 1, sb.length(), " where yw_guid=?");
		int result = update(sb.toString(), YW, list.toArray());
		if (result == 1) {
			flush(js.getJSONObject(0), yw_guid);
		}
		return result == 1 ? true : false;
	}

	private void flush(JSONObject jObject, String guid) {
		int count = xmList.size();
		int num = -1;
		Map<String, Object> map = null;
		for (int i = 0; i < count; i++) {
			map = xmList.get(i);
			if (map.get("yw_guid").equals(guid)) {
				num = i;
				break;
			}
		}
		if (num != -1) {
			Iterator<?> it = jObject.keys();
			while (it.hasNext()) {
				String key = (String) it.next().toString();
				String value = jObject.getString(key);
				map.put(key, value);
			}
			xmList.set(num, map);
		}
	}

	/**
	 * 
	 * <br>Description:修改红线项目的值
	 * <br>Author:黎春行
	 * <br>Date:2013-12-24
	 * @param xmmc
	 * @param field
	 * @param value
	 * @return
	 */
	public boolean modifyValue(String xmmc, String field, String value) {
    	StringBuffer sqlBuffer = new StringBuffer();
    	sqlBuffer.append(" update ").append(formName);
    	sqlBuffer.append(" t set t.").append(field).append("=? where t.xmname=?");
    	int i = update(sqlBuffer.toString(), YW, new Object[]{value, xmmc});
		return i == 1 ? true : false;
	}

	public boolean insertHxxm(String xmmc) {
		String sql = "insert into " + formName + "(xmname) values(?)";
		int result = update(sql, YW, new Object[]{xmmc});
		return result == 1 ? true : false;
	}
}
