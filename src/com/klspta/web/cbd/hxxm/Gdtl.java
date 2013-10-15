package com.klspta.web.cbd.hxxm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:供地体量
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2013-10-10
 */
@Component
public class Gdtl extends AbstractBaseBean {
    /**
     * 
     * <br>Description:新增供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void add() {
        String xmbh = request.getParameter("xmbh");
        String xmmc = request.getParameter("xmmc");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String cb = request.getParameter("cb");
        String sy = request.getParameter("sy");
        String zj = request.getParameter("zj");
        String dlz = request.getParameter("dlbl");
        String gmz = request.getParameter("gmbl");
        String cbz = request.getParameter("cbbl");
        String syz = request.getParameter("sybl");
        String zjz = request.getParameter("zjbl");
        String zujin = request.getParameter("zujin");
        String season = getSeason(month);
        //删除已存在同月信息
        String sql="delete from hx_gdtl where nd=? and yf=? and xmguid=?";
        update(sql, YW, new Object[]{year,month,xmbh});
        sql = "insert into hx_gdtl(xmmc,nd,jd,dl,gm,cb,sy,zj,zuj,xmguid,yf,dlz,gmz,cbz,syz,zjz) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int flag = update(sql, YW, new Object[] { xmmc, year, season, dl, gm, cb, sy, zj, zujin,xmbh,month,dlz,gmz,cbz,syz,zjz});
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
     * <br>Description:更新供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void update() {
        String gdbh = request.getParameter("gdbh");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String cb = request.getParameter("cb");
        String sy = request.getParameter("sy");
        String zj = request.getParameter("zj");
        String dlz = request.getParameter("dlbl");
        String gmz = request.getParameter("gmbl");
        String cbz = request.getParameter("cbbl");
        String syz = request.getParameter("sybl");
        String zjz = request.getParameter("zjbl");
        String zujin = request.getParameter("zujin");
        String season = getSeason(month);
        String sql = "select nd,jd from hx_gdtl where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { gdbh });
        boolean seasonChange = false;
        String oldYear;
        String oldSeason;
        if (list.size() > 0) {
            Map<String, Object> map = list.get(0);
            oldYear = map.get("nd").toString();
            oldSeason = map.get("jd").toString();
            if (oldYear.equals(year) && oldSeason.equals(season)) {

            } else {
                seasonChange=judgeCount(year,season,gdbh);
            }
        }
        sql = "update hx_gdtl set nd=?,jd=?,dl=?,gm=?,cb=?,sy=?,zj=?,zuj=?,dlz=?,gmz=?,cbz=?,syz=?,zjz=?,yf=? where yw_guid=?";
        int flag = update(sql, YW, new Object[] { year, season, dl, gm, cb, sy, zj, zujin,dlz,gmz,cbz,syz,zjz,month,gdbh});
        if (flag == 0) {
            response("{success:false}");
        } else {
            if (seasonChange) {
                //删除旧的时序关联
                removeFromSx(year, season, gdbh);
                //插入新的时序关联
                insertToSx(year, season, gdbh);
            }
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:删除供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void delete() {
        String gdbh = request.getParameter("gdbh");
        String sql="select nd,jd,xmguid from hx_gdtl where yw_guid=?";
        List<Map<String,Object>> list=query(sql,YW,new Object[]{gdbh});
        if(list.size()>0){
            Map<String,Object> map=list.get(0);
            String nd=map.get("nd").toString();
            String jd=map.get("jd").toString();
            String xmbh=map.get("xmguid").toString();
            boolean isSingle=judgeCount(nd, jd, xmbh);
            sql = "delete from hx_gdtl where yw_guid=?";
            int flag = update(sql, YW, new Object[] { gdbh });
            if (flag == 0) {
                response("{success:false}");
            } else {
                if(isSingle){
                    removeFromSx(nd, jd, xmbh);
                }
                response("{success:true}");
            }
        }
        response("{success:false}");
    }

    /**
     * 
     * <br>Description:供地体量查询
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void query() {
        String xmbh = request.getParameter("xmbh");  
        String keyWord=request.getParameter("keyWord");
        String sql="select xmmc,nd||'-'||yf as sx,dl,gm,cb,sy,zj,zuj as zujin,rownum-1 as mod,rownum-1 as del,yw_guid  as gdbh,dlz,gmz,cbz,syz,zjz,yf from hx_gdtl where xmguid=?";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql+=" and nd||'-'||yf like '%"+keyWord+"%'";
        }
        List<Map<String,Object>> list=query(sql,YW,new Object[]{xmbh});
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
     * <br>Description:将项目供地体量关联时序
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     */
    private void insertToSx(String nd, String jd, String xmbh) {
        String sql = "select gdtl from hx_sx where nd=? and jd=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { nd, jd });
        if (list.size() > 0) {
            Object obj= list.get(0).get("gdtl");
            String gdtls =obj==null?"":obj.toString();
            if (gdtls.indexOf(xmbh) < 0) {
                StringBuffer sb = new StringBuffer(gdtls);
                sql = "update hx_sx set gdtl =? where nd=? and jd=?";
                if (sb.length() > 0) {
                    sb.append(",").append(xmbh);
                } else {
                    sb.append(xmbh);
                }
                update(sql, YW, new Object[] { sb.toString(), nd, jd });
            }
        } else {
            sql = "insert into hx_sx(nd,jd,gdtl) values(?,?,?)";
            update(sql, YW, new Object[] { nd, jd, xmbh });
        }
    }

    /**
     * 
     * <br>Description:将项目供地体量从时序移除
     * <br>Author:陈强峰
     * <br>Date:2013-10-14
     * @param nd
     * @param jd
     * @param xmbh
     */
    private void removeFromSx(String nd, String jd, String xmbh) {
        String sql = "select gdtl from hx_sx where nd=? and jd=?";
        List<Map<String, Object>> listGdtl = query(sql, YW, new Object[] { nd, jd });
        if(listGdtl.size()>0){
            Object obj=listGdtl.get(0).get("gdtl");
            String gdtls = obj==null?"":obj.toString();
            if (gdtls.indexOf(xmbh) >= 0) {
                gdtls = gdtls.replace(xmbh + ",", "").replace(xmbh, "");
                sql = "update hx_sx set gdtl =? where nd=? and jd=?";
                update(sql, YW, new Object[] { gdtls, nd, jd });
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
        String sql = "select yw_guid from hx_gdtl where nd=? and jd=? and xmguid=?";
        List<Map<String, Object>> listCount = query(sql, YW, new Object[] { nd, jd, xmbh });
        if (listCount.size() ==1) {
            return true;
        }
        return false;
    }
}
