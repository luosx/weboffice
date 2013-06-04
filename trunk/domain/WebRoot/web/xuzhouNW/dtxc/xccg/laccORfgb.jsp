<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String yw_guid = request.getParameter("yw_guid");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String fullName = ((User) principal).getFullName();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	    <base href="<%=basePath%>"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>立案查处或法规办</title>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/restRequest.jspf" %>
		<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		
<style type="text/css">
body {
	background-image: url(images/main_bk.gif);
	margin: 0px;
	padding: 0px;
}

.btn {
	background: url(images/btn_bk.gif);
	CURSOR: hand;
	FONT-SIZE: 12px;
	color: white;
	BORDER-RIGHT: #002D96 0px solid;
	BORDER-TOP: #002D96 0px solid;
	BORDER-LEFT: #002D96 0px solid;
	BORDER-BOTTOM: #002D96 0px solid
}
</style>
<script>
//确定
var myData;
function confirm(){
  var selectedValue="";
  var radio=document.getElementsByName("laccORfgb");
  for(var i=0;i<radio.length;i++){
	if(radio[i].checked==true)
	{
	  selectedValue=radio[i].value;
	  
	  if(selectedValue=="立案查处"){
	  	 //立案操作
		 putClientCommond("startWorkflow","startWorkflow");
         putRestParameter("zfjcType","7");
         putRestParameter("yw_guid","<%=yw_guid%>");
         putRestParameter("flag","1");
         putRestParameter("lyType","DTXC");
         putRestParameter("fullName",escape(escape("<%=fullName%>")));
         var path=restRequest();
         path=eval(path);
         var MyArgs = new Array("3",path);
         window.returnValue = MyArgs; 
         cancel();
	}
	  
	  if(selectedValue=="法规办")
	  {
	    putClientCommond("dtxcCG","setAjFgb");
	    putRestParameter("status",6);
	    putRestParameter("yw_guid",'<%=yw_guid%>');
		myData = restRequest();
		if(myData=="true")
		{
		    var MyArgs = new Array("1","2");
            window.returnValue = MyArgs; 
			cancel();
		}
	 }
	 
	 
	}
	
  }
  return selectedValue;
}
//取消关闭窗口
function cancel(){
	window.close();
}
</script>
	</head>
	<body>  
	      <div style="width: 250px; height: 150px; margin: auto; margin-top: 50px">
			<form>
			  <font color="#804000"><b>请选择处理方式</b></font><br/><br/>
			  <input type="radio" name='laccORfgb' id='laccO' value="立案查处"/>立案查处&nbsp;&nbsp;
			  <input type="radio" name='laccORfgb' id='fgb' value="法规办"/>法规办
			  <br/><br/>			
			  <input type="button"  value="确定" onclick="confirm();" style="width: 61px; height: 22px;FONT-SIZE: 12px;CURSOR: hand;" />&nbsp;&nbsp;&nbsp;&nbsp;
			  <input type="button"  value="取消" onclick="cancel();" style="width: 61px; height: 22px;FONT-SIZE: 12px;CURSOR: hand;" />
			</form>
			
	      </div>
	</body>
</html>