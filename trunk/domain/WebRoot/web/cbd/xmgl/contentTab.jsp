﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>tab</title>
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
    var w=document.body.clientWidth;
	var h=document.body.clientHeight - 30; 
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,            
        frame:true,
        items:[
        	{
                title: '办理经过',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/xmgl/blgc/blgc.jsp?yw_guid=<%=yw_guid%>'/>" 
            }
            ,{
                title: '资金管理',
                html: "<iframe width='"+w+"' height='"+h+"' src=''/>"
            }
            ,{
                title: '档案管理',
                html: "<iframe width='"+w+"' height='"+h+"' src=''/>"
            },{
                title: '控规表',
                html: "<iframe width='"+w+"' height='"+h+"' src=''/>"
            },{
                title: '控规表',
                html: "<iframe width='"+w+"' height='"+h+"' src=''/>"
            }
        ]
    })
  });
  
   </script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="statusTab" style="width:100%"></div>
	</body>
</html>
