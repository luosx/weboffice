<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String name = ProjectInfo.getInstance().PROJECT_NAME;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
  <head>
    <title>执法监察系统</title>
</head>
    <frameset id="query" name="query" cols="200,*" frameborder="no" border="0"  framespacing="0" >
        <frame id="left" name="left" scrolling="NO" noresize src="content.jsp" />
        <frame id="right" name="right" scrolling="NO" noresize src="<%=basePath%>base/fxgis/framework/gisViewFrame.jsp" />
    </frameset>
</html>