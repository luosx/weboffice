<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>全部图斑</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
  </head>
  
  <script type="text/javascript">
  Ext.onReady(function (){
  	Ext.QuickTips.init();
  	
  	var toolbar = new Ext.Toolbar({ 
  	 renderTo: "div_view",   
        frame: true,   
        items:[   
            {id:"tbtj", text:"图斑统计", iconCls:"add",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/faq.png',handler:tbtj},"-",
            {id:"lctj", text:"里程统计", iconCls:"add",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/faq.png',handler:lctj},"-",    
            {id:"save", text:"柱状图", iconCls:"save",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/zhuzhuang.png',handler:zhu_shape},"-",  
            {id:"bingzhung", text:"饼状图", iconCls:"bingzhung",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/statics.png',handler:bing_shape},  "-",  
            {id:"print", text:"打印", iconCls:"print",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/printer.png',handler:print_page},   "-",  
            {id:"tongji", text:"统计设置", iconCls:"tongji",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/config.png'}, "-",    
            {id:"refresh", text:"刷新", iconCls:"refresh",icon:'<%=basePath%>web/jizeWW/tjAnalyse/img/0001.png',handler:flush_page}   
        ]   
    });
  });
  
  //显示报表
  function tbtj(){
  	parent.view.location.href="<%=basePath%>web/jizeWW/tjAnalyse/tbtj.jsp";
  }
  function lctj(){
  	parent.view.location.href="<%=basePath%>web/jizeWW/tjAnalyse/lctj.htm";
  }
  //显示柱状图
  function zhu_shape(){
  	parent.view.location.href="<%=basePath%>web/jizeWW/tjAnalyse/anychart/chart.jsp?xml=zhu.xml";
  }
  
  //显示饼状图
  function bing_shape(){
  	parent.view.location.href="<%=basePath%>web/jizeWW/tjAnalyse/anychart/chart.jsp?xml=bing.xml";
  }
  
  //打印
  function print_page(){
  	print();
  }
  
  //刷新
  function flush_page(){
  	parent.view.location.reload();
  }
  </script>
  
  <body>
    <div id="div_view"></div>
  </body>
</html>
