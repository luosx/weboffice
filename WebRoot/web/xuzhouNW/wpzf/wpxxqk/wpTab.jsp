<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.PADDataManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	Map<String, Object> map = new PADDataManager().getWphcData(yw_guid);
	String year = request.getParameter("year");
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
                title: '土地疑似违法图斑核查情况登记卡',
                html: "<iframe width='"+w+"' height='"+h+"' src='weipiandjb.jsp?yw_guid=<%=yw_guid%>'/>" 
            }
            <%if(null != map){%>
            ,{
                title: '现场核查情况',
                html: "<iframe width='"+w+"' height='"+h+"' src='xckcqk.jsp?yw_guid=<%=yw_guid%>'/>"
            }
            <%}%>
            ,{
                title: '卫片位置查看',
                html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>base/fxgis/framework/gisViewFrame.jsp?flag=1&year=<%=year%>&yw_guid=<%=yw_guid%>'/>"
            },{
                title: '电子附件',
                html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>model/accessory/dzfj/accessorymain.jsp?yw_guid=<%=yw_guid%>'/>"
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
