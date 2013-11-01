package com.klspta.web.cbd.dtjc.tjbb;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class YearPlanKfgm extends AbstractBaseBean implements IDataClass{

    @Override
    public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
        Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
        String sql = "select distinct(nd) from hx_sx order by nd";
        List<Map<String, Object>> list = query(sql, YW);
        TRBean trb = trBean.copyStatic();
        if (list.size() > 0) {
            int count = list.size();
            List<Map<String, Object>> trList;
                StringBuffer sb = new StringBuffer("select ");
                Object[] objs = new Object[count];
                for (int t = 0; t < count; t++) {
                    sb.append("(select  sum(t.gm)  from hx_kftl t  where nd =?) as ").append("s").append(t)
                            .append(",");
                    objs[t] = list.get(t).get("nd");
                }
                sb.append("(select  sum(t.gm)  from hx_kftl t ) as ").append("s").append(count);
                sb.append(" from dual");
                trList = query(sb.toString(), YW, objs);
                if (trList.size() > 0) {
                    Map<String, Object> mapKf = trList.get(0);
                    for (int z = 0; z <= count; z++) {
                        TDBean tb = new TDBean(checkNull(mapKf.get("s" + z)), "", "");
                        trb.addTDBean(tb);
                    }
                } else {
                    for (int z = 0; z <= count; z++) {
                        TDBean tb = new TDBean("", "", "");
                        trb.addTDBean(tb);
                    }
                }
                trbeans.put("kfgm", trb);
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
