﻿<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().getProjectName();
%>

<html>
  <head>
    <title>执法监察系统</title>
    <script>
function openURL(url){
	top.center.mapView.openURL(url);
}
</script>
</head>
  	<frameset id="index"  rows="53,*" frameborder="no" border="0"  framespacing="0" >
		<frame id="flash" name="flash" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/flash.jsp" />
		<frame id="menu" name="menu" scrolling="yes" noresize src="<%=basePath%>web/<%=name%>/videoMonitor/index.html" />
	</frameset>
</html>
