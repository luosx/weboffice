<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>信访汇总</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="DatePicker.js"></script>
		<style>
input,img {
	vertical-align: middle;
}
</style>
		<script>
			var basePath="<%=basePath%>";
		</script>
		<script src="js/hxxmEditor.js"></script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="update" class="x-hidden">
			<div id="updateForm"
				style="width: 100%; height: 90%; margin-left: 10px; margin-top: 5px"></div>
		</div>
	</body>
</html>