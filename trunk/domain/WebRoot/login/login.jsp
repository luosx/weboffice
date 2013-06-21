<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.base.rest.ProjectInfo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String type = request.getParameter("type");
    String name = ProjectInfo.getInstance().PROJECT_NAME;
    if("oa".equals(name)){
    	response.sendRedirect("/reduce/login/oalogin.jsp?type="+type);
    }
    if(type != null && "logout".equals(type)){
        type = "已登出!";
    }else if(type != null && "error".equals(type)){
    	type="用户名或密码错误！";
    }else{
        type = "&nbsp;";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>
    <%
    	if(name.equals("xuzhouWW")){
    %>徐州市国土资源指挥调度监控中心
    <%}else{%>
     国土资源违法违规线索在线管理系统
    <%	}
     %>
    </title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>/login/js/cookies.js" type="text/javascript"></script>
    <style type="text/css">
    body {
	    background-image: url(images/<%=name%>/login_bk.jpg);
    }
    </style>
</head>

<body onload="MM_preloadImages()">
<form id='loginForm' method="post" action='<%=basePath %>j_spring_security_check'>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="595" valign="top" background="images/<%=name%>/login.jpg"><table width="1000" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="707" height="287">&nbsp;</td>
        <td width="293">&nbsp;</td>
      </tr>
      <tr>
        <td height="18">&nbsp;</td>
        <td style="padding-left:55px;padding-top:1px;"><label>
          <input name="j_username" type="text" class="input" id="j_username" />
        </label></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="21">&nbsp;</td>
        <td style="padding-left:55px;padding-top:5px;"><input name="j_password" type="password" class="input" id="j_password" /></td>
      </tr>
      <tr>
        <td height="53">&nbsp;</td>
        <td><table width="" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td style="width:150px;text-align: left"><span style="margin-left:-10px;color:red;"><%=type%></span></td>
            <td width="93" ><a href="#" style="margin-left:-49px;" onclick='login();return false;' target="_parent" onmouseover="MM_swapImage('Image1','','images/<%=name%>/dl_btnB.gif',1)" onmouseout="MM_swapImgRestore()"><img src="images/<%=name%>/dl_btnA.gif" name="Image1" width="51" height="22" border="0" id="Image1" /></a></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
<script>
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