﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
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

  	<frameset id="index" rows="53,28,*" frameborder="no" border="0"  framespacing="0" >
		<frame id="flash" name="flash" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/top.jsp" />
		<frame id="menu" name="menu" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/menu.jsp" />
		     <frameset id="left"  cols="6,*" frameborder="no" border="0" framespacing="0">
     <frame id="leftbg" name="leftbg"  src="<%=basePath%>web/<%=name%>/framework/pages/leftbg.jsp" scrolling="No" noresize="noresize" />
    <frame id="center" name="center" src="<%=basePath%>web/<%=name%>/framework/pages/content.jsp"  scrolling="No" noresize="noresize" />
      </frameset>
	</frameset>
</html>

