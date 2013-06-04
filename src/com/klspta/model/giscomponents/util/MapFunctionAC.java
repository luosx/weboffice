package com.klspta.model.giscomponents.util;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Point;

public class MapFunctionAC extends AbstractBaseBean {
    /**
     * 
     * <br>Description:属性查询内容入口
     * <br>Author:陈强峰
     * <br>Date:2011-9-15
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void sxcxFunction() throws Exception {
        Object obj = MapFucntionUtil.getSx();
        String ms;
        if (JSONUtils.isArray(obj)) {
            ms = JSONArray.fromObject(obj).toString();
        } else {
            ms = JSONObject.fromObject(obj).toString();
        }
        response(ms);
    }

    /**
     * 
     * <br>Description:项目查询内容入口
     * <br>Author:陈强峰
     * <br>Date:2011-9-15
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return 
     * @return
     * @throws Exception
     */
    public void xmcxFunction() {
        String function = request.getParameter("function");
        Object obj = MapFucntionUtil.getXm(function);
        String ms;
        if (JSONUtils.isArray(obj)) {
            ms = JSONArray.fromObject(obj).toString();
        } else {
            ms = JSONObject.fromObject(obj).toString();
        }
        response(ms);
    }

    /**
     * 
     * <br>Description:框选查询信息
     * <br>Author:陈强峰
     * <br>Date:2011-9-15
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void kxFunction() throws Exception {
        String function = request.getParameter("function");
        Object obj = MapFucntionUtil.getKx(function);
        String ms;
        if (JSONUtils.isArray(obj)) {
            ms = JSONArray.fromObject(obj).toString();
        } else {
            ms = JSONObject.fromObject(obj).toString();
        }
        response(ms);
    }

    /**
     * 
     * <br>Description:地图标注查看分析
     * <br>Author:陈强峰
     * <br>Date:2012-8-10
     */
    public void markAnalysis() {
        try {
            String markString = request.getParameter("geometry");
            JSONObject point = UtilFactory.getJSONUtil().jsonToObject(markString);
            Point p = new Point(point.getString("x"), point.getString("y"));
            String wkt = p.toWKT();
            StringBuffer ms = new StringBuffer("");
            String sql = "select t.srid from sde.st_geometry_columns t";
            List<Map<String, Object>> ls = query(sql, GIS);
            int srid = Integer.parseInt(ls.get(0).get("SRID").toString());
            int objid;
            sql = "select max(objectid) ma from yz_edit_point t";
            ls = query(GIS, sql);
            objid = ls.get(0).get("ma") == null ? 1 : Integer.parseInt(ls.get(0).get("ma").toString()) + 1;

            sql = "insert into yz_edit_point  (objectid,shape) values(?,sde.st_geometry(?,?))";
            update(sql, GIS, new Object[] { objid, wkt, srid });

            sql = "select  *   from  yz_jsydsp t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:green'>已审批:").append(map.get("xmmc")).append("</SPAN><br>");
            } else {
                ms.append("<SPAN style='COLOR:red'>未审批</SPAN>").append("<br>");
            }

            sql = "select  *   from  jsydgzq t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:green'>规划建设用地管制区:").append(map.get("sm")).append("</SPAN><br>");
            } else {
                ms.append("<SPAN style='COLOR:red'>非建设用地管制区").append("</SPAN><br>");
            }
            sql = "select  *   from  ghjbntbhq t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                ms.append("<SPAN style='COLOR:red'>占用基本农田</SPAN>").append("<br>");
            } else {
                ms.append("<SPAN style='COLOR:green'>未占用基本农田</SPAN>").append("<br>");
            }
            sql = "select  *   from  yz_wpzfjc_2009 t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:green'>2009卫片执法检查").append(map.get("JCBH")).append(
                        "号图斑已核查</SPAN><br>");
            }
            sql = "select  *   from  yz_wpzfjc_2010_b t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:green'>2010卫片本年执法检查").append(map.get("BGTBBH")).append(
                        "号图斑已核查</SPAN><br>");
            }
            sql = "select  *   from  yz_wpzfjc_2010_pj t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:green'>2010卫片往年执法检查").append(map.get("BGTBBH")).append(
                        "号图斑已核查</SPAN><br>");
            }
            sql = "select  *   from  yz_wpzfjc_2010_w t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:red'>2010卫片执法检查").append(map.get("BGTBBH")).append(
                        "号图斑未批先建</SPAN><br>");
            }
            sql = "select  *   from  yz_ysxztb_2010 t where sde.st_contains (t.shape,sde.st_geometry(?,?))=1";
            ls = query(sql, GIS, new Object[] { wkt, srid });
            if (ls.size() > 0) {
                Map<String, Object> map = ls.get(0);
                ms.append("<SPAN style='COLOR:red'>2010卫片执法检查疑似新增").append(map.get("JCBH")).append(
                        "号图斑已核查<br>");
                ms.append("核查情况:").append(map.get("HCQK")).append(map.get("</SPAN>"));
            }
            if (ms.toString().indexOf("卫片执法检查") < 0) {
                ms.append("<SPAN style='COLOR:green'>年度卫片执法检查未发现</SPAN>");
            }
            response(ms.toString());
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
