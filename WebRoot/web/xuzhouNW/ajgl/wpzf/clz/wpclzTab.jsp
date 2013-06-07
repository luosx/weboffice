<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    String year=request.getParameter("year");

	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>处理中</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
        <%@ include file="/base/include/ext.jspf" %>
		<style>
		input,img{vertical-align:middle;}
		</style>
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
		<script type="text/javascript">

Ext.onReady(function(){
var w=document.body.clientWidth ;
var h=document.body.clientHeight - 30;
var tabs;
	var tabs = new Ext.TabPanel({
        renderTo:'wpzfjcTab',
        activeTab: 0,     
        frame:true,
        items:[{
                title: '未核查',
               html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>/web/xuzhouNW/ajgl/wpzf/clz/wpclzWhcList.jsp?status=2&year=<%=year%>'/>"
           },{
                title: '已核查',
               html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>/web/xuzhouNW/ajgl/wpzf/clz/wpclzYhcList.jsp?status=6&year=<%=year%>'/>"
           }
        ]
    })
       
    });
    
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="wpzfjcTab" style="width:100%;"></div>
	</body>
</html>