﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String name = ProjectInfo.getInstance().PROJECT_NAME;
	String resourcePath = basePath + "web/"+name+"/framework";
	String parentMenuId = request.getParameter("menuId");
//	if (parentMenuId == null)
//		parentMenuId = "721651a8cb5855116e0ee6d40c85e4f2";

	Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	User userBean = null;
	if (principal instanceof User) {
		userBean = (User) principal;
	} 
	String userId = userBean.getUserID();
	session.setAttribute("docName", null);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=7" >
		<title>left</title>
	<script src="<%=resourcePath%>/js/style.js"></script>
	</head>
	<link href="<%=resourcePath%>/css/style.css" rel="stylesheet"
		type="text/css" />
		<link href="<%=resourcePath%>/css/default.css" rel="stylesheet"
		type="text/css" />
	<style type="text/css">
<!--
body {
	background-color:#FFFFFF;
}
-->
</style>
	<script type="text/javascript">
function openPage(url){
	showSel(url);
    if(!(url=='#' || url=='')){
    url=url.replace("*username*",'<%=userBean.getUsername()%>');
    if(url.indexOf("*closeMenu*")!=-1)
    {
        parent.partline.turn();
    }
    if(url.indexOf("?") != -1){
    	parent.right.location.href='<%=basePath%>'+url + "&userId=<%=userId%>";
    }else{
    	parent.right.location.href='<%=basePath%>'+url + "?userId=<%=userId%>";
    }
    
    
     
    var  autoExtend = url.indexOf("autoExtend");
    if(autoExtend != -1){
        var isAuto = url.substring(autoExtend+11,autoExtend+15);
        if(isAuto){
            top.content.content.cols="0,0,*"; 
        }
    }       
    }
}
var showid;
function showSel(selId)
{
	if(showid!=selId)
	{
		document.getElementById("sel_"+selId).style.display="inline";
		if(showid!=null)
		document.getElementById("sel_"+showid).style.display="none";
	}
	showid=selId;
}
var closeMenu;


window.onload=function(){
	//alert(document.getElementById("menuLeftDiv").children[0].);

	var url=parent.right.location.href.replace('<%=basePath%>','');
	if(document.getElementById("sel_"+url)!=null)
		showSel(url);
	
	document.getElementById("menuLeftDiv").children.length!=0;
	{
		var obj = document.getElementById("menuLeftDiv").children[0];
		if(obj!=null)
		{
				obj=obj.children[0];
			if( document.createEvent )
			{
				var evObj = document.createEvent('MouseEvents');
				evObj.initEvent( 'onclick', true, false );
				obj.dispatchEvent(evObj);
			}
			else if( document.createEventObject )
			{
				obj.fireEvent('onclick');
			}
	
		}
	}
	//var leftMenuHeight=window.screen.availHeight-top.flash.document.body.clientHeight-top.menu.document.body.clientHeight-100;
}

function openMenu(){
	
	
}
</script>
	<body style="margin: 0px 0px 0px 0px;" >
	<div id="menuLeftDiv" class="menuLeft" onmousedown="scrollMouserDown()"  onmouseup="scrollMouserUp()" onmousemove="scrollMouserMove(this)" onmouseout="scrollMouserUp()">
		<%
			if(parentMenuId!=null)
				out.print(ManagerFactory.getMenuManager().getMenuCode(userBean,parentMenuId,0));
		%>
	</div>
	</body>
</html>