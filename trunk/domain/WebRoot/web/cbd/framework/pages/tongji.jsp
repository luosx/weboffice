﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String name = ProjectInfo.getInstance().PROJECT_NAME;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>执法监察系统</title>
</head>
    <frameset id="right" name="right" rows="0,*" frameborder="no" border="0"  framespacing="0" >
        <frame id="header" name="header" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/header.jsp" />
        <frame id="content" name="content" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/helloworld.jsp" />
    </frameset>
</html>
