package com.klspta.model.dc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;


import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:PDA列表
 * <br>Description:PDA列表
 * <br>Author:王雷
 * <br>Date:2011-5-9
 */
public class MarkList extends AbstractBaseBean{
    /**
     * 
     * <br>Description:呈现PDA信息
     * <br>Author:王雷
     * <br>Date:2011-5-9
     * @param list
     * @return
     */
	public String getMarkList(String type) {
		//JdbcTemplate jt = Globals.getYwJdbcTemplate();
		
		if("task".equals(type)){
			String sql="select t.rwmc,t.xh,t.zb from dc_ydqkdcb t where t.status='0'";
			//List<Map<String,Object>> rows = jt.queryForList(sql);
			List<Map<String, Object>> rows = query(sql, YW);
			List<List<Object>> allRows = new ArrayList<List<Object>>();
			for (int i = 0; i < rows.size(); i++) {
				List<Object> oneRow = new ArrayList<Object>();
				Map<String,Object> map = (Map<String,Object>) rows.get(i);
				oneRow.add(i+1);
				oneRow.add((String)map.get("xh"));
				oneRow.add((String)map.get("zb"));
				oneRow.add((String)map.get("rwmc"));
				oneRow.add(i);
				oneRow.add(i);
				allRows.add(oneRow);
			}
			return JSONArray.fromObject(allRows).toString();
		}else{
		String sql = "select zb,xh,rwmc,type,isbeian from dc_ydqkdcb where (status='1' or status='!0!1') and YW_GUID like '%"+type+"%'  order by dateflag desc";
		//List<Map<String,Object>> rows = jt.queryForList(sql);
		List<Map<String, Object>> rows = query(sql, YW);
		List<List<Object>> allRows = new ArrayList<List<Object>>();
		for (int i = 0; i < rows.size(); i++) {
			List<Object> oneRow = new ArrayList<Object>();
			Map<String,Object> map = (Map<String,Object>) rows.get(i);
			oneRow.add(i+1);
			oneRow.add((String)map.get("xh"));
			oneRow.add((String)map.get("rwmc"));
			oneRow.add((String)map.get("isbeian"));
			oneRow.add((String)map.get("zb"));
			oneRow.add(i);
			oneRow.add(i);
			allRows.add(oneRow);
		}
		return JSONArray.fromObject(allRows).toString();
	}
	}

}
