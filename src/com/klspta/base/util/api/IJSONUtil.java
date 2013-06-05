/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface IJSONUtil {
      
    String objectToJSON(Object object) throws Exception;

    JSONObject jsonToObject(String json) throws Exception;

    JSONArray jsonToObjects(String json) throws Exception;

    String format(String json);
}
