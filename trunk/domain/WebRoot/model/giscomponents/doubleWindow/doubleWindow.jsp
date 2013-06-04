﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>双窗口地图查看</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
var source='first';
</script>
</head>
  	<frameset id="double" name="double" cols="50%,50%" frameborder="no" border="0" framespacing="0" >
			<frame id="left" name="left" scrolling="NO" noresize
				src="<%=basePath%>gisapp/pages/gisViewFrame.jsp?frameName=left&showtree=false" />		
			<frame id="right" name="right" scrolling="NO" noresize
				src="<%=basePath%>gisapp/pages/gisViewFrame.jsp?frameName=right&showtree=false" />	 		
	</frameset>
</html>