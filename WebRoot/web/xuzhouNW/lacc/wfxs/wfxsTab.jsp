<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String role=request.getParameter("");
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
   	var w=document.body.clientWidth - 20;
	var h=document.body.clientHeight - 30;
      
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,     
        frame:true,
        items:[{
                title: '卫片执法',
                html: "<iframe width='"+w+"' height='"+h+"' src='wpzf.jsp'/>" 
            },{
                title: '信访反映',
                html: "<iframe width='"+w+"' height='"+h+"' src='xfjb.jsp'/>" 
            },{
                title: '巡查发现',
                html: "<iframe width='"+w+"' height='"+h+"' src='xcfx.jsp'/>" 
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
