<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>执法监察系统</title>
<script type="text/javascript">
function exitFullScreen() 
{ 
   var esc=window.event.keyCode; 
   if(esc==27) //判断是不是按的Esc键,27表示Esc键的keyCode. 
   {   
     var url=document.location.href;  
     var scrWidth=screen.availWidth;
     var scrHeight=screen.availHeight;   
     newWin=window.open(url,'','fullscreen=0,directories=1,location=1,menubar=1,resizable=1,scrollbars=1,status=1,titlebar=1,toolbar=1'); 
     newWin.moveTo(0,0);
     newWin.resizeTo(scrWidth,scrHeight);                               
     window.opener=null; 
     window.open('','_self');          
     window.close();                          
    }
} 
document.onkeydown = exitFullScreen; 
</script>
  </head>
  	<frameset id="main" name="main" rows="106,*" frameborder="no" border="0" framespacing="0" >
		<frame id="upper" name="upper" scrolling="NO" noresize src="<%=basePath%>console/upper.jsp" />
		<frame id="lower" name="lower" scrolling="NO" noresize src="<%=basePath%>console/adminMain.jsp" />
	</frameset>
</html>
