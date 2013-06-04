package com.klspta.model.giscomponents.pda.pdalist;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:PDA列表
 * <br>Description:PDA列表
 * <br>Author:王雷
 * <br>Date:2011-5-9
 */
public class PDAList extends AbstractBaseBean{
    /**
     * 
     * <br>Description:呈现PDA信息
     * <br>Author:王雷
     * <br>Date:2011-5-9
     * @param list
     * @return
     */
	public String getPDAList(List<String> list) {
    	String strColumnName ="t.pda_id||t.pda_name||t.pda_type||t.pda_unit||t.pda_person||t.pda_person_phone||t.pda_phone";
        String where=UtilFactory.getQueryUtil().queryForWhere(list, strColumnName);
        String condition=null;
        if(list!=null&&list.size()>0){
            condition=(String)list.get(0);
        }
		//JdbcTemplate jt = Globals.getYwJdbcTemplate();
		String sql = "select t.pda_id,t.pda_name,t.pda_type,t.pda_unit,t.pda_person,t.pda_person_phone,t.pda_phone from WY_PDA_INFO t";
		sql+=where;
		List<Map<String,Object>> rows = query(sql,YW);
		List<List<Object>> allRows = new ArrayList<List<Object>>();
		for (int i = 0; i < rows.size(); i++) {
			List<Object> oneRow = new ArrayList<Object>();
			Map<String,Object> map = (Map<String,Object>) rows.get(i);
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_id"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_name"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_type"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_unit"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_person"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_person_phone"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_phone"), condition));
			oneRow.add(i);
			oneRow.add(i);
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_cantoncode"), condition));
			allRows.add(oneRow);
		}
		return JSONArray.fromObject(allRows).toString();
	}

}
