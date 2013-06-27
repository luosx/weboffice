<%@ page language="java" pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>任务移交窗口</title>
		
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
<script language="javascript">
 
var dqName = window.dialogArguments

window.onload=function()
{
	document.getElementById("dqName").innerHTML=dqName;
}
	
function xfrw()
{
	window.returnValue="true";
	window.close();
	}
function closeWin()
{
     window.close();
}

</script>
	</head>
<!-- #804000 -->
<body>
		<div style="width:250px; height:100%; margin: auto; margin-top:50px">		
				<span style="font-size:10pt;display:block;marign-left:20px;"><font color="#804000"><b>任务下发给：</b></font></span>	
				
				<span style="display:block;margin-left:50px;margin-top:20px;font-size:8pt;" ><span id='dqName'></span> 国土资源局</span>
				<div style="width:100%;text-align:center;margin-top:20px;">
					<input type="button" class='btn' value="下发" onclick="xfrw()"
						style="width: 61px; height: 22px" />
					<input type="button" class='btn' value="关 闭" onclick="closeWin()"
						style="width: 61px; height: 22px;margin-left:20px;" />
				</div>
			
		</div>
	</body>
</html>