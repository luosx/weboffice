package com.klspta.web.cbd.dtjc.jcmx;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class PtzzgmlMXOneData extends AbstractBaseBean {
	
	public void getCL(){
		String sql = "select * from GML_PARAMETER_CL";
		List<Map<String,Object>> list = query(sql, YW);
		response(list);
	}
	
	public void getBL(){
		String sql = "select * from GML_PARAMETER_BL";
		List<Map<String,Object>> list = query(sql, YW);
		response(list);
	}
}
