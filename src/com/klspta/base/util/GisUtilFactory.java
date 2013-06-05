package com.klspta.base.util;

import com.klspta.base.util.api.IGisBaseUtil;
import com.klspta.base.util.api.IGisExpandUtil;

/**
 * 
 * <br>Title:工具工厂类
 * <br>Description:GIS工具类实例均通过此工厂获取
 * <br>Author:陈强峰
 * <br>Date:2013-6-5
 */
public class GisUtilFactory {

    /**
     * 
     * <br>Description:私有化
     * <br>Author:陈强峰
     * <br>Date:2013-6-5
     */
    private GisUtilFactory() {
    }

    /**
     * <br>Description:获取GIS工具
     * <br>Author:陈强峰
     * <br>Date:2013-6-5
     * @return
     */
    public static IGisBaseUtil getGisBaseUtil() {
        return UtilFactory.getGisBaseUtil();
    }

    /**
     * <br>Description:GIS扩展工具
     * <br>Author:陈强峰
     * <br>Date:2013-6-5
     * @return
     */
    public static IGisExpandUtil getCoordinateEncryptUtil() {
        return UtilFactory.getGisExpandUtil();
    }
}
