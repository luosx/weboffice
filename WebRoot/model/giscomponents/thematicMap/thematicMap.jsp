<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'zt.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 <%@ include file="/common/include/ext.jspf" %>
	 <%@ include file="../componentsbase.jspf" %>

  </head>
		<style type="text/css">
    html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	height: 100%;
	font-family: helvetica, tahoma, verdana, sans-serif;
	padding: 0px;
	scrollbar-3dlight-color:#D4D0C8; 
    scrollbar-highlight-color:#fff; 
    scrollbar-face-color:#E4E4E4; 
    scrollbar-arrow-color:#666; 
    scrollbar-shadow-color:#808080; 
    scrollbar-darkshadow-color:#D7DCE0; 
    scrollbar-base-color:#D7DCE0; 
    scrollbar-track-color:#;
    }

    .upload-icon { background: url('<%=basePath%>ext/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;}
</style>
<script type="text/javascript">
basePath="<%=basePath%>"
</script>
  <body>
  		<div id="panel" style="margin:0px">
  		</div>
  		<iframe id='legend' style="width: 100%;height:400PX;  overflow: auto;"></iframe>
  </body>
</html>
