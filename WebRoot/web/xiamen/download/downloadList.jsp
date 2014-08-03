<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xiamen.helpfile.HelpFileManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/download/";
	//System.out.println(basePath);
    HelpFileManager manager = new HelpFileManager();
    String s = manager.fileList();
	String[] ss = s.split(",");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>资料下载列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>

		<body>
		提示：如果文件下载失败，右键“目标另存为”即可下载文件。<br/>
		提示：如果文件下载较慢请等待。<br/>
		<%for(int i = 1; i < ss.length; i++){%>
		    <a href="<%=basePath%>/<%=ss[i]%>"><%=ss[i]%></a><br>
		<%}%>
		</body>
        
</html>