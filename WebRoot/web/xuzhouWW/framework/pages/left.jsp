<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   
    String name = ProjectInfo.getInstance().PROJECT_NAME;
    
    
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>执法监察系统</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
   
    background-image: URL("<%=basePath%>web/<%=name%>/framework/images/left/menu_bk.PNG");
}
body,td,div,span,li{
 font-size:12px;
  color:#DFF3FF;
}
div.c{width:261px; overflow:hidden;}
div.selected{font-weight:bold;cursor: hand;float:left;color:#3E89B6;width:87px;height:38px;margin-top:0px;border:0px solid #333; line-height:38px;;background:url("<%=basePath%>web/<%=name%>/framework/images/left/menu_left.PNG") no-repeat 0 0;}
div.unSelected{cursor: hand;float:left;color:#DFF3FF;width:87px;height:38px;margin-top:0px;border:0px solid #333; line-height:38px;}
-->
</style>

</head>
    <body>
    <div class="c；" style="display:none;">
<div id='carMonitor' class="selected" onclick='carMonitor()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;车辆跟踪</div>
<div id='carHistory' class="unSelected" onclick='carHistory()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;轨迹回放</div>
<div id='analyse' class="unSelected" onclick='analyse()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计分析</div>
</div>
<iframe frameborder="no" style='height:100%;width:100%;' id='leftContent' src = "<%=basePath%>web/<%=name%>/carMonitor/carMonitor.jsp"></iframe>
    </body>
</html>
<script type="text/javascript">
/*
 * 车辆监控
 */
function carMonitor(){
	setClassName("carMonitor");
	document.getElementById("leftContent").src = "<%=basePath%>web/<%=name%>/carMonitor/carMonitor.jsp";
}
/*
 * 轨迹回放
 */
function carHistory(){
	setClassName("carHistory");
	document.getElementById("leftContent").src = "<%=basePath%>web/<%=name%>/carHistory/carHistory.jsp";
}
/*
 * 统计分析
 */
function analyse(){
	setClassName("analyse");
	document.getElementById("leftContent").src = "<%=basePath%>web/<%=name%>/analyse/analyse.jsp";
}
/*
 * 为不同菜单设置点击后样式
 */
function setClassName(divName){
	//1、取消所有的样式
    var arr = document.getElementsByTagName('div');
    var num = arr.length;
    for(var i=1;i<num;++i)
    {arr[i].className = "unSelected";
    }
	//2、为当前选中的菜单设置样式
	document.getElementById(divName).className="selected";
}
</script>
