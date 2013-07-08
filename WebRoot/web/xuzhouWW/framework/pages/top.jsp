<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="com.klspta.web.xuzhouWW.util.UtilTool"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   
    String name = ProjectInfo.getInstance().getProjectName();
     String weather= new UtilTool().getWeather();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>执法监察系统</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
        <meta http-equiv="description" content="This is my page">
        <style type="text/css">
        
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background-image: URL("<%=basePath%>web/<%=name%>/framework/images/top/top_bk.jpg");
}
body,td,div,span,li{
 font-size:12px;
  color:#fff;
}
</style>
<style type="text/css" media="all"> 
	.d1{
	margin-top:15px;
	margin-left:50px;
	width:230px;
	background-image:url('<%=basePath%>web/<%=name%>/xuzhouWW/framework/images/menu/menu_bk.jpg');
	height:20px;
	overflow:hidden;
	white-space:nowrap;
	}
	.d2{
	background-color:#FF9933;
	}
	.div2{
	width:auto;
	height:20px;
	font-size:12px;
	color:#FFFFFF;
	}
</style>
<script language="javascript" type="text/javascript"> 
var  temp1="1℃";
var  temp2="12℃";
var image="001";
var temp=temp1+"~"+temp2;
var temp_image;
var weather=<%=weather%>;
 weather=eval(weather);
 function onload(){
  temp1=weather.weatherinfo.temp1;
  temp2=weather.weatherinfo.temp2;
  temp_image=weather.weatherinfo.weather;
  temp=temp1+"-"+temp2;
  
for(var i=0;i<temp_image.length;i++){
if("晴"==temp_image.substring(i,i+1)){
document.getElementById("img").src='<%=basePath%>web/<%=name%>/framework/images/weather/001.png';
}
if("雨"==temp_image.substring(i,i+1)){
document.getElementById("img").src='<%=basePath%>web/<%=name%>/framework/images/weather/003.png';
}
if("阴"==temp_image.substring(i,i+1)){
document.getElementById("img").src='<%=basePath%>web/<%=name%>/framework/images/weather/002.png';
}
if("雪"==temp_image.substring(i,i+1)){
document.getElementById("img").src='<%=basePath%>web/<%=name%>/framework/images/weather/004.png';
}
 document.getElementById("weather").innerHTML="徐州"+temp;
 }
}

function onlineCar(){
  var result = ajaxRequest("<%=basePath%>","hander","countAllCar","");
  result=eval(result);
  var onlineCar=0;
  for(var i=0;i<result.length;i++){
   var xzqcode=result[i].xzqcode;
   var xzqname=result[i].xzqname;
   var child=result[i].child;
   var parent=result[i].parent;
   if(xzqcode=='320300'){
     onlineCar=child;
   }
  }
  document.getElementById("online").innerHTML=onlineCar+"&nbsp&nbsp台";

}

 function getid(id){
	return document.getElementById(id);
	}
	
	
</script>

</head>
    <body  onload="onload();onlineCar()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="417"><img src="<%=basePath%>web/<%=name%>/framework/images/top/logo.jpg" width="417" height="53" /></td>
    <td></td>
    <td width="332" style="background-position:bottom left;background-repeat:no-repeat;background-image:url('<%=basePath%>web/<%=name%>/framework/images/top/notice.png')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img style="position:absolute;bottom:2;" src="<%=basePath%>web/<%=name%>/framework/images/top/announce.png" width="24" height="24" />
     <div class="d1" id="div1">
       <span class="div2" id="div2"><b>&nbsp;&nbsp;&nbsp;&nbsp;当前在线执法监察车：<a id='online' style="color: red; ">23台&nbsp;&nbsp;&nbsp;&nbsp;</a></b></span><span id="div3" class="div2"></span>
    </div>
    </td>
     <td align="right" style="padding-right: 5px"><img id="img" src="<%=basePath%>web/<%=name%>/framework/images/weather/001.png" width="32" height="32" /></td>
     <td  id='weather'  width="80"  align='right'  style="padding-right: 10px"> 徐州12℃ </td>
  </tr>
</table>
<div  id='toollip'></div>
<div  id='updateForm'></div>
    </body>
</html>

