package com.klspta.model.giscomponents.sdxc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.wkt.Linestring;
import com.klspta.base.wkt.Point;
import com.klspta.base.wkt.Polygon;
import com.klspta.base.wkt.Ring;

/**
 * <br>Title:实地巡查处理类
 * <br>Description:TODO 类功能描述
 * <br>Author:尹宇星
 * <br>Date:2011-8-5
 */
public class SdxcDataOperation extends AbstractBaseBean{

    private static SdxcDataOperation shtcDataOperation;

    //JdbcTemplate jt = Globals.getGisJdbcTemplate();

    private SdxcDataOperation() {

    }

    /**
     * <br>Description:获取实例
     * <br>Author:尹宇星
     * <br>Date:2011-8-4
     * @return
     */
    public static SdxcDataOperation getInstance() {
        if (shtcDataOperation == null) {
            shtcDataOperation = new SdxcDataOperation();
        }
        return shtcDataOperation;
    }

    /**
     * <br>Description:保存shape文件
     * <br>Author:尹宇星
     * <br>Date:2011-8-5
     * @param arrays
     * @param id
     * @param name
     * @param describe
     * @param ringType
     * @param shareflag
     * @param username
     * @param zfjctype
     * @param yw_guid
     */
    public void save(String[] arrays, String ringType, String zfjctype, String yw_guid, String dkid) {
        String tableName = "";
        String wkt = null;

        if (ringType.equals("point")) {
            tableName = "WYXCHC_POINT";
            Point point = new Point(arrays[0], arrays[1]);
            wkt = point.toWKT();
        }
        if (ringType.equals("polyline")) {
            tableName = "WYXCHC_LINE";
            Linestring line = new Linestring();
            for (int i = 0; i < arrays.length / 2; i++) {
                line.putPoint(arrays[i * 2], arrays[i * 2 + 1]);
            }
            wkt = line.toWKT();
        }
        if (ringType.equals("polygon")) {
            tableName = "WYXCHC_POLYGON";
            Ring ring = new Ring();
            for (int i = 0; i < arrays.length / 2; i++) {
                ring.putPoint(arrays[i * 2], arrays[i * 2 + 1]);
            }
            Polygon polygon = new Polygon();
            polygon.addRing(ring);
            wkt = polygon.toWKT();
        }
        String querySrid = "select t.srid from sde.st_geometry_columns t where t.table_name = '" + tableName
                + "'";
        String srid = null;
        List<Map<String,Object>> list = query(querySrid,GIS);
        if (list.size() > 0) {
            Map<String,Object> map = (Map<String,Object>) list.get(0);
            srid = map.get("srid") + "";
        }

        String sql = "INSERT INTO "
                + tableName
                + " (OBJECTID,YW_GUID,PLOTID,DATEFLAG,ZFJCTYPE,SHAPE) VALUES ((select nvl(max(OBJECTID)+1,1) from "
                + tableName + "),'" + yw_guid + "','" + dkid + "',sysdate," + zfjctype
                + ",sde.st_geometry ('" + wkt + "', " + srid + "))";
        update(sql,GIS);
    }

    /**
     * <br>Description:删除实地巡查图层
     * <br>Author:尹宇星
     * <br>Date:2011-8-5
     * @param id
     */
    public void delSdxcLocation(String id) {
        String sql = null;
        sql = "delete from WYXCHC_POINT where PLOTID ='" + id + "'";
        update(sql,GIS);
        sql = "delete from WYXCHC_LINE where PLOTID ='" + id + "'";
        update(sql,GIS);
        sql = "delete from WYXCHC_POLYGON where PLOTID ='" + id + "'";
        update(sql,GIS);
    }
    
    /**
     * <br>Description:返回一个四至，包含所有实地巡查图斑
     * <br>Author:尹宇星
     * <br>Date:2011-8-5
     * @return
     */
    public Double[] getAllSdxcDk(){
        Double minx = 0.0;
        Double miny = 0.0;
        Double maxx = 0.0;
        Double maxy = 0.0;
        List<String> tables = new ArrayList<String>();
        tables.add("POINT");
        tables.add("LINE");
        tables.add("POLYGON");
        for(int i=0;i<tables.size();i++){
            String sql = "select t.shape.minx,t.shape.miny,t.shape.maxx,t.shape.maxy from giser.WYXCHC_"+ tables.get(i) + " t";
            List<Map<String,Object>> list = query(sql,GIS);
            for(int j=0;j<list.size();j++){
                Map<String,Object> map = (Map<String,Object>) list.get(j);
                if(minx>Double.parseDouble(map.get("shape.minx").toString())||minx==0.0){
                    minx = Double.parseDouble(map.get("shape.minx").toString());
                }
                if(miny>Double.parseDouble(map.get("shape.miny").toString())||miny==0.0){
                    miny = Double.parseDouble(map.get("shape.miny").toString());
                }
                if(maxx<Double.parseDouble(map.get("shape.maxx").toString())){
                    maxx = Double.parseDouble(map.get("shape.maxx").toString());
                }
                if(maxy<Double.parseDouble(map.get("shape.maxy").toString())){
                    maxy = Double.parseDouble(map.get("shape.maxy").toString());
                }
            }
        }
        Double[] zuobiao = {minx,miny,maxx,maxy};
        return zuobiao;
    }
}
