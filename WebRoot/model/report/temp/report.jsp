<%@ page language="java" pageEncoding="utf-8"%>

<%@page import="com.klspta.model.report.ReportUtil"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";

    String id = request.getParameter("id");
    String queryPath = new ReportUtil().getReportBeanById(id).getQueryPath();
    String queryPagePath = "/" + queryPath;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'report.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
	</head>

	<body>
		<%
		    if (!"".equals(queryPath)) {
		%>
		<jsp:include page="<%=queryPagePath%>"></jsp:include>
		<%
		    }
		%>

		<iframe id="ifr" name="ifr" width="100%" height="100%" frameborder="0"
			src="<%=basePath%>model/report/loadCondition.jsp?id=<%=id%>"></iframe>
	</body>
</html>
