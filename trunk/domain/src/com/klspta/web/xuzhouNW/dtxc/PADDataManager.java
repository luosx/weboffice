﻿package com.klspta.web.xuzhouNW.dtxc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Polygon;

/**
 * 
 * <br>
 * Title:Pad功能类 <br>
 * Description:对数据库中PAD表操作 <br>
 * Author:陈强峰 <br>
 * Date:2011-7-22
 */
public class PADDataManager extends AbstractBaseBean {

    /**
     * 
     * <br>Description:获取成果列表
     * <br>Author:陈强峰
     * <br>Date:2013-6-19
     */
    public void getQueryData() {
        String keyword = request.getParameter("keyWord");
        String sql = "select t.readflag,t.guid,t.xzqmc,t.xmmc,t.rwlx,t.sfwf,(select u.fullname from core.core_users u where u.username=t.xcr) xcr,t.xcrq,t.cjzb,t.jwzb,t.imgname from v_pad_data t";
        if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
            sql = "select t.readflag,t.guid,t.xzqmc,t.xmmc,t.rwlx,t.sfwf,(select u.fullname from core.core_users u where u.username=t.xcr) xcr,t.xcrq,t.cjzb,t.jwzb,t.imgname from v_pad_data t where (upper(guid)||upper(xmmc)||upper(rwlx)||upper(sfwf)||upper(xcr)||upper(xcrq) like '%"
                    + keyword + "%')";
        }
        List<Map<String, Object>> query = query(sql, YW);
        for (int i = 0; i < query.size(); i++) {
            query.get(i).put("XIANGXI", i);
            query.get(i).put("DELETE", i);
        }
        response(query);
    }

    /**
     * 
     * <br>Description: 删除指定的外业设备回传信息
     * <br>Author:姚建林
     * <br>Date:2012-11-19
     * @return
     */
    public String delPAD() {
        String guid = request.getParameter("yw_guid");
        if (guid != null) {
            String sql = "delete from pad_xcxcqkb where yw_guid='" + guid + "'";
            update(sql, YW);
        }
        return null;
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
        String sql = "select cjzb from pad_xcxcqkb where yw_guid=?";
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
                Polygon polygon = new Polygon(listzb, wkid.intValue(), true);
                return polygon.toJson();
            }
        } else {
            return null;
        }
    }
}