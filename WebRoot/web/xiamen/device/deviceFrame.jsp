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
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="result-win" class="x-hidden">    </div>
    <div id="result-tabs"></div>
    <div id='properties'   title="图斑属性" style="overflow: scroll;"></div>
    <div id='xz'  title="现状叠加分析" style="overflow: scroll; "></div>
    <div id='gh'   title="规划叠加分析" style="overflow: scroll;"></div>
	</body>
		<script src="deviceFrame.js"></script>
		<script src="deviceTree.js"></script>
		<script src="monitorView.js"></script>
		<script src="control.js"></script>
		<script src="buttons.js"></script>
		<script src="flexCallback.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/fields_to_chinese.js"></script>
		<script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
</html>