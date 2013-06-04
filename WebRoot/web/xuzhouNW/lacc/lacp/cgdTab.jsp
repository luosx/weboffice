<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.xuzhouNW.lacc.laccWorkflow.LaccWFManager"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.cgd.CgdManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	int num = new CgdManager().getCgdnum(yw_guid);
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
        activeTab:0,
        frame:true,
        items:[
	        <% if(num >= 1){ %>
					{
					title:'表1',
					html:"<iframe width='" + w + "' height='" + h + "' src='<%=basePath%>web/xuzhouNW/lacc/lacp/cgd.jsp?jdbcname=YWTemplate&yw_guid=<%=yw_guid%>V1'></>"
					}
			<%}%>
	        <% for(int i = 2; i <= num; i++){ %>
	        	,{
					title:'表<%=i%>',
					html:"<iframe width='" + w + "' height='"+ h +"' src='<%=basePath%>web/xuzhouNW/lacc/lacp/cgd.jsp?jdbcname=YWTemplate&yw_guid=<%=yw_guid%>V<%=i%>'></>"
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

