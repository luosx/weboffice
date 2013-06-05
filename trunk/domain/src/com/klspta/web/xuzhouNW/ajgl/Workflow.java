package com.klspta.web.xuzhouNW.ajgl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.jbpm.api.JbpmException;
import org.jbpm.api.task.Task;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.console.ManagerFactory;
import com.klspta.console.user.User;
import com.klspta.base.workflow.foundations.IWorkflowInsOp;
import com.klspta.base.workflow.foundations.IWorkflowOp;
import com.klspta.base.workflow.foundations.JBPMServices;
import com.klspta.base.workflow.foundations.WorkflowInsOp;
import com.klspta.base.workflow.foundations.WorkflowOp;

public class Workflow extends AbstractBaseBean {

	/**
	 * <br>
	 * Description:启动工作流 <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-17
	 */
	public void startWorkflow() {
		// 获取前台参数
		// 必须参数
		String zfjcType = request.getParameter("zfjcType");// 在public_code里面的配置的，给不同工作流配置的一个数字编号，对应多个字段信息
		String yw_guid = request.getParameter("yw_guid");// 要和工作流绑定的业务主键，到流程里面原来的主键到这里变量名变为yw_guid
		String fullName = UtilFactory.getStrUtil().unescape(request.getParameter("fullName"));// 启动工作流的人员汉字名称
		String lyType = request.getParameter("lyType");// 要和工作流绑定的业务案件类型
		// 附加传递参数
		String buttonHidden = request.getParameter("buttonHidden");// 按钮自定义隐藏
		String type = request.getParameter("type");

		// 根据数据配置信息获取指定编号的工作流定义ID
		String sql1 = "select t.child_name from public_code t where t.id='WORKFLOW' and t.child_id=?";
		List<Map<String, Object>> wfIdList = query(sql1, YW, new Object[] { zfjcType });
		Map<String, Object> map1 = (Map<String, Object>) wfIdList.get(0);
		String wfId = (String) map1.get("child_name");

		// 启动工作流，创建工作流实例.
		// 将启动工作流方法放在更改状态位和更改表单前面，防止工作流出现异常，流程实例创建失败，状态位更改，案件丢失。
		IWorkflowOp work = WorkflowOp.getInstance();
		String wfInsId = work.start(wfId, fullName, yw_guid);// 工作流实例ID
		Task wfInsTask = JBPMServices.getInstance().getTaskService().createTaskQuery().executionId(wfInsId)
				.uniqueResult();
		String wfInsTaskId = wfInsTask.getId();// 启动后，当前节点id
		String activityName = wfInsTask.getActivityName();// 启动后，当前节点名称

		// 将案件和工作流进行绑定
		bind2Case(fullName, zfjcType, lyType, yw_guid, wfId, wfInsId, wfInsTaskId);

		// 根据配置信息获取工作流名称。（违法案件查处）
		String sql2 = "select t.child_name from public_code t where t.child_id=? and t.id='ZFJCTYPE'";
		List<Map<String, Object>> nodeList = query(sql2, YW, new Object[] { zfjcType });
		Map<String, Object> map2 = (Map<String, Object>) nodeList.get(0);
		String zfjcName = (String) map2.get("child_name");

		response.setCharacterEncoding("utf-8");
		String urlPath = "/model/workflow/wf.jsp?yw_guid=" + yw_guid + "&zfjcType=" + zfjcType + "&type=" + type
				+ "&wfId=" + wfId + "&wfInsId=" + wfInsId + "&wfInsTaskId=" + wfInsTaskId + "&activityName="
				+ UtilFactory.getStrUtil().escape(UtilFactory.getStrUtil().escape(activityName)) + "&zfjcName="
				+ UtilFactory.getStrUtil().escape(UtilFactory.getStrUtil().escape(zfjcName)) + "&permission=yes"
				+ "&lyType=" + lyType + "&buttonHidden=" + buttonHidden;
		try {
			response.getWriter().write("{urlPath:'" + urlPath + "'}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * <br>
	 * Description:根据不同的案件流程（zfjcType）将工作流和指定案件进行绑定<br>
	 * Author:赵伟 <br>
	 * Date:2012-10-24
	 */
	private void bind2Case(String fullName, String zfjcType, String lyType, String yw_guid, String wfId,
			String wfInsId, String wfInsTaskId) {
		// zfjcType=7：立案查处流程
		if (zfjcType.equals("7")) {
			// 移交的同时根据案源类型将案件状态位更改变为已立案
			if (lyType != null) {
				String sql = "";
				if (lyType.equals("WPZF_TB")) {
					sql = "update WPZF_TB t set t.ajstatus='3' where tbbh=?";
				} else if (lyType.equals("WY_DEVICE_DATA")) {
					sql = "update WY_DEVICE_DATA t set t.AJSTATUS='3' where t.guid=?";
				} else if (lyType.equals("WFXSDJBL")) {
					sql = "update WFXSDJBL t set t.AJSTATUS='3' where t.yw_guid=?";
				}
				update(sql, YW, new Object[] { yw_guid });
			}

			// 向立案呈批表插入数据
			Date date = new Date();
			String lacpb_sql = "insert into lacpb(GUID,YW_GUID,zfjcType,WFINSID,slrq) values(?,?,?,?,?)";
			update(lacpb_sql, YW, new Object[] { getGUID(), yw_guid, wfId, wfInsId, date });

			// 法律文书呈批表
			String flwscpb_sql = "insert into SG_FLWSCPB(YW_GUID) values(?)";
			update(flwscpb_sql, YW, new String[] { yw_guid });

			// 结案呈批表
			String jacpb_sql = "insert into JACPB(YW_GUID) values(?)";
			update(jacpb_sql, YW, new String[] { yw_guid });
		}
	}

	/**
	 * <br>
	 * Description:移交任务 <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-6
	 */
	public void transferTask() {
		String nextNodeName = "";
		String op = "";
		String wfInsTaskId = "";
		String nextFullName = "";
		String assignee = "";
		String wfInsId = "";
		try {
			nextNodeName = URLDecoder.decode(request.getParameter("nextNodeName"), "utf-8");
			op = request.getParameter("op");
			assignee = request.getParameter("assignee");
			wfInsTaskId = request.getParameter("wfInsTaskId");
			wfInsId = request.getParameter("wfInsId");
			nextFullName = URLDecoder.decode(request.getParameter("nextFullName"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		if (nextNodeName != null) {
			if (op != null && op.equals("donext")) {
				// 移交完成任务
				IWorkflowInsOp workflowInsOp = WorkflowInsOp.getInstance();
				workflowInsOp.doNext(wfInsTaskId, nextNodeName);

				// 获取移交后下一节点的节点ID,首先查出task对象，根据是否有下一节点判断流程是否结束。
				Task nextWfInsTask = JBPMServices.getInstance().getTaskService().createTaskQuery().executionId(wfInsId)
						.uniqueResult();
				String nextWfInsTaskId = "";
				if (nextWfInsTask != null) {
					nextWfInsTaskId = nextWfInsTask.getId();
				}

				// 取走/占有该任务
				if (!"all".equals(nextFullName) && !"".equals(nextFullName) && assignee.equals("false")
						&& nextWfInsTask != null) {
					try {
						workflowInsOp.iDoIt(nextWfInsTaskId, nextFullName);
					} catch (JbpmException e) {
					}
				}
			}
			try {
				response.getWriter().write("true");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				response.getWriter().write("false");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * <br>
	 * Description:删除任务 <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-24
	 */
	public void deleteTask() {
		String wfInsId = request.getParameter("wfInsId");
		String yw_guid = request.getParameter("yw_guid");
		IWorkflowInsOp workflowInsOp = WorkflowInsOp.getInstance();
		String sql = "delete from lacpb where yw_guid=?";
		update(sql, YW, new Object[] { yw_guid });
		try {
			if (wfInsId != null) {
				workflowInsOp.deleteWfIns(wfInsId);
				response.getWriter().write("true");
			} else {
				response.getWriter().write("false");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * <br>
	 * Description:回退任务 <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-24
	 */
	public void backTask() {
		try {
			request.setCharacterEncoding("utf-8");
			String wfId = request.getParameter("wfId");
			String wfInsId = request.getParameter("wfInsId");
			String wfInsTaskId = request.getParameter("wfInsTaskId");
			String activityName = URLDecoder.decode(request.getParameter("activityName"), "utf-8");
			boolean b = false;

			// 当回退出现错误，捕捉到错误返回错误。
			try {
				b = WorkflowInsOp.getInstance().back(wfId, wfInsId, wfInsTaskId, activityName);
			} catch (Exception e) {
				response("error");
				return;
			}
			if (b) {
				response.getWriter().write("success");
			} else {
				response.getWriter().write("false");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * <br>
	 * Description:根据角色获取人员 <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-24
	 * 
	 * @throws Exception
	 */
	public void getUsersByRoleId() throws Exception {
		String roleid = request.getParameter("roleId");
		String wfInsId = request.getParameter("wfInsId");
		String result = "";
		List<User> list = null;
		if (roleid != null) {
			list = ManagerFactory.getUserManager().getUserWithRoleID(roleid);
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					result += list.get(i).getFullName();
					continue;
				}
				result += "," + list.get(i).getFullName();
			}
		} else if (roleid == null && wfInsId != null) {
			result = JBPMServices.getInstance().getExecutionService().getVariable(wfInsId, "owner").toString();
		}
		response(result);
	}

	/**
	 * <br>
	 * Description:根据节点获取名称 <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-24
	 * 
	 * @throws UnsupportedEncodingException
	 */
	public void getRoleByActivityName() throws UnsupportedEncodingException {
		String activityName = URLDecoder.decode(request.getParameter("activityName"), "utf-8");
		String wfId = request.getParameter("wfId");
		IWorkflowOp workflowOp = WorkflowOp.getInstance();
		List<Map<String, Object>> Roles = workflowOp.getAllRoles(activityName, wfId);
		try {
			response(UtilFactory.getJSONUtil().objectToJSON(Roles));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * <br>
	 * Description:生成lacpb的GUID <br>
	 * Author:赵伟 <br>
	 * Date:2012-9-6
	 * 
	 * @return
	 */
	private String getGUID() {
		String GUID = "";
		int year = Calendar.getInstance().get(Calendar.YEAR);
		int month = (Calendar.getInstance().get(Calendar.MONTH) + 1);
		int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		GUID = String.valueOf(year) + UtilFactory.getStrUtil().manageStr(month, 2)
				+ UtilFactory.getStrUtil().manageStr(day, 2) + "00000";
		long number = Long.parseLong(GUID);
		String sql = "Select lacpb_sequence.nextval index_ from dual";
		List<Map<String, Object>> resuList = new Workflow().query(sql, AbstractBaseBean.YW);
		long index = Long.parseLong(resuList.get(0).get("index_").toString());
		number = (number + index);
		GUID = "CC" + number;
		return GUID;
	}

	/**
	 * 
	 * <br>
	 * Description:表单授权 <br>
	 * Author:黎春行 <br>
	 * Date:2012-10-9
	 */
	public void setEditFields() {
		String formName = "";
		String activityName = "";
		try {
			request.setCharacterEncoding("utf-8");
			formName = request.getParameter("formName");
			activityName = request.getParameter("activityName");
			activityName = URLDecoder.decode(request.getParameter("activityName"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String zfjcType = request.getParameter("zfjcType");
		String editFiles = request.getParameter("editFiles");
		if (!"".equals(editFiles)) {
			editFiles = editFiles.substring(0, editFiles.length() - 1);
		} else {
			editFiles = "no";
		}
		Object[] args = { editFiles, activityName, zfjcType, formName };
		int i = 0;
		if (queryData(activityName, zfjcType, formName)) {
			i = update("update FORM_AUTHORITY set editFiles=? where activityName=? and zfjcType=? and formName=?",
					CORE, args);
		} else {
			i = update("insert into FORM_AUTHORITY(editFiles,activityName,zfjcType,formName) values(?,?,?,?)", CORE,
					args);
		}
		if (i == 1) {
			response("success");
		} else {
			response("failure");
		}
		// return new ActionForward("/supervisory/ajcc/" + formName +
		// ".jsp?permission=yes&msg=success");
	}

	private boolean queryData(String activityName, String zfjcType, String formName) {
		boolean b = false;
		List<Map<String, Object>> queryList = null;
		String sql = "select * from FORM_AUTHORITY where zfjcType=? and activityName=? and formName=?";
		Object[] args = { zfjcType, activityName, formName };
		queryList = query(sql, CORE, args);
		if (queryList.size() > 0) {
			b = true;
		}
		return b;
	}

	public void saveWorkflowTree() {
		try {
			String treeIdList = request.getParameter("treeIdList");
			String wfID = request.getParameter("wfID");
			String treeName = request.getParameter("treeName");
			String nodeName = URLDecoder.decode(request.getParameter("nodeName"), "utf-8");
			String sql = "select nodeName from map_workflow_tree where wfid='" + wfID + "' and nodeName='" + nodeName
					+ "'";
			List<Map<String, Object>> list = query(sql, CORE);
			if (list.size() == 0) {
				sql = "insert into map_workflow_tree(nodeids,wfid,nodename,treename) values(?,?,?,?)";
			} else {
				sql = "update map_workflow_tree set nodeids=? where wfid=? and nodename=? and treename=?";
			}
			Object[] args = { treeIdList, wfID, nodeName, treeName };
			update(sql, CORE, args);
			response.getWriter().write("{success:true}");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
