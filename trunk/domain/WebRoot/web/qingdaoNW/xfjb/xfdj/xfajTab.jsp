<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	String yw_guid = request.getParameter("yw_guid");
	String enterFlag = request.getParameter("enterFlag");
	String keyWord = request.getParameter("keyWord");
	if(yw_guid == null || "".equals(yw_guid)){
		yw_guid = UtilFactory.getStrUtil().getGuid();
	}
	if(keyWord != null){
		keyWord = new String(keyWord.getBytes("ISO8859-1"),"UTF-8");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>信访案件</title>
		
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
	                title: '<font size="2">线索登记表</font>',
	                html: "<iframe width='"+w+"' height='"+h+"' src='wgwfxsdjb.jsp?enterFlag=<%=enterFlag%>&yw_guid=<%=yw_guid%>&keyWord=<%=keyWord%>'/>" 
	            },{
	                title: '<font size="2">附件管理</font>',
	                html: "<iframe width='"+w+"' height='"+h+"' src='/domain/model/accessory/dzfj/accessorymain.jsp?yw_guid=<%=yw_guid%>'/>" 
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
