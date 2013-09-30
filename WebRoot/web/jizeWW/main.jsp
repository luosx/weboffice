﻿<%@page language="java"    pageEncoding="utf-8"%>
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
<!-- <frame id="center" name="center" src="<%=basePath%>web/<%=name%>/framework/pages/content.jsp" scrolling="no" noresize="noresize"> -->
<frameset id="index" rows="53,28,*" frameborder="no" border="0"  framespacing="0" >
		<frame id="flash" name="flash" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/top.jsp" />
		<frame id="menu" name="menu" scrolling="NO" noresize src="<%=basePath%>web/<%=name%>/framework/pages/menu.jsp" />
   <frameset id="left"  cols="6,*" frameborder="no" border="0" framespacing="0">
      <frame id="leftbg" name="leftbg"  src="<%=basePath%>web/<%=name%>/framework/pages/leftbg.jsp" scrolling="No" noresize="noresize" />
      <frame id="mapView" name="mapView"  src="<%=basePath%>web/<%=name%>/tdMap/mapView.jsp?flag=map" scrolling="no" noresize="noresize" />
    </frameset>
</frameset>
</html>

