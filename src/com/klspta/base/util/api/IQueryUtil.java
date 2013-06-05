package com.klspta.base.util.api;

import java.util.List;

public interface IQueryUtil {

    /**
     * 
     * <br>Description:根据传入的参数list和strColumnName返回where条件语句
     * <br>Author:王雷
     * <br>Date:2011-5-6
     * @param list
     * @param strColumnName
     * @return
     */
    public abstract String queryForWhere(List<String> list, String strColumnName);

}