<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String type = request.getParameter("type");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script>
		var basePath="<%=basePath%>";
		var type="<%=type%>";
</script>
		<script src="deviceFrame.js"></script>
		<script src="deviceTree.js"></script>
		<script src="monitorView.js"></script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	</body>
</html>