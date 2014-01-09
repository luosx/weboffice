<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String name = ProjectInfo.getInstance().PROJECT_NAME;
String resourcePath=basePath+"web/"+name+"/framework";
%>
<html>
<head>
<title>left</title>
</head>
<script>

</script>
<style type="text/css">
body { margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px;
background-image : url('<%=basePath%>web/cbd/xmgl/image/left/line.png');background-repeat : repeat-y;
}
</style>
<body >

					<div style="padding-top:200px;">
						<img align="absmiddle" id=frameshow src="<%=basePath%>web/cbd/xmgl/image/left/line.png">
					</div>
	
</body>
</html>