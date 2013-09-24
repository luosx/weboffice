<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.jizeNW.dtxc.PADDataManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String year = request.getParameter("year");
	Map<String, Object> map = new PADDataManager().getWphcData(yw_guid, year);
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
            <%if(null != map){%>
            {
                title: '现场核查情况',
                html: "<iframe width='"+w+"' height='"+h+"' src='xckcqk.jsp?yw_guid=<%=yw_guid%>&year=<%=year%>'/>"
            },
            <%}%>
            {
                title: '卫片位置查看',
                html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>base/fxgis/framework/gisViewFrame.jsp?flag=1&yw_guid=<%=yw_guid%>&year=<%=year%>'/>"
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
