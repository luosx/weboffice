<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String type = request.getParameter("type");
String yw_guid = request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>信访案件</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
	<frameset id="main" rows="30,*" frameborder="no" border="0"
		framespacing="0">
		<frame id="upper" name="upper" scrolling="NO" noresize
			src="web/sanya/zhbg/zhbgdj/back.jsp?type=<%=type%>" />
		<frame id="lower" name="lower" scrolling="NO" noresize
			src="web/sanya/zhbg/zhbgdj/wjspTab.jsp?yw_guid=<%=yw_guid%>" />
	</frameset>
</html>
