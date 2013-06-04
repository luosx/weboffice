<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String type = request.getParameter("type");
    String name = ProjectInfo.getInstance().PROJECT_NAME;
    if(type != null && "logout".equals(type)){
        type = "已登出!";
    }else if(type != null && "error".equals(type)){
    	type="用户名或密码错误！";
    }else{
        type = "&nbsp;";
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>苏州伽利综合办公系统</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>/login/js/cookies.js" type="text/javascript"></script>
    <style type="text/css">
    body {
	    background-image: url(images/<%=name%>/loginbg.png);
	    background-position:55% 55%;
    }
    .input{
    	width:170px;
    	height:25px;
  
    }
    ul
    {  
    	position:absolute;
    	right:80px;
    	width:740px;
    	height:390px;
    	margin:0;
    	padding:0;  	
    	background:url(images/<%=name%>/login.png) no-repeat;
    	text-align:left;
    }
    ul li
    {
    	text-align:left;
    	list-style:none;
    	width:100px;
    	padding:0;
    }

    
    </style>
</head>

<body onload="MM_preloadImages()" style="text-align:center;padding-top:100px;">
<form id='loginForm' method="post" action='<%=basePath %>j_spring_security_check'>
	<div>
 
    	<ul> 	
      		<li> 	
        		<input name="j_username" type="text" class="input" id="j_username" style="height:15px;margin:164px 0 0 460px;"/>
      		</li> 
     	   <li >     
        		<input name="j_password" type="password" class="input" id="j_password" style="height:15px;margin:41px 0 0 460px;"/>
      	    </li> 
      	    <li style="height:15px;margin:20px 0 0 460px;">
      	    	<%=type %>
      	    </li>
          	<li  style="height:15px;margin:10px 0 0 458px;"> 
            	<span id="btn" style="cursor:hand;width:99px;height:30px;display:block;background:url(images/<%=name%>/btn1.png);" onclick="login();return false;" target="_parent" 
            	onmouseover="onmouseronandout(2)" onmouseout="onmouseronandout(1)"          	
            	></span>
           </li> 
       </ul>
        </div>
	
</form>
<script>
function onmouseronandout(index)
{
	document.getElementById("btn").style.background="url(images/<%=name%>/btn"+index+".png)";
}
function MM_swapImgRestore() { //v3.0
    var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
  }
function MM_findObj(n, d) { //v4.01
    var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
      d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    if(!x && d.getElementById) x=d.getElementById(n); return x;
  }
function MM_preloadImages(){
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImage() { //v3.0
var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
 if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function login(){
var loginName=document.getElementById('j_username').value;
setCookie('loginName',loginName,30);
document.getElementById('loginForm').submit();
}

var logName=getCookie('loginName');
if(logName){
if(logName=="undefined"){
    logName="";
    document.getElementById('j_username').focus(false,100);
}else{
    document.getElementById('j_username').value=logName;
    document.getElementById('j_password').focus(false,100);
}
}else{
document.getElementById('j_username').focus(false,100);
} 

function loginin() 
{ 
	if(event.keyCode==13) 
	{ 
		login();
	} 
}
document.onkeydown=loginin;
</script>
</body>
</html>

