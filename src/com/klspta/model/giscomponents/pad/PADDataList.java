package com.klspta.model.giscomponents.pad;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Polygon;

public class PADDataList extends AbstractBaseBean {

    /**
     * <br>Description: 外业采集成果展现
     * <br>Author:李如意
     * <br>Date:2012-7-24
     * @param list
     * @return
     */
    public String getPADDataList(String condition, String flag) {
        String strColumnName = "guid||xmmc||dwmc|| rwlx|| wfdd|| rwms||sfwf||xcqkms|| xcr|| xcrq|| gpsid";
        String where = "";
        String sql = "select guid,xmmc,dwmc, rwlx, wfdd, rwms,sfwf,xcqkms,xcr, xcrq, cjzb,jwzb,imgname, gpsid from WY_DEVICE_DATA";
        if ("5".equals(flag)) {
            sql += " where sfwf = '合法'";
        } else {
            sql += " where sfwf != '合法'";
        }
        if (condition != null && !"".equals(condition)) {
            condition = condition.trim();
            while (condition.indexOf("  ") > 0) {// 寰幆鍘绘帀澶氫釜绌烘牸锛屾墍鏈夊瓧绗︿腑闂村彧鐢ㄤ竴涓┖鏍奸棿闅?
                condition = condition.replace("  ", " ");
            }
            condition = UtilFactory.getStrUtil().unescape(condition);
            // keyword=keyword.toUpperCase();
            where += " and (" + strColumnName + " like '%"
                    + (condition.replaceAll(" ", "%' and " + strColumnName + "  like '%")) + "%')";// 鏌ヨ鏉′欢
        }
        sql += where;
        List<List<Object>> allRows = new ArrayList<List<Object>>();
        List<Map<String, Object>> rows = query(sql, AbstractBaseBean.YW);
        for (int i = 0; i < rows.size(); i++) {
            List<Object> oneRow = new ArrayList<Object>();
            Map<String, Object> map = (Map<String, Object>) rows.get(i);
            oneRow.add(map.get("guid") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("guid"), condition));
            oneRow.add(map.get("xmmc") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("xmmc"), condition));
            oneRow.add(map.get("dwmc") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("dwmc"), condition));
            oneRow.add(map.get("rwlx") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("rwlx"), condition));
            oneRow.add(map.get("wfdd") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("wfdd"), condition));
            oneRow.add(map.get("rwms") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("rwms"), condition));
            oneRow.add(map.get("xcqkms") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("xcqkms"), condition));
            oneRow.add(map.get("xcr") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("xcr"), condition));
            oneRow.add(map.get("xcrq") == null ? " " : map.get("xcrq").toString().split("\\.")[0]);
            oneRow.add(map.get("sfwf") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("sfwf"), condition));
            oneRow.add(map.get("jwzb") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("jwzb"), condition));
            oneRow.add(map.get("imgname") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("imgname"), condition));
            oneRow.add(map.get("gpsid") == null ? " " : UtilFactory.getStrUtil().changeKeyWord(
                    (String) map.get("gpsid"), condition));
            oneRow.add(i);
            oneRow.add(i);
            allRows.add(oneRow);
        }
        return JSONArray.fromObject(allRows).toString();
    }

    /**
     * 
     * <br>Description:删除指定采集信息
     * <br>Author:陈强峰
     * <br>Date:2011-7-22
     * @param mes 删除条件参数数组
     * @return
     */
    boolean del(Object[] mes) {
        delgis(mes);
        //JdbcTemplate jt=Globals.getYwJdbcTemplate();
        String sql = "delete from wy_pad_data where xh=? and tbsj=? and username=?";
        //int i=jt.update(sql,mes);
        int i = update(sql, AbstractBaseBean.YW, mes);
        return i == 1 ? true : false;
    }

    /**
     * 
     * <br>Description:从空间表中删除指定数据
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param mes
     * @return
     */
    private boolean delgis(Object[] mes) {
        String message = searchZb(mes);
        //JdbcTemplate jt=Globals.getGisJdbcTemplate();
        String sql = "delete from " + message.split("@")[1] + " where dataid=?";
        //int i=jt.update(sql,new Object[]{message.split("@")[0]});
        int i = update(sql, AbstractBaseBean.YW, mes);
        return i == 1 ? true : false;
    }

    /**
     * 
     * <br>Description:从空间表中返回guid@table的格式字符串
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param mes
     * @return
     */
    private String searchZb(Object[] mes) {
        String zb = "";
        String guid = "";
        //JdbcTemplate jt=Globals.getYwJdbcTemplate();
        String sql = "select zb,guid from wy_pad_data  where xh=? and tbsj=? and username=?";
        //List<Map<String,Object>> list=jt.queryForList(sql,mes);
        List<Map<String, Object>> list = query(sql, AbstractBaseBean.YW, mes);

        if (list.size() > 0) {
            Map<String, Object> map = (Map<String, Object>) list.get(0);
            zb = map.get("zb").toString();
            guid = map.get("guid").toString();
        }
        String[] allPoint = zb.split(";");
        String table = "";
        if (allPoint.length == 1) {
            table = "WYXCHC_POINT";
        } else if (allPoint.length == 2) {
            table = "WYXCHC_LINE";
        } else {
            table = "WYXCHC_POLYGON";
        }
        return guid + "@" + table;
    }

    /**
     *  回传信息
     * @param rwbh
     * @return
     */
    public List<Map<String, Object>> getData(String rwbh) {
        String sql = "select guid,xmmc,dwmc,rwlx,wfdd,rwms,sfwf,xcqkms,xcr,xcrq,cjzb,jwzb,imgname,gpsid,sjzdmj from WY_DEVICE_DATA where guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { rwbh });
        if (list.size() > 0) {
            return list;
        } else {
            return null;
        }
    }

    public String getZb(String rwbh) {
        String sql = "select jwzb from WY_DEVICE_DATA where guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { rwbh });
        if (list.size() > 0) {
            return list.get(0).get("jwzb").toString();
        } else {
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取80坐标
     * <br>Author:陈强峰
     * <br>Date:2012-8-16
     * @param rwbh
     * @return
     */
    public String getCjzb(String rwbh) {
    	//池州课题测试用
    	String sql = "select cjzb from pad_xcxcqkb where yw_guid=?";
        //String sql = "select cjzb from xcxcqkb where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { rwbh });
        if (list.size() > 0) {
            Object zb = list.get(0).get("cjzb");
            if (zb == null) {
                return null;
            } else {
                String[] zbs = zb.toString().split(",");
                List<String> listzb = new ArrayList<String>();
                for (int i = 0; i < zbs.length / 2; i++) {
                    listzb.add(zbs[i * 2] + "," + zbs[i * 2 + 1]);
                }
                listzb.add(zbs[0] + "," + zbs[1]);
                sql = "select t.*, t.rowid from gis_extent t where t.flag = '1'";
                List<Map<String, Object>> mapConfigList = query(sql, CORE);
                BigDecimal wkid = (BigDecimal) mapConfigList.get(0).get("wkid");
                Polygon polygon = new Polygon(listzb,wkid.intValue(),true);
                return polygon.toJson();
            }
        } else {
            return null;
        }
    }

}
