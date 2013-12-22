package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class ZjglData extends AbstractBaseBean {

    public List<Map<String, Object>> getZJGL_ZJLR(String yw_guid) {
        String sql = "select * from  XMZJGL_lr where  yw_guid=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { yw_guid });
        return list;
    }

    public List<Map<String, Object>> getZJGL_father(String yw_guid, String type) {
        String sql = "select * from  XMZJGL_ZC where status=? and yw_guid=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { type, yw_guid });
        return list;
    }

    public List<Map<String, Object>> getZJGL_child(String yw_guid, String tree_name, String type) {
        String sql = "select * from  XMZJGL_ZC where status=? and yw_guid=? and lb=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { type, yw_guid, tree_name });
        return list;
    }
}
