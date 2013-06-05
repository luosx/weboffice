package com.klspta.base.util.api;

/**
 * <br>Title:GIS功能扩展工具类
 * <br>Description:1.java调用DLL动态链接库，实现坐标的加密解密，此dll由【国土资源部信息中心】提供
 * 请将dll文件 放到服务器的system32下，并用regsvr32命令进行注册
 * <br>Author:陈强峰
 * <br>Date:2013-6-5
 */
public interface ICoordinateEncryptUtil {
    /**
     * <br>Description:对x、y坐标进行加密，返回加密后字符串
     * <br>Author:郭润沛
     * <br>Date:2011-8-29
     * @param x
     * @param y
     * @return
     */
    public String GetEncryptData(double x, double y);

    /**
     * <br>Description:对加密坐标串进行解密，返回结果为3500000,40400000
     * <br>Author:郭润沛
     * <br>Date:2011-8-29
     * @param jmzb
     * @return
     */
    public String GetDecryptData(String jmzb);
}
