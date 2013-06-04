<%@ page language="java" pageEncoding="utf-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String id = request.getParameter("id");
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

	</head>
	<frameset id="main" name="main" rows="12,88" frameborder="no"
		border="1" framespacing="0">
		<frame id="top" name="top" scrolling="NO" noresize
			src="<%=basePath%>model/report/report_top.jsp?id=<%=id%>" />
		<frame id="lower" name="lower" scrolling="NO" noresize
			src="<%=basePath%>model/report/report.jsp?id=<%=id%>" />
	</frameset>
</html>

