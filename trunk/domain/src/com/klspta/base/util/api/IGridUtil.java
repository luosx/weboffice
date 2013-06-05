package com.klspta.base.util.api;

import com.klspta.base.wkt.Point;




public interface IGridUtil {
/**
 * <br>Description:根据传入的坐标，返回网格处理过的point
 * <br>Author:郭润沛
 * <br>Date:2012-11-15
 * @param point
 * @return
 */
public Point changePoint(Point p);
}
