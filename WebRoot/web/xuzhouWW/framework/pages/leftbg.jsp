<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   
    String name = ProjectInfo.getInstance().PROJECT_NAME;
    
    
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>执法监察系统</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <style type="text/css">

body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background-image: URL("<%=basePath%>web/<%=name%>/framework/images/bk.jpg");
}

.Font9Black {
	font-family: "宋体";
	font-size: 9pt;
	color: #444444;
}

.Font9Blue {
	font-family: "宋体";
	font-size: 9pt;
	color: #001F6D;
}

.Font9BlueInfo {
	font-family: "宋体";
	font-size: 9pt;
	color: #2C5DA5;
}
</style>

</head>
    <body>

    </body>
</html>
 