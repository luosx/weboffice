<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>leftmenu</title>
<script>
 //巡查日志填写
 function xcrzWrite(){
	 parent.rightview.location.href="<%=basePath%>web/<%=name%>/dtxc/xcrz/xcrz.jsp";
 }
 //巡查日志列表
 function xcrzList(){
	 parent.rightview.location.href="<%=basePath%>web/<%=name%>/dtxc/xcrz/xcrzList.jsp";
 }
 //巡查成果导入
 function xccgImport(){
	 parent.rightview.location.href="<%=basePath%>web/<%=name%>/dtxc/wyxc/importCgfile.jsp";
 }
 //巡查成果列表
 function xccgList(){
	 parent.rightview.location.href="<%=basePath%>web/<%=name%>/dtxc/wyxc/PADDataList.jsp";
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
	  	<li onClick='xcrzWrite()'>
		    <img class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/phone.png"/>
		    <span class="menutitle">巡查日志填写</span>
		</li>
	  
	    <li onClick='xcrzList()'>
		    <img class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/calendar.png"/>
		    <span class="menutitle">巡查日志列表</span>
	    </li>
	    <!-- 
		    <li onClick='xccgImport()'>
			    <img  class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png"/>
			    <span class="menutitle">巡查成果导入</span>
		    </li>
		 -->
	    <li onClick='xccgList()'>
		    <img  class="menuicon" src="<%=basePath%>web/<%=name%>/framework/images/menu/mail.png"/>
		    <span class="menutitle">巡查成果列表</span>
	    </li>
    </ul>
  </body>
</html>