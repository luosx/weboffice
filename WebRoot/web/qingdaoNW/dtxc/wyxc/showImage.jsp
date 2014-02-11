<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="java.util.Map"%>
<%
    String image = request.getParameter("image");
    String[] images = image.split(",");
 //   String width = request.getParameter("width");
  //  String height = request.getParameter("height");
    //Map<String ,Object> map=UtilFactory.getFtpUtil().getFtpConfig();
    String host = UtilFactory.getConfigUtil().getConfig("ftp.host");
    String port = UtilFactory.getConfigUtil().getConfig("ftp.port");
    String username = UtilFactory.getConfigUtil().getConfig("ftp.username");
    String password = UtilFactory.getConfigUtil().getConfig("ftp.password");
    String str="ftp://"+username+":"+password+"@"+host+":"+port+"/"+images[0];
    System.out.print(str+"                                        ");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>JavaScript 图片滑动切换效果</title>
<script src="SlideTrans.js"></script>
</head>
<style type="text/css"> 
.container, .container img{
margin:0;
width:670px;
height:400px;
}
.container img{border:1 solid black;vertical-align:top;}
</style>

<br />
<style type="text/css">
.container ul, .container li{list-style:none;margin:0;padding:0;}


</style>
<body style="padding:0;margin-top:0;">
<center>
<div  id="idContainer2" style="margin:0;padding:0;margin-top:-24px;overflow: visible;">
    <ul id="idSlider2" style="list-style:none;">
        <%
		if(!"no_picture".equals(image))
		{
		for(int i = 0; i < images.length; i++){%>
        <li><img src="ftp://<%=username%>:<%=password%>@<%=host%>:<%=port%>/<%=images[i]%>" alt="图片上传预览" /></li>
        <%}}
		else
		{%>
		<li>未拍摄照片</li>
		<%
		}
		%>
    </ul>
</div>
</center>
</body>
</html>
