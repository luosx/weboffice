<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.menu.MenuBean"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
  String name = ProjectInfo.getInstance().PROJECT_NAME;
	String resourcePath = basePath + "web/"+name+"/framework/";
	Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	User user=(User) principal;
	String userId = null;
	String fullName = "";
	if (principal instanceof User) {
		userId = user.getUserID();
		fullName =user.getFullName();
	} else {
		userId = null;
		fullName = principal.toString();
	}
	
	MenuBean firstMenu = null;
	Date date = new Date();
	DateFormat df = new SimpleDateFormat("yyyy年MM月dd日");
	String today = df.format(date);
	String day = "日";
	int number = date.getDay();
	if (number == 1) {
		day = "一";
	} else if (number == 2) {
		day = "二";
	} else if (number == 3) {
		day = "三";
	} else if (number == 4) {
		day = "四";
	} else if (number == 5) {
		day = "五";
	} else if (number == 6) {
		day = "六";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>menu</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=resourcePath%>/css/default.css" rel="stylesheet"
		type="text/css" />
		<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->
</style>

<script  src="<%=resourcePath%>/js/style.js"></script>

		<link href="<%=resourcePath%>css/style.css" rel="stylesheet"
			type="text/css" />
	</head>
	<body>
		<table width="100%" height="32" border="0" cellspacing="0"
			cellpadding="0" style="border:1px solid #8E8E8E;">
			<tr height="30">
			<!-- 
				<td width="11"  background="<%=resourcePath%>images/top/bg_w.png">
				&nbsp;
				</td>
			-->
				<td width="100%"  background="<%=resourcePath%>images/top/bg_w.png">
			
					<%out.print(ManagerFactory.getMenuManager().getMenuCode(user,"",1));%>
					<span style="font-size:12px;position:relative;top:5px;width:92%;text-align:right"><%=fullName%>,<%=today%>,星期<%=day%></span>
					<span style="font-size:12px;position:relative;top:5px;cursor:pointer;"><a onclick="fankui()" style="color:red;">反馈</a></span>
				</td>
				
				<td width=1950" align="left" style="background:url(<%=resourcePath%>images/top/bg_w.png);cursor:pointer;">			
					<div style="border:1px soild black;background:url(<%=resourcePath%>images/top/navrightbc.png);width:195px;height:25px;margin-top:1px;">
						<span style="color:#285290;font-size:12px;margin-top:5px;display:block;margin-left:26px;">
						<a onclick="openMap()">地图</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a onclick="returnFirst()">首页</a>&nbsp;&nbsp;&nbsp;&nbsp;		
						<a class="logout"  style="color:#285290;" href="#" onclick="top.location.href='<%=basePath %>j_spring_security_logout';return false;">注销</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="closeWindow()">退出</a>
						</span>
					</div>
				</td>
			<!-- 
				<td width="10" background="<%=resourcePath%>images/top/bg_w.png">
					<img src="<%=resourcePath%>/images/top/2.jpg"
						onclick="exitfullscreen();" title="退出全屏">
				</td>
				 -->
			</tr>
		</table>
	</body>
</html>
<script language="javascript">
/**
*菜单点击事件 add by guorp 2012-5-24
*/
var openObj;
var isLoad=true;
function mouserNavMoveOnOrOut(obj,color,isMouseIn)
{		
	if(openObj!=obj)
		obj.style.color=color;	
}
function openMenu(menuId){
parent.content.left.location.href="<%=basePath%>web/<%=name%>/framework/pages/left.jsp?menuId="+menuId;	
}
function clickMenu(obj,menuId)
{	
	//alert(parent.content.partline.document.documentElement.outerHTML);
	if(!isLoad)		
		parent.content.partline.show();
	if(openObj!=obj)
	{		
		obj.style.background="url('<%=resourcePath%>/images/top/bg_w_hc.png')";	
		obj.style.color="white";
		isChange=false;	
		if(openObj!=undefined)
		{
			openObj.style.background="none";
			openObj.style.color="#444444";
					
		}	
		openObj=obj;
	}
	
	openMenu(menuId);
}
/**
*全屏及退出全屏 add by guorp 2012-5-24
*/
function exitfullscreen(){
if(top.index.rows=="106,32,*"){
	top.index.rows="0,32,*"
	}else{
	top.index.rows="106,32,*"
	}
}

window.onload=function()
{
	var obj=document.getElementById("menu0_cm").children[0];
	if(obj!=null)
	{

		if( document.createEvent )
		{
			var evObj = document.createEvent('MouseEvents');
			evObj.initEvent( 'onclick', true, true );
			obj.dispatchEvent(evObj);
		}
		else if( document.createEventObject )
		{
			obj.fireEvent('onclick');
		}

	}
	isLoad=false;

	}
function openPage(obj,url){
	if(!isLoad)		
		parent.content.partline.show();
	if(openObj!=obj)
	{		
		obj.style.background="url('<%=resourcePath%>/images/top/bg_w_hc.png')";	
		obj.style.color="white";
		isChange=false;	
		if(openObj!=undefined)
		{
			openObj.style.background="none";
			openObj.style.color="#444444";
					
		}	
		openObj=obj;
	}
	top.content.document.getElementById("content").cols="0,0,*";	
	parent.content.right.location.href='<%=basePath%>'+url; 
	
	/*
    var  autoExtend = url.indexOf("autoExtend");
    if(autoExtend != -1){
        var isAuto = url.substring(autoExtend+11,autoExtend+15);
        if(isAuto){
            top.content.content.cols="0,0,*"; 
       }
    }     
    */    
}

	//点击退出时，触发关闭窗口事件
	function closeWindow(){
		 var browserName=navigator.appName;
		 var rootWindow = window.parent;
		 if (browserName=="Netscape"){
		    rootWindow.open('','_parent','');
		    rootWindow.close(); 
		}else if (browserName=="Microsoft Internet Explorer"){
			rootWindow.opener = null;
			rootWindow.open('','_self');
			rootWindow.close(); 
		}
	}
	
	//点击首页时，进入首页
	function returnFirst(){
		//top.location.href="<%=basePath%>login/login.jsp";
		parent.location.href="<%=basePath%>web/xuzhouNW/main.jsp";
	}
	//打开地图
	function openMap(){
		parent.content.right.location.href="<%=basePath%>base/fxgis/framework/gisViewFrame.jsp?closemenu=*closeMenu*";
		top.content.content.cols="0,0,*"; 
	}
	//反馈功能模块
	function fankui(){
		var url = "/domain/web/xiamen/xxfk/xxfkTab.jsp";     
		var height = window.screen.availHeight;
		var width = window.screen.availWidth-5;
		window.open(url,"","width="+width+",height="+height);
	}
</script>