﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
String name1 = ProjectInfo.getInstance().getProjectLoginName1();
%>

<html>
  <head>
  <meta http-equiv="X-UA-Compatible" content="IE=7" >
  <META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
    <title><%=name1 %></title>
</head>
  	<frameset id="index" name="index" rows="106,32,*" frameborder="no" border="0"  framespacing="0" >
		<frame id="flash" name="flash" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/flash.jsp" />
		<frame id="menu" name="menu" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/menu.jsp" />
		<frame id="content" name="content" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/content.jsp" />
	</frameset>
</html>
