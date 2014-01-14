package com.klspta.web.cbd.swkgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class Fyzcmanager extends AbstractBaseBean {
    private static Fyzcmanager Fyzcmanager;

    public static Fyzcmanager getInstcne() {
        if (Fyzcmanager == null) {
            Fyzcmanager = new Fyzcmanager();
        }
        return Fyzcmanager;
    }

    public void saveFyzc() {
        String mc = request.getParameter("mc");
        String gzfy = request.getParameter("gzfy");
        String gzgm = request.getParameter("gzgm");
        String cbzj = request.getParameter("cbzj");
        String gzdj = request.getParameter("gzdj");
        String lyfy = request.getParameter("lyfy");
        String lygm = request.getParameter("lygm");
        String qmfy = request.getParameter("qmfy");
        String jzmj = request.getParameter("jzmj");
        String zyzj = request.getParameter("zyzj");
        String pmft = request.getParameter("pmft");
        String lyft = request.getParameter("lyft");
        String clft = request.getParameter("clft");
        String ze = request.getParameter("ze");
        String jhcb = request.getParameter("jhcb");
        String xj = request.getParameter("xj");
        String dj = request.getParameter("dj");
        String jhcbs = request.getParameter("jhcbs");
        String xjs = request.getParameter("xjs");
        String djs = request.getParameter("djs");
        String yw_guid = request.getParameter("yw_guid");
        mc = UtilFactory.getStrUtil().unescape(mc);
        String insertString = "insert into fyzc (mc,gzfy,gzgm,cbzj,gzdj,lyfy,lygm,qmfy,jzmj,zyzj,pmft,lyft,clft,ze,jhcb,xj,dj,jhcbs,xjs,djs,yw_guid)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int i = update(insertString, YW, new Object[] { mc, gzfy, gzgm, cbzj, gzdj, lyfy, lygm, qmfy, jzmj,
                zyzj, pmft, lyft, clft, ze, jhcb, xj, dj, jhcbs, xjs, djs, yw_guid });
        if (i > 0) {
            response("success");
        } else {
            response("failure");
        }
    }

    public void set() {
        String dklx = UtilFactory.getStrUtil().unescape(request.getParameter("dklx"));
        String jzrq = UtilFactory.getStrUtil().unescape(request.getParameter("jzrq"));
        String jzrqs = UtilFactory.getStrUtil().unescape(request.getParameter("jzrqs"));
        String updateString = "update fyzc set dklx ='" + dklx + "',jzrq='" + jzrq + "',jzrqs='" + jzrqs
                + "'";
        this.update(updateString, YW);
        response("success");
    }

    public String getList() {
        String sql = "select distinct dklx from fyzc";
        List<Map<String, Object>> list = query(sql, YW);
        String dklx = (String) (list.get(0)).get("dklx");
        String sql2 = "select distinct jzrq from fyzc";
        List<Map<String, Object>> list2 = query(sql2, YW);
        String jzrq = (String) (list2.get(0)).get("jzrq");
        String sql3 = "select distinct jzrqs from fyzc";
        List<Map<String, Object>> list3 = query(sql3, YW);
        String jzrqs = (String) (list3.get(0)).get("jzrqs");
        StringBuffer result = new StringBuffer(
                "<table><tr><td rowspan='2' colspan='1' class='tr01'>名称</td><td colspan='4' rowspan='1' class='tr01'>购置情况</td><td colspan='2' rowspan='1' class='tr01'>利用情况</td><td colspan='3' rowspan='1' class='tr01'>期末存量情况</td><td colspan='4' rowspan='1' class='tr01'>"
                        + dklx
                        + "</td><td colspan='3' rowspan='1' class='tr01'>"
                        + jzrq
                        + "</td><td colspan='3' rowspan='1' class='tr01'>"
                        + jzrqs
                        + "</td></tr><tr><td colspan='1' rowspan='1' class='tr01'>房源</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>动用储备资金</td><td colspan='1' rowspan='1' class='tr01'>购置单位</td><td colspan='1' rowspan='1' class='tr01'>房源</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>房源</td><td colspan='1' rowspan='1' class='tr01'>建筑面积</td><td colspan='1' rowspan='1' class='tr01'>占压资金</td><td colspan='1' rowspan='1' class='tr01'>每平米分摊</td><td colspan='1' rowspan='1' class='tr01'>已利用分摊</td><td colspan='1' rowspan='1' class='tr01'>期末存量分摊</td><td colspan='1' rowspan='1' class='tr01'>总额</td><td colspan='1' rowspan='1' class='tr01'>机会成本分摊利息</td><td colspan='1' rowspan='1' class='tr01'>小计</td><td colspan='1' rowspan='1' class='tr01'>当前单价</td><td colspan='1' rowspan='1' class='tr01'>机会成本分摊利息</td><td colspan='1' rowspan='1' class='tr01'>小计</td><td colspan='1' rowspan='1' class='tr01'>当前单价</td></tr>");
        String allsql = "select t.mc,t.gzfy,t.gzgm,t.cbzj,t.gzdj,t.lyfy,t.lygm,t.qmfy,t.jzmj,t.zyzj,t.pmft,t.lyft,t.clft,t.ze,t.jhcb,t.xj,t.dj,t.jhcbs,t.xjs,t.djs from fyzc t";
        List<Map<String, Object>> alllist = query(allsql, YW);
        for (int i = 0; i < alllist.size(); i++) {
            String mc = (String) (alllist.get(i)).get("mc");
            String gzfy = (String) (alllist.get(i)).get("gzfy");
            String gzgm = (String) (alllist.get(i)).get("gzgm");
            String cbzj = (String) (alllist.get(i)).get("cbzj");
            String gzdj = (String) (alllist.get(i)).get("gzdj");
            String lyfy = (String) (alllist.get(i)).get("lyfy");
            String lygm = (String) (alllist.get(i)).get("lygm");
            String qmfy = (String) (alllist.get(i)).get("qmfy");
            String jzmj = (String) (alllist.get(i)).get("jzmj");
            String zyzj = (String) (alllist.get(i)).get("zyzj");
            String pmft = (String) (alllist.get(i)).get("pmft");
            String lyft = (String) (alllist.get(i)).get("lyft");
            String clft = (String) (alllist.get(i)).get("clft");
            String ze = (String) (alllist.get(i)).get("ze");
            String jhcb = (String) (alllist.get(i)).get("jhcb");
            String xj = (String) (alllist.get(i)).get("xj");
            String dj = (String) (alllist.get(i)).get("dj");
            String jhcbs = (String) (alllist.get(i)).get("jhcbs");
            String xjs = (String) (alllist.get(i)).get("xjs");
            String djs = (String) (alllist.get(i)).get("djs");
            result.append("<tr><td>" + mc + "</td><td>" + gzfy + "</td><td>" + gzgm + "</td><td>" + cbzj
                    + "</td><td>" + gzdj + "</td><td>" + lyfy + "</td><td>" + lygm + "</td><td>" + qmfy
                    + "</td><td>" + jzmj + "</td><td>" + zyzj + "</td><td>" + pmft + "</td><td>" + lyft
                    + "</td><td>" + clft + "</td><td>" + ze + "</td><td>" + jhcb + "</td><td>" + xj
                    + "</td><td>" + dj + "</td><td>" + jhcbs + "</td><td>" + xjs + "</td><td>" + djs
                    + "</td></tr>");
        }
        result.append("</table>");
        return result.toString().replaceAll("null", "");
    }

}
