package com.klspta.web.cbd.dtjc.kfgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class XmgljgManager extends AbstractBaseBean{

	public List<Map<String,Object>> getXmgljg(){
		List<Map<String,Object>> result = null;
		String sql = "select rownum as xh ,to_char(t.sj,'yyyy-MM-dd') as sj,t.event,t.department,t.remark from xmbljg t";
		result = query(sql, YW);
		return result;
	}
}
