<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.gisapp.components.legend.LegendFiles"%>
<%@page import="java.io.File"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    String type=request.getParameter("type");
	File[] pngFiles=LegendFiles.getInstance().getAllFiles(type);
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/common/include/ext.jspf" %>	
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
   <style type="text/css">
    body {
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
   </style>
   <script>
   </script>
  </head>
	<body bgcolor="#FFFFFF">
	<table>
	<%
	if(pngFiles!=null&&pngFiles.length>0){
	for(int i=0;i<pngFiles.length;i++){
		File file=pngFiles[i];	%>	
	<tr>
	<td>	
		<img src="<%= basePath + "gisapp/images/legend/" + type + "/" + file.getName()%>"></img><font size=2>&nbsp;&nbsp;	<%=file.getName().substring(0,file.getName().length()-4)%></font>
	</td>
	</tr>
	<% } }%>
	</table>
	</body>
</html>
