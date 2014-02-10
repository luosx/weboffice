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
        String sj = request.getParameter("sj");
        String jzrq = request.getParameter("jzrq");
        jzrq = UtilFactory.getStrUtil().unescape(jzrq);
        sj = UtilFactory.getStrUtil().unescape(sj);
        if (sj != null && !sj.equals("")) {
            String[] date = sj.split("@");
            for (int i = 0; i < date.length; i++) {
                String[] split = date[i].split("_");
                String yw_guid = split[0];
                String xh = split[1];
                String value = split[2];
                String update = "update fyzc set " + xh + "='" + value + "' where yw_guid=?";
                this.update(update, YW, new Object[] { yw_guid });
            }
        }
        String sql = "update fyzc set jzrq='" + jzrq + "'";
        this.update(sql, YW);
        response("success");
    }

    public void addFyzc() {
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
        String ftlx = request.getParameter("ftlx");
        String fymc = request.getParameter("fymc");
        String ze = request.getParameter("ze");
        String pmft = request.getParameter("pmft");
        String lyft = request.getParameter("lyft");
        String jzft = request.getParameter("jzft");
        String jkzj = request.getParameter("jkzj");
        String dj = request.getParameter("dj");
        String jzrq = request.getParameter("jzrq");
        String bz = request.getParameter("bz");

        mc = UtilFactory.getStrUtil().unescape(mc);
        jzrq = UtilFactory.getStrUtil().unescape(jzrq);
        bz = UtilFactory.getStrUtil().unescape(bz);
        String insertString = "insert into fyzc  (mc, gzfy, gzgm, cbzj, gzdj, lyfy, lygm, qmfy, jzmj,zyzj,ftlx,fymc,ze,pmft, lyft, jzft, jkzj, dj, bz,jzrq)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int i = update(insertString, YW, new Object[] { mc, gzfy, gzgm, cbzj, gzdj, lyfy, lygm, qmfy, jzmj,
                zyzj, ftlx, fymc, ze, pmft, lyft, jzft, jkzj, dj, bz, jzrq });
        if (i > 0) {
            response("success");
        } else {
            response("failure");
        }
    }

    public String getList() {
        String sql = "select distinct jzrq from fyzc";
        List<Map<String, Object>> list2 = query(sql, YW);
        String jzrq = (String) (list2.get(0)).get("jzrq");
        StringBuffer result = new StringBuffer(
                "<table width='180%'><tr><td rowspan='2' colspan='1' class='tr01'>名称</td><td colspan='4' rowspan='1' class='tr01'>购置情况</td><td colspan='2' rowspan='1' class='tr01'>利用情况</td><td colspan='3' rowspan='1' class='tr01'>期末存量情况</td><td  class='tr01'><input id='jzrq' style='border:0;background:transparent;' value="
                        + jzrq
                        + "></td><td rowspan='1' colspan='5' class='tr01'>其他费用</td><td rowspan='2' colspan='1' class='tr01'>房屋价款总计</td><td rowspan='2' colspan='1' class='tr01'>当前单价</td><td rowspan='2' colspan='1' class='tr01'>备注</td><td rowspan='2' colspan='1' class='tr01'>操作</td></tr><tr><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>动用储备资金</td><td colspan='1' rowspan='1' class='tr01'>购置单价</td><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑面积</td><td colspan='1' rowspan='1' class='tr01'>占压资金</td><td colspan='1' rowspan='1' class='tr01'>分摊利息</td><td colspan='1' rowspan='1' class='tr01'>费用名称</td><td colspan='1' rowspan='1' class='tr01'>总金额</td><td colspan='1' rowspan='1' class='tr01'>每平米分摊</td><td colspan='1' rowspan='1' class='tr01'>已利用房源分摊</td><td colspan='1' rowspan='1' class='tr01'>结转房源分摊</td></tr>");
        String allsql = "select t.mc,t.gzfy,t.gzgm,t.cbzj,t.gzdj,t.jzmj,t.zyzj,t.pmft,t.lyft,t.ze,t.lyfy,t.lygm,t.dj,t.qmfy,t.ftlx,t.fymc,t.jzft,t.jkzj,t.bz,t.yw_guid from fyzc t";
        List<Map<String, Object>> alllist = query(allsql, YW);
        for (int i = 0; i < alllist.size(); i++) {
            String mc = (String) (alllist.get(i)).get("mc");
            String gzfy = (String) (alllist.get(i)).get("gzfy");
            String gzgm = (String) (alllist.get(i)).get("gzgm");
            String cbzj = (String) (alllist.get(i)).get("cbzj");
            String gzdj = (String) (alllist.get(i)).get("gzdj");
            String jzmj = (String) (alllist.get(i)).get("jzmj");
            String zyzj = (String) (alllist.get(i)).get("zyzj");
            String pmft = (String) (alllist.get(i)).get("pmft");
            String lyft = (String) (alllist.get(i)).get("lyft");
            String ze = (String) (alllist.get(i)).get("ze");
            String lyfy = (String) (alllist.get(i)).get("lyfy");
            String lygm = (String) (alllist.get(i)).get("lygm");
            String dj = (String) (alllist.get(i)).get("dj");
            String qmfy = (String) (alllist.get(i)).get("qmfy");
            String ftlx = (String) (alllist.get(i)).get("ftlx");
            String fymc = (String) (alllist.get(i)).get("fymc");
            String jzft = (String) (alllist.get(i)).get("jzft");
            String jkzj = (String) (alllist.get(i)).get("jkzj");
            String bz = (String) (alllist.get(i)).get("bz");
            String yw_guid = (String) (alllist.get(i)).get("yw_guid");
            result.append("<tr><td><input id='" + yw_guid + "_"
                    + "mc'   style='border:0;background:transparent;' value='" + mc
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "gzfy' onchange='chang(this)' style='border:0;background:transparent;' value='" + gzfy
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "gzgm' onchange='chang(this)' style='border:0;background:transparent;' value='" + gzgm
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "cbzj' onchange='chang(this)' style='border:0;background:transparent;' value='" + cbzj
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "gzdj' onchange=\"chang(this)\" style='border:0;background:transparent;' value='"
                    + gzdj + "'/></td><td><input id='" + yw_guid + "_"
                    + "lyfy' onchange='chang(this)' style='border:0;background:transparent;' value='" + lyfy
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "lygm' onchange='chang(this)' style='border:0;background:transparent;' value='" + lygm
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "qmfy' onchange='chang(this)' style='border:0;background:transparent;' value='" + qmfy
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "jzmj' onchange=\"chang(this)\" style='border:0;background:transparent;' value='"
                    + jzmj + "'/></td><td><input id='" + yw_guid + "_"
                    + "zyzj' onchange='chang(this)' style='border:0;background:transparent;' value='" + zyzj
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "ftlx' onchange='chang(this)' style='border:0;background:transparent;' value='" + ftlx
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "fymc' onchange='chang(this)' style='border:0;background:transparent;' value='" + fymc
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "ze' onchange=\"chang(this)\" style='border:0;background:transparent;' value='" + ze
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "pmft' onchange='chang(this)' style='border:0;background:transparent;' value='" + pmft
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "lyft' onchange='chang(this)' style='border:0;background:transparent;' value='" + lyft
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "jzft' onchange='chang(this)' style='border:0;background:transparent;' value='" + jzft
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "jkzj' onchange=\"chang(this)\" style='border:0;background:transparent;' value='"
                    + jkzj + "'/></td><td><input id='" + yw_guid + "_"
                    + "dj' onchange='chang(this)' style='border:0;background:transparent;' value='" + dj
                    + "'/></td><td><input id='" + yw_guid + "_"
                    + "bz' onchange='chang(this)' style='border:0;background:transparent;' value='" + bz
                    + "'/></td><td><a href=\"javascript:del('" + yw_guid + "')\">删除</a></td></tr>");
        }
        String sumsql = "select sum(gzfy)as gzfy,sum(gzgm)as gzgm,sum(cbzj)as cbzj,sum(gzdj)as gzdj,sum(lyfy)as lyfy,sum(lygm)as lygm,sum(qmfy)as qmfy,sum(jzmj)as jzmj,sum(zyzj)as zyzj,sum(ftlx)as ftlx,sum(fymc)as fymc,sum(ze)as ze,sum(pmft)as pmft,sum(lyft)as lyft,sum(jzft)as jzft,sum(jkzj)as jkzj,sum(dj)as dj from fyzc t";
        List<Map<String, Object>> sumlist = query(sumsql, YW);
        for (int i = 0; i < sumlist.size(); i++) {
            String sumgzfy = (String) (sumlist.get(i)).get("gzfy").toString();
            String sumgzgm = (String) (sumlist.get(i)).get("gzgm").toString();
            String sumcbzj = (String) (sumlist.get(i)).get("cbzj").toString();
            String sumgzdj = (String) (sumlist.get(i)).get("gzdj").toString();
            String sumlyfy = (String) (sumlist.get(i)).get("lyfy").toString();
            String sumlygm = (String) (sumlist.get(i)).get("lygm").toString();
            String sumqmfy = (String) (sumlist.get(i)).get("qmfy").toString();
            String sumjzmj = (String) (sumlist.get(i)).get("jzmj").toString();
            String sumzyzj = (String) (sumlist.get(i)).get("zyzj").toString();
            String sumftlx = (String) (sumlist.get(i)).get("ftlx").toString();
            String sumfymc = (String) (sumlist.get(i)).get("fymc").toString();
            String sumze = (String) (sumlist.get(i)).get("ze").toString();
            String sumpmft = (String) (sumlist.get(i)).get("pmft").toString();
            String sumlyft = (String) (sumlist.get(i)).get("lyft").toString();
            String sumjzft = (String) (sumlist.get(i)).get("jzft").toString();
            String jkzj = (String) (sumlist.get(i)).get("jkzj").toString();
            String sumdj = (String) (sumlist.get(i)).get("dj").toString();
            result.append("<tr><td class='tr01'>总计</td><td class='tr01'>" + sumgzfy
                    + "</td><td class='tr01'>" + sumgzgm + "</td><td class='tr01'>" + sumcbzj
                    + "</td><td class='tr01'>" + sumgzdj + "</td><td class='tr01'>" + sumlyfy
                    + "</td><td class='tr01'>" + sumlygm + "</td><td class='tr01'>" + sumqmfy
                    + "</td><td class='tr01'>" + sumjzmj + "</td><td class='tr01'>" + sumzyzj
                    + "</td><td class='tr01'>" + sumftlx + "</td><td class='tr01'>" + sumfymc
                    + "</td>v<td class='tr01'>" + sumze + "</td><td class='tr01'>" + sumpmft
                    + "</td><td class='tr01'>" + sumlyft + "</td><td class='tr01'>" + sumjzft
                    + "</td><td class='tr01'>" + jkzj + "</td><td class='tr01'>" + sumdj + "</td><td class='tr01'></td><td class='tr01'></td></tr>");
        }
        result.append("</table>");
        return result.toString().replaceAll("null", "");
    }

    public void delByYwGuid() {
        String yw_guid = request.getParameter("yw_guid");
        String sql = "delete from fyzc t where yw_guid='" + yw_guid + "'";
        this.update(sql, YW);
        response("success");
    }

}
