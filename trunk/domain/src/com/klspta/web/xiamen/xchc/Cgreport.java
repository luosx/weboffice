package com.klspta.web.xiamen.xchc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class Cgreport extends AbstractBaseBean implements IDataClass {
	
	public static String[][] showList = new String[][]{{"YDDW","用地单位"},{"ydsj","用地时间"},{"ydqk","用地情况"},{"mj","面积"},{"jsqk","建设情况"},{"dfccqk","地方查处情况"},{"wfwglx","违法违规类型"},{"sfwf","是否违法"},{"wflx","违法类型"},{"xcqkms","现场情况描述"}};
	private String form_name = "DC_YDQKDCB";
	
	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new TreeMap<String, TRBean>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		if(obj.length > 0){
			queryMap = (Map<String, Object>)obj[0];
		}
		TRBean titleBean = getTitle();
		List<TRBean> trbeanList = getBody(queryMap);
		trbeans.put("01", titleBean);
        for(int i=0;i<trbeanList.size();i++){
            trbeans.put(i+"2", trbeanList.get(i));
        }  
		return trbeans;
	}
	
	private TRBean getTitle(){
		TRBean titleBean = new TRBean();
		titleBean.setCssStyle("title");
		for(int i = 0; i < showList.length; i++){
			TDBean tdBean =new TDBean(showList[i][1],"120","20");
			titleBean.addTDBean(tdBean);
		}
		return titleBean;
	}
	
	private List<TRBean> getBody(Map queryMap){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select ");
		for(int i = 0; i < showList.length - 1; i++){
			sqlBuffer.append("t.").append(showList[i][0]).append(",");
		}
		sqlBuffer.append("t.").append(showList[showList.length - 1][0]).append(" from ");
		sqlBuffer.append(form_name).append(" t ");
		if(queryMap != null && !queryMap.isEmpty()){
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		
		for(int num = 0; num < queryList.size(); num++){
			TRBean trBean = new TRBean();
			trBean.setCssStyle("trsingle");
			Map<String, Object> map = queryList.get(num);
			for(int i = 0; i < showList.length; i++){
				String value = String.valueOf(map.get(showList[i][0]));
				if("null".equals(value)){
					value = "";
				}
				TDBean tdBean = new TDBean(value, "120", "20");
				trBean.addTDBean(tdBean);
			}
			list.add(trBean);
		}
		return list;
	}

}
