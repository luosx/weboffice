<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
String resourcePath=basePath+"web/"+name+"/framework";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
.image
{
	display:block;
}
</style>

<script language="javascript">
var width;
var direction=true;
var t;
function clickImage()
{	
	 clearTimeout(t);
	if(direction)
	{
		document.getElementById("icon").src="<%=resourcePath%>/images/back.png";
		
		showImage();
		direction=!direction;
		
	}
	else
	{
		document.getElementById("icon").src="<%=resourcePath%>/images/go.png";
		showImage2();
		direction=!direction;
	}
}
function showImage()
{

	document.getElementById("showimage").scrollLeft+=22;
	if(width>document.getElementById("showimage").scrollLeft)
	{
		t=setTimeout("showImage()",10);
		
	}
	else
	{
		clearTimeout(t);
	}
}
function showImage2()
{
	document.getElementById("showimage").scrollLeft-=22;
	if(document.getElementById("showimage").scrollLeft>0)
	{
		t=setTimeout("showImage2()",10);
	}
	else
	{
		clearTimeout(t);
	}
}
window.onload=function()
{
	var obj=document.getElementById("showimage");
	width=obj.scrollWidth-obj.offsetWidth;
	}
</script>
<body style="background-color:#D6F3FC;">
<img id="icon" onclick="clickImage()"  src="<%=resourcePath%>/images/go.png" style="display:block;float:right;width:26px;height:26px;"/> 

<div style="width:100%;text-align:center;float:right;padding:0;margin:0;">
	<div  id="showimage" style="width:800px;text-align:center;padding:0;margin:0;overflow:hidden;">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td width="790"><img id="img1"  class="image" src="<%=resourcePath%>/images/index3.png" style="border:none;"><td>
				<td width="790"><img id="img2" class="image" src="<%=resourcePath%>/images/ldjc1.png" style="border:none;"></td>
			</tr>
		</table>	
	</div>
</div>
	<!-- 
	<table class="allitem" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td>
			<div class="item">
				<div class="numStyle">10</div>
			</div>
		</td>
		<td>
			<div class="item">
				<div class="numStyle">10</div>
			</div>
		</td>
		<td>
			<div class="item">
				<div class="numStyle">10</div>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="item">
				<div class="numStyle">10</div>
			</div>
		</td>
		<td>
			<div class="item">
				<div class="numStyle">10</div>
			</div>
		</td>
		<td>
			<div class="item">
				<div class="numStyle">10</div>
			</div>
		</td>
	</tr>
	
	</table>
	 -->

</body>
</html>
