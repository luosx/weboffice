package com.klspta.web.cbd.yzt.zrb;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import com.klspta.model.CBDinsertGIS.AbstractInsertGIS;


public class ZrbInsertGIS extends AbstractInsertGIS {
	
	 private static final String form_gis = "CBD_ZRB";

	@Override
	public boolean insertGIS(InputStream inputStream, String guid) {
		boolean result = false;
		try {
			String sql = "";
			sql = "select yw_guid from jc_ziran where zrbbh = '"+guid+"'";
			List<Map<String,Object>> list = query(sql, YW);
			String yw_guid = list.get(0).get("yw_guid").toString();
			String wkt = buildWKT(inputStream);
			String srid = getSrid(form_gis);
            //判断对应zrbbh是否存在,存在用update 否则 用 insert
            boolean isExit = isExit(form_gis, "yw_guid", yw_guid, GIS);
            
            if(isExit){
            	sql = "update " + form_gis + " t set t.SHAPE=sde.st_geometry ('" + wkt + "', " + srid + ") where t.ZRBBH='" + guid + "'";
            }else{
                sql = "INSERT INTO "+ form_gis+"(OBJECTID,YW_GUID,ZRBBH,SHAPE) VALUES ((select nvl(max(OBJECTID)+1,1) from "+form_gis+"),'"
                	+yw_guid+"','"+ guid + "',sde.st_geometry ('" + wkt + "', " + srid + "))";
            }
            update(sql, GIS);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	


}
