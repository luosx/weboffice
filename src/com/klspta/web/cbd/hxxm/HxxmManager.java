package com.klspta.web.cbd.hxxm;

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
    public void addKftl(){
        Kftl re = new Kftl();
        re.request = this.request;
        re.response = this.response;
    }
}
