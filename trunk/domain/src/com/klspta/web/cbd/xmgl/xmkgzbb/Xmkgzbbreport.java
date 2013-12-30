package com.klspta.web.cbd.xmgl.xmkgzbb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class Xmkgzbbreport extends AbstractBaseBean implements IDataClass {
	public static String[][] showList = new String[][]{{"ROWNUM","序号"},{"DKBH","地块编号"},{"YDXZDH","用地性质代号"},{"YDXZ","用地性质"},{"YDMJ","用地面积"},{"RJL","容积率"},{"JZMJ","建筑面积"},{"KZGD","控制高度"},{"BZ","备注"},{"YDXZLX","用地性质类型"}};
	private String form_name = "XMKGZBB";
	
	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new TreeMap<String, TRBean>();
		Map<String, String> queryMap = new HashMap<String, String>();
		if(obj.length > 0){
			queryMap = (Map<String, String>)obj[0];
		}
		List<TRBean> trbeanList = getBody(queryMap);
        for(int i=0;i<trbeanList.size();i++){
        	String key = String.valueOf(i);
        	if(key.length() == 1){
        		key = "0" + key;
        	}
            trbeans.put(key, trbeanList.get(i));
        }  
		return trbeans;
	}
	
	
	private List<TRBean> getBody(Map queryMap){
		StringBuffer sqlBuffer = new StringBuffer();
		//String yw_guid = request.getParameter("yw_guid");
		sqlBuffer.append("select rownum,t.dkbh, t.ydxzdh, t.ydxz, t.ydmj, t.rjl, t.jzmj, t.kzgd, t.bz,t.ydxzlx from  ");
		sqlBuffer.append(form_name).append(" t ");

		if(queryMap != null && !queryMap.isEmpty()){ 
			sqlBuffer.append(" where ");
			sqlBuffer.append(String.valueOf(queryMap.get("query")));
		}
		
		List<Map<String, Object>> queryList = query(sqlBuffer.toString(), YW);
		List<TRBean> list = new ArrayList<TRBean>();
		double ydmj_jyxjsyd = 0;
		double jzmj_jyxjsyd = 0;
		double ydmj_fjyxjsyd = 0;
		double jzmj_fjyxjsyd = 0;
		double ydmj_dzldjsy = 0;
		double jzmj_dzldjsy = 0;
		double ydmj_dzdl = 0;
		double jzmj_dzdl = 0;
		boolean isnull = true;
		
		for(int num=0;num<queryList.size();num++){
			Map<String, Object> map = queryList.get(num);
			String ydxzlx =String.valueOf(map.get("ydxzlx"));
			if(ydxzlx.equals("1")){
				ydmj_jyxjsyd+=Double.valueOf(String.valueOf( map.get("ydmj"))).intValue();
				jzmj_jyxjsyd+=Double.valueOf(String.valueOf( map.get("jzmj"))).intValue();
				isnull = false;
				
				TRBean trBean = new TRBean();
				trBean.setCssStyle("trsingle");
					for(int i = 0; i < showList.length-1; i++){
						String value = String.valueOf(map.get(showList[i][0]));
						if("null".equals(value)){
							value = "";
						}
						String width = "";
						TDBean tdBean;
						if(i==2){
							width ="30px";
						}else if(3 == i){
							width = "130px";
						}
						tdBean = new TDBean(value, width, "","");
						trBean.addTDBean(tdBean);
					}
					if(isnull){
						for(int i = 0; i < showList.length-1; i++){
							String value = "";
							
							String width = "";
							TDBean tdBean;
							if(i==2){
								width ="30px";
							}else if(3 == i){
								width = "130px";
							}
							tdBean = new TDBean(value, width, "","");
							trBean.addTDBean(tdBean);
						}
					}
				list.add(trBean);
			}
			
		}
		
		
		if(isnull){
			TRBean trBean = new TRBean();
			trBean.setCssStyle("trsingle");
			for(int i = 0; i < showList.length-1; i++){
				String value = "";
				
				String width = "";
				TDBean tdBean;
				if(i==2){
					width ="30px";
				}else if(3 == i){
					width = "130px";
				}
				tdBean = new TDBean(value, width, "","");
				trBean.addTDBean(tdBean);
			}
			list.add(trBean);
		}
		
		
		TRBean trBean_jyxjsyd = new TRBean();
		trBean_jyxjsyd.setCssStyle("title");
		TDBean tdname11=new TDBean("经营性建设用地小计","","");
		tdname11.setColspan("4");
		trBean_jyxjsyd.addTDBean(tdname11);
		
		TDBean tdname12=new TDBean(""+ydmj_jyxjsyd,"","");
		trBean_jyxjsyd.addTDBean(tdname12);
		
		TDBean tdname13=new TDBean(ydmj_jyxjsyd!=0?String.format("%.2f", jzmj_jyxjsyd/ydmj_jyxjsyd):"0","","");
		trBean_jyxjsyd.addTDBean(tdname13);
		
		TDBean tdname14=new TDBean(""+jzmj_jyxjsyd,"","");
		trBean_jyxjsyd.addTDBean(tdname14);
		
		TDBean tdname15=new TDBean("","","");
		trBean_jyxjsyd.addTDBean(tdname15);
		trBean_jyxjsyd.addTDBean(tdname15);
		
		list.add(trBean_jyxjsyd);
		
		for(int num=0;num<queryList.size();num++){
			Map<String, Object> map = queryList.get(num);
			String ydxzlx =String.valueOf(map.get("ydxzlx"));
			if(ydxzlx.equals("2")){
				ydmj_fjyxjsyd+=Double.valueOf(String.valueOf( map.get("ydmj"))).intValue();
				jzmj_fjyxjsyd+=Double.valueOf(String.valueOf( map.get("jzmj"))).intValue();
				
				TRBean trBean = new TRBean();
				trBean.setCssStyle("trsingle");
					for(int i = 0; i < showList.length-1; i++){
						String value = String.valueOf(map.get(showList[i][0]));
						if("null".equals(value)){
							value = "";
						}
						String width = "";
						TDBean tdBean;
						if(i==2){
							width ="20";
						}
						tdBean = new TDBean(value, width, "","");
						trBean.addTDBean(tdBean);
					}
				list.add(trBean);
			}
			
		}
		TRBean trBean_fjyxjsyd = new TRBean();
		trBean_fjyxjsyd.setCssStyle("title");
		TDBean tdname21=new TDBean("非经营性建设用地小计","","");
		tdname21.setColspan("4");
		trBean_fjyxjsyd.addTDBean(tdname21);
		
		TDBean tdname22=new TDBean(""+ydmj_fjyxjsyd,"","");
		trBean_fjyxjsyd.addTDBean(tdname22);
		
		TDBean tdname23=new TDBean(ydmj_fjyxjsyd!=0?String.format("%.2f", jzmj_fjyxjsyd/ydmj_fjyxjsyd):"0","","");
		trBean_fjyxjsyd.addTDBean(tdname23);
		
		TDBean tdname24=new TDBean(""+jzmj_fjyxjsyd,"","");
		trBean_fjyxjsyd.addTDBean(tdname24);
		
		TDBean tdname25=new TDBean("","","");
		trBean_fjyxjsyd.addTDBean(tdname25);
		trBean_fjyxjsyd.addTDBean(tdname25);
		
		list.add(trBean_fjyxjsyd);
		
		TRBean trBean_jsyd = new TRBean();
		trBean_jsyd.setCssStyle("title");
		TDBean tdname31=new TDBean("建设用地小计","","");
		tdname31.setColspan("4");
		trBean_jsyd.addTDBean(tdname31);
		
		TDBean tdname32=new TDBean(""+(ydmj_fjyxjsyd+ydmj_jyxjsyd),"","");
		trBean_jsyd.addTDBean(tdname32);
		
		TDBean tdname33=new TDBean((ydmj_fjyxjsyd+ydmj_jyxjsyd)!=0?String.format("%.2f", (jzmj_fjyxjsyd+jzmj_jyxjsyd)/(ydmj_fjyxjsyd+ydmj_jyxjsyd)):"0","","");
		trBean_jsyd.addTDBean(tdname33);
		
		TDBean tdname34=new TDBean(""+(jzmj_fjyxjsyd+jzmj_jyxjsyd),"","");
		trBean_jsyd.addTDBean(tdname34);
		
		TDBean tdname35=new TDBean("","","");
		trBean_jsyd.addTDBean(tdname35);
		trBean_jsyd.addTDBean(tdname35);
		
		list.add(trBean_jsyd);
		
		for(int num=0;num<queryList.size();num++){
			Map<String, Object> map = queryList.get(num);
			String ydxzlx =String.valueOf(map.get("ydxzlx"));
			if(ydxzlx.equals("3")){
				ydmj_dzldjsy+=Double.valueOf(String.valueOf( map.get("ydmj"))).intValue();
				jzmj_dzldjsy+=Double.valueOf(String.valueOf( map.get("jzmj"))).intValue();
				
				TRBean trBean = new TRBean();
				trBean.setCssStyle("trsingle");
					for(int i = 0; i < showList.length-1; i++){
						String value = String.valueOf(map.get(showList[i][0]));
						if("null".equals(value)){
							value = "";
						}
						String width = "";
						TDBean tdBean;
						if(i==2){
							width ="20";
						}
						tdBean = new TDBean(value, width, "","");
						trBean.addTDBean(tdBean);
					}
				list.add(trBean);
			}
			
		}
		
		TRBean trBean_dzldjsy = new TRBean();
		trBean_dzldjsy.setCssStyle("trsingle");
		TDBean tdname41=new TDBean("代征绿地及水域","","");
		tdname41.setColspan("4");
		trBean_dzldjsy.addTDBean(tdname41);
		
		TDBean tdname42=new TDBean(""+ydmj_dzldjsy,"","");
		trBean_dzldjsy.addTDBean(tdname42);
		
		TDBean tdname43=new TDBean("--","","");
		trBean_dzldjsy.addTDBean(tdname43);
		
		TDBean tdname44=new TDBean(""+jzmj_dzldjsy,"","");
		trBean_dzldjsy.addTDBean(tdname44);
		
		TDBean tdname45=new TDBean("","","");
		trBean_dzldjsy.addTDBean(tdname45);
		trBean_dzldjsy.addTDBean(tdname45);
		
		list.add(trBean_dzldjsy);
		
		for(int num=0;num<queryList.size();num++){
			Map<String, Object> map = queryList.get(num);
			String ydxzlx =String.valueOf(map.get("ydxzlx"));
			if(ydxzlx.equals("4")){
				ydmj_dzdl+=Double.valueOf(String.valueOf( map.get("ydmj"))).intValue();
				jzmj_dzdl+=Double.valueOf(String.valueOf( map.get("jzmj"))).intValue();
				
				TRBean trBean = new TRBean();
				trBean.setCssStyle("trsingle");
					for(int i = 0; i < showList.length-1; i++){
						String value = String.valueOf(map.get(showList[i][0]));
						if("null".equals(value)){
							value = "";
						}
						String width = "";
						TDBean tdBean;
						if(i==2){
							width ="20";
						}
						tdBean = new TDBean(value, width, "","");
						trBean.addTDBean(tdBean);
					}
				list.add(trBean);
			}
			
		}
		TRBean trBean_dzdl = new TRBean();
		trBean_dzdl.setCssStyle("trsingle");
		TDBean tdname51=new TDBean("代征道路","","");
		tdname51.setColspan("4");
		trBean_dzdl.addTDBean(tdname51);
		
		TDBean tdname52=new TDBean(""+ydmj_dzdl,"","");
		trBean_dzdl.addTDBean(tdname52);
		
		TDBean tdname53=new TDBean("--","","");
		trBean_dzdl.addTDBean(tdname53);
		
		TDBean tdname54=new TDBean(""+jzmj_dzdl,"","");
		trBean_dzdl.addTDBean(tdname54);
		
		TDBean tdname55=new TDBean("","","");
		trBean_dzdl.addTDBean(tdname55);
		trBean_dzdl.addTDBean(tdname55);
		
		list.add(trBean_dzdl);
		
		TRBean trBean_dzd = new TRBean();
		trBean_dzd.setCssStyle("title");
		TDBean tdname61=new TDBean("代征地小计","","");
		tdname61.setColspan("4");
		trBean_dzd.addTDBean(tdname61);
		
		TDBean tdname62=new TDBean(""+(ydmj_dzdl+ydmj_dzldjsy),"","");
		trBean_dzd.addTDBean(tdname62);
		
		TDBean tdname63=new TDBean("--","","");
		trBean_dzd.addTDBean(tdname63);
		
		TDBean tdname64=new TDBean(""+(jzmj_dzdl+jzmj_dzldjsy),"","");
		trBean_dzd.addTDBean(tdname64);
		
		TDBean tdname65=new TDBean("","","");
		trBean_dzd.addTDBean(tdname65);
		trBean_dzd.addTDBean(tdname65);
		
		list.add(trBean_dzd);
		
		TRBean trBean_zj = new TRBean();
		trBean_zj.setCssStyle("title");
		TDBean tdname71=new TDBean("总计","","");
		tdname71.setColspan("4");
		trBean_zj.addTDBean(tdname71);
		
		TDBean tdname72=new TDBean(""+(ydmj_jyxjsyd+ydmj_fjyxjsyd+ydmj_dzldjsy+ydmj_dzdl),"","");
		trBean_zj.addTDBean(tdname72);
		
		TDBean tdname73=new TDBean((ydmj_jyxjsyd+ydmj_fjyxjsyd+ydmj_dzldjsy+ydmj_dzdl)!=0?String.format("%.2f", (jzmj_jyxjsyd+jzmj_fjyxjsyd+jzmj_dzldjsy+jzmj_dzdl)/(ydmj_jyxjsyd+ydmj_fjyxjsyd+ydmj_dzldjsy+ydmj_dzdl)):"0","","");
		trBean_zj.addTDBean(tdname73);
		
		TDBean tdname74=new TDBean(""+(jzmj_jyxjsyd+jzmj_fjyxjsyd+jzmj_dzldjsy+jzmj_dzdl),"","");
		trBean_zj.addTDBean(tdname74);
		
		TDBean tdname75=new TDBean("","","");
		trBean_zj.addTDBean(tdname75);
		trBean_zj.addTDBean(tdname75);
		
		list.add(trBean_zj);
		return list;
	}

}
