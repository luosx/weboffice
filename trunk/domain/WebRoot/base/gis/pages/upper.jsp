<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@page import="com.klspta.common.security.User" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String imagePath=basePath+"common/images/";
	String swfPath=basePath+"common/images/swf";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String fullName;
if (principal instanceof User) {
   fullName = ((User)principal).getFullName();
} else {
    fullName = principal.toString();
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察系统</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style>
html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 90;
}
</style>
<script type="text/javascript">
		QTObject = function(_html) {
	this.getHTML = _html;
}
QTObject.prototype.write = function(elementId) {
	if (elementId) {
		document.getElementById(elementId).innerHTML = this.getHTML;
	} else {
		document.write(this.getHTML);
	}
}
function init(){
	/*增加FLASH控件*/
	var _html = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='<%=imagePath%>/swflash.cab#version=7,0,19,0' width='772' height='90' title='主菜单'>";
		_html += "<param name='movie' value='<%=swfPath%>/logoFlash.swf'>";
		_html += "<param name='quality' value='high'>";
		_html += "<embed src='<%=swfPath%>/logoFlash.swf' width='772' height='90' quality='high'  pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash'></embed>";
		_html += "</object>";
	var myQTObject = new QTObject(_html);
	myQTObject.write("flashMenu");
}
function logout(){

top.location.href='<%=basePath %>j_spring_security_logout';

}
</script>
	</head>
	<body onload='init()' width='100%'  background="<%=imagePath%>tab_background2.png" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
					<table  width='1230'   border="0" cellspacing="0" cellpadding="0" >
						<tr>
						<td  width='430' >
						 <img src="<%=imagePath%>swf/title.png"></img> 
						</td>
						<td      valign="top" >
						<div id="flashMenu" >
						</div>
						</td>
				</tr>
				</table>
	</body>
</html>
