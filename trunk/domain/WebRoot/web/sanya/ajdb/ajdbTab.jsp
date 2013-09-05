<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
    var height=document.body.clientHeight-30;
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,     
        frame:true,
        items:[{
                title: '信访',
                html: "<iframe style='height:"+height+"px;width:100%' src='xf.jsp'/>"
            },
            {
                title: '文件',
                html: "<iframe style='height:"+height+"px;width:100%' src='wj.jsp'/>"
            },
            {
                title: '立案',
                html: "<iframe style='height:"+height+"px;width:100%' src='la.jsp'/>"
            }
        ]
    })
  });
  
   </script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="statusTab" style="width:100%;"></div>
	</body>
</html>
