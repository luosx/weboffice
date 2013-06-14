<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>违法统计表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   		<iframe id="chart"  name="chart" frameborder='0'  style="width: 100%; height: 100%;overflow: auto;"
			src="<%=basePath%>report/wfxsclqk/chart.jsp?xml=wftjb.xml"></iframe>
  		<iframe id="tj" name="tj"   frameborder='0' style="width: 100%; height:700;overflow: auto; "
		  src="<%=basePath%>report/wfxsclqk/wftjb.html"></iframe>
  </body>
</html>
