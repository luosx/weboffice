package com.klspta.web.cbd.hxxm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:安置房建设
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2013-10-15
 */
@Component
public class Anzfjs extends AbstractBaseBean {

    /**
     * 
     * <br>Description:新增安置房
     * <br>Author:陈强峰
     * <br>Date:2013-10-15
     */
    public void add() {
        String azfbh = request.getParameter("azfbh");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String kgmc = request.getParameter("kgmc");
        String kg = request.getParameter("kg");
        String kgbl = request.getParameter("kgbl");
        String tz = request.getParameter("tz");
        String tzmc = request.getParameter("tzmc");
        String syl = request.getParameter("syl");
        String kc = request.getParameter("kc");
        String season = getSeason(month);
        //删除已存在同月信息
        String sql = "delete from hx_gdtl where nd=? and yf=? and xmguid=?";
        update(sql, YW, new Object[] { year, month, azfbh });
        sql = "insert into hx_gdtl(nd,jd,kgmc,kg,kgbl,tz,tzmc,syl,kc,yf) values(?,?,?,?,?,?,?,?,?,?)";
        int flag = update(sql, YW, new Object[] { year, season, kgmc, kg, kgbl, tz, tzmc, syl, kc, month });
        if (flag == 1) {
            insertToSx(year, season, azfbh);
        }
        if (flag == 0) {
            response("{success:false}");
        } else {
            response("{success:true}");
        }
    }

    public void delete() {
        String azfbh = request.getParameter("azfbh");
        String sql = "select nd,jd from hx_azf where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { azfbh });
        if (list.size() > 0) {
            Map<String, Object> map = list.get(0);
            String nd = map.get("nd").toString();
            String jd = map.get("jd").toString();
            boolean isSingle = judgeCount(nd, jd, azfbh);
            sql = "delete from hx_azf where yw_guid=?";
            int flag = update(sql, YW, new Object[] { azfbh });
            if (flag == 0) {
                response("{success:false}");
            } else {
                if (isSingle) {
                    removeFromSx(nd, jd, azfbh);
                }
                response("{success:true}");
            }
        }
        response("{success:false}");
    }

    /**
     * 
     * <br>Description:更新安置房
     * <br>Author:陈强峰
     * <br>Date:2013-10-15
     */
    public void update() {
        String azfbh = request.getParameter("azfbh");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String kgmc = request.getParameter("kgmc");
        String kg = request.getParameter("kg");
        String kgbl = request.getParameter("kgbl");
        String tz = request.getParameter("tz");
        String tzmc = request.getParameter("tzmc");
        String syl = request.getParameter("syl");
        String kc = request.getParameter("kc");
        String season = getSeason(month);
        String sql = "select nd,jd from hx_azf where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { azfbh });
        boolean seasonChange = false;
        String oldYear="";
        String oldSeason="";
        if (list.size() > 0) {
            Map<String, Object> map = list.get(0);
            oldYear = map.get("nd").toString();
            oldSeason = map.get("jd").toString();
            if (oldYear.equals(year) && oldSeason.equals(season)) {

            } else {
                seasonChange = judgeCount(year, season, azfbh);
            }
        }
        sql = "update hx_azf set nd=?,jd=?,kgmc=?,kg=?,kgbl=?,tz=?,tzmc=?,syl=?,kc=?,yf=? where yw_guid=?";
        int flag = update(sql, YW, new Object[] { year, season, kgmc, kg, kgbl, tz, tzmc, syl, kc, month,
                azfbh });
        if (flag == 0) {
            response("{success:false}");
        } else {
            if (seasonChange) {
                //删除旧的时序关联
                removeFromSx(oldYear, oldSeason, azfbh);
                //插入新的时序关联
                insertToSx(year, season, azfbh);
            }
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:查询
     * <br>Author:陈强峰
     * <br>Date:2013-10-15
     */
    public void query() {
        String keyWord = request.getParameter("keyWord");
        String sql = "select kgmc,nd||'-'||yf as sx,kg,kgbl,tz,tzmc,syl,kc,rownum-1 as mod,rownum-1 as del,yw_guid  as azfbh from hx_azf";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " where (nd||'-'||yf||kgmc||tzmc like '%" + keyWord + "%')";
        }
        List<Map<String, Object>> list = query(sql, YW);
        response(list);
    }

    /**
     * 
     * <br>Description:获取季度
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param month
     * @return
     */
    private String getSeason(String month) {
        int season = 1;
        int mon = Integer.parseInt(month);
        if (mon >= 4) {
            if (mon < 7) {
                season = 2;
            } else if (mon < 10) {
                season = 3;
            } else {
                season = 4;
            }
        }
        return String.valueOf(season);
    }

    /**
     * 
     * <br>Description:将安置房关联时序
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     */
    private void insertToSx(String nd, String jd, String xmbh) {
        String sql = "select azfjs from hx_sx where nd=? and jd=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { nd, jd });
        if (list.size() > 0) {
            Object obj = list.get(0).get("azfjs");
            String azfs = obj == null ? "" : obj.toString();
            if (azfs.indexOf(xmbh) < 0) {
                StringBuffer sb = new StringBuffer(azfs);
                sql = "update hx_sx set azfjs =? where nd=? and jd=?";
                if (sb.length() > 0) {
                    sb.append(",").append(xmbh);
                } else {
                    sb.append(xmbh);
                }
                update(sql, YW, new Object[] { sb.toString(), nd, jd });
            }
        } else {
            sql = "insert into hx_sx(nd,jd,azfjs) values(?,?,?)";
            update(sql, YW, new Object[] { nd, jd, xmbh });
        }
    }

    /**
     * 
     * <br>Description:将安置房从时序移除
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     */
    private void removeFromSx(String nd, String jd, String xmbh) {
        String sql = "select azfjs from hx_sx where nd=? and jd=?";
        List<Map<String, Object>> listGdtl = query(sql, YW, new Object[] { nd, jd });
        if (listGdtl.size() > 0) {
            Object obj = listGdtl.get(0).get("azfjs");
            String azfs = obj == null ? "" : obj.toString();
            if (azfs.indexOf(xmbh) >= 0) {
                azfs = azfs.replace(xmbh + ",", "").replace(xmbh, "");
                sql = "update hx_sx set azfjs =? where nd=? and jd=?";
                update(sql, YW, new Object[] { azfs, nd, jd });
            }
        }
    }

    /**
     * 
     * <br>Description:判断在同一季度项目开发体量的条数是否唯一
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     * @return
     */
    private boolean judgeCount(String nd, String jd, String xmbh) {
        String sql = "select yw_guid from hx_azf where nd=? and jd=? and xmguid=?";
        List<Map<String, Object>> listCount = query(sql, YW, new Object[] { nd, jd, xmbh });
        if (listCount.size() == 1) {
            return true;
        }
        return false;
    }
}
