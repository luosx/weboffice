<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "ext/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	<%@ include file="/base/include/ext.jspf" %>
   <style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }
   </style>
   <script>
Ext.onReady(function(){
   Ext.QuickTips.init();
   var scrHeight= document.body.offsetHeight; //(包括边线的高)457
    var viewport = new Ext.Viewport({
        layout:'border',
        items:[{
            region: 'west',
            width: 300,   
            layout: 'accordion',
            layoutConfig: {
                titleCollapse: true,
                animate: true,
                activeOnTop: false
            },
            items: [
               		{
		                title: '外业设备监控',    
		                html: "<iframe style='height:"+(scrHeight-95)+"PX;' src='pdaList.jsp?type=0' />"            
		       		},
		       		// 
	            	//{
		            //    title: '车辆实时监控',    
		            //    html: "<iframe style='height:"+(scrHeight-95)+"PX;' src='localCarMonitor.jsp' />"            
		       		//}, 
	            	{
		                title: '轨迹回放',    
		                html: "<iframe style='height:"+(scrHeight-95)+"PX;' src='playBack.jsp' />"            
		       		}
            ]
        },{
            region: 'center',
            split: true,
            border: true
        }]
    });
 
});
  
   </script>
  </head>
	<body >
		<div id="legendTab" style='height:100%;width:100%; '></div>	
	</body>
</html>
