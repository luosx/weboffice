/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import com.klspta.base.wkt.Polygon;

public interface IWKTUtil {

    Polygon stringToWKTObject(String string);
}
