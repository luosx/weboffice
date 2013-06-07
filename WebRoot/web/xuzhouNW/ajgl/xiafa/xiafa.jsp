<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>下发</title>
    
	<script src="<%=basePath%>/base/include/ajax.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script type="text/javascript" src="<%=basePath%>/web/default/ajgl/xiafa/xiafa.js"></script> 
  </head>
  	<script>
	var basePath="<%=basePath%>";
	</script>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	    <div id="panel"></div>
	</body>
</html>
