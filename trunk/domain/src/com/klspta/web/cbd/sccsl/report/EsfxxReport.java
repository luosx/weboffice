package com.klspta.web.cbd.sccsl.report;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;
import com.klspta.web.cbd.sccsl.EsfzjjcManager;
import com.klspta.web.cbd.sccsl.XzlzjjcManager;

public class EsfxxReport extends AbstractBaseBean implements IDataClass{
	
	private final static String[] TITLE= {"所属区域","序号","小区名称","性质","建设年代","区位","房屋、建筑类型","物业费",
											"楼栋总数","房屋总数","楼层状况","容积率","绿化率","停车位","开发商",
											  "物业公司","地址"};
	
//	所属区域  	序号  	小区名称  	性质 	建设年代  	区位 	房屋、建筑类型	"物业费	(元/平米•月）"
//	"楼栋总数（栋）"	"房屋总数（户）"  	楼层状况                 容积率  	绿化率	  停车位	       开发商	物业公司	地址
	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
		buildTitle(trbeans);
		buildESF(trbeans);
		return trbeans;
	}

	private void buildESF(Map<String, TRBean> trbeans) {
		List<Map<String, Object>> esf = new EsfzjjcManager().getESFData();
		TRBean trbean = null;
		TDBean tdbean = null;
		int i= 0;
		if(esf!=null){
			for(Map<String,Object> map : esf){
				trbean = new TRBean();
				Set<String> keyset = map.keySet();
				for(String key : keyset){
					if("QT".equals(key)){
						tdbean = new TDBean(map.get(key)==null?"":map.get(key).toString(),"300","");
						trbean.addTDBean(tdbean);
					}else{
						tdbean = new TDBean(map.get(key)==null?"":map.get(key).toString(),"120","");
						trbean.addTDBean(tdbean);
					}
				}
				trbeans.put("esf"+i, trbean);
				i++;
			}
		}
	}

	private void buildTitle(Map<String, TRBean> trbeans) {
		TRBean trbean = new TRBean();
		trbean.setCssStyle("tr01");
		TDBean tdBean = null;
		for(String name : TITLE){
			tdBean = new TDBean(name, "120", "");
			tdBean.setRowspan("2");
			trbean.addTDBean(tdBean);
		}
	}
	
}
