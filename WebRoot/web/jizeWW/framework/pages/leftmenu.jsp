<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="com.klspta.web.jizeWW.framework.WWmenuManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
String parentMenuId = request.getParameter("menuId");
Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	User userBean = null;
	if (principal instanceof User) {
		userBean = (User) principal;
	}
	WWmenuManager wwmenuManager = new WWmenuManager();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>leftmenu</title>
<script>
function openPage(url){
	  		top.center.mapView.openURL("<%=basePath%>web/<%=name%>/" + url,1);
	}
 </script>
 <style type="text/css">
 .menutitle
{
	font-family:"宋体";
	font-size: 12pt;
	color: #3E89B6;
	vertical-align: middle;	
}
.menuicon
{	
	width:20px;
	height:20px;
	vertical-align: middle;	
}
.menu
{
	list-style:none;
	display:block;
	height:28px;
	margin:0;
	padding:0;
	float:center;
}
.menu li
{
	float:center;
	display:block;
	list-style:none;
	vertical-align:middle;
	margin-top:5px;
	width:160px;
	cursor:hand;
}
</style>
</head>
  <body>
  	<ul class="menu">
	    <%
			out.print(wwmenuManager.getWWMenuCode(userBean,parentMenuId,0));
		%>
    </ul>
  </body>
</html>