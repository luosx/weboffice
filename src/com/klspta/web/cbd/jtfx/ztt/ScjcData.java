package com.klspta.web.cbd.jtfx.ztt;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.web.cbd.yzt.utilList.IData;

public class ScjcData extends AbstractBaseBean implements IData{
    private static final String formName = "ZSQK";
    public static List<Map<String, Object>> List;

    @Override
    public List<Map<String, Object>> getAllList(HttpServletRequest request) {
        StringBuffer sql = new StringBuffer();
        sql.append("select * from ").append(formName);
        List<Map<String, Object>> resultList = query(sql.toString(), YW);
        List = resultList;
        return List;
    }

    @Override
    public List<Map<String, Object>> getQuery(HttpServletRequest request) {
        // TODO Auto-generated method stub
        return null;
    }
    
}
