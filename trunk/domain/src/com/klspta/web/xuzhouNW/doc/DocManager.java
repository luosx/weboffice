package com.klspta.web.xuzhouNW.doc;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;

/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息：
 * <bean name="simpleExample" class="com.klspta.model.SimpleExample" scope="prototype"/>
 * @author wang
 *
 */
@Component
public class DocManager extends AbstractBaseBean {

    public DocManager() {
      
    }
    
    /**
     * 
     * <br>Description:获取书签值下载
     * <br>Author:陈强峰
     * <br>Date:2013-4-2
     */
    public void GetFieValue() {
        String docId = request.getParameter("id");
        String yw_guid = request.getParameter("yw_guid");
        int formId=Integer.parseInt(docId);
        String sql="select tablename,keyfield from doc_code where docid=?";
        List<Map<String,Object>> list=query(sql,YW,new Object[]{formId});
        if(list.size()>0&&yw_guid!=null){
            String tablename=list.get(0).get("tablename").toString();
            String keyword=list.get(0).get("keyfield").toString();
            sql="select * from "+tablename+" where "+keyword+" =?"; 
            list=query(sql,YW,new Object[]{yw_guid});
            if(list.size()>0){
                response(list);
            } else{
                response("null");
            }
        }else{
            response("null");
        }
    }
}
