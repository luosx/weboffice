package com.klspta.base.util.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.AbstractDataBaseSupport;
import com.klspta.base.util.api.IGisExpandUtil;
import com.klspta.base.wkt.Point;

public class GisExpandUtil extends AbstractBaseBean implements IGisExpandUtil {
    private static GisExpandUtil instance = null;

    private static List<String> xList = new ArrayList<String>();

    private static List<String> yList = new ArrayList<String>();

    private static Map<String, String> gridMap = new HashMap<String, String>();

    public static IGisExpandUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            instance = new GisExpandUtil();
        }
        return instance;
    }

    @Override
    public String GetDecryptData(String jmzb) {
        ActiveXComponent app = new ActiveXComponent("CoordinateEncrypt.Encrypt.1");
        Dispatch mycom = (Dispatch) app.getObject();
        if (mycom != null) {
            Variant result = Dispatch.callN(mycom, "GetDecryptData", jmzb);
            return result.toString();
        }
        return null;
    }

    @Override
    public String GetEncryptData(double x, double y) {
        ActiveXComponent app = new ActiveXComponent("CoordinateEncrypt.Encrypt.1");
        Dispatch mycom = (Dispatch) app.getObject();
        if (mycom != null) {
            Variant result = Dispatch.callN(mycom, "GetEncryptData", new Object[] { x + "", y + "" });
            return result.toString();
        }
        return null;
    }

    @Override
    public Point changePoint(Point p) {
        init();
        String xGrid = getXGrid(p.getX4Str());
        String yGrid = getYGrid(p.getY4Str());
        String[] DBL = gridMap.get(yGrid + "_" + xGrid).split(",");
        p.setPointXY(p.getX() + Double.parseDouble(DBL[1]), p.getY() + Double.parseDouble(DBL[0]));
        return p;
    }

    private String getXGrid(String x4Str) {
        double distance = 360;
        String x = "";
        for (int i = 0; i < xList.size(); i++) {
            double disTemp = Math.abs(Float.parseFloat(x4Str) - Float.parseFloat(xList.get(i)));
            if (distance > disTemp) {
                x = xList.get(i);
                distance = disTemp;
            }
        }
        return x;
    }

    private String getYGrid(String y4Str) {
        double distance = 360;
        String y = "";
        for (int i = 0; i < yList.size(); i++) {
            double disTemp = Math.abs(Float.parseFloat(y4Str) - Float.parseFloat(yList.get(i)));
            if (distance > disTemp) {
                y = yList.get(i);
                distance = disTemp;
            }
        }
        return y;
    }

    private void init() {
        String sqlXList = "select distinct(t.l) as L from gis_gird t order by L";
        String sqlYList = "select distinct(t.b) as B from gis_gird t order by B";
        String sqlGrid = "select b||'_'||l as BL,db||','||dl as DBL from gis_gird t";
        if (xList == null || xList.isEmpty()) {
            List<Map<String, Object>> listmap = query(sqlXList, AbstractDataBaseSupport.YW);
            for (int i = 0; i < listmap.size(); i++) {
                xList.add(listmap.get(i).get("L").toString());
            }
        }
        if (yList == null || yList.isEmpty()) {
            List<Map<String, Object>> listmap = query(sqlYList, AbstractDataBaseSupport.YW);
            for (int i = 0; i < listmap.size(); i++) {
                yList.add(listmap.get(i).get("B").toString());
            }
        }
        if (gridMap == null || gridMap.size() == 0) {
            List<Map<String, Object>> listmap = query(sqlGrid, AbstractDataBaseSupport.YW);
            for (int i = 0; i < listmap.size(); i++) {
                Map<String, Object> map = listmap.get(i);
                gridMap.put(map.get("BL").toString(), map.get("DBL").toString());
            }
        }
    }

}
