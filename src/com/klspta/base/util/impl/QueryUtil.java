package com.klspta.base.util.impl;

import java.util.List;

import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IQueryUtil;

/**
 * 
 * <br>Title:模糊查询
 * <br>Description:模糊查询公共类
 * <br>Author:王雷
 * <br>Date:2011-5-6
 */
public class QueryUtil implements IQueryUtil {
    private static QueryUtil instance;

    private QueryUtil() {

    }

    public static IQueryUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            return new QueryUtil();
        } else {
            return instance;
        }
    }

    /**
     * 
     * <br>Description:根据传入的参数list和strColumnName返回where条件语句
     * <br>Author:王雷
     * <br>Date:2011-5-6
     * @param list
     * @param strColumnName
     * @return
     */
    public String queryForWhere(List<String> list, String strColumnName) {
        String condition = null;
        String accord = null;
        String where = "";
        if (list != null && list.size() > 0) {
            condition = (String) list.get(0);
            accord = (String) list.get(1);
        }
        if (condition != null && condition.length() > 0) {
            condition = condition.trim();
            while (condition.indexOf("  ") > 0) {//循环去掉多个空格，所有字符中间只用一个空格间隔
                condition = condition.replace("  ", " ");
            }
            condition = UtilFactory.getStrUtil().unescape(condition);
            condition = condition.toUpperCase();
            if (accord != null && "true".equals(accord)) {
                where += " and (" + strColumnName + " like '%"
                        + (condition.replaceAll(" ", "%' and " + strColumnName + "  like '%")) + "%')";//查询条件
            } else {
                where += " and (" + strColumnName + "  like '%"
                        + (condition.replaceAll(" ", "%' or " + strColumnName + "  like '%")) + "%')";//查询条件
            }
        }
        return where;
    }
}
