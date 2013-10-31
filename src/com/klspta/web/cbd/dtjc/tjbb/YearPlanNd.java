package com.klspta.web.cbd.dtjc.tjbb;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class YearPlanNd extends AbstractBaseBean implements IDataClass {

    @Override
    public Map<String, TRBean> getTRBeans(Object[] obj,TRBean trBean) {
        Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
        String sql="select distinct(nd) from hx_sx order by nd";
        List<Map<String,Object>> list=query(sql,YW);
        TRBean trb =trBean.copyStatic();
        for(int i=0;i<list.size();i++){
             TDBean td=new TDBean(list.get(i).get("nd").toString(),"90","");
             trb.addTDBean(td);
        }
        TDBean td=new TDBean("合计","90","");
        trb.addTDBean(td);
        trbeans.put("nd",trb);
        return trbeans;
    }

}
