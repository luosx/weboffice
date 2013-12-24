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
			frames['west'].frames['report'].setRecord(s);
		</script>
   <script type="text/javascript">
	function drawPolygonCallback(s){
		frames['west'].setRecord(s);
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
	<body>
	<div style="width: 100%;height: 100%;">
		<iframe id="east" name="east" class="div2"
			style="width: 38%; height: 100%; overflow: auto; border: 0px;float: left;margin-left: 10px;margin-top: 0px" src="<%=basePath%>base/fxgis/framework/gisViewFrame.jsp"></iframe>
		<iframe id="west" name="west" class="div1"
			style="width: 61%; height: 100%; overflow: auto; margin: " src="hxxmEditor.jsp"></iframe>
	</div>
	</body>
</html>
