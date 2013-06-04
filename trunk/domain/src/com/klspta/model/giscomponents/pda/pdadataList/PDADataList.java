package com.klspta.model.giscomponents.pda.pdadataList;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:PDA发回外业核查
 * <br>Description:PDA发回外业核查列表
 * <br>Author:王雷
 * <br>Date:2011-5-9
 */
public class PDADataList extends AbstractBaseBean{
    /**
     * 
     * <br>Description:呈现PDA发回外业核查成果
     * <br>Author:王雷
     * <br>Date:2011-5-9
     * @param list
     * @return
     */
	public String getPDADataList(List<String> list) {
		String strColumnName ="t.dataid||t.pda_name||t.pda_unit||t.datatype||t.cantonname";
        String where=UtilFactory.getQueryUtil().queryForWhere(list, strColumnName);
        String condition=null;
        if(list!=null&&list.size()>0){
            condition=(String)list.get(0);
        }
		String sql = "select t.pdaid,t.dataid,t.pda_name,t.pda_unit,t.datatime,t.datatype,t.cantonname from V_PDA_DATA t where 1=1";
		sql+=where;
		List<Map<String,Object>> rows = query(sql,YW);
		List<List<Object>> allRows = new ArrayList<List<Object>>();
		for (int i = 0; i < rows.size(); i++) {
			List<Object> oneRow = new ArrayList<Object>();
			Map<String,Object> map = (Map<String,Object>) rows.get(i);
			oneRow.add(i+1);
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pdaid"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_name"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("pda_unit"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("datatime"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("datatype"), condition));
			oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String)map.get("cantonname"), condition));
			oneRow.add(i);
			oneRow.add(i);
			oneRow.add(i);
			oneRow.add(map.get("pda_id"));
			oneRow.add(map.get("dataid"));
			allRows.add(oneRow);
		}
		return JSONArray.fromObject(allRows).toString();
	}
	/**
	 * 
	 * <br>Description:简单格式
	 * <br>Author:郭润沛
	 * <br>Date:2011-3-17
	 * @return
	 */
    public String getSimplePDADataList() {
        String sql = "select t.* from V_PDA_DATA t";
        List<Map<String,Object>> rows = query(sql,YW);
        List<List<Object>> allRows = new ArrayList<List<Object>>();
        for (int i = 0; i < rows.size(); i++) {
            List<Object> oneRow = new ArrayList<Object>();
            Map<String,Object> map = (Map<String,Object>) rows.get(i);
            oneRow.add(i+1);
            oneRow.add(map.get("pda_name"));
            oneRow.add(map.get("datatime"));
            oneRow.add(map.get("datatype"));
            oneRow.add(i);
            oneRow.add(map.get("pda_id"));
            oneRow.add(map.get("dataid"));
            allRows.add(oneRow);
        }
        return JSONArray.fromObject(allRows).toString();
    }
}
