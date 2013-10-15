package com.klspta.web.cbd.hxxm;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:红线项目管理
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2013-10-10
 */
@Component
public class HxxmManager extends AbstractBaseBean {
    /**
     * 
     * <br>Description:获取项目信息
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void getXmmc(){
        String xmbh=request.getParameter("xmbh").toString();
        String sql="select xmname,zd,hs,gm,zzcqfy,qycqfy,cqhbtz,lmcb,lmcjj,zj,lmcjj,fwsj from jc_xiangmu where yw_guid=?";
        List<Map<String,Object>> list=query(sql,YW,new Object[]{xmbh});
        response(list);
    }
    
    
    /**
     * 
     * <br>Description:新增开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void addKftl(){
        Kftl re = new Kftl();
        re.request = this.request;
        re.response = this.response;
        re.add();
    }
    
    /**
     * 
     * <br>Description:新增供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void addGdtl(){
        Gdtl gd = new Gdtl();
        gd.request = this.request;
        gd.response = this.response;
        gd.add();
    }
    
    /**
     * 
     * <br>Description:更新开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void updateKftl(){
        Kftl re = new Kftl();
        re.request = this.request;
        re.response = this.response;
        re.update();
    }
    
    /**
     * 
     * <br>Description:更新供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void updateGdtl(){
        Gdtl gd = new Gdtl();
        gd.request = this.request;
        gd.response = this.response;
        gd.update();
    }
    
    /**
     * 
     * <br>Description:删除开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void delKftl(){
        Kftl re = new Kftl();
        re.request = this.request;
        re.response = this.response;
        re.delete();
    }
    
    /**
     * 
     * <br>Description:删除供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void delGdtl(){
        Gdtl gd = new Gdtl();
        gd.request = this.request;
        gd.response = this.response;
        gd.delete();
    }
    
    
    /**
     * 
     * <br>Description:查询开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void queryKftl(){
        Kftl re = new Kftl();
        re.request = this.request;
        re.response = this.response;
        re.query();
    }
    
    /**
     * 
     * <br>Description:查询供地体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void queryGdtl(){
        Gdtl gd = new Gdtl();
        gd.request = this.request;
        gd.response = this.response;
        gd.query();
    }
}
