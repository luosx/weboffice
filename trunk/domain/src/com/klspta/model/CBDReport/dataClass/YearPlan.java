package com.klspta.model.CBDReport.dataClass;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;

public class YearPlan extends AbstractBaseBean implements IDataClass {

    //select sum(t.hs) as hs,sum(t.dl) as dl,sum(t.gm) as gm,sum(t.tz) as tz,nd from hx_kftl t group by t.nd
    @Override
    public Map<String, TRBean> getTRBeans(Object[] obj) {
        Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
        String sql = "select distinct(xmname) as xmmc from jc_xiangmu t ";
        List<Map<String, Object>> list = query(sql, YW);
        if (list.size() > 0) {
            int count = list.size();
            String xmmc = "";
            List<Map<String, Object>> trList;
            for (int i = 0; i < count; i++) {
                xmmc = list.get(i).get("xmmc").toString();
                sql = "select (select  sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2011') as a,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2012') as b,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2013') as c,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2014') as d,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2015') as e,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2016') as f,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2017') as g,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2018') as h,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ? and nd = '2019') as i,"
                        + " (select sum(t.tz)  from hx_kftl t  where xmmc = ?) as j" + " from dual";
                trList = query(sql, YW, new Object[] { xmmc, xmmc, xmmc, xmmc, xmmc, xmmc, xmmc, xmmc, xmmc,
                        xmmc });
                Map<String, Object> map = trList.get(0);
                TRBean trb = new TRBean();
                TDBean tdbxh = new TDBean(i+"", "", "");
                TDBean tdbtz = new TDBean("投资", "", "");
                TDBean tdbmc = new TDBean(xmmc, "", "");
                trb.addTDBean(tdbxh);
                trb.addTDBean(tdbtz);
                trb.addTDBean(tdbmc);
                if (trList.size() > 0) {
                    TDBean tdb1 = new TDBean(checkNull(map.get("a")), "", "");
                    TDBean tdb2 = new TDBean(checkNull(map.get("b")), "", "");
                    TDBean tdb3 = new TDBean(checkNull(map.get("c")), "", "");
                    TDBean tdb4 = new TDBean(checkNull(map.get("d")), "", "");
                    TDBean tdb5 = new TDBean(checkNull(map.get("e")), "", "");
                    TDBean tdb6 = new TDBean(checkNull(map.get("f")), "", "");
                    TDBean tdb7 = new TDBean(checkNull(map.get("g")), "", "");
                    TDBean tdb8 = new TDBean(checkNull(map.get("h")), "", "");
                    TDBean tdb9 = new TDBean(checkNull(map.get("i")), "", "");
                    TDBean tdb10 = new TDBean(checkNull(map.get("j")), "", "");
                    trb.addTDBean(tdb1);
                    trb.addTDBean(tdb2);
                    trb.addTDBean(tdb3);
                    trb.addTDBean(tdb4);
                    trb.addTDBean(tdb5);
                    trb.addTDBean(tdb6);
                    trb.addTDBean(tdb7);
                    trb.addTDBean(tdb8);
                    trb.addTDBean(tdb9);
                    trb.addTDBean(tdb10);
                }else{
                    TDBean tdb1 = new TDBean("", "","");
                    TDBean tdb2 = new TDBean("", "", "");
                    TDBean tdb3 = new TDBean("", "", "");
                    TDBean tdb4 = new TDBean("", "", "");
                    TDBean tdb5 = new TDBean("", "", "");
                    TDBean tdb6 = new TDBean("", "", "");
                    TDBean tdb7 = new TDBean("", "", "");
                    TDBean tdb8 = new TDBean("", "", "");
                    TDBean tdb9 = new TDBean("", "", "");
                    TDBean tdb10 = new TDBean("", "", "");
                    trb.addTDBean(tdb1);
                    trb.addTDBean(tdb2);
                    trb.addTDBean(tdb3);
                    trb.addTDBean(tdb4);
                    trb.addTDBean(tdb5);
                    trb.addTDBean(tdb6);
                    trb.addTDBean(tdb7);
                    trb.addTDBean(tdb8);
                    trb.addTDBean(tdb9);
                    trb.addTDBean(tdb10);
                }
                trbeans.put(tdbxh.getText(), trb);
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
