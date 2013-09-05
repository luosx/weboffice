<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Map.Entry"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
   
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		
		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=extPath%>adapter/ext/ext-base.js"
			type="text/javascript"></script>
		<script src="<%=extPath%>ext-all.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=extPath%>resources/css/ext-all.css" />
		<script type="text/javascript"
			src="<%=extPath%>/src/locale/ext-lang-zh_CN.js"></script>
		<script src="<%=basePath%>/common/js/json2String.js"></script>
		 <%@ include file="/base/include/ext.jspf" %>
	</head>
<script type="text/javascript">
  Ext.onReady(function (){
  	Ext.QuickTips.init();
  	
  	var toolbar = new Ext.Toolbar({ 
  	 renderTo: "div_view",   
        frame: true,   
        items:[   
            {id:"workplan", text:"工作计划", iconCls:"report",icon:'images/edit.png',handler: onMenuItem},"-",
            {id:"worknotice", text:"工作通知", iconCls:"report",icon:'images/faq.png',handler: onMenuItem},"-",
            {id:"refresh", text:"刷新", iconCls:"refresh",icon:'images/0001.png',handler: onMenuItem}   
        ]   
    });
  });
  
function onMenuItem(item){  
//alert(item.text);  
//item.setDisabled(true);
//currnetItem = item;
if(item.text=='工作计划'){
 document.getElementById('bot').src="anyChart/anygantt.html";
    }else if(item.text=='工作通知'){
    document.getElementById('bot').src="worknotice.jsp";
    }else if(item.text=='刷新'){
    document.location.reload();
    }  
}

function aa(){
 document.getElementById('bot').height=document.body.clientHeight;
 document.getElementById('bot').width=document.body.clientWidth;
  document.getElementById('bot').src="anyChart/anygantt.html";
}
  </script>
  
  <body onload="aa()">
    <div id="div_view"></div>
    <iframe id="bot" frameborder="0"></iframe>
  </body>
</html>