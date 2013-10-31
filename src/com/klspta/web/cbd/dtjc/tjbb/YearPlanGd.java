package com.klspta.web.cbd.dtjc.tjbb;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class YearPlanGd extends AbstractBaseBean implements IDataClass {

    public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
        Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
        String sql = "select distinct(nd) from hx_sx order by nd";
        List<Map<String, Object>> listNd = query(sql, YW);

        sql = "select distinct(xmname) as xmmc from jc_xiangmu t ";
        List<Map<String, Object>> list = query(sql, YW);
        if (list.size() > 0) {
            int count = list.size();
            String xmmc = "";
            List<Map<String, Object>> trList;
            for (int i = 0; i < count; i++) {
                xmmc = list.get(i).get("xmmc").toString();
                StringBuffer sb = new StringBuffer("select ");
                int ndCount = listNd.size();
                Object[] objs = new Object[ndCount * 2 + 1];
                for (int t = 0; t < ndCount; t++) {
                    sb.append("(select  sum(t.dl)  from hx_gdtl t  where xmmc = ? and nd =?) as ")
                            .append("s").append(i).append(",");
                    objs[t * 2] = xmmc;
                    objs[t * 2 + 1] = listNd.get(t).get("nd");
                }
                sb.append("(select  sum(t.dl)  from hx_gdtl t  where xmmc = ?) as ").append("s").append(i)
                        .append(",");
                objs[ndCount * 2] = xmmc;
                sb.replace(sb.length() - 1, sb.length(), " from dual");
                trList = query(sb.toString(), YW, objs);
                TRBean trb = new TRBean();
                trb.setCssStyle("trsingle");

                TDBean tdbxh = new TDBean(i+1+ "", "20", "");
                TDBean tdbtz = new TDBean("规模", "40", "");
                TDBean tdbmc = new TDBean(xmmc, "150", "");
                trb.addTDBean(tdbxh);
                trb.addTDBean(tdbtz);
                trb.addTDBean(tdbmc);
                if (trList.size() > 0) {
                    Map<String, Object> mapKf = trList.get(0);
                    for (int z = 0; z <= ndCount; z++) {
                        TDBean tb = new TDBean(checkNull(mapKf.get("s" + z)), "", "");
                        trb.addTDBean(tb);
                    }
                } else {
                    for (int z = 0; z <= ndCount; z++) {
                        TDBean tb = new TDBean("", "", "");
                        trb.addTDBean(tb);
                    }
                }
                trbeans.put("gd" + tdbxh.getText(), trb);
            }
        }
        return trbeans;
    }

    private String checkNull(Object obj) {
        if (obj == null) {
            return "";
        }
        return obj.toString();
    }
}
