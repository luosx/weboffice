package com.klspta.web.cbd.yzt.zrb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class ZrbReport extends AbstractBaseBean implements IDataClass {
	public static String[][] shows = new String[][]{{"rownum","false"},{"zrbbh","true"},{"zdmj","true"},{"lzmj","true"},{"cqgm","true"},{"zzlzmj","true"},{"zzcqgm","true"},{"yjhs","true"},{"fzzlzmj","true"},{"fzzcqgm","true"},{"bz","true"}};
	private String form_name = "JC_ZIRAN";
	
	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new TreeMap<String, TRBean>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if(obj.length > 0){
			queryMap = (Map<String, Object>)obj[0];
		}
		List<TRBean> trbeanList = getBody(queryMap);
		for(int i = 0; i < trbeanList.size(); i++){
			trbeans.put(i + "1", trbeanList.get(i));
		}
		return trbeans;
	}
	
	public List<TRBean> getBody(Map queryMap){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select rownum,");
		for(int i = 1; i < shows.length - 1; i++){
			sqlBuffer.append("t.").append(shows[i][0]).append(",");
		}
		sqlBuffer.append("t.").append(shows[shows.length - 1][0]).append(" from ");
		sqlBuffer.append(form_name).append(" t ");
		if(queryMap != null && !queryMap.isEmpty()){
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		//sqlBuffer.append(" order by t.zrbbh,t.yw_guid");
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		for(int num = 0; num < queryList.size(); num++){
			TRBean trBean = new TRBean();
			trBean.setCssStyle("trsingle");
			Map<String, Object> map = queryList.get(num);
			for(int i = 0; i < shows.length; i++){
				String value = String.valueOf(map.get(shows[i][0]));
				if("null".equals(value)){
					value = "";
				}
				TDBean tdBean = new TDBean(value, "80", "20",shows[i][1]);
				trBean.addTDBean(tdBean);
			}
			list.add(trBean);
		}
		
		return list;
	}
}
