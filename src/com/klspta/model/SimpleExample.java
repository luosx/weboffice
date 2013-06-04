package com.klspta.model;


import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.AbstractDataBaseSupport;
/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息：
 * <bean name="simpleExample" class="com.klspta.model.SimpleExample" scope="prototype"/>
 * @author wang
 *
 */
@Component
public class SimpleExample extends AbstractBaseBean {
    
    public SimpleExample(){
        //System.out.println("" + this.getClass().getName());
    }
    public void aaaa(){
        System.out.println(request.getParameter("zhege"));
/*        String sql = "delete from ZFJC_HONGXIAN where RECID = '100001'";
        query(sql, SDE);
        execute(sql, GIS);
        Map<String,Integer> mm = new HashMap<String,Integer>();
        mm.put("code", 1);
        mm.put("obj", 2);
        putParameter(mm);*/
        List<Map<String, Object>> list = query("select * from testtable t", AbstractDataBaseSupport.CORE);
        response(list);
    }
}
