package com.klspta.web.cbd.dtjc.jcmx;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class PtzzgmlMXOneClReport extends AbstractBaseBean implements IDataClass{

	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
		List<Map<String,Object>> CLlist = getGMLCL();
		if(CLlist.size()>0){
			trbeans.put("cl", buildTitle());
			buildGMLCL(trbeans,CLlist);
		}
		return trbeans;
	}

	private void buildGMLCL(Map<String, TRBean> trbeans,
			List<Map<String, Object>> llist) {
		TRBean trbean = new TRBean();
		trbean.setCssStyle("tr02");
		TDBean tdbean = new TDBean("装修及置物比例","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("ZXJZWBL").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("契税、印花税","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("QSYHS").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("营业税","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("YYS").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("手续费","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("SXF").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("中介费","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("ZJF").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("借款还款期限","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("JKHKQX").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("公积金贷款最高额度","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("GJJDKZGED").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("贷款年限年龄要求上限","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("DKNXNLYQSX").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("月缴存公积金比例","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("YJCGJJBL").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("贷款最高年限","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("DKZGNX").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("公积金贷款利率","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("GJJDKLL").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("商业贷款基准利率","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("SYDKJZL").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
		trbean = new TRBean();
		trbean.setCssStyle("tr02");
		tdbean = new TDBean("商业贷款利率浮点","150","");
		trbean.addTDBean(tdbean);
		tdbean = new TDBean(llist.get(0).get("SYDKLLFD").toString(),"150","");
		trbean.addTDBean(tdbean);
		trbeans.put("gmlcl", trbean);
		
	}

	private TRBean buildTitle(){
		TRBean trbean = new TRBean();
		trbean.setCssStyle("tr01");
		TDBean tdbean = new TDBean("购房常规涉及参数（常量）","300","");
		tdbean.setColspan("2");
		trbean.addTDBean(tdbean);
		return trbean;
	}
	
	private List<Map<String,Object>> getGMLCL(){
		List<Map<String,Object>> result = null;
		String sql = "select * from zfjc.GML_PARAMETER_CL";
		result = query(sql,YW);
		return result;
	}
	
}
