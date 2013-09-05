<%@ page language="java"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
 
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
	
	<frameset id="qbtb"  rows="27,*" frameborder="no" border="0" framespacing="0" >
		<frame id="toolbar" name="toolbar" noresize 
			src="<%=basePath%>web/jizeWW/tjAnalyse/fxjg.jsp" />
		<frame id="view" name="view" noresize 
			src="<%=basePath%>web/jizeWW/tjAnalyse/lctj.htm"/>
	</frameset>
</html>
