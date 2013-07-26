package com.klspta.web;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class ExceptionCS  extends AbstractBaseBean{
	public void getData(){
		try {
			int s=1/0;
			
		} catch (Exception e) {
			
			responseException(this, "getData", "100003", e);
		}
		
		
	}
	public void getcar(){
		String sql="select * from car_info";
		List<Map<String, Object>> list = query(sql, YW);
		response("sssss");
	}

}
