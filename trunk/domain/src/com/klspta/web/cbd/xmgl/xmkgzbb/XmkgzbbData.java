package com.klspta.web.cbd.xmgl.xmkgzbb;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class XmkgzbbData extends AbstractBaseBean {
	
	private static final String formName = "XMKGZBB";
	private static final String queryString = "(upper(yw_guid)||upper(rownum)||upper(DKBH)||upper(YDXZDH)||upper(YDXZ)||upper(YDMJ)||upper(RJL)||upper(JZMJ)||upper(KZGD)||upper(BZ)";
	public static List<Map<String, Object>> xmkgzbbList;
	
	private static XmkgzbbData xmkgzbbData;
	
	private String dkbh = "";
    private String field = "";
    private String value = "";
	
	public static XmkgzbbData getInstance(){
    	if(xmkgzbbData == null){
    		xmkgzbbData = new XmkgzbbData();
    	}
    	return xmkgzbbData;
    }
	
	public List<Map<String, Object>> getAllList(HttpServletRequest request) {
			String yw_guid = request.getParameter("yw_guid").toString();
			if(xmkgzbbList == null){
			    StringBuffer sql = new StringBuffer();
			    sql.append("select rownum,t.dkbh, t.ydxzdh, t.ydxz, t.ydmj, t.rjl, t.jzmj, t.kzgd, t.bz from ").append(formName).append(" t where yw_guid = '") .append(yw_guid).append("'");
			    
			    xmkgzbbList = query(sql.toString(), YW);
			}
			return xmkgzbbList;
		}
	public List<Map<String, Object>> getDclList(String userId, String keyword) {
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.* from v_pad_data_xml t ");
		if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
             sqlBuffer.append(" and").append(queryString).append(" like '%");
             sqlBuffer.append(keyword);
             sqlBuffer.append("%')");
        }
		List<Map<String, Object>> getList = query(sqlBuffer.toString(), YW);
        for (int i = 0; i < getList.size(); i++) {
        	getList.get(i).put("XIANGXI", i);
        	getList.get(i).put("DELETE", i);
        }
		return getList;
	}
	
	
	public List<Map<String, Object>> getQuery(HttpServletRequest request) {
        String keyWord = request.getParameter("keyWord");
        String yw_guid = request.getParameter("yw_guid");
        StringBuffer querySql = new StringBuffer();
        querySql.append("select rownum ,t.* from ").append(formName).append(" t where yw_guid = '").append(yw_guid).append("'");
        if (keyWord != null&&!"".equals(keyWord)) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            querySql.append("and t.rownum||t.dkbh||t.ydxz||t.ydxzdh||t.ydmj||t.rjl||t.jzmj||t.kzgd||t.bz like '%");
            querySql.append(keyWord).append("'");
        } else if (xmkgzbbList != null) {
            return xmkgzbbList;
        }
        return query(querySql.toString(), YW);
    }
	public boolean delete(String dk){
    	String sql = "delete from " + formName + " t where t.dkbh = ?";
    	int result = update(sql, YW, new Object[]{dk});
    	return result == 1 ? true : false;
    }
	public boolean modifyValue(String dkbh, String field, String value){
    	StringBuffer sqlBuffer = new StringBuffer();
    	sqlBuffer.append(" update ").append(formName);
    	sqlBuffer.append(" t set t.").append(field);
    	sqlBuffer.append("='"+value);
    	sqlBuffer.append("' where t.dkbh=?");
    	int i = update(sqlBuffer.toString(), YW, new Object[]{ dkbh});
     	return i == 1 ? true : false;
    }
	
}
