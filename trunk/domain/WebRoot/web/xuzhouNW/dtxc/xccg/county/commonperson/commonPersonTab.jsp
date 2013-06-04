<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String usetype = request.getParameter("usetype");
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
    var w=document.body.clientWidth;
	var h=document.body.clientHeight - 30; 
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,  
           
        frame:true,
        items:[
        	{
                title: '疑似违法',
                html: "<iframe width='"+w+"' height='"+h+"' src='yswfTab.jsp?usetype=<%=usetype%>'/>" 
            },{
                title: '已立案',
                html: "<iframe width='"+w+"' height='"+h+"' src='ylaTab.jsp'/>" 
            },{
                title: '不予立案',
                html: "<iframe width='"+w+"' height='"+h+"' src='bylaTab.jsp'/>" 
            },{
                title: '已上报',
                html: "<iframe width='"+w+"' height='"+h+"' src='countyYsb.jsp'/>" 
            },{
                title: '合法',
                html: "<iframe width='"+w+"' height='"+h+"' src='countyHf.jsp'/>" 
            }
        ]
    })
  });
  
   </script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="statusTab" style="width:100%"></div>
		<div id="graphwin" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>	
	</body>
</html>
