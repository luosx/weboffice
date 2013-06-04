<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>shp坐标转换</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
        <%@ include file="/base/include/ext.jspf" %>
        <script src="<%=basePath%>/base/include/ajax.js"></script>
        <script src="<%=basePath%>model/shptransfer84to80/shpzbtransfer84to80.js" type="text/javascript"></script>
		<script src="<%=basePath%>common/js/json2String.js" type="text/javascript"></script>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }

    .upload-icon { background: url('<%=basePath%>thirdres/ext/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;}
</style>
<script>
var basePath='<%=basePath%>';
﻿var resPath;
 </script>
	</head>
	<body bgcolor="#FFFFFF">
		<div id="form-ct" style="width:600px;"></div>
		<br>
		<div>&nbsp;说明：<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;【转换】：将手持机采集的坐标为WGS-84经纬度的shp文件转换为西安1980平面坐标，并生成新的shp文件并打包成zip格式<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;【下载】：将打包后的zip文件从临时目录文件夹下载到客户端
		</div>
	</body>
</html>
