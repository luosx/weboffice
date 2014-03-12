<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String xmmc = request.getParameter("xmmc");
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
                title: '资金筹集-总体',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zxzjgl/swqfzxzjcjqkb/swqfzxzjcjqkb.jsp'/>"
            }
            ,{
                title: '资金筹集-按项目',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zxzjgl/zjcjxm/zjcjxm.jsp'/>"
            },
            {
                title: '资金来源与投向-总体(也可分项目)',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zxzjgl/zjlyytx/zjlyytx.jsp'/>"
            }
            ,{
                title: '资金使用-分项目',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zxzjgl/zjsyxm.jsp'/>"
            }
            ,{
                title: '资金使用-各项目汇总',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zxzjgl/zjsyxmhz.jsp'/>"
            },{
                title: '资金管理明细表',
                html: "<iframe width='"+w+"' height='"+h+"' src='web/cbd/zxzjgl/zjglmxb.jsp'/>"
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
