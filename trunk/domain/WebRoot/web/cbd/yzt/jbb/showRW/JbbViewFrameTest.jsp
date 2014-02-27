<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'JbbViewFrameTest.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
  		var gisurl = "<%=basePath%>/base/fxgis/framework/gisViewFrame.jsp";
  		var url = "<%=basePath%>/web/cbd/yzt/jbb/showRW/jbbEditor.jsp";
  		Ext.onReady(function(){
  			Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
  			var	width = document.body.clientWidth;
			var	height = document.body.clientHeight;
          new Ext.Viewport({
              layout: "border",
              items:[{
                 region:"center",
                 width:width * 0.5,
                 split:true,
                 layout:'fit',
                 layoutConfig:{
                    animate:true
                	},
                 html:"<iframe id='report' width=100% height=100% src=" + gisurl
							+ "></iframe>"
            },{
                 title:'east',
                 region:'east',
                 width:width * 0.5,
                 split:true,
                 layout:'fit',
                 collapsible: true,
                 layoutConfig:{
                    animate:true
                	},
                 html:"<iframe id='report' width=100% height=100% src=" + url
							+ "></iframe>"
            }]
           });
        });
  </script>
  <body>
  </body>
</html>
