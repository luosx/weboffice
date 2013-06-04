package com.klspta.model.giscomponents.shtc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.springframework.security.core.context.SecurityContextHolder;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.wkt.Linestring;
import com.klspta.base.wkt.Point;
import com.klspta.base.wkt.Polygon;
import com.klspta.base.wkt.Ring;
import com.klspta.console.user.User;

/**
 * <br>
 * Description:手绘图层功能处理类 <br>
 * Author:王峰 <br>
 * Date:2011-7-25
 * 
 * @return
 */
public class ShtcDataOperation extends AbstractBaseBean{

	private static ShtcDataOperation shtcDataOperation;
	
	private ShtcDataOperation() {

	}

	/**
	 * <br>
	 * Description:获取实例 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-25
	 * 
	 * @return
	 */
	public static ShtcDataOperation getInstance() {
		if (shtcDataOperation == null) {
			shtcDataOperation = new ShtcDataOperation();
		}
		return shtcDataOperation;
	}

	/**
	 * <br>
	 * Description:保存手绘图层信息 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-25
	 * 
	 * @return
	 */
	public void save(String[] arrays, String id, String name, String describe,
			String ringType, String shareflag, String username,
			String zfjctype, String yw_guid) {
		String tableName = "";
		String wkt = null;

		if (ringType.equals("point")) {
			tableName = "DC_EDIT_POINT";
			if(id==null){
			  Point point = new Point(arrays[0], arrays[1]);
		      wkt = point.toWKT();
			}
		}
		if (ringType.equals("polyline")) {
			tableName = "DC_EDIT_POLYLINE";
			if(id==null){
			  Linestring line = new Linestring();
			  for (int i = 0; i < arrays.length / 2; i++) {
				line.putPoint(arrays[i * 2], arrays[i * 2 + 1]);
			  }
			  wkt = line.toWKT();
			}
		}
		if (ringType.equals("polygon")) {
			tableName = "DC_EDIT_POLYGON";
			if(id==null){
			  Ring ring = new Ring();
			  for (int i = 0; i < arrays.length / 2; i++) {
				ring.putPoint(arrays[i * 2], arrays[i * 2 + 1]);
			  }
		 	  Polygon polygon = new Polygon();
			  polygon.addRing(ring);
			  wkt = polygon.toWKT();
			}
		}
		String querySrid = "select t.srid from sde.st_geometry_columns t where t.table_name = '"
				+ tableName + "'";
		String srid = null;
		List<Map<String,Object>> list = query(querySrid, GIS);
		if (list.size() > 0) {
			Map<String,Object> map = (Map<String,Object>) list.get(0);
			srid = map.get("srid") + "";
		}
		String sql = "update " + tableName + " set BJNAME='" + name
				+ "',BZ='" + describe + "',SHAREFLAG='" + shareflag
				+ "' where BJID='" + id + "'";
		if (id == null) {
			sql = "INSERT INTO "
					+ tableName
					+ " (OBJECTID,BJID,BJNAME,BZ,DATEFLAG,USERNAME,ZFJCTYPE,YW_GUID,SHAREFLAG,SHAPE) VALUES ((select nvl(max(OBJECTID)+1,1) from "
					+ tableName + "),(select nvl(max(BJID)+1,1) from "
					+ tableName + "),'" + name + "','" + describe + "',sysdate,'" + username + "','" + zfjctype + "','"
					+ yw_guid + "','" + shareflag + "',sde.st_geometry ('"
					+ wkt + "', " + srid + "))";
			System.out.print(sql);
		}
		update(sql, GIS);
	}

	/**
	 * <br>
	 * Description:刪除手绘图层信息 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-25
	 * 
	 * @return
	 */
	public void delShtcInfo(String id) {
		String sql1 = "delete from DC_EDIT_POLYGON where yw_guid='" + id + "'";
	    String sql2 = "delete from DC_EDIT_POINT where yw_guid='" + id + "'";
	    String sql3 = "delete from DC_YDQKDCB where yw_guid='" + id + "'";
	    update(sql1, GIS);
	    update(sql2, GIS);
	    update(sql3, YW);
	}

