package com.klspta.web.xuzhouNW.xfjb.workflow;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.workflow.foundations.WorkflowOp;
import com.klspta.console.ManagerFactory;

public class StartWorkflowXfjb extends AbstractBaseBean {
	public String yw_guid = "";

	/**
	 * 
	 * <br>
	 * Description:创建工作流实例 <br>
	 * Author:黎春行 <br>
	 * Date:2013-4-2
	 * 
	 * @throws Exception
	 */
	public void buildWorkflow() throws Exception {
		//1、获取参数 启动流程
		yw_guid = UtilFactory.getStrUtil().getGuid();
		String userId = request.getParameter("userId");
		String zfjcType = request.getParameter("zfjcType");
		String wfinsId = WorkflowOp.getInstance().start(
				zfjcType,
				ManagerFactory.getUserManager().getUserWithId(userId)
						.getFullName(), yw_guid);
		
		//2、处理业务相关初始化
		insertForm("wfxsfkxx", yw_guid);
		
		//3、response参数封装及跳转
		String urlPath = "model/workflow/pages/wf.jsp?yw_guid="
				+ yw_guid + "&zfjcType=" + zfjcType + "&wfInsId=" + wfinsId
				+ "&buttonHidden=la,return,back";
		response(urlPath);
	}
	
	/**
	 * 
	 * <br>Description:相关业务表单初始化
	 * <br>Author:黎春行
	 * <br>Date:2013-6-17
	 */
	private void insertForm(String formname, String yw_guid){
		String[] formsName = formname.split("#");
		for(int i = 0; i < formsName.length; i++){
			String sql = "insert into ";
			sql = sql + formsName[i] + "(yw_guid) values (?)";
			update(sql, YW, new Object[] { yw_guid });
		}
	}

}
