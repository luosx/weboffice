<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>土地变更调查待核查</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
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

  </head>
  <script type='text/javascript'>
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
	                html: "<iframe width='"+w+"' height='"+h+"' src='tdbgyswf.jsp'/>" 
	            },{
	                title: '疑似合法',
	                html: "<iframe width='"+w+"' height='"+h+"' src='tdbgyshf.jsp'/>"
	            }
	        ]
    	})
  });
  
  
  </script>
  <body>
  	<div id="statusTab" style="width:100%"></div>
  </body>
</html>
