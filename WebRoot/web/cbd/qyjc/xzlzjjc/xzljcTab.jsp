<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String view = request.getParameter("view");
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
        items:[{
                title: '租金情况',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/qyjc/xzlzjjc/zjqknd_pjzj.jsp?view=<%=view%>'/>"
            }
        	,
        	{
                title: '写字楼信息',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/qyjc/xzlzjjc/xzlxxViewFrame.jsp?view=<%=view%>'/>" 
            }
            ,{
                title: '平均租金趋势分析',
                html: "<iframe width='100%' height='"+h+"' src='<%=basePath%>web/cbd/tjbb/chart.jsp?xml=xzlzj.xml'/>"
            },{
                title: '平均售价趋势分析',
                html: "<iframe width='100%' height='"+h+"' src='<%=basePath%>web/cbd/tjbb/chart.jsp?xml=xzlsj.xml'/>"
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
