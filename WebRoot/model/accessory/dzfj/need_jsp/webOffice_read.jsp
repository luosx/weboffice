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
String file_type=request.getParameter("file_type");//文档后缀
String temp_file_path=basePath+"common//pages//accessory//download//"+AccessoryOperation.getInstance().download(bean,realPath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>webOffice</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
function onload(){
		var webObj=document.getElementById("WebOffice1"); 
		var vCurItem = document.all.WebOffice1.HideMenuItem(0); 
		if(vCurItem & 0x01){
			webObj.HideMenuItem(0x01);
		}else{
			webObj.HideMenuItem(0x01 + 0x8000); //隐藏新建文档按钮    
		}
		if(vCurItem & 0x02){
			webObj.HideMenuItem(0x02);
		}else{
			webObj.HideMenuItem(0x02 + 0x8000); //隐藏打开文档按钮   
		}
		if(vCurItem & 0x04){
			webObj.HideMenuItem(0x04); 
		}else{
			webObj.HideMenuItem(0x04 + 0x8000); //隐藏保存文档按钮  
		} 
	document.all.WebOffice1.LoadOriginalFile("<%=temp_file_path%>", "<%=file_type%>");
}


</script>
  </head>
  
  <body onload="onload()" bgcolor="#FFFFFF" leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0">
<OBJECT id=WebOffice1 height="100%" width="100%" style="LEFT: 0px; TOP: 0px" 
classid="clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5"  codebase=WebOffice.ocx#V3,0,0,0>
	<PARAM NAME="_Version" VALUE="65536">
	<PARAM NAME="_ExtentX" VALUE="2646">
	<PARAM NAME="_ExtentY" VALUE="1323">
	<PARAM NAME="_StockProps" VALUE="0"></OBJECT> 

  </body>
</html>
