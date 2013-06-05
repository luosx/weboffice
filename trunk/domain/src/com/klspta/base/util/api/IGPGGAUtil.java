/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import com.klspta.base.wkt.Point;

/**
 * <br>Title:GPGG工具
 * <br>Description:GPGGA信息处理
 * <br>Author:陈强峰
 * <br>Date:2013-6-5
 */
public interface IGPGGAUtil {
	
	void setGPGGA(String gpgga);
	
	void isFix(boolean isfix);

    Point getPoint84();
    
    Point getPoint80();
}
