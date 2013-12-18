package com.klspta.web.cbd.yzt.jbb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

/**
 * 
 * <br>Title:基本斑详细列表
 * <br>Description:生成基本详细列表
 * <br>Author:黎春行
 * <br>Date:2013-12-18
 */
public class JbbReport extends AbstractBaseBean implements IDataClass {
	public static String[] shows = new String[]{"dkmc","zzsgm","zzzsgm","zzzshs","hjmj","fzzzsgm","fzzjs","zd","jsyd","rjl","jzgm","ghyt","gjjzgm","jzjzgm","szjzgm","kfcb","lmcb","dmcb","yjcjj","yjzftdsy","cxb","cqqd","cbfgl"};
	private String form_name = "JC_JIBEN";
	
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
		List<TRBean> list = new ArrayList<TRBean>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select ");
		for(int i = 0; i < shows.length - 1; i++){
			sqlBuffer.append("t.").append(shows[i]).append(",");
		}
		sqlBuffer.append("t.").append(shows[shows.length - 1]).append(" from ");
		sqlBuffer.append(form_name).append(" t ");
		if(queryMap != null && !queryMap.isEmpty()){
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		sqlBuffer.append(" order by t.dkmc");
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		Map<String, List<TRBean>> buildMap = new TreeMap<String, List<TRBean>>();
		for(int i = 0; i < queryList.size(); i++){
			Map map = queryList.get(i);
			String key = String.valueOf(map.get("dkmc"));
			key = key.split("_")[0];
			if("".equals(key)){
				continue;
			}
			List<TRBean> subTotal = buildMap.get(key);
			if(subTotal == null){
				subTotal = getSubTotal(key, queryMap);
			}
			TRBean trBean = new TRBean();
			trBean.setCssStyle("trsingle");
			for(int j = 0; j < shows.length; j++){
				String value = String.valueOf(map.get(shows[j]));
				if("null".equals(value)){
					value = "";
				}
				TDBean tdBean = new TDBean(value,"100","20");
				trBean.addTDBean(tdBean);
			}
			subTotal.add(trBean);
			buildMap.remove(key);
			buildMap.put(key, subTotal);
		}

		Set<String> keySet = buildMap.keySet();
		for(String key : keySet){
			List<TRBean> trBeans = buildMap.get(key);
			list.addAll(trBeans);
		}
		return list;
	}
	
	private Set<String> getSubTotalKey(Map queryMap){
		Set<String> keySet = new TreeSet<String>();
		String sqlKey = "select substr(t.dkmc, 0,instr(t.dkmc,'_') - 1) dk from "+ form_name +" t ";
		if(queryMap != null && !queryMap.isEmpty()){
			sqlKey += String.valueOf(queryMap.get("query"));
		}
		sqlKey += " order by t.dkmc";
		List<Map<String, Object>> queryList = query(sqlKey, YW);
		for(int i = 0; i < queryList.size(); i++){
			String value = String.valueOf(queryList.get(i).get("dk"));
			keySet.add(value);
		}
		return keySet;
	}
	
	
	private List<TRBean> getSubTotal(String key,Map queryMap){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select ");
		for(int i = 1; i < shows.length - 1; i++){
			sqlBuffer.append("sum(t.").append(shows[i]).append(") as ").append(shows[i]).append(",");
		}
		sqlBuffer.append("sum(t.").append(shows[shows.length - 1]).append(") as ").append(shows[shows.length - 1]).append(" from ");
		sqlBuffer.append(form_name).append(" t ");
		if(queryMap != null && !queryMap.isEmpty()){
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
			sqlBuffer.append("　and  t.dkmc like '").append(key).append("_%'");
		}else{
			sqlBuffer.append("  where t.dkmc like '").append(key).append("_%'");
		}
		sqlBuffer.append(" order by t.dkmc");
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		Map<String, Object> map = queryList.get(0);
		TRBean trBean = new TRBean();
		trBean.setCssStyle("trtotal");
		TDBean tdtitle = new TDBean(key + "小计","130","20");
		trBean.addTDBean(tdtitle);
		for(int j = 1; j < shows.length; j++){
			String value = String.valueOf(map.get(shows[j]));
			if("null".equals(value)){
				value = "";
			}
			TDBean tdBean = new TDBean(value,"100","20");
			trBean.addTDBean(tdBean);
		}
		List<TRBean> returnList = new ArrayList<TRBean>();
		returnList.add(trBean);
		return returnList;
	}
}
