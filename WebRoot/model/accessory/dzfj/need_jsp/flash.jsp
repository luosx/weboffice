<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.accessory.dzfj.AccessoryOperation" %>
<%@page import="com.klspta.model.accessory.dzfj.AccessoryBean" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String file_id=request.getParameter("file_id");
String realPath=request.getRealPath("/")+"common//pages//accessory//download//";
AccessoryBean bean=new AccessoryBean();
bean.setFile_id(file_id);
bean.setFile_type("file");
String imagePath=basePath+"/model/accessory/dzfj/imgs";
String temp_file_path=basePath+"model//accessory//dzfj//download//"+AccessoryOperation.getInstance().download(bean,realPath);
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
function onloadmethod(){
	var screenWidth = screen.width;
	if(screenWidth<1024)
	document.all("tralign").align = "left";
	
	/*增加FLASH控件*/
	var _html = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='<%=imagePath%>/swflash.cab#version=7,0,19,0' width='800' height='600' title='主菜单'>";
		_html += "<param name='movie' value='<%=temp_file_path%>'>";
		_html += "<param name='quality' value='high'>";
		_html += "<embed src='<%=temp_file_path%>' width='800' height='600' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash'></embed>";
		_html += "</object>";
	var myQTObject = new QTObject(_html);
	myQTObject.write("flashMenu");
}
function logout(){

top.location.href='<%=basePath %>j_spring_security_logout';

}
</script>
	</head>
	<body onload="javascript:onloadmethod()"  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="flashMenu">
</div>
	</body>
</html>
