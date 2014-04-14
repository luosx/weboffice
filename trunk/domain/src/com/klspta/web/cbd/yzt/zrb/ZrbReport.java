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
	private String[][] title1 = new String[][] { { "序号", "80" ,"2","1"},
			{ "自然斑编号", "100","2","1" }, { "占地面积（㎡）", "140","2","1" }, { "总计", "200" ,"1","2"},
			{ "住宅现状（户、人、㎡）", "300" ,"1","3"}, { "非住宅现状（㎡）", "280","1","2" }, { "备注", "100" ,"2","1"},
			{ "yw_guid", "100","2","1" } };
	private String[][] title2 = new String[][] { { "楼座面积", "100" },
			{ "现状规模", "100" }, { "住宅楼座面积", "100" }, { "住宅现状规模", "100" },
			{ "预计户数", "100" }, { "非住宅楼座面积", "140" }, { "非住宅现状规模", "140" } };
	public static String[][] shows = new String[][] { { "zrbbh", "true","100" },
			{ "zdmj", "true","140" }, { "lzmj", "true" ,"100"}, { "cqgm", "true" ,"100"},
			{ "zzlzmj", "true" ,"100"}, { "zzcqgm", "true" ,"100"}, { "yjhs", "true" ,"100"},
			{ "fzzlzmj", "true","140" }, { "fzzcqgm", "true","140" }, { "bz", "true","100" },
			{ "yw_guid", "false" ,"100"} };
	private String form_name = "JC_ZIRAN";
	private String isEdit = "true";

	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new TreeMap<String, TRBean>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if (obj.length > 1) {
			queryMap = (Map<String, Object>) obj[1];
			isEdit = (String) obj[0];
		} else {
			isEdit = (String) obj[0];
		}
		trbeans = buildtitle(trbeans);
		List<TRBean> trbeanList = getBody(queryMap);
		for (int i = 3; i < trbeanList.size()+3; i++) {
			String key = String.valueOf(i);
			key = "000" + i;
			key = key.substring(key.length() - 3, key.length());
			trbeans.put(key, trbeanList.get(i-3));
		}
		trbeans.put("999", getSub(queryMap).get(0));
		return trbeans;
	}

	public Map<String, TRBean> buildtitle(Map<String, TRBean> trbeans) {
		TRBean trbean = new TRBean();
		TDBean tdbean = null;
		for(int i=0;i<title1.length;i++){
			tdbean = new TDBean(title1[i][0],title1[i][1],"");
			tdbean.setRowspan(title1[i][2]);
			tdbean.setColspan(title1[i][3]);
			tdbean.setStyle("title");
			trbean.addTDBean(tdbean);
		}
		trbeans.put("0001", trbean);
		trbean= new TRBean();
		for(int i=0;i<title2.length;i++){
			tdbean = new TDBean(title2[i][0],title2[i][1],"");
			tdbean.setStyle("title");
			trbean.addTDBean(tdbean);
		}
		trbeans.put("0002", trbean);
		return trbeans;
	}

	public List<TRBean> getBody(Map queryMap) {
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select ");
		for (int i = 0; i < shows.length - 1; i++) {
			sqlBuffer.append("t.").append(shows[i][0]).append(",");
		}
		sqlBuffer.append("t.").append(shows[shows.length - 1][0]).append(
				" from ");
		sqlBuffer.append(form_name).append(" t ");
		if (queryMap != null && !queryMap.isEmpty()) {
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		sqlBuffer.append(" order by t.zrbbh");
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		for (int num = 0; num < queryList.size(); num++) {
			TRBean trBean = new TRBean();
			trBean.setCssStyle("trsingle");
			Map<String, Object> map = queryList.get(num);
			trBean.addTDBean(new TDBean(String.valueOf(num + 1), "80", "20"));
			for (int i = 0; i < shows.length; i++) {
				String value = String.valueOf(map.get(shows[i][0]));
				TDBean tdBean;
				if ("null".equals(value)) {
					value = "";
				}
				if ("true".equals(isEdit)) {
					tdBean = new TDBean(value, shows[i][2], shows[i][1]);
				} else {
					tdBean = new TDBean(value, shows[i][2], "false");
				}
				trBean.addTDBean(tdBean);
			}
			list.add(trBean);
		}
		return list;
	}

	public List<TRBean> getSub(Map queryMap) {
		String sql = "select sum(t.zdmj) as zdmj, sum(t.lzmj) as lzmj, sum(t.cqgm) as cqgm, sum(t.zzlzmj) as zzlzmj, sum(t.zzcqgm) as zzcqgm, sum(t.yjhs) as yjhs, sum(t.fzzlzmj) as fzzlzmj, sum(t.fzzcqgm) as fzzcqgm, '0' as bz from jc_ziran t ";
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
		for (int i = 1; i < shows.length - 1; i++) {
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
