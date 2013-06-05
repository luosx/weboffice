package com.klspta.base.util.api;

import com.klspta.base.wkt.Point;

/**
 * <br>Title:GIS功能扩展工具类
 * <br>Description:1.java调用DLL动态链接库，实现坐标的加密解密，此dll由【国土资源部信息中心】提供
 * 请将dll文件 放到服务器的system32下，并用regsvr32命令进行注册  2.格网处理点
 * <br>Author:陈强峰
 * <br>Date:2013-6-5
 */
public interface IGisExpandUtil {
    
    /**
     * <br>Description:对x、y坐标进行加密，返回加密后字符串
     * <br>Author:郭润沛
     * <br>Date:2011-8-29
     * @param x
     * @param y
     * @return
     */
    public String GetEncryptData(double x,double y);
    /**
     * <br>Description:对加密坐标串进行解密，返回结果为3500000,40400000
     * <br>Author:郭润沛
     * <br>Date:2011-8-29
     * @param jmzb
     * @return
     */
    public String GetDecryptData(String jmzb);
    
    /**
     * <br>Description:根据传入的坐标，返回网格处理过的point
     * <br>Author:郭润沛
     * <br>Date:2012-11-15
     * @param point
     * @return
     */
    public Point changePoint(Point p);
}
