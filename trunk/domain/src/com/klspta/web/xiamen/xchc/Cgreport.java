package com.klspta.web.xiamen.xchc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.lang.ObjectUtils.Null;
import org.geotools.filter.IsBetweenImpl;
import org.hibernate.annotations.SQLUpdate;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class Cgreport extends AbstractBaseBean implements IDataClass {
	
	public static String[][] showList = new String[][]{{"xmmc", "项目名称"},{"YDDW","用地单位"},{"hcrq","用地时间"},{"tdyt","土地用途"},{"jsqk","建设情况"},{"ydqk","用地情况"},{"dfccqk","地方查处情况"},{"wfwglx","违法违规类型"},{"spxmmc","审批项目名称"},{"spwh","审批文号"},{"gdxmmc","供地项目名称"},{"gdwh","供地文号"}};
	private String form_name = "DC_YDQKDCB";
	
	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new TreeMap<String, TRBean>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap = (Map<String, Object>)obj[0];
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
		if(queryMap != null){
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		
		for(int num = 0; num < queryList.size(); num++){
			TRBean trBean = new TRBean();
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
