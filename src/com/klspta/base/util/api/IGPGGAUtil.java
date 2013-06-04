/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import com.klspta.base.wkt.Point;

public interface IGPGGAUtil {
	
	void setGPGGA(String gpgga);
	
	void isFix(boolean isfix);

    Point getPoint84();
    
    Point getPoint80();
}
