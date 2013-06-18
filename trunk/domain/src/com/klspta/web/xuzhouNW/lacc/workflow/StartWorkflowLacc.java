package com.klspta.web.xuzhouNW.lacc.workflow;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.workflow.foundations.IWorkflowInsOp;
import com.klspta.base.workflow.foundations.WorkflowInsOp;
import com.klspta.base.workflow.foundations.WorkflowOp;
import com.klspta.console.ManagerFactory;

public class StartWorkflowLacc extends AbstractBaseBean {
	public String yw_guid = "";

	/**
	 * 
	 * <br>Description:启动工作流并初始化相关业务
	 * <br>Author:王雷
	 * <br>Date:2013-6-17
	 * @throws Exception
	 */
	public void buildWorkflow() throws Exception {
		//1、获取参数 启动流程
		yw_guid = UtilFactory.getStrUtil().getGuid();
		String userId = request.getParameter("userId");
		String zfjcType = request.getParameter("zfjcType");
		String wfinsId = WorkflowOp.getInstance().start(zfjcType,ManagerFactory.getUserManager().getUserWithId(userId).getFullName(), yw_guid);
				
		//2、处理业务相关初始化
	    //立案呈批表编号生成规则 执立徐国土资【2013】128号
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String selectSql="select count(*) count from lacpb";
		List<Map<String,Object>> list=query(selectSql,YW);
		int count=Integer.parseInt((list.get(0)).get("count").toString());		
		String bh = "执立徐国土资【"+year+"】"+(count+1)+"号";
		String insertSql="insert into lacpb(yw_guid,bh) values(?,?)";
		update(insertSql,YW,new Object[]{yw_guid,bh});
		//立案查处其他表初始化
		String []datasheets={"cljdcpb","cfjdzysx","cfjdlsqk","flwscpb","jacpb"};
		String otherSql="";
		for(int i=0;i<datasheets.length;i++){
		    otherSql="insert into "+datasheets[i]+"(yw_guid) values(?)";
		    update(otherSql,YW,new Object[]{yw_guid});
		}
		
		//3、response参数封装及跳转
		String urlPath = "/model/workflow/wf.jsp?yw_guid="
				+ yw_guid + "&zfjcType=" + zfjcType + "&wfInsId=" + wfinsId+ "&zfjcName=立案查处";
		response(urlPath);
	}
	
	/**
	 * 
	 * <br>Description:工作流的中止方法
	 * <br>Author:王雷
	 * <br>Date:2013-6-17
	 */
	public void deleteTask(){
	    String yw_guid = request.getParameter("yw_guid");
	    String wfInsId = request.getParameter("wfInsId");
	    //1.删除业务数据
	    String []datasheets={"lacpb","cljdcpb","cfjdzysx","cfjdlsqk","flwscpb","jacpb"};
        String sql="";
	    for(int i=0;i<datasheets.length;i++){
	        sql="delete from "+datasheets[i]+" where yw_guid=?";
	        update(sql,YW,new Object[]{yw_guid});   
	    }
	    //2.删除工作流实例
	    IWorkflowInsOp workflowIns = WorkflowInsOp.getInstance();
	    workflowIns.deleteWfIns(wfInsId);
	    response("true");
	}
}
