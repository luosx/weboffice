<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Map.Entry"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    String id = request.getParameter("id");
    String xzqhdm=request.getParameter("xzqhdm");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

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

	<body>
<script type="text/javascript">
  Ext.onReady(function (){
  	Ext.QuickTips.init();
  	
  	var toolbar = new Ext.Toolbar({ 
  	 renderTo: "div_view",   
        frame: true,   
        items:[   
            {id:"report", text:"报表", iconCls:"report",icon:'<%=basePath%>web/xuzhouWW/analyse/img/faq.png',handler: onMenuItem},"-",   
            {id:"zhuzhuang", text:"柱状图", iconCls:"zhuzhuang",icon:'<%=basePath%>web/xuzhouWW/analyse/img/zhuzhuang.png',handler: onMenuItem},"-",  
            {id:"bingzhuang", text:"饼状图", iconCls:"bingzhuang",icon:'<%=basePath%>web/xuzhouWW/analyse/img/statics.png',handler: onMenuItem},"-",  
            {id:"fullscreen", text:"全屏显示", iconCls:"fullscreen",icon:'<%=basePath%>web/xuzhouWW/analyse/img/copy.gif',handler: onMenuItem},"-",   
            {id:"print", text:"打印", iconCls:"print",icon:'<%=basePath%>web/xuzhouWW/analyse/img/printer.png',handler: onMenuItem},   "-",  
           // {id:"tongji", text:"统计设置", iconCls:"tongji",icon:'<%=basePath%>web/xuzhouWW/analyse/img/config.png',handler: onMenuItem}, "-",    
            {id:"refresh", text:"刷新", iconCls:"refresh",icon:'<%=basePath%>web/xuzhouWW/analyse/img/0001.png',handler: onMenuItem}   
        ]   
    });
  });
  
function onMenuItem(item){  
 //alert(item.text);  
//item.setDisabled(true);
//currnetItem = item;
var id = <%=id%>;
var item = item.text;
if(item == '报表')
{
	parent.view.location.href="<%=basePath%>web/xuzhouNW/wpzf/tjfx/hefei.html";
}
if(item == "柱状图"){
parent.view.location.href="<%=basePath%>web/xuzhouNW/wpzf/tjfx/chartfile/chart.jsp?xml=tj_z.xml";
}
if(item == "饼状图"){
	parent.view.location.href="<%=basePath%>model/report/showReport.jsp?id=350E9FD41FC948498141218D79AC451E&fieldValue=321003-515,321003-515";
}
if(item == "全屏显示"){
	if(top.index.rows=="106,32,*"){
	top.index.rows="0,32,*"
	top.content.partline.turn();
	}else{
	top.index.rows="106,32,*"
	}
	
}
if(item == "打印"){
	print();
}
if(item == "刷新"){
	parent.view.location.reload();
}
if(item == "统计设置"){
	
}
}  
  </script>
  
  <body>
    <div id="div_view"></div>

		<div id='container'></div>
	</body>
</html>