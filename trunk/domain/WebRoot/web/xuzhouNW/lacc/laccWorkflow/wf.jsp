<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.model.workflow.foundations.WorkflowOp"%>
<%@page import="com.klspta.model.workflow.foundations.IWorkflowOp"%>
<%@page import="java.net.URLEncoder"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String wfInsId = request.getParameter("wfInsId");
	String zfjcType = request.getParameter("zfjcType");
	String returnPath=request.getParameter("returnPath");
	String buttonHidden = request.getParameter("buttonHidden");
	String edit = request.getParameter("edit");
	IWorkflowOp workflow = WorkflowOp.getInstance();
	String activityName = workflow.getActivityNameByWfInsID(wfInsId);
	String sb = "zfjcType=" + zfjcType + "&yw_guid=" + yw_guid +  "&wfInsId=" + wfInsId + "&buttonHidden="+buttonHidden + "&returnPath="+returnPath + "&activityName="+activityName + "&edit=" + edit;
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String fullName=((User) principal).getFullName();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>待办任务处理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<script>
	function deleteTask() {
		lower.Ext.MessageBox.confirm('注意', '终止后不可恢复，是否继续?', function(btn) {
			if (btn == 'yes') {
				upper.stopTask(btn);
			}
		})
	}

</script>
	</head>
	<frameset id="main" rows="30,*" frameborder="no" border="0"
		framespacing="0">
		<frame id="upper" name="upper" scrolling="NO" noresize
			src="<%=basePath%>/web/xuzhouNW/lacc/laccWorkflow/dispense.jsp?<%=sb.toString()%>" />
		<frame id="lower" name="lower" scrolling="NO" noresize
			src="<%=basePath%>model/resourcetree/resourceTree.jsp?<%=sb.toString()%>" />
	</frameset>
	<body>
</body>

</html>
