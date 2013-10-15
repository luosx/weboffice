package com.klspta.web.cbd.hxxm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:开发体量
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2013-10-10
 */
@Component
public class Kftl extends AbstractBaseBean {
    /**
     * 
     * <br>Description:新增开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void add() {
        String xmbh = request.getParameter("xmbh");
        String xmmc = request.getParameter("xmmc");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String hs = request.getParameter("hs");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String tz = request.getParameter("tz");
        String z = request.getParameter("z");
        String q = request.getParameter("q");
        String hsz = request.getParameter("hsbl");
        String dlz = request.getParameter("dlbl");
        String gmz = request.getParameter("gmbl");
        String tzz = request.getParameter("tzbl");
        String zhuz = request.getParameter("zbl");
        String qiz = request.getParameter("qbl");
        String lm = request.getParameter("lm");
        String cj = request.getParameter("cj");
        String season = getSeason(month);
        //删除已存在同月信息
        String sql = "delete from hx_kftl where nd=? and yf=? and xmguid=?";
        update(sql, YW, new Object[] { year, month, xmbh });
        sql = "insert into hx_kftl(xmmc,nd,jd,hs,dl,gm,tz,zhu,qi,lm,cj,xmguid,yf,hsz,dlz,gmz,tzz,zhuz,qiz) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int flag = update(sql, YW, new Object[] { xmmc, year, season, hs, dl, gm, tz, z, q, lm, cj, xmbh,
                month, hsz, dlz, gmz, tzz, zhuz, qiz });
        if (flag == 1) {
            insertToSx(year, season, xmbh);
        }
        if (flag == 0) {
            response("{success:false}");
        } else {
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:更新开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void update() {
        String kfbh = request.getParameter("kfbh");
        String xmbh = request.getParameter("xmbh");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String hs = request.getParameter("hs");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String tz = request.getParameter("tz");
        String z = request.getParameter("z");
        String q = request.getParameter("q");
        String hsz = request.getParameter("hsbl");
        String dlz = request.getParameter("dlbl");
        String gmz = request.getParameter("gmbl");
        String tzz = request.getParameter("tzbl");
        String zhuz = request.getParameter("zbl");
        String qiz = request.getParameter("qbl");
        String lm = request.getParameter("lm");
        String cj = request.getParameter("cj");
        String season = getSeason(month);
        String sql = "select nd,jd from hx_kftl where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { kfbh });
        boolean seasonChange = false;
        String oldYear;
        String oldSeason;
        if (list.size() > 0) {
            Map<String, Object> map = list.get(0);
            oldYear = map.get("nd").toString();
            oldSeason = map.get("jd").toString();
            if (oldYear.equals(year) && oldSeason.equals(season)) {

            } else {
                seasonChange = judgeCount(year, season, xmbh);
            }
        }
        sql = "update hx_kftl set nd=?,jd=?,hs=?,dl=?,gm=?,tz=?,zhu=?,qi=?,hsz=?,dlz=?,gmz=?,tzz=?,zhuz=?,qiz=?,lm=?,cj=?,yf=? where yw_guid=?";
        int flag = update(sql, YW, new Object[] { year, season, hs, dl, gm, tz, z, q, hsz, dlz, gmz, tzz,
                zhuz, qiz, lm, cj, month, kfbh });
        if (flag == 0) {
            response("{success:false}");
        } else {
            if (seasonChange) {
                //删除旧的时序关联
                removeFromSx(year, season, xmbh);
                //插入新的时序关联
                insertToSx(year, season, xmbh);
            }
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:删除开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void delete() {
        String kfbh = request.getParameter("kfbh");
        String sql = "select nd,jd,xmguid from hx_kftl where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { kfbh });
        if (list.size() > 0) {
            Map<String, Object> map = list.get(0);
            String nd = map.get("nd").toString();
            String jd = map.get("jd").toString();
            String xmbh = map.get("xmguid").toString();
            boolean isSingle = judgeCount(nd, jd, xmbh);
            sql = "delete from hx_kftl where yw_guid=?";
            int flag = update(sql, YW, new Object[] { kfbh });
            if (flag == 0) {
                response("{success:false}");
            } else {
                if (isSingle) {
                    removeFromSx(nd, jd, xmbh);
                }
                response("{success:true}");
            }
        }
        response("{success:false}");
    }

    /**
     * 
     * <br>Description:开发体量查询
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void query() {
        String xmbh = request.getParameter("xmbh");
        String keyWord = request.getParameter("keyWord");
        String sql = "select xmmc,nd||'-'||yf as sx,dl,hs,gm,tz,zhu as z,qi as q,lm,cj,rownum-1 as mod,rownum-1 as del,yw_guid  as kfbh,hsz,dlz,gmz,tzz,zhuz,qiz,yf from hx_kftl where xmguid=?";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and nd||'-'||yf like '%" + keyWord + "%'";
        }
        List<Map<String, Object>> list = query(sql, YW, new Object[] { xmbh });
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
     * <br>Description:将项目开发体量关联时序
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     */
    private void insertToSx(String nd, String jd, String xmbh) {
        String sql = "select kftl from hx_sx where nd=? and jd=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { nd, jd });
        if (list.size() > 0) {
            Object obj = list.get(0).get("kftl");
            String kftls = obj == null ? "" : obj.toString();
            if (kftls.indexOf(xmbh) < 0) {
                StringBuffer sb = new StringBuffer(kftls);
                sql = "update hx_sx set kftl =? where nd=? and jd=?";
                if (sb.length() > 0) {
                    sb.append(",").append(xmbh);
                } else {
                    sb.append(xmbh);
                }
                update(sql, YW, new Object[] { sb.toString(), nd, jd });
            }
        } else {
            sql = "insert into hx_sx(nd,jd,kftl) values(?,?,?)";
            update(sql, YW, new Object[] { nd, jd, xmbh });
        }
    }

    /**
     * 
     * <br>Description:将项目开发体量从时序移除
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     */
    private void removeFromSx(String nd, String jd, String xmbh) {
        String sql = "select kftl from hx_sx where nd=? and jd=?";
        List<Map<String, Object>> listKftl = query(sql, YW, new Object[] { nd, jd });
        if (listKftl.size() > 0) {
            Object obj = listKftl.get(0).get("kftl");
            String kftls = obj == null ? "" : obj.toString();
            if (kftls.indexOf(xmbh) >= 0) {
                kftls = kftls.replace(xmbh + ",", "").replace(xmbh, "");
                sql = "update hx_sx set kftl =? where nd=? and jd=?";
                update(sql, YW, new Object[] { kftls, nd, jd });
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
        String sql = "select yw_guid from hx_kftl where nd=? and jd=? and xmguid=?";
        List<Map<String, Object>> listCount = query(sql, YW, new Object[] { nd, jd, xmbh });
        if (listCount.size() == 1) {
            return true;
        }
        return false;
    }
}
