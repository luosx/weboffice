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
   	float:left;position:relative;left:5px;
   }
   .div2{
   	float:left;margin-left:10px;position:relative;left:0px;
   }
</style>
	</head>

	<body >
	<div style="width: 100%;height: 100%;">
		<iframe id="west" name="west" class="div1"
			style="width: 28%; height: 100%; overflow: auto; margin: " src="bcbz.jsp"></iframe>
		<iframe id="east" name="east" class="div2"
			style="width: 71%; height: 100%; overflow: auto; border: 0px;float: left;margin-left: 10px;margin-top: 0px" src="<%=basePath%>web/cbd/tjbb/chart.jsp?xml=esfzj.xml"></iframe>
	</div>
	</body>
</html>
