package com.klspta.web.cbd.hxxm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;

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
        String season = request.getParameter("season");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String cb = request.getParameter("cb");
        String sy = request.getParameter("sy");
        String zj = request.getParameter("zj");
        String zujin = request.getParameter("zujin");
        String sql = "insert into hx_gdtl(xmmc,nd,jd,dl,gm,cb,sy,zj,zuj,xmguid) values(?,?,?,?,?,?,?,?,?,?)";
        int flag = update(sql, YW, new Object[] { xmmc, year, season, dl, gm, cb, sy, zj, zujin,xmbh});
        if (flag == 1) {
            sql = "select gdtl from hx_sssx where nd=? and jd=?";
            List<Map<String, Object>> list = query(sql, YW, new Object[] { year, season });
            if (list.size() > 0) {
                String kftls=list.get(0).get("gdtl").toString();
                if(kftls.indexOf(xmbh)<0){
                    StringBuffer sb=new StringBuffer(kftls);
                    sql="update hx_sssx set gdtl =? where nd=?,jd=?";
                    if(sb.length()>0){
                        sb.append(",").append(xmbh);
                    }else{
                        sb.append(xmbh);
                    }
                     update(sql,YW,new Object[]{sb.toString(),year,season}); 
                }
            }else{
                sql="insert into hx_sssx(nd,jd,gdtl) values(?,?,?)";
                update(sql,YW,new Object[]{year,season,xmbh});
            }
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
        String season = request.getParameter("season");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String cb = request.getParameter("cb");
        String sy = request.getParameter("sy");
        String zj = request.getParameter("zj");
        String zujin = request.getParameter("zujin");
        String sql = "update hx_gdtl set nd=?,jd=?,dl=?,gm=?,cb=?,sy=?,zj=?,zuj=? where yw_guid=?";
        int flag = update(sql, YW, new Object[] { year, season, dl, gm, cb, sy, zj, zujin, gdbh });
        if (flag == 0) {
            response("{success:false}");
        } else {
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
        String sql = "delete from hx_gdtl where yw_guid=?";
        int flag = update(sql, YW, new Object[] { gdbh });
        if (flag == 0) {
            response("{success:false}");
        } else {
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:供地体量查询
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void query() {
        String xmbh = request.getParameter("xmbh");  
        String sql="select xmmc,nd||jd as sx,dl,gm,cb,sy,zj,zuj as zujin,rownum-1 as mod,yw_guid as del,gdbh from hx_gdtl where xmguid=?";
        List<Map<String,Object>> list=query(sql,YW,new Object[]{xmbh});
        response(list);
    }
}
