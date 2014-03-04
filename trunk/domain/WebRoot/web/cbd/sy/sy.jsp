<%@ page language="java" pageEncoding="utf-8"%>
<%String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
		<base href="<%=basePath%>">

		<title>地图</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
	</head>
<script type="text/javascript">
	function openMap(){
		top.content.content.cols="0,9,*"; 
	}
	Ext.onReady(function() {
			border = new Ext.Viewport({
						layout : "border",
						items : [{
									region : 'center',
									contentEl : 'center',
									collapsible : false,
									margins : '0 0 0 0'
								}, {
									region : 'east', 
									contentEl : 'east',
									id : 'east-panel',
									collapsible : true,
									margins : '0 0 0 0',
									split:true,
									width : 300,
									minSize : 0,
									maxSize : 300,
									collapsed : true,
									title : '地块/项目数据'
								}, {
									region:'west',
					                id:'west-panel',
                                    contentEl: 'mapTree',
                                    split:true,
                                    width: 200,
                                    minSize: 0,
                                    maxSize: 300,
                                    collapsible: true,
                                    title:'图层树',
                                    collapsed: true,
                                    margins:'0 0 0 0'
								}]
					});
		});
	
</script>
  <body onload="openMap();">
  <div style="position:absolute; bottom:20px; right:30px; width:50px; height:50px;" align="right"><img src="<%=basePath%>/base/form/images/go.png" width="50px" height="50px" title="系统设计图" onClick="javascript:window.location.href='jgs.jsp'"  /></div>
<iframe id="mapTree" name="mapTree"
			style="width: 100%; height: 100%; overflow: auto;"
			src="<%=basePath%>base/fxgis/framework/mapTree.jsp"></iframe>
		<iframe id="center" name="center"
			style="width: 100%; height: 100%; overflow: auto; border: 0px"
			src="<%=basePath%>base/fxgis/framework/menu.jsp"></iframe>
		<iframe id="east" name="east"
			style="width: 100%; height: 100%; overflow: auto;" src="<%=basePath%>web/cbd/map/dataGrid.jsp"></iframe>
  </body>
</html>
