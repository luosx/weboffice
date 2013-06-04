package com.klspta.model.wyrw;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:任务操作入口
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2012-8-14
 */
@Component
public class WyrwManager extends AbstractBaseBean {

    public WyrwManager() {
    }

    /**
     * 
     * <br>Description:下载任务
     * <br>Author:陈强峰
     * <br>Date:2012-8-14
     */
    public void downTask() {
        WyrwDeal wyrw = new WyrwDeal();
        wyrw.request = this.request;
        wyrw.response = this.response;
        wyrw.expTaskTxt();
    }

    public void downTasks() {
        WyrwDeal wyrw = new WyrwDeal();
        wyrw.request = this.request;
        wyrw.response = this.response;
        wyrw.expTasks();
    }
    /**
     * 
     * <br>Description:导出任务
     * <br>Author:陈强峰
     * <br>Date:2012-8-14
     */
    public void impTask() {
        WyrwDeal wyrw = new WyrwDeal();
        wyrw.request = this.request;
        wyrw.response = this.response;
        wyrw.impTaskTxt();
    }

    /**
     * 
     * <br>Description:导出成果
     * <br>Author:陈强峰
     * <br>Date:2012-8-14
     */
    public void downResult() {
        ResultExp re = new ResultExp();
        re.request = this.request;
        re.response = this.response;
        re.expResult();
    }

    /**
     * 
     * <br>Description:成果导入（成果回传）
     * <br>Author:陈强峰
     * <br>Date:2012-8-14
     */
    public void uploadResult() {
        ResultImp rs = new ResultImp();
        rs.request = this.request;
        rs.response = this.response;
        rs.saveData();
    }
}
