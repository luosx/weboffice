<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>

		<%@ include file="/base/include/ext.jspf"%>
<script type="text/javascript">
	function drawPolygonCallback(s){
		frames['west'].frames['report'].setRecord(s);
	}
</script>
<style type="text/css">
.div1{
   	float:left;position:relative;left:5px;top: 10px;
   }
   .div2{
   	float:left;margin-left:10px;position:relative;left:0px;top: 0px;
   }
</style>
	</head>

	<body >
	<div style="width: 100%;height: 100%;">
		<iframe id="west" name="west" class="div1" 
			style="width: 98%; height: 15%; overflow: auto; " src="sccsnlfxinfo.jsp"></iframe>
		
		<iframe id="east" name="east" class="div2"
			style="width: 98%; height: 90%; overflow: auto; border: 0px;float: left;margin-left: 10px;margin-top: 20px" src="sccsnlfxTab.jsp"></iframe>
	</div>
	</body>
</html>
