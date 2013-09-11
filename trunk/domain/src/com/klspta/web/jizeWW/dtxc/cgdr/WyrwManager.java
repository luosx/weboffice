package com.klspta.web.jizeWW.dtxc.cgdr;

import java.util.List;
import java.util.Map;

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
    
    /**
     * 
     * <br>Description:根据巡查成果的主键（yw_guid）,返回巡查成果的简略信息
     * <br>Author:黎春行
     * <br>Date:2013-9-6
     */
    public void getSimInfo(){
    	String simInfo = request.getParameter("simInfo");
    	String[] simArray = simInfo.split("##");
    	StringBuffer yw_guidBuffer = new StringBuffer();
    	yw_guidBuffer.append("('");
    	for(int i = 1; i < simArray.length; i++){
    		yw_guidBuffer.append(simArray[i]).append("',");
    	}
    	yw_guidBuffer.append("null)");
    	String simsql = "select t.yw_guid, t.yddw, substr(replace(replace(t.ydsj,'年','-'),'月','-'),0,length(t.ydsj) - 5) ydsj, t.jsqk, t.mj from DC_YDQKDCB t where t.yw_guid in " + yw_guidBuffer.toString();
    	List<Map<String, Object>> simList = query(simsql, YW);
    	response(simList);
    }
}
