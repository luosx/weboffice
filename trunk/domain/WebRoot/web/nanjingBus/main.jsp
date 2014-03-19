﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
%>

<html>
  <head>
    <title>指挥调度监控中心</title>

</head>

<frameset id="index" rows="90,*" frameborder="no" border="0"  framespacing="0" >
		<frame id="top" name="top" scrolling="NO" noresize src="<%=basePath%>web/nanjingBus/framework/menu.jsp" />
		<frame id="content" name="content" scrolling="NO" noresize src="<%=basePath%>web/nanjingBus/baiduMap/baiduMap.jsp" />

</frameset>
</html>
