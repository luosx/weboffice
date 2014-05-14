package com.klspta.web.cbd.qyjc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class WgfxManager extends AbstractBaseBean{
    public static WgfxManager wgfxmanager;
    
    public static WgfxManager getInstcne() {
        if (wgfxmanager == null) {
            wgfxmanager = new WgfxManager();
        }
        return wgfxmanager;
    }
    
    public void save(){
        String bcdj = request.getParameter("bcdj");
        String jlgfzb = request.getParameter("jlgfzb");
        String djxs = request.getParameter("djxs");
        String azfsj = request.getParameter("azfsj");
        String asfshij = request.getParameter("asfshij");
        String zsbzf = request.getParameter("zsbzf");
        String ybbzf = request.getParameter("ybbzf");
        String jlbzf = request.getParameter("jlbzf");
        String tsrqbzf = request.getParameter("tsrqbzf");
        String gfbt = request.getParameter("gfbt");
        String sql = "update zzzsbz set bcdj=?,jlgfzb=?,djxs=?,azfsj=?,asfshij=?,zsbzf=?,ybbzf=?,jlbzf=?,tsrqbzf=?,gfbt=?";
        this.update(sql, YW, new Object[]{bcdj,jlgfzb,djxs,azfsj,asfshij,zsbzf,ybbzf,jlbzf,tsrqbzf,gfbt});
        response("{success:true}");
    }
    
    public List<Map<String,Object>> getList() {
        String sql = "select bcdj,jlgfzb,djxs,azfsj,asfshij,zsbzf,ybbzf,jlbzf,tsrqbzf,gfbt,bl1,bl2,bl3,bl4 from zzzsbz ";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getPgjkList(){
        String sql = "select ((t.bcdj*20)/1000)as pgjkone,((t.bcdj*40)/1000)as pgjktwo,((t.bcdj*60)/1000)as pgjkthree,((t.bcdj*80)/1000)as pgjkfour,((t.bcdj*50)/1000)as pgjkfive from zzzsbz t ";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getHbbcList(){
        String sql = "select (((t.bcdj*20)/1000)+t.zsbzf)as hbbcone,(((t.bcdj*40)/1000)+t.zsbzf)as hbbctwo,(((t.bcdj*60)/1000)+t.zsbzf)as hbbcthree,(((t.bcdj*80)/1000)+t.zsbzf)as hbbcfour,(((t.bcdj*50)/1000)+t.zsbzf)as hbbcfive from zzzsbz t ";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getBcbzList(){
        String sql = "select ((((t.bcdj*20)/1000)+t.zsbzf)/20)as bcbzone,((((t.bcdj*40)/1000)+t.zsbzf)/40)as bcbztwo,round(((((t.bcdj*60)/1000)+t.zsbzf)/60),1)as bcbzthree,((((t.bcdj*80)/1000)+t.zsbzf)/80)as bcbzfour,((((t.bcdj*50)/1000)+t.zsbzf)/50)as bcbzfive from zzzsbz t ";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getKgmazfList(){
        String sql = "select (t.djxs*20+t.jlgfzb)as kgmazfone,(t.djxs*40+t.jlgfzb)as kgmazftwo,(t.djxs*60+t.jlgfzb)as kgmazfthree,(t.djxs*80+t.jlgfzb)as kgmazffour,(t.djxs*50+t.jlgfzb)as kgmazffive from zzzsbz t";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getK1List(){
        String sql = "select ((t.djxs*20+t.jlgfzb)/20)as k1one,((t.djxs*40+t.jlgfzb)/40)as k1two,((t.djxs*60+t.jlgfzb)/60)as k1three,((t.djxs*80+t.jlgfzb)/80)as k1four,((t.djxs*50+t.jlgfzb)/50)as k1five from zzzsbz t";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getGfkList(){
        String sql = "select (((t.djxs*20+t.jlgfzb)*t.azfsj)/10000)as gfkone,(((t.djxs*40+t.jlgfzb)*t.azfsj)/10000)as gfktwo,(((t.djxs*60+t.jlgfzb)*t.azfsj)/10000)as gfkthree,(((t.djxs*80+t.jlgfzb)*t.azfsj)/10000)as gfkfour,(((t.djxs*50+t.jlgfzb)*t.azfsj)/10000)as gfkfive from zzzsbz t";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getZsjyList(){
        String sql = "select ((((t.bcdj*20)/1000)+t.zsbzf)-(((t.djxs*20+t.jlgfzb)*t.azfsj)/10000))as zsjyone,((((t.bcdj*40)/1000)+t.zsbzf)-(((t.djxs*40+t.jlgfzb)*t.azfsj)/10000))as zsjytwo,((((t.bcdj*60)/1000)+t.zsbzf)-(((t.djxs*60+t.jlgfzb)*t.azfsj)/10000))as zsjythree,((((t.bcdj*80)/1000)+t.zsbzf)-(((t.djxs*80+t.jlgfzb)*t.azfsj)/10000))as zsjyfour,((((t.bcdj*50)/1000)+t.zsbzf)-(((t.djxs*50+t.jlgfzb)*t.azfsj)/10000))as zsjyfive from zzzsbz t";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getBcList(){
        String sql = "select ((((t.djxs*20+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*20)/1000)+t.zsbzf)-(((t.djxs*20+t.jlgfzb)*t.azfsj)/10000)))as bcone,((((t.djxs*40+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*40)/1000)+t.zsbzf)-(((t.djxs*40+t.jlgfzb)*t.azfsj)/10000)))as bctwo,((((t.djxs*60+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*60)/1000)+t.zsbzf)-(((t.djxs*60+t.jlgfzb)*t.azfsj)/10000)))as bcthree,((((t.djxs*80+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*80)/1000)+t.zsbzf)-(((t.djxs*80+t.jlgfzb)*t.azfsj)/10000)))as bcfour,((((t.djxs*50+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*50)/1000)+t.zsbzf)-(((t.djxs*50+t.jlgfzb)*t.azfsj)/10000)))as bcfive from zzzsbz t";
        return query(sql, YW);
    }
    
    public List<Map<String,Object>> getSzList(){
        String sql = "select cast(round((((((t.djxs*20+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*20)/1000)+t.zsbzf)-(((t.djxs*20+t.jlgfzb)*t.azfsj)/10000)))/20),1) as numeric(20,1))as bcone,cast(round((((((t.djxs*40+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*40)/1000)+t.zsbzf)-(((t.djxs*40+t.jlgfzb)*t.azfsj)/10000)))/40),1) as numeric(20,1))as bctwo,cast(round((((((t.djxs*60+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*60)/1000)+t.zsbzf)-(((t.djxs*60+t.jlgfzb)*t.azfsj)/10000)))/60),1) as numeric(20,1))as bcthree,cast(round((((((t.djxs*80+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*80)/1000)+t.zsbzf)-(((t.djxs*80+t.jlgfzb)*t.azfsj)/10000)))/80),1) as numeric(20,1))as bcfour,cast(round((((((t.djxs*50+t.jlgfzb)*t.asfshij)/10000)+((((t.bcdj*50)/1000)+t.zsbzf)-(((t.djxs*50+t.jlgfzb)*t.azfsj)/10000)))/50),1) as numeric(20,1))as bcfive from zzzsbz t";
        return query(sql, YW);
    }
}
