package com.klspta.model.giscomponents.pda.pdastatus;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import com.klspta.base.AbstractBaseBean;


/**
 * 
 * <br>Title:PDAStatusList
 * <br>Description:PDAStatusList
 * <br>Author:王雷
 * <br>Date:2012-2-7
 */
public class PDAStatusList extends AbstractBaseBean{
    /**
     * 
     * <br>Description:获取PDA状态列表
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
    public String getPDAStatusList() {
        //JdbcTemplate jt =Globals.getYwJdbcTemplate();
        String sql = "select * from wy_pda_location t";
        List<Map<String,Object>> rows = query(sql,YW);
        List<List<Object>> allRows = new ArrayList<List<Object>>();
        for (int i = 0; i < rows.size(); i++) {
            List<Object> oneRow = new ArrayList<Object>();
            Map<String,Object> map = (Map<String,Object>) rows.get(i);
            oneRow.add(map.get("pda_id"));
            oneRow.add(map.get("pda_name"));
            oneRow.add(map.get("pda_type"));
            oneRow.add(map.get("pda_unit"));
            oneRow.add(map.get("pda_person"));
            oneRow.add(map.get("pda_person_phone"));
            oneRow.add(map.get("pda_phone"));
            oneRow.add(i);
            oneRow.add(map.get("pda_id"));
            allRows.add(oneRow);
        }
        return JSONArray.fromObject(allRows).toString();
    }
}
