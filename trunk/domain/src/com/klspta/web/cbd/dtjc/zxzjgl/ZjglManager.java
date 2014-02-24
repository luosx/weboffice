package com.klspta.web.cbd.dtjc.zxzjgl;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.CBDReportManager;

public class ZjglManager extends AbstractBaseBean{
    public void selectYear(){
        String year = request.getParameter("year");
        StringBuffer buffer = new CBDReportManager().getReport("ZXSYQK", new Object[] { year,"false" });
        response(buffer.toString());
    }
    
    
}
