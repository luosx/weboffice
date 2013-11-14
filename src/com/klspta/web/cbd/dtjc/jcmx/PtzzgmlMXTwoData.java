package com.klspta.web.cbd.dtjc.jcmx;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class PtzzgmlMXTwoData extends AbstractBaseBean{
	
	/*
	 * 
	 */
	public void getGMLData_CL(){
		String sql = "select * from zfjc.gmlmx1_parameter";
		List<Map<String,Object>> result = query(sql, YW);
		response(result);
	}
}