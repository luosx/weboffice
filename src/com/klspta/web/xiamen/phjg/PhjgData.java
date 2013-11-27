package com.klspta.web.xiamen.phjg;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class PhjgData extends AbstractBaseBean implements IphjgData {
	private String FORM_NAME = "PHJG_LXB";
	
	public PhjgData(String fORMNAME) {
		super();
		this.FORM_NAME = fORMNAME;
	}

	public PhjgData() {
		super();
	}

	@Override
	public List<Map<String, Object>> getList(String where) {
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.* from ").append(FORM_NAME).append(" t ");
		if(where != null){
			sqlBuffer.append(where);
		}
		sqlBuffer.append(" order by t.ydsj");
		List<Map<String, Object>> getList = query(sqlBuffer.toString(), YW);
		return getList;
	}

}
