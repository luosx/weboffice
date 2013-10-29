package com.klspta.web.cbd.yzt.zrb;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:自然斑管理类
 * <br>Description:管理自然斑数据
 * <br>Author:黎春行
 * <br>Date:2013-10-18
 */
public class ZrbManager extends AbstractBaseBean {

    /**
     * 
     * <br>Description:获取所有自然斑列表
     * <br>Author:黎春行
     * <br>Date:2013-10-18
     */
    public void getZrb() {
        HttpServletRequest request = this.request;
        response(new ZrbData().getAllList(request));
    }

    /**
     * 
     * <br>Description:根据关键字查询自然斑列表
     * <br>Author:黎春行
     * <br>Date:2013-10-21
     */
    public void getQuery() {
        HttpServletRequest request = this.request;
        response(new ZrbData().getQuery(request));
    }

    /**
     * 
     * <br>Description:更新自然斑
     * <br>Author:黎春行
     * <br>Date:2013-10-22
     */
    public void updateZrb() {
        HttpServletRequest request = this.request;
        if (new ZrbData().updateZrb(request)) {
            response("{success:true}");
        } else {
            response("{success:false}");
        }
    }
}
