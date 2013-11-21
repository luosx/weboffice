package com.klspta.web.xiamen.xchc;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.xiamen.jcl.XzqHandle;

public class XchcData extends AbstractBaseBean implements IxchcData {
	
	private static final String queryString = "(upper(guid)||upper(xzqmc)||upper(xmmc)||upper(rwlx)||upper(sfwf)||upper(xcr)||upper(xcrq)";
	
	@Override
	public List<Map<String, Object>> getDclList(String userId, String keyword) {
		String xzq = editXzq(userId);
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.readflag,t.guid,t.xzqmc,t.xmmc,t.rwlx,t.sfwf,t.xcr,t.xcrq,t.cjzb,t.jwzb,t.imgname from v_pad_data_xml t where t.impxzqbm in");
		sqlBuffer.append(xzq);
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
	
	
	private String editXzq(String userId){
		Set<String> xzqSet = XzqHandle.getChildSetByUserId(userId);
		StringBuffer containBuffer = new StringBuffer();
		containBuffer.append("(");
		for(String xzqname : xzqSet){
			containBuffer.append("'").append(xzqname).append("',");
		}
		containBuffer.append(" 'null' )");
		return containBuffer.toString();
	}

}
