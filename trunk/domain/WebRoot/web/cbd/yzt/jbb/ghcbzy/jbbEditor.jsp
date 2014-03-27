<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String type = request.getParameter("type");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>基本斑列表</title>

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
.x-form-file-wrap {
    position: relative;
    height: 22px;
}
.x-form-file-wrap .x-form-file {
	position: absolute;
	right: 0;
	-moz-opacity: 0;
	filter:alpha(opacity: 0);
	opacity: 0;
	z-index: 2;
    height: 22px;
}
.x-form-file-wrap .x-form-file-btn {
	position: absolute;
	right: 0;
	z-index: 1;
}
.x-form-file-wrap .x-form-file-text {
    position: absolute;
    left: 0;
    z-index: 3;
    color: #777;
}
</style>
		<script>
		var basePath="<%=basePath%>";
		var url = basePath
		+ '/web/cbd/yzt/jbb/ghcbzy/jbbRowEditor.jsp?type=<%=type%>' ;
</script>
		<script src="js/jbbEditor.js"></script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow-x:hidden;overflow-y:hidden">
		<div id="mygrid_container"></div>
		<div id="update" class="x-hidden">
			<div id="updateForm"
				style="width: 100%; height: 90%; margin-left: 10px; margin-top: 5px"></div>
		</div>
	</body>
</html>