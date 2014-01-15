package com.klspta.web.cbd.yzt.kgzb;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class KgzbManager extends AbstractBaseBean{

	public void getQyList(String qyName,String dqyName){
		String sql="Select *  from dcsjk_kgzb where qy=? and dqy=?";
		List<Map<String, Object>> list = query(sql, YW,new Object[]{qyName,dqyName});
		
		
	}
	
	public void delet(){
    String yw_guid=  request.getParameter("yw_guid");		
    String type=  request.getParameter("type");		
    type= UtilFactory.getStrUtil().unescape(type);
	String delet="delete dcsjk_kgzb where yw_guid=? and dqy=? ";	
	int i = update(delet, YW,new Object[]{yw_guid,type});
	if(i==1){
		response("success");
	}

	}
	
	public void quey(){
	    String yw_guid=  request.getParameter("yw_guid");		
	    String type=  request.getParameter("type");		
	    type= UtilFactory.getStrUtil().unescape(type);
		String quey="select * from dcsjk_kgzb where yw_guid=? and dqy=? ";	
		List<Map<String, Object>> query = query(quey, YW,new Object[]{yw_guid,type});
	    response(query);

		}	
	
	
	
}
