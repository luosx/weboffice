<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = "fyzc";
	String view = request.getParameter("view");
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
                title: '房源资产',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zcgl/fyzc/fyzcEditor.jsp?view=<%=view%>'/>"
            }
            ,{
                title: '附件管理',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zcgl/fyzc/dagl/accessorymain.jsp?yw_guid=<%=yw_guid%>'/>"
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
