package com.klspta.base.util;

import java.util.TimerTask;

import com.klspta.base.util.api.IGPGGAUtil;
import com.klspta.base.util.api.IGisBaseUtil;
import com.klspta.base.util.api.IGisExpandUtil;
import com.klspta.base.util.api.IShapeUtil;

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

    /**
     * <br>Description:shp文件操作工具
     * <br>Author:陈强峰
     * <br>Date:2013-6-5
     * @return
     */
    public static IShapeUtil getShapeUtil() {
        return UtilFactory.getShapeUtil();
    }

    /**
     * <br>Description:获取GPGGA字符串解析工具类实例
     * <br>Author:陈强峰
     * <br>Date:2013-6-5
     * @return
     */
    public static IGPGGAUtil getGPGGAUtil() {
        return UtilFactory.getGPGGAUtil();
    }

    /**
     * <br>Description:获取GPS守护进程工具类实例
     * <br>Author:陈强峰
     * <br>Date:2013-6-5
     * @return
     */
    public static TimerTask getGPSPointUtilTimerTask() {
        return UtilFactory.getGPSPointUtilTimerTask();
    }
}
