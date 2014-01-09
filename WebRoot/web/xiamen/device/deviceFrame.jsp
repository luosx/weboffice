<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<script>
		Ext.onReady(function(){
		   new Ext.Viewport(
		   {
		     layout:"border",
		     items:[
		       {region:'center',
		       contentEl:'center',
		       collapsible:false,
		       margins:'0 0 0 0'},
		       {region:'west',
		        contentEl:'west',
		        split:true,
		        width: 200,
                minSize: 0,
                maxSize: 300,
		        collapsible:true,
		        title:'设备列表'}
		     ]
		   }
		   );
		});
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<iframe id="west" name="west"
			style="width: 100%; height: 100%; overflow: auto;" src="deviceTree.jsp"></iframe>
		<iframe id="center" name="center"
			style="width: 100%; height: 100%; overflow: auto; border: 0px"
			src="<%=basePath%>base/fxgis/fx/FxGIS.html?i=false"></iframe>
	</body>
</html>