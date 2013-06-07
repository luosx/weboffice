<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.model.giscomponents.pad.PADDataList"%>
<%
	//32.395,119.56,32.395,119.565,32.39,119.56 
    String yw_guid = request.getParameter("yw_guid");
    //System.out.println(yw_guid);
   	String coord =new PADDataList().getZb(yw_guid);  
   //	System.out.println(coord);
    
%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<meta charset="UTF-8">
<style type="text/css">
html,body,#container {
	margin: 0;
	padding: 0;
	height: 100%;
}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>
</head>
<body>
<div id="container"></div>	
<script type="text/javascript">
//------------------------ 地图初始化 -------------------------- 
	var map = new BMap.Map("container");            
	var point = new BMap.Point(120.160129,30.271473);
	map.centerAndZoom(point,18);                 
 	map.enableScrollWheelZoom();  
  	map.enableKeyboard();         
  	map.enableContinuousZoom();   
  	map.enableInertialDragging(); 
  	var opts = {type: BMAP_NAVIGATION_CONTROL_LARGE }		
	map.addControl(new BMap.NavigationControl(opts));		
	map.addControl(new BMap.ScaleControl());				
	map.addControl(new BMap.OverviewMapControl()); 	
	map.addControl(new BMap.MapTypeControl()); 				
 	map.setCurrentCity("浙江");
</script> 
 	
<script type="text/javascript">
parseStringToArray("<%=coord%>");
function parseStringToArray(data){ 
	var point = []; 
	var arr = data.split(";"); 
	for(var i=0;i<arr.length;i++){     
		point[i] = new BMap.Point (arr[i].split(",")[1],arr[i].split(",")[0]);  
	}
	var secRingCenter = new BMap.Point(point[0].lng,point[0].lat);  
	var secRingPolygon = new BMap.Polygon(point, {strokeColor:"red", strokeWeight:3, strokeOpacity:0.8}); 
	map.addOverlay(secRingPolygon); 
	map.setCenter(secRingCenter);    
//	map.setZoom(18);
}
</script>				
</body>
</html>