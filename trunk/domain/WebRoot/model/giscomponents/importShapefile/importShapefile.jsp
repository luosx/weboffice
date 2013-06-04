<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.gis.GisConfigTools"%>
<%@page import="com.klspta.base.gis.Extent"%>
<%
	String path = request.getContextPath();
	String basePath = request.getServerName() + ":" + request.getServerPort() + path + "/";
	String gisapiPath = basePath + "thirdres/arcgis_js_api/library/2.5/arcgis_compact";
	basePath = request.getScheme() + "://" + basePath; 
	Extent extent=GisConfigTools.getInstance().getExtent();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script>
var gisapiPath = "<%=gisapiPath%>";
</script>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
    <script type="text/javascript" src="http://<%=gisapiPath %>/index.jsp"></script>
        <%@ include file="/base/include/ext.jspf" %>
        <%@ include file="../componentsbase.jspf" %>
		<script src="<%=basePath%>thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<script src="<%=basePath%>common/js/json2String.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }

    .upload-icon { background: url('<%=basePath%>thirdres/ext/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;}
</style>
<script>

var store;
var myData;
Ext.onReady(function(){
    store = new Ext.data.ArrayStore({
        fields: [
           {name: '编号'},
           {name: '面积'}
        ]
    });  
       var grid = new Ext.grid.GridPanel({
        store: store, 
        height:500,
        width:300,
        columns: [
            {header: '编号', width: 100},
            {header: '面积', width: 180}
        ]    
    });  
    grid.render('status_grid');
 })
 var _$WKID = <%=extent.getWkid()%>;
 </script>
	</head>
	<body bgcolor="#FFFFFF">
		<div id="form-ct" style="width:100%; "></div>
		<div id="status_grid"></div>
	</body>
</html>
