package com.klspta.web.xiamen.phjg;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class PhjgData extends AbstractBaseBean implements IphjgData {
	private String FORM_NAME = "V_PHJG_DATA";
	
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
		sqlBuffer.append("select t.* from ").append(FORM_NAME).append(" t where 1=1 ");
		if(where != null){
		    where = UtilFactory.getStrUtil().unescape(where);
		    sqlBuffer.append("and t.XMBH||t.XMMC||t.YDDWMC||t.AREA||t.YWLX||t.用地主体||t.发现时间||t.SZFPW||t.PZRQ like '%"+where+"%'");
		}
		sqlBuffer.append("order by t.发现时间");
		List<Map<String, Object>> getList = query(sqlBuffer.toString(), YW);
		Map<String,Object> map = null;
		for(int i=0;i<getList.size();i++){
		    map = getList.get(i);
		    Set<Entry<String,Object>> set = map.entrySet();
		    for(Iterator<Entry<String,Object>> it = set.iterator();it.hasNext();){
		        Entry<String,Object> entry = it.next();
		        if(entry.getValue()==null || "null".equals(entry.getValue())){
		            map.put(entry.getKey(), "");
		        }
		    }
		}
		getList.add(map);
		return getList;
	}

}
