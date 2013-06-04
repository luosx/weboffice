<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"+ request.getServerPort() + path + "/";
    String url = "";
    url=basePath+"web/xuzhouNW/plane/tjfx/hefei.html";
    String xzqhdm=request.getParameter("xzqhdm");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>全部图斑</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<frameset id="qbtb" name="qbtb" rows="10%,*" frameborder="no" border="0" framespacing="0" >
		<frame id="toolbar" name="toolbar"  noresize src="<%=basePath%>web/xuzhouNW/plane/tjfx/wpzf_topBar.jsp?xzqhdm=<%=xzqhdm%>" />
		<frame id="view" name="view"  noresize src="<%=url%>"/>
			
	</frameset>
</html>
