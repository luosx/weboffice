/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import com.klspta.base.wkt.Point;

public interface IChangeCoordsSysUtil {
    
    static final String GPS84_TO_BALIN80 = "GPS84_3212.34567,12012.34567 PLAIN80_40345678.90,4034567.89";
    static final String BL84_TO_BL80 = "BL84_32.1234567,120.1234567";
    static final String BL80_TO_PLAIN80 = "BL80_32.1234567,120.1234567 PLAIN80_40345678.90,4034567.89";
    static final String PLAIN80_TO_BL80 = "PLAIN80_40345678.90,4034567.89";
    static final String PLAIN84_TO_PLAIN80="PLAIN84_ PLAIN80_40345678.90,4034567.89";
    static final String GRID="GRID";//格网法坐标偏移
    /**
     * <br>Description:坐标转换
     * <br>Author:郭润沛
     * <br>Date:2012-4-2
     * @param point
     * @param fromCoordinate：转换前坐标参考
     * @param toCoordinate：转换后坐标参考
     * @return
     */
    Point changeMe(Point point,String changetype);
}
