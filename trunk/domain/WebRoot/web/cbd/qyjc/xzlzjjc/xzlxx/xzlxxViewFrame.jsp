<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String layoutPath = basePath + "base/thirdres/dhtmlx//dhtmlxLayout//codebase";
    String toolbarPath = basePath + "base/thirdres/dhtmlx//dhtmlxToolbar//codebase";
    String view = request.getParameter("view");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<title></title>

		<%@ include file="/base/include/ext.jspf"%>
				<link rel="stylesheet" type="text/css"
			href="<%=basePath%>base/form/css/styles.css">
		<link rel="stylesheet" type="text/css"
			href="<%=layoutPath%>/dhtmlxlayout.css">
		<link rel="stylesheet" type="text/css"
			href="<%=toolbarPath%>/skins/dhtmlxtoolbar_dhx_skyblue.css">
		<link rel="stylesheet" type="text/css"
			href="<%=layoutPath%>/skins/dhtmlxlayout_dhx_blue.css">
		<link rel="stylesheet" type="text/css"
			href="<%=layoutPath%>/skins/dhtmlxlayout_dhx_skyblue.css">
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=layoutPath%>/dhtmlxcommon.js"></script>
		<script src="<%=layoutPath%>/dhtmlxcontainer.js"></script>
		<script src="<%=layoutPath%>/dhtmlxlayout.js"></script>
		<script src="<%=toolbarPath%>/dhtmlxtoolbar.js"></script>
		<script src="<%=toolbarPath%>/patterns/dhtmlxlayout_pattern4j.js"></script>
<style type="text/css">
.div1{
   	float:left;position:relative;left:5px;
   }
   .div2{
   	float:left;margin-left:10px;position:relative;left:0px;
   }
</style>
	</head>
	<script type="text/javascript">
		function doOnLoad(){
			dhxLayout = new dhtmlXLayoutObject("parentId", "2U");
			dhxLayout.cells("a").setWidth(600);
			dhxLayout.cells("a").hideHeader();
			dhxLayout.setEffect("resize", true);
			dhxLayout.cells("a").attachURL("<%=basePath%>base/fxgis/framework/gisViewFrame.jsp");
			//dhxLayout.cells("b").setWidth(width * 0.61);
			dhxLayout.cells("b").attachURL("xzlxxEditor.jsp?view=<%=view%>");
			dhxLayout.cells("b").hideHeader();
			//dhxLayout.setAutoSize("a;b", "a;b");
			//页面大小修改时重新刷新
			dhxLayout.attachEvent("onPanelResizeFinish", function(){
				//dhxLayout.cells("a").fixSize(true, false);
				//dhxLayout.cells(id).getFrame().refresh;
				//dhxLayout.cells("a").attachURL("<%=basePath%>base/fxgis/framework/gisViewFrame.jsp");
				dhxLayout.cells("b").attachURL("xzlxxEditor.jsp?view=<%=view%>");
				
			});
		}	
	
		function drawPolygonCallback(s){
			frames[1].frames['report'].setRecord(s);
		}
	</script>
	<body onLoad="doOnLoad()" >
		<div id="parentId" style="top: 0px; left: 0px; width: 100%; height: 100%;overflow-x:hidden;overflow-y:hidden"></div>
	</body>
</html>
