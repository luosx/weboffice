package com.klspta.base.util.api;

import java.util.Date;

/**
 * <br>Title:日期操作工具
 * <br>Description:
 * <br>Author:郭润沛
 * <br>Date:2011-5-31
 */
public interface IDateUtil {
    /**
     * <br>Description:获取中文日期xxxx年xx月xx日，用于数据库中日期转换
     * <br>Author:郭润沛
     * <br>Date:2011-5-31
     * @param d
     * @return
     */
    public String getChineseDate(Date d);
    /**
     * <br>Description:获取当前中文日期xxxx年xx月xx日
     * <br>Author:郭润沛
     * <br>Date:2011-7-21
     * @return
     */
    public String getCurrentChineseDate() ;
    
    /**
     * 
     * <br>Description:获取普通日期格式yyyy-MM-dd
     * <br>Author:黎春行
     * <br>Date:2012-8-31
     * @return
     */
    public String getSimpleDate(Date d);
    
}
