<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>巡查核查成果汇总</title>

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
		<script src="hccg.js"></script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
	</body>
</html>