<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.web.xuzhouWW.PADDataList"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
 //获取当前登录用户
	Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	User userBean = (User) user;
	String username=userBean.getFullName();
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
        <%@ include file="/base/include/ext.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
        <style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background:url("<%=basePath%>web/<%=name%>/framework/images/menu/menu_bk.jpg");
   }
-->

.menutitle
{
	
	font-family:"宋体";
	font-size: 9pt;
	color: #3E89B6;
	vertical-align: middle;	
	
}
.menuicon
{	
	width:15px;
	height:15px;
	vertical-align: middle;	

}
.menuseparate
{
	vertical-align: middle;	
	padding:0;
	margin:0;
}
.menu
{
	list-style:none;
	display:block;
	height:28px;
	margin:0;
	padding:0;
	float:left;
	
}
.menu li
{
	float:left;
	display:block;
	list-style:none;
	vertical-align:middle;
	margin-top:5px;
	width:87px;
	cursor:hand;

}
.menuright
{
	
	list-style:none;
	display:block;
	margin:0;
	padding:0;
	float:right;
}
.menuright li
{
	float:left;
	display:block;
	list-style:none;
	margin-top:5px;
	vertical-align:middle;
	cursor:hand;
}


</style>

</head>
    <body onload="timedCount();">

<ul class="menu">
    <li style="width:12px;margin:0;">
    	<img src="<%=basePath%>web/<%=name%>/framework/images/menu/menu_left.jpg"/>
    </li>
    <li onClick='gohome()' style="width:50px;">
   	 	<img  class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/home.png" />
    	<span class="menutitle">首页</span>
    </li>
        </li>  
       <li onClick='tdMapJb()' style="width:105px;">
	    <img class="menuseparate"  src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img class="menuicon"  src="<%=basePath%>web/<%=name%>/framework/images/menu/call.png" />
	    <span class="menutitle">天地图举报</span>
    </li> 
    <li onClick='letterVisit()' style="width:94px;">
	    <img class="menuseparate"  src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img class="menuicon"  src="<%=basePath%>web/<%=name%>/framework/images/menu/phone.png" />
	    <span class="menutitle">12336举报</span>
  
    <li onClick='carMonitor()'>
	    <img class="menuseparate" src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/calendar.png" />
	    <span class="menutitle">车辆跟踪</span>
    </li>
    
    <li onClick='vidoesC()'>
	    <img class="menuseparate"    src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img  class="menuicon"  src="<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png" />
	    <span class="menutitle">视频监控</span>
    </li>

    <li onClick='padResult()'>
	    <img class="menuseparate"    src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png"  />
	    <img  class="menuicon"   src="<%=basePath%>web/<%=name%>/framework/images/menu/mail.png" />
	    <span class="menutitle">平板回传</span>
    </li>


    <li onClick='carHistory()'>
	    <img class="menuseparate"    src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img class="menuicon"  src="<%=basePath%>web/<%=name%>/framework/images/menu/history.png"  />
	    <span class="menutitle">轨迹回放</span>
    </li>
    
    <li onClick='carAnalyse()'>
	    <img  class="menuseparate"   src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png"  />
	    <img  class="menuicon"   src="<%=basePath%>web/<%=name%>/framework/images/menu/statistics3.png" />
	    <span class="menutitle">统计分析</span>
    </li>
    
    <li onClick='carManage()'>
	    <img class="menuseparate"   src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img  class="menuicon"  src="<%=basePath%>web/<%=name%>/framework/images/menu/preferences.png"  />
	    <span class="menutitle">车辆管理</span>
    </li>
    
    <li style="width:120px;"  onClick='showkuangshan()'>
	    <img class="menuseparate"   src="<%=basePath%>web/<%=name%>/framework/images/menu/split.png" />
	    <img  class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/mineral.png"  />
	    <span class="menutitle">矿产执法监察</span>
    </li>
    </ul>
	<ul class="menuright" >
    	<li style="width:120;text-align:right;margin-right:10px;cursor:auto;"><span class="menutitle">欢迎您：<%=username %></span></li>
	    	<li onclick="top.location.href='<%=basePath %>j_spring_security_logout';return false;" >
	    	<img  src="<%=basePath%>web/<%=name%>/framework/images/menu/exit.png"  class="menuicon"/>
	    	<span class="menutitle">退出</span>
    	</li>
    	<li style="width:12px;margin:0;">
    		<img src="<%=basePath%>web/<%=name%>/framework/images/menu/menu_right.jpg"/>
    	</li>
    </ul>

    </body>
</html>
 <script>
 var number;
  var t;  
  function timedCount()  
  {  
    var result = ajaxRequest("<%=basePath%>","pADDataList","getNotReadNumber","");
    number = eval('(' + result + ')');
    number = "&nbsp;"+number;
  }  
  
  //车辆管理
 function carManage(){
	 top.center.mapView.openURL("<%=basePath%>web/<%=name%>/carManager/carList.jsp",1);
	 packUpLeft();
 }
  //平板回传
 function padResult(){
	 top.center.mapView.openURL("<%=basePath%>web/<%=name%>/padResult/PADDataList.jsp",1);
	 packUpLeft();
 }
  //信访举报
 function letterVisit(){
	 top.center.mapView.openURL("<%=basePath%>web/<%=name%>/xfxs_12336/xfxs_list.jsp",1);
	 packUpLeft();
 }
   //天地图举报信息
 function tdMapJb(){
	 top.center.mapView.openURL("<%=basePath%>web/<%=name%>/tdmapjb/jblist.jsp",1);
	 packUpLeft();
 }
  //首页
 function gohome(){
	 top.center.mapView.openMap();
	 spreadLeft();
	 
	 
 }
  //车辆跟踪
 function carMonitor(){
	 top.center.left.location.href="<%=basePath%>web/<%=name%>/carMonitor/carMonitor.jsp";
         top.center.mapView.frames["lower"].swfobject.getObjectById("FxGIS").clear();
	 spreadLeft();
 }
  //轨迹回放
 function carHistory(){
	 top.center.left.location.href="<%=basePath%>web/<%=name%>/carHistory/carHistory.jsp";
         top.center.mapView.frames["lower"].swfobject.getObjectById("FxGIS").clear();
	 spreadLeft();
 }
  //分析
 function carAnalyse(){
	 top.center.mapView.openURL("<%=basePath%>web/<%=name%>/analyse/tjfxTree.jsp",1);
	 packUpLeft();
 }
  
 function packUpLeft()
 {	
  	 if(top.center.content.cols=='261,7,*'){
    	 top.center.partline.turn();
	 }
 }
 function spreadLeft()
 {
  	 if(top.center.content.cols=='0,7,*'){
    	 top.center.partline.turn();
	 }
 }
 function vidoesC(){
 window.open("<%=basePath%>web/<%=name%>/videoMonitor/index.jsp");
 }
 function showkuangshan(){
  window.open("http://218.3.204.222:8008");
 }
 </script>