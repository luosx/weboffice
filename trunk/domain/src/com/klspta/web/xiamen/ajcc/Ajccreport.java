package com.klspta.web.xiamen.ajcc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class Ajccreport extends AbstractBaseBean implements IDataClass {
	
	public static String[][] showList = new String[][]{{"XH","序号"},{"YDXMMC","用地项目名称"},{"YDZT","用地主体"},{"ZDMJ","占地面积"},{"JZMJ","建筑面积"},{"JZXZ","建筑现状"},{"YT","用途"},{"SFFHTDLYZTGH","是否符合土地利用总体规划"},{"FXSJ","发现时间"},{"WFLX","违法类型"},{"ZZQK","制止情况"},{"ZZTZSBH","制止通知书编号"},{"WJZZHJXZZ","违建制止后继续制止"},{"YYDSPQCZ","有用地审批且超占"}};
	private String form_name = "AJCCQD";
	
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
