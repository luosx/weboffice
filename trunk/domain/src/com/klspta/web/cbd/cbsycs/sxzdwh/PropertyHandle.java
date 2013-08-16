package com.klspta.web.cbd.cbsycs.sxzdwh;

import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class PropertyHandle extends AbstractBaseBean {
    
    /**
     * 
     * <br>Description:生成属性字段维护页面的Yw_guid.
     * <br>Author:王雷
     * <br>Date:2013-8-15
     */
    public void generateYw_guid(){
        String yw_guid= UtilFactory.getStrUtil().getGuid();
        String basePath = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + request.getContextPath()
                + "/";
        StringBuffer url = new StringBuffer();
        url.append(basePath);
        url.append("/web/cbd/cbsycs/sxzdwh/propertyconfig.jsp?jdbcname=YWTemplate&yw_guid=");
        url.append(yw_guid);
        redirect(url.toString());       
    }
    
    
    public void bindData(){
        String yw_guid = request.getParameter("yw_guid");
        String sql="select t.shuxing,t.ziduanming,t.bieming,t.fangshi,t.gongshi,t.sort from propertyconfig t where t.yw_guid=? order by t.num asc";
        List<Map<String,Object>> list = query(sql,YW,new Object[]{yw_guid});
        response(list);     
    }
    
}
