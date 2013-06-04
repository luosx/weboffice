package com.klspta.web.xuzhouNW.dtxc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:动态巡查
 * <br>Description:相关操作
 * <br>Author:陈强峰
 * <br>Date:2013-4-9
 */
public class DtxcManager extends AbstractBaseBean{
    
    /**
     * 
     * <br>Description:查询回传内容能
     * <br>Author:陈强峰
     * <br>Date:2013-4-9
     * @param yw_guid
     * @return
     */
    public Map<String, Object> getXckcqkData(String yw_guid) {
        String sql = "select * from pad_xcxcqkb t where t.yw_guid=?";
        List<Map<String, Object>> result = query(sql, YW,
                new String[] { yw_guid });
        return result.get(0);
    }
}
