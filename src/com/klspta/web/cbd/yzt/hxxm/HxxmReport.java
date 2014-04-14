package com.klspta.web.cbd.yzt.hxxm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

/**
 * 
 * <br>
 * Title:基本斑详细列表 <br>
 * Description:生成基本详细列表 <br>
 * Author:黎春行 <br>
 * Date:2013-12-18
 */
public class HxxmReport extends AbstractBaseBean implements IDataClass {
	public static String[][] shows = new String[][] { { "xh", "false" },
			{ "xmname", "false" }, { "zd", "false" }, { "jsyd", "false" },
			{ "rjl", "false" }, { "jzgm", "false" }, { "ghyt", "false" },
			{ "GJJZGM", "false" }, { "JZJZGM", "false" },
			{ "SZJZGM", "false" }, { "zzsgm", "false" }, { "zzzsgm", "false" },
			{ "zzzshs", "false" }, { "hjmj", "false" }, { "fzzzsgm", "false" },
			{ "fzzjs", "false" }, { "KFCB", "false" }, { "LMCB", "false" },
			{ "DMCB", "false" }, { "YJCJJ", "false" }, { "YJZFTDSY", "false" },
			{ "CXB", "false" }, { "CQQD", "false" }, { "CBFGL", "false" },
			{ "ZZCQFY", "false" }, { "QYCQFY", "false" }, { "QTFY", "false" },
			{ "AZFTZCB", "false" }, { "ZZHBTZCB", "false" },
			{ "CQHBTZ", "false" }, { "QTFYZB", "false" }, { "LMCJJ", "false" },
			{ "FWSJ", "false" }, { "ZJ", "false" }, { "DKMC", "false" } ,{"yw_guid","false"}};
	private String form_name = "JC_XIANGMU";

	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new TreeMap<String, TRBean>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if (obj.length > 0) {
			queryMap = (Map<String, Object>) obj[0];
		}
		trbeans.put("000", getSub(queryMap).get(0));
		List<TRBean> trbeanList = getBody(queryMap);
		for (int i = 1; i < trbeanList.size()+1; i++) {
			String key = String.valueOf(i);
			if(i<10){
				key = "00" + i;
			}else{
				key = "0" + i;
			}
			//key = key.substring(key.length() - 2, key.length());
			trbeans.put(key, trbeanList.get(i-1));
		}
		return trbeans;
	}

	public List<TRBean> getBody(Map queryMap) {
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.xh,");
		for (int i = 1; i < shows.length - 1 ; i++) {
			sqlBuffer.append("t.").append(shows[i][0]).append(",");
		}
		sqlBuffer.append("t.").append(shows[shows.length - 1][0]).append(
				" from ");
		sqlBuffer.append(form_name).append(" t ");
		if (queryMap != null && !queryMap.isEmpty()) {
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		sqlBuffer.append(" order by t.xh");
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		for (int num = 0; num < queryList.size(); num++) {
			TRBean trBean = new TRBean();
			TDBean tdBean;
			trBean.setCssStyle("trsingle");
			Map<String, Object> map = queryList.get(num);
			for (int i = 0; i < shows.length; i++) {
				String value = String.valueOf(map.get(shows[i][0]));
				if ("null".equals(value)) {
					value = "";
				}
				if (i == shows.length - 1) {
					tdBean = new TDBean(value, "200", "20", shows[i][1]);
				} else {
					tdBean = new TDBean(value, "80", "20", shows[i][1]);
				}

				trBean.addTDBean(tdBean);
			}
			list.add(trBean);
		}
		return list;
	}

	public List<TRBean> getSub(Map queryMap) {
		String sql = "select round(sum(t.zzsgm),2) as zzsgm, round(sum(t.zzzsgm),2) as zzzsgm, round(sum(t.zzzshs),2) as zzzshs," +
				"case when sum(t.zzzshs)=0 then 0 else trunc(decode(sum(t.zzzshs),0,0,sum(t.zzzsgm)/sum(t.zzzshs)),2) end as hjmj," +
				"round(sum(t.fzzzsgm),2) as fzzzsgm, round(sum(t.fzzjs),2) as fzzjs, round(sum(t.zd),2) as zd, round(sum(t.jsyd),2) as jsyd," +
				" case when sum(t.jsyd)=0 then '0' else  round(sum(t.jzgm)/sum(t.jsyd),2)/100||'%' end as rjl, " +
				" round(sum(t.jzgm),2) as jzgm, '--'as ghyt, round(sum(t.gjjzgm),2) as gjjzgm, round(sum(t.jzjzgm),2) as jzjzgm,round(sum(t.szjzgm),2) as szjzgm," +
				"  round(sum(t.kfcb),2) as kfcb,case when sum(t.jsyd)=0 then 0 else round(sum(t.kfcb)/sum(t.jsyd)*10000,2) end as dmcb,case when sum(t.jzgm)=0 then 0 else round(sum(t.kfcb)/sum(jzgm)*10000,2) end as lmcb,round(avg(t.yjcjj),2) as yjcjj," +
				" round(avg(t.yjcjj)*sum(t.jzgm)/10000 - sum(t.kfcb),2) as yjzftdsy,case when avg(t.yjcjj)*sum(t.jzgm)=0 then '0' else" +
				" round((avg(t.yjcjj)*sum(t.jzgm)/10000 - sum(t.kfcb)) /(avg(t.yjcjj)*sum(t.jzgm)/10000),2)||'%' end as cxb," +
				"  case when sum(t.zd)=0 then 0 else round(sum(t.zzsgm)/sum(t.zd),2) end as cqqd,case when sum(kfcb)=0 then '0' else round(sum(t.jzgm)*2.4/sum(kfcb),2)||'%' end as cbfgl" +
				"  ,round(sum(t.zzcqfy),2) as zzcqfy,round(sum(t.qycqfy),2) as qycqfy,round(sum(t.qtfy),2) as qtfy,round(sum(t.azftzcb),2) as azftzcb," +
				" round(sum(t.zzhbtzcb),2) as zzhbtzcb,round(sum(t.cqhbtz),2) as cqhbtz,'' as qtfyzb,round(sum(t.lmcjj),2) as lmcjj," +
				" round(sum(t.fwsj),2) as fwsj,round(sum(t.zj),2) as zj,''as dk,'' as yw_guid from JC_XIANGMU t ";
		if (queryMap != null && !queryMap.isEmpty()) {
			sql += String.valueOf(queryMap.get("query"));
		}
		List<Map<String, Object>> queryList = query(sql.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		TRBean trBean = new TRBean();
		trBean.setCssStyle("trtotal");
		Map<String, Object> map = queryList.get(0);
		TDBean tdname = new TDBean("合计", "180", "20");
		tdname.setColspan("2");
		trBean.addTDBean(tdname);
		for (int i = 2; i < shows.length; i++) {
			String value = String.valueOf(map.get(shows[i][0]));
			if ("null".equals(value)) {
				value = "";
			}
			TDBean tdBean = new TDBean(value, "80", "20", "false");
			trBean.addTDBean(tdBean);
		}
		list.add(trBean);
		return list;
	}
}
