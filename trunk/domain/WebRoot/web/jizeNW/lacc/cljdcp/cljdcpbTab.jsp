<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.jizeNW.lacc.LaccManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	int num = new LaccManager().getNum(yw_guid, "flwscpb");
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
	var showPathN = "<%=basePath%>web/jizeNW/lacc/cljdcp/cljdcpb.jsp?jdbcname=YWTemplate&yw_guid=<%=yw_guid%>v02";
	var showPathF = "<%=basePath%>web/jizeNW/lacc/cljdcp/cljdcpb.jsp?jdbcname=YWTemplate&yw_guid=<%=yw_guid%>";
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
       	<% if(num == 2){ %>
			activeTab: 1,
		<% }else{%>
			activeTab:0,
		<%}%>
        frame:true,
        items:[
			{
				title:'表一',
				html:"<iframe width='" + w + "' height='"+ h +"' src=" + showPathF + "></>"
			}
			<% if(num == 2){ %>
				,{
				title:'表二',
				html:"<iframe width='" + w + "' height='" + h + "' src=" + showPathN + "></>"
				}
			<%}%>
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

