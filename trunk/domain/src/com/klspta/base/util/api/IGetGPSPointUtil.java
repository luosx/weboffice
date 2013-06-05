package com.klspta.base.util.api;

/**
 * <br>Title:GPS端口控制
 * <br>Description:控制GPS开关和获取80点数据
 * <br>Author:陈强峰
 * <br>Date:2013-6-5
 */
public interface IGetGPSPointUtil {
    public String[] getXY();
    public boolean openCOM();
    public void closeCOM();
    public String direction ();
    public String speed();
}
