package com.klspta.web.qingdaoNW.dtxc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * <br>
 * Title:OverLay <br>
 * Description:青岛内网压盖分析<br>
 * Author:赵伟 <br>
 * Date:2014-3-17
 */
public class OverLay extends AbstractBaseBean {

	private static List<Map<String, Object>> gp = new ArrayList<Map<String, Object>>();
	private static List<Map<String, Object>> geometry = new ArrayList<Map<String, Object>>();

	public JSONObject executeTask(String coords) throws Exception {
		coords = coordsToWKT(coords);
		String geourl = getGeoServices();
		//geourl="http://127.0.0.1:8399/arcgis/rest/services/SEU/GPServer/OVERLAY/execute";
		Map<String, String> params = new HashMap<String, String>();
		params.put("f", "pjson");
		params.put("INPUT_POLYGON", coords);
		String result = sendGetHttp(geourl, params);
		JSONObject json = UtilFactory.getJSONUtil().jsonToObject(result);
		return areaResults(json);
	}

	private JSONObject areaResults(JSONObject json) throws Exception {
		List<JSONObject> polygons = new ArrayList<JSONObject>();
		List<Integer> polygonsIndex = new ArrayList<Integer>();
		int index = 0;
		for (int i = 0; i < json.getJSONArray("results").size(); i++) {
			JSONObject value = (JSONObject) json.getJSONArray("results").get(i);
			if (value.getJSONObject("value").getJSONArray("features").size() == 0) {
				polygonsIndex.add(i);
				continue;
			}
			for (int j = 0; j < value.getJSONObject("value").getJSONArray("features").size(); j++) {
				JSONObject polygon = value.getJSONObject("value").getJSONArray("features").getJSONObject(j)
						.getJSONObject("geometry");
				polygons.add(polygon);
			}
			index = index + value.getJSONObject("value").getJSONArray("features").size();
			polygonsIndex.add(index);
		}
		String geometryurl = getGeometry();
		//geometryurl="http://127.0.0.1:8399/arcgis/rest/services/Geometry/GeometryServer";
		geometryurl += "/areasAndLengths";
		Map<String, String> params = new HashMap<String, String>();
		params.put("f", "json");
		params.put("sr", "2364");
	    params.put("polygons", polygons.toString());
		String result = sendPostHttp(geometryurl, params);
		JSONArray areas = UtilFactory.getJSONUtil().jsonToObject(result).getJSONArray("areas");
		int index1 = 0;
		for (int i = 0; i < polygonsIndex.size(); i++) {
			int index2 = polygonsIndex.get(i);
			if (index2 - index == 0) {
				continue;
			}
			double area = 0;
			for (int j = index1; j < index2; j++) {
				area = area + Double.parseDouble(areas.getString(j));
				index1++;
			}
			json.getJSONArray("results").getJSONObject(i).put("F_AREA", area);
		}
		return json;
	}

	private String coordsToWKT(String coords) {
		StringBuilder str = new StringBuilder();
		str
				.append("{\"features\":[{\"geometry\":{\"rings\":[[[40536806.190814316,4011619.3428660976],[40522849.39206739,3989791.1742097605],[40539782.75926746,3989791.1742097605]]],\"spatialReference\":{\"wkid\":2364}}}],\"geometryType\":\"esriGeometryPolygon\"}");
		return str.toString();
	}

	private String sendGetHttp(String url, Map<String, String> param) {
		StringBuilder result = new StringBuilder();
		Iterator<Entry<String, String>> iter = param.entrySet().iterator();
		url += "?";
		while (iter.hasNext()) {
			Map.Entry<String, String> entry = (Map.Entry<String, String>) iter.next();
			Object key = entry.getKey();
			Object val = entry.getValue();
			url += "&" + key + "=" + val;
		}
		try {
			URL geturl = new URL(url);
			HttpURLConnection connection = (HttpURLConnection) geturl.openConnection();
			connection.connect();
			BufferedReader reader = new BufferedReader(new java.io.InputStreamReader(connection.getInputStream(),
					"UTF-8"));
			String lines;
			while ((lines = reader.readLine()) != null) {
				result.append(lines);
			}
			reader.close();
			connection.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result.toString();
	}
	
	private String sendPostHttp(String url, Map<String, String> param){
		StringBuilder result = new StringBuilder();
		Iterator<Entry<String, String>> iter = param.entrySet().iterator();
		url += "?";
		String parameters="";
		while (iter.hasNext()) {
			Map.Entry<String, String> entry = (Map.Entry<String, String>) iter.next();
			Object key = entry.getKey();
			Object val = entry.getValue();
			parameters += "&" + key + "=" + val;
		}
		try {
			URL posturl = new URL(url);
			HttpURLConnection connection = (HttpURLConnection) posturl.openConnection();
			connection.setUseCaches(false);
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			byte[] b = parameters.getBytes(); 
			connection.getOutputStream().write(b, 0, b.length); 
			connection.getOutputStream().flush(); 
			connection.getOutputStream().close(); 
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8")); 
			String lines;
			while ((lines = in.readLine()) != null) {
				result.append(lines);
			}
			in.close();
			connection.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result.toString();
	}

	// //////////////////////获取服务地址/////////////////////////
	private String getGeoServices() {
		if (gp.size() == 0) {
			String sql = "select * from gis_gpservices t where t.flag=1 and t.id='OVERLAY'";
			List<Map<String, Object>> list = query(sql, CORE);
			gp = list;
		}
		return gp.get(0).get("URL").toString();
	}

	private String getGeometry() {
		if (geometry.size() == 0) {
			String sql = "select * from GIS_GEOMETRYSERVICE t where t.flag=1 ";
			List<Map<String, Object>> list = query(sql, CORE);
			geometry = list;
		}
		return geometry.get(0).get("URL").toString();
	}
}
