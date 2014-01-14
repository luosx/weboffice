<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
   String beginDate = request.getParameter("beginDate");
   String endDate = request.getParameter("endDate");
   String year=beginDate.substring(0,4);
   String startMonth=beginDate.substring(5,7);
   String endMonth=endDate.substring(5,7);
   String region =UtilFactory.getStrUtil().unescape(request.getParameter("region"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>案件台账标题</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/ext.jspf"%>
	</head>
	<body>
	  <h1 align="center">徐州市<%=year%>年度<%=startMonth%>月—<%=endMonth%>月国土资源违法案件汇总表(<%=region%>)</h1>
	</body>
</html>
