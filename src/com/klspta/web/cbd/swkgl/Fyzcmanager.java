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
        String dklx = request.getParameter("dklx");
        String jzrq = request.getParameter("jzrq");
        String jzrqs = request.getParameter("jzrqs");
        dklx = UtilFactory.getStrUtil().unescape(dklx);
        jzrq = UtilFactory.getStrUtil().unescape(jzrq);
        jzrqs = UtilFactory.getStrUtil().unescape(jzrqs);
        if (sj != null && !sj.equals("")){
            String[] date = sj.split("@");
            for (int i = 0; i < date.length; i++){
                String[] split = date[i].split("_");
                String yw_guid = split[0];
                String xh = split[1];
                String value = split[2];
                String update = "update fyzc set "+xh+"='" + value+"',dklx='"+dklx+"',jzrq='"+jzrq+"',jzrqs='"+jzrqs+"' where yw_guid=?";
                this.update(update, YW, new Object[] {yw_guid});
            }
        }
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
        String dklx = request.getParameter("dklx");
        String jzrq = request.getParameter("jzrq");
        String jzrqs = request.getParameter("jzrqs");
        
        
        mc = UtilFactory.getStrUtil().unescape(mc);
        dklx = UtilFactory.getStrUtil().unescape(dklx);
        jzrq = UtilFactory.getStrUtil().unescape(jzrq);
        jzrqs = UtilFactory.getStrUtil().unescape(jzrqs);
        String insertString = "insert into fyzc  (mc, gzfy, gzgm, cbzj, gzdj, lyfy, lygm, qmfy, jzmj,zyzj, pmft, lyft, clft, ze, jhcb, xj, dj, jhcbs, xjs, djs,dklx,jzrq,jzrqs)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int i = update(insertString, YW, new Object[] { mc, gzfy, gzgm, cbzj, gzdj, lyfy, lygm, qmfy, jzmj,
                zyzj, pmft, lyft, clft, ze, jhcb, xj, dj, jhcbs, xjs, djs,dklx,jzrq,jzrqs });
        if (i > 0) {
            response("success");
        } else {
            response("failure");
        }
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
                "<table><tr><td rowspan='2' colspan='1' class='tr01'>名称</td><td colspan='4' rowspan='1' class='tr01'>购置情况</td><td colspan='2' rowspan='1' class='tr01'>利用情况</td><td colspan='3' rowspan='1' class='tr01'>期末存量情况</td><td colspan='4' rowspan='1' class='tr01'><input id='dklx' style='border:0;background:transparent;' value="
                        + dklx
                        + "></td><td colspan='3' rowspan='1' class='tr01'><input id='jzrq' style='border:0;background:transparent;' value="
                        + jzrq
                        + "></td><td colspan='3' rowspan='1' class='tr01'><input id='jzrqs' style='border:0;background:transparent;' value="
                        + jzrqs
                        + "></td></tr><tr><td colspan='1' rowspan='1' class='tr01'>房源</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>动用储备资金</td><td colspan='1' rowspan='1' class='tr01'>购置单位</td><td colspan='1' rowspan='1' class='tr01'>房源</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>房源</td><td colspan='1' rowspan='1' class='tr01'>建筑面积</td><td colspan='1' rowspan='1' class='tr01'>占压资金</td><td colspan='1' rowspan='1' class='tr01'>每平米分摊</td><td colspan='1' rowspan='1' class='tr01'>已利用分摊</td><td colspan='1' rowspan='1' class='tr01'>期末存量分摊</td><td colspan='1' rowspan='1' class='tr01'>总额</td><td colspan='1' rowspan='1' class='tr01'>机会成本分摊利息</td><td colspan='1' rowspan='1' class='tr01'>小计</td><td colspan='1' rowspan='1' class='tr01'>当前单价</td><td colspan='1' rowspan='1' class='tr01'>机会成本分摊利息</td><td colspan='1' rowspan='1' class='tr01'>小计</td><td colspan='1' rowspan='1' class='tr01'>当前单价</td></tr>");
        String allsql = "select t.mc,t.gzfy,t.gzgm,t.cbzj,t.gzdj,t.lyfy,t.lygm,t.qmfy,t.jzmj,t.zyzj,t.pmft,t.lyft,t.clft,t.ze,t.jhcb,t.xj,t.dj,t.jhcbs,t.xjs,t.djs,t.yw_guid from fyzc t";
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
            String yw_guid = (String) (alllist.get(i)).get("yw_guid");
            result.append("<tr><td><input id='"+yw_guid+"_"+"mc'  onchange=\"chang(this)\" style='border:0;background:transparent;' value='" + mc + "'/></td><td><input id='"+yw_guid+"_"+"gzfy' onchange='chang(this)' style='border:0;background:transparent;' value='" + gzfy + "'/></td><td><input id='"+yw_guid+"_"+"gzgm' onchange='chang(this)' style='border:0;background:transparent;' value='" + gzgm + "'/></td><td><input id='"+yw_guid+"_"+"cbzj' onchange='chang(this)' style='border:0;background:transparent;' value='" + cbzj
                    + "'/></td><td><input id='"+yw_guid+"_"+"gzdj' onchange=\"chang(this)\" style='border:0;background:transparent;' value='" + gzdj + "'/></td><td><input id='"+yw_guid+"_"+"lyfy' onchange='chang(this)' style='border:0;background:transparent;' value='" + lyfy + "'/></td><td><input id='"+yw_guid+"_"+"lygm' onchange='chang(this)' style='border:0;background:transparent;' value='" + lygm + "'/></td><td><input id='"+yw_guid+"_"+"qmfy' onchange='chang(this)' style='border:0;background:transparent;' value='" + qmfy
                    + "'/></td><td><input id='"+yw_guid+"_"+"jzmj' onchange=\"chang(this)\" style='border:0;background:transparent;' value='" + jzmj + "'/></td><td><input id='"+yw_guid+"_"+"zyzj' onchange='chang(this)' style='border:0;background:transparent;' value='" + zyzj + "'/></td><td><input id='"+yw_guid+"_"+"pmft' onchange='chang(this)' style='border:0;background:transparent;' value='" + pmft + "'/></td><td><input id='"+yw_guid+"_"+"lyft' onchange='chang(this)' style='border:0;background:transparent;' value='" + lyft
                    + "'/></td><td><input id='"+yw_guid+"_"+"clft' onchange=\"chang(this)\" style='border:0;background:transparent;' value='" + clft + "'/></td><td><input id='"+yw_guid+"_"+"ze' onchange='chang(this)' style='border:0;background:transparent;' value='" + ze + "'/></td><td><input id='"+yw_guid+"_"+"jhcb' onchange='chang(this)' style='border:0;background:transparent;' value='" + jhcb + "'/></td><td><input id='"+yw_guid+"_"+"xj' onchange='chang(this)' style='border:0;background:transparent;' value='" + xj
                    + "'/></td><td><input id='"+yw_guid+"_"+"dj' onchange=\"chang(this)\" style='border:0;background:transparent;' value='" + dj + "'/></td><td><input id='"+yw_guid+"_"+"jhcbs' onchange='chang(this)' style='border:0;background:transparent;' value='" + jhcbs + "'/></td><td><input id='"+yw_guid+"_"+"xjs' onchange='chang(this)' style='border:0;background:transparent;' value='" + xjs + "'/></td><td><input id='"+yw_guid+"_"+"djs' onchange='chang(this)' style='border:0;background:transparent;' value='" + djs
                    + "'/></td></tr>");
        }
        String sumsql = "select sum(gzfy)as gzfy,sum(gzgm)as gzgm,sum(cbzj)as cbzj,sum(gzdj)as gzdj,sum(lyfy)as lyfy,sum(lygm)as lygm,sum(qmfy)as qmfy,sum(jzmj)as jzmj,sum(zyzj)as zyzj,sum(pmft)as pmft,sum(lyft)as lyft,sum(clft)as clft,sum(ze)as ze,sum(jhcb)as jhcb,sum(xj)as xj,sum(dj)as dj,sum(jhcbs)as jhcbs,sum(xjs)as xjs,sum(djs)as djs from fyzc t";
        List<Map<String, Object>> sumlist = query(sumsql, YW);
        for(int i=0;i<sumlist.size();i++){
            String sumgzfy = (String) (sumlist.get(i)).get("gzfy").toString();
            String sumgzgm = (String) (sumlist.get(i)).get("gzgm").toString();
            String sumcbzj = (String) (sumlist.get(i)).get("cbzj").toString();
            String sumgzdj = (String) (sumlist.get(i)).get("gzdj").toString();
            String sumlyfy = (String) (sumlist.get(i)).get("lyfy").toString();
            String sumlygm = (String) (sumlist.get(i)).get("lygm").toString();
            String sumqmfy = (String) (sumlist.get(i)).get("qmfy").toString();
            String sumjzmj = (String) (sumlist.get(i)).get("jzmj").toString();
            String sumzyzj = (String) (sumlist.get(i)).get("zyzj").toString();
            String sumpmft = (String) (sumlist.get(i)).get("pmft").toString();
            String sumlyft = (String) (sumlist.get(i)).get("lyft").toString();
            String sumclft = (String) (sumlist.get(i)).get("clft").toString();
            String sumze = (String) (sumlist.get(i)).get("ze").toString();
            String sumjhcb = (String) (sumlist.get(i)).get("jhcb").toString();
            String sumxj = (String) (sumlist.get(i)).get("xj").toString();
            String sumdj = (String) (sumlist.get(i)).get("dj").toString();
            String sumjhcbs = (String) (sumlist.get(i)).get("jhcbs").toString();
            String sumxjs = (String) (sumlist.get(i)).get("xjs").toString();
            String sumdjs = (String) (sumlist.get(i)).get("djs").toString();
            result.append("<tr><td class='tr01'>总计</td><td class='tr01'>"+sumgzfy+"</td><td class='tr01'>"+sumgzgm+"</td><td class='tr01'>"+sumcbzj+"</td><td class='tr01'>"+sumgzdj+"</td><td class='tr01'>"+sumlyfy+"</td><td class='tr01'>"+sumlygm+"</td><td class='tr01'>"+sumqmfy+"</td><td class='tr01'>"+sumjzmj+"</td><td class='tr01'>"+sumzyzj+"</td><td class='tr01'>"+sumpmft+"</td><td class='tr01'>"+sumlyft+"</td>v<td class='tr01'>"+sumclft+"</td><td class='tr01'>"+sumze+"</td><td class='tr01'>"+sumjhcb+"</td><td class='tr01'>"+sumxj+"</td><td class='tr01'>"+sumdj+"</td><td class='tr01'>"+sumjhcbs+"</td><td class='tr01'>"+sumxjs+"</td><td class='tr01'>"+sumdjs+"</td></tr>");
        }
        result.append("</table>");
        return result.toString().replaceAll("null", "");
    }

}