	/**
	 * <br>
	 * Description:刪除手绘图层信息 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-25
	 * 
	 * @return
	 */
	public void delShtcLocation(String id) {
		String sql = null;
		sql = "delete from DC_EDIT_POINT where YW_GUID='" + id + "'";
		update(sql, GIS);
		sql = "delete from DC_EDIT_POLYLINE where YW_GUID='" + id + "'";
		update(sql, GIS);
		sql = "delete from DC_EDIT_POLYGON where YW_GUID='" + id + "'";
		update(sql, GIS);
	}
	/**
	 * <br>
	 * Description:获取手绘图层信息列表 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-25
	 * 
	 * @return
	 */
	public String getShtc() {
		Object principal = SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		String fullName = "";
		if (principal instanceof User) {
			fullName = ((User) principal).getFullName();
		} else {
			fullName = principal.toString();
		}
		List<List<Object>> allRows = new ArrayList<List<Object>>();
		String sql1 = "select BJID,BJNAME,BZ,DATEFLAG from DC_EDIT_POLYGON t where YW_GUID='0' and (shareflag='1' or username='"
				+ fullName + "')";
		List<Map<String,Object>> rows1 = query(sql1, GIS);
		for (int i = 0; i < rows1.size(); i++) {
			List<Object> oneRow = new ArrayList<Object>();
			Map<String,Object> map = (Map<String,Object>) rows1.get(i);
			oneRow.add(map.get("BJID"));
			oneRow.add(map.get("BJNAME"));
			oneRow.add(map.get("BZ"));
			oneRow.add("区域");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
			if(map.get("DATEFLAG")!=null){ 	
			  String date=sdf.format(map.get("DATEFLAG"));
			  oneRow.add(date);
			}
		    else
		    {
			  oneRow.add("");
			}
			oneRow.add(i);
			oneRow.add(i);
			allRows.add(oneRow);
		}
		String sql2 = "select BJID,BJNAME,BZ,DATEFLAG from DC_EDIT_POLYLINE t where YW_GUID='0' and (shareflag='1' or username='"
				+ fullName + "')";
		List<Map<String,Object>> rows2 = query(sql2, GIS);
		for (int i = 0; i < rows2.size(); i++) {
			List<Object> oneRow = new ArrayList<Object>();
			Map<String,Object> map = (Map<String,Object>) rows2.get(i);
			oneRow.add(map.get("BJID"));
			oneRow.add(map.get("BJNAME"));
			oneRow.add(map.get("BZ"));
			oneRow.add("路线");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
			if(map.get("DATEFLAG")!=null){ 	
			  String date=sdf.format(map.get("DATEFLAG"));
			  oneRow.add(date);
			}
		    else
		    {
			  oneRow.add("");
			}
			oneRow.add(i);
			oneRow.add(i);
			allRows.add(oneRow);
		}
		String sql3 = "select BJID,BJNAME,BZ,DATEFLAG from DC_EDIT_POINT t where YW_GUID='0' and (shareflag='1' or username='"
				+ fullName + "')";
		List<Map<String,Object>> rows3 = query(sql3, GIS);
		for (int i = 0; i < rows3.size(); i++) {
			List<Object> oneRow = new ArrayList<Object>();
			Map<String,Object> map = (Map<String,Object>) rows3.get(i);
			oneRow.add(map.get("BJID"));
			oneRow.add(map.get("BJNAME"));
			oneRow.add(map.get("BZ"));
			oneRow.add("地点");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
			if(map.get("DATEFLAG")!=null){ 	
			  String date=sdf.format(map.get("DATEFLAG"));
			  oneRow.add(date);
			}
		    else
		    {
			  oneRow.add("");
			}
			oneRow.add(i);
			oneRow.add(i);
			allRows.add(oneRow);
		}
		return JSONArray.fromObject(allRows).toString();
	}
	
	public String getServices(String name){
		String sql="select url from gis_mapservices where id='"+name+"'";
		List<Map<String, Object>> list = query(sql, CORE);
		Map<String, Object> map=list.get(0);
		String servicesName=(String)map.get("url");
		return servicesName;
	}
}
