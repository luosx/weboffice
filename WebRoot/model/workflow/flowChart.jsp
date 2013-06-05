<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.klspta.base.workflow.foundations.IWorkflowOp"%>
<%@page import="com.klspta.base.workflow.bean.DoNextBean"%>
<%@page import="com.klspta.base.workflow.foundations.WorkflowOp"%>
<%
	String wfInsTaskId = request.getParameter("wfInsTaskId");
	if (wfInsTaskId != null) {
		IWorkflowOp workflowOp = WorkflowOp.getInstance();
		DoNextBean ac = workflowOp.getNextInfo(wfInsTaskId);
		InputStream inputStream = ac.getImageAsInputStream();
		if (inputStream != null) {
			byte[] b = new byte[1024];
			int len = -1;
			while ((len = inputStream.read(b, 0, 1024)) != -1) {
				response.getOutputStream().write(b, 0, len);
			}
			out.clear();//清空缓存内容
			out = pageContext.pushBody(); //返回一个新的BodyContent
			inputStream.close();
		}
	}
%>