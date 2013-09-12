<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String type = request.getParameter("type");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	</head>
	<style>
		html,body {
			FONT-SIZE: 12px;
			color: #CC3300;
			font-weight: bold;
			margin: 0;
			padding: 0;
			border: 0 none;
			overflow: hidden;
			height: 100%;
		}

		.btn {
			background: url('<%=basePath%>/base/form/images/button.png');
			height: 23;
			width: 73;
			CURSOR: hand;
			FONT-SIZE: 12px;
			color: #CC3300;
			BORDER-RIGHT: #002D96 0px solid;
			BORDER-TOP: #002D96 0px solid;
			BORDER-LEFT: #002D96 0px solid;
			BORDER-BOTTOM: #002D96 0px solid
		}
	</style>
	<script type="text/javascript">
		function back(){
			if("blz" == "<%=type%>"){
				parent.location.href = "/domain/web/jizeNW/xfjb/xfList/xfajblz.jsp";
			}else{
				parent.location.href = "/domain/web/jizeNW/xfjb/xfList/xfajybl.jsp";
			}
		}
	</script>
	<body background="<%=basePath%>workflow/images/bg.png">
		<table width="100%">
			<tr>
				<td valign="middle">
					<font color="#804000" size="2">
						<b>信访案件查看</b>
					</font>
				</td>
				<td align="right" valign="middle">
					<button class='btn' id="return" onclick="back()">
						返 回
					</button>
					&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</body>
</html>