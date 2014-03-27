<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo;"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String type = request.getParameter("type");
	ProjectInfo project = ProjectInfo.getInstance();
	//  String name = project.getProjectName();
	String loginname1 = project.getProjectLoginName1();
	String loginname2 = project.getProjectLoginName2();
	if (type != null && "logout".equals(type)) {
		type = "已登出!";
	} else if (type != null && "error".equals(type)) {
		type = "用户名或密码错误！";
	} else {
		type = "&nbsp;";
	}
%>


<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="shortcut icon" href="../../image/nanjingBus/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="../../css/nanjingBus/ext-all.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/nanjingBus/ext-patch.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/nanjingBus/site.css" />
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/login/js/cookies.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/nanjingBus/Silverlight.js"></script>
<script type="text/javascript"
	src="../../js/nanjingBus/InstallCreateSilverlight.js"></script>
<script type="text/javascript" src="../../js/nanjingBus/ext-base.js"></script>
<script type="text/javascript" src="../../js/nanjingBus/ext-all.js"></script>
<script type="text/javascript"
	src="../../js/nanjingBus/ext-lang-zh_CN.js"></script>

</head>
<body id="div1"
	style="overflow: hidden; margin-left: auto; margin-right: auto; width: 100%; height: 100%; background: #00A6EA url(../../images/nanjingBus/bg.png) repeat-x;">
	<div id="loginDiv" style="width: 645px; margin: auto; clear: both;">
		<div
			style="margin-left: auto; margin-right: auto; margin-top: 160px; margin-bottom: 50px; width: 645px; height: 295px;">
			<ul>
				<li class="FloatLeft"
					style="width: 15px; height: 15px; background: url(../../images/nanjingBus/bgbox_r2_c2.png) no-repeat;"></li>
				<li class="FloatLeft"
					style="width: 615px; height: 15px; background: url(../../images/nanjingBus/bgbox_r2_c5.png) repeat-x;"></li>
				<li class="FloatLeft"
					style="width: 15px; height: 15px; background: url(../../images/nanjingBus/bgbox_r2_c8.png) no-repeat;"></li>
			</ul>
			<ul>
				<li class="FloatLeft"
					style="width: 15px; height: 265px; background: url(../../images/nanjingBus/bgbox_r3_c2.png) no-repeat;"></li>
				<li class="FloatLeft"
					style="width: 615px; height: 265px; background: url(../../images/nanjingBus/bgbox_r3_c3.png) repeat-x;">
					<div
						style="width: 560px; height: 122px; background: url(../../images/nanjingBus/bgbox_r4_c4.gif) no-repeat; margin: 10px 0px 0px 25px;"></div>
					<form id='loginForm' method="post" action='<%=basePath %>j_spring_security_check'>
					<div style="height: 30px; margin: 10px 0px 0px 35px;">
						<span style="margin-left:160px;">
						帐&nbsp;&nbsp;&nbsp;&nbsp;号：<input type="text" name="j_username" 
							id="username" style="height: 18px; width: 150px"
							/>&nbsp;&nbsp;<span
							id="err" style="color: Red"></span></span>
					</div>
					<div style="height: 30px; margin: 0px 0px 0px 35px;">
					<span style="margin-left:160px;">
						密&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="password" name="j_password"
							id="pwd" style="height: 18px; width: 150px"
							/></span>
					</div>
					</form>
					<div style="height: 30px; margin: 10px 0px 0px 35px;"id="buttondiv">
						
							<span style="margin-left:230px;"><input type="button" id="submit" value="登录" onclick="login();" style="width:60px;height:30px;" /></span>
					</div>
					<div id="load"
						style="display: none; color: Red; height: 30px; margin: 10px 0px 0px 35px;">
						<img src="../../images/nanjingBus/ajax-loader.gif" />登录中......
					</div></li>
				<li class="FloatLeft"
					style="width: 15px; height: 265px; background: url(../../images/nanjingBus/bgbox_r3_c9.png) no-repeat;"></li>
			</ul>
			<ul>
				<li class="FloatLeft"
					style="width: 15px; height: 15px; background: url(../../images/nanjingBus/bgbox_r8_c2.png) no-repeat;"></li>
				<li class="FloatLeft"
					style="width: 615px; height: 15px; background: url(../../images/nanjingBus/bgbox_r8_c5.png) repeat-x;"></li>
				<li class="FloatLeft"
					style="width: 15px; height: 15px; background: url(../../images/nanjingBus/bgbox_r8_c8.png) no-repeat;"></li>
			</ul>
		</div>
		<div id="info"
			style="font-size: 14px; color: #FFFFFF; font-weight: bold; text-align: left; position: absolute; display: none; margin-top: -40px; margin-left: 40px; line-height: 130%;">

		</div>

	</div>
	<div id="divPlayer_0"
		style="margin-left: auto; margin-right: auto; width: 640px; height: 480px">
	</div>


	
	<script type="text/javascript">
		//我们自己的

		function login() {
			if (document.getElementById("username").value.trim() != "" && document.getElementById("pwd").value.trim() != "") {
			var loginName = document.getElementById('username').value;
			setCookie('loginName', loginName, 30);
			document.getElementById('loginForm').submit();
		}else{
                        document.getElementById("err").innerHTML="用户和密码不能为空！"
                    }
		}
		function loginin() {
			if (event.keyCode == 13) {
				login();
			}
		}
		document.onkeydown = loginin;
	</script>
	<div id="ipinfo"
		style="font-size: 12px; text-align: center; position: absolute; right: 20px; bottom: 10px;"></div>
</body>

</html>
