<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String xmmc = request.getParameter("xmmc");
	String type=request.getParameter("type");
	String editor=request.getParameter("editor");
	if(xmmc!=null){
		xmmc = new String(xmmc.getBytes("iso-8859-1"),"utf-8");
	}
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
        		title: '一览表',
        		html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/xmgl/ylb/ylb.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>'/>"
        	},
        	{
                title: '用地指标',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/xmgl/xmkgzb/xmkgzbb.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>'/>"
            }
            ,
        	{
                title: '办理经过',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/xmgl/blgc/blgcEditor.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>'/>" 
            }
            ,
            {
                title: '资金管理',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/xmgl/zjgl/zjgl.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>&type=<%=type%>&editor=<%=editor %>'/>"
            }
            ,
            {
                title: '档案管理',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/xmgl/dagl/accessorymain.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>'/>"
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
