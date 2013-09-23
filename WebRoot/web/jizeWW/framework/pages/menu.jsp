<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.web.jizeWW.framework.WWmenuManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	//获取当前登录用户
	Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	User userBean = (User) user;
	String username = userBean.getFullName();
	String name = ProjectInfo.getInstance().PROJECT_NAME;
	WWmenuManager wwmenuManager = new WWmenuManager();
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
		<script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
	<script>
	var var_flag;  
  
	function openPage(url){
		var_flag = url.split("/")[url.split("/").length - 1];//得到jsp页面名称
		if(var_flag == "carMonitor.jsp"){
			carMonitor(url);
		}else if(var_flag == "carHistory.jsp"){
			carHistory(url);
		}else if(var_flag == "index.jsp"){
			vidoesC(url);
		}else{
	  		top.center.mapView.openURL("<%=basePath%>web/<%=name%>/" + url,1);
	  		packUpLeft();
  		}
	}
	
	function openMenu(menuId){
		top.center.left.location.href="<%=basePath%>web/<%=name%>/framework/pages/leftmenu.jsp?menuId="+menuId;
		spreadLeft();
	}
	
	function clickMenu(obj,menuId){	
		openMenu(menuId);
	}
  
  	//首页
	function gohome(){
		top.center.mapView.openMap();
		spreadLeft();
	}
	
	//车辆跟踪
	function carMonitor(url){
		spreadLeft();
		top.center.left.location.href="<%=basePath%>web/<%=name%>/" + url;
		top.center.mapView.openMap();
		top.center.mapView.frames["lower"].swfobject.getObjectById("FxGIS").clear();
	}
	
	//轨迹回放
	function carHistory(url){
		spreadLeft();
		top.center.left.location.href="<%=basePath%>web/<%=name%>/" + url;
		top.center.mapView.openMap();
		top.center.mapView.frames["lower"].swfobject.getObjectById("FxGIS").clear();
	}
	
	//视频监控
	function vidoesC(url){
		window.open("<%=basePath%>web/<%=name%>/" + url);
	}
	
	function packUpLeft()
	{	
		if(top.center.content.cols=='261,7,*'){
			top.center.partline.turn();
		}
	}
	
	function spreadLeft(){
		if(top.center.content.cols=='0,7,*'){
			top.center.partline.turn();
		}
	}
	</script>	
		
<style type="text/css">
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background:url("<%=basePath%>web/<%=name%>/framework/images/menu/menu_bk.jpg");
   }

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
    <body>

		<ul class="menu">
			<li style="width: 12px; margin: 0;">
				<img src="<%=basePath%>web/<%=name%>/framework/images/menu/menu_left.jpg" />
			</li>
			<li onClick='gohome()' style="width: 50px;">
				<img class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/home.png" />
				<span class="menutitle">首页</span>
			</li>
			<%out.print(wwmenuManager.getWWMenuCode(userBean,"",1));%>
		</ul>
		<ul class="menuright">
			<li style="width: 120; text-align: right; margin-right: 10px; cursor: auto;">
				<span class="menutitle">欢迎您：<%=username%></span>
			</li>
			<li onclick="top.location.href='<%=basePath%>j_spring_security_logout';return false;">
				<img src="<%=basePath%>web/<%=name%>/framework/images/menu/exit.png" class="menuicon" />
				<span class="menutitle">退出</span>
			</li>
			<li style="width: 12px; margin: 0;">
				<img src="<%=basePath%>web/<%=name%>/framework/images/menu/menu_right.jpg" />
			</li>
		</ul>

	</body>
</html>
