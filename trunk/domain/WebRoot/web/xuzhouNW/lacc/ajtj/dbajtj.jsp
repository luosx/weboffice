<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xuzhouNW.lacc.Ajtj"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int[][] list=Ajtj.getInstance().getAjtj();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>待办案件统计表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<style type="text/css">
table {
	font-size: 12px;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #000;
	width: 2027px;
}

tr td {
	border: 1px solid #000;
	border-top: 0px solid #000;
	width: 80px;
}

input {
	width: 40px;
	border: 0px;
	text-align: center;
}
</style>
	</head>

	<body>
		<center>
			<h3>
				待办案件统计一览表
			</h3>
			<hr style="width: 2027px;">
			<br>
			<table cellpadding="0" cellspacing="0" border="1">
				<tr>
					<td>
						机构/节点
					</td>
					<td>
						受理
						<br>
						立案
					</td>
					<td>
						立案
						<br>
						审查
					</td>
					<td>
						立案
						<br>
						审核
					</td>
					<td>
						立案
						<br>
						审批
					</td>
					<td>
						调查
						<br>
						取证
					</td>
					<td>
						撤离
					</td>
					<td>
						大队
						<br>
						审查
					</td>
					<td>
						案件执行室
						<br>
						审核
					</td>
					<td>
						局领导
						<br>
						审批
					</td>
					<td>
						审查
						<br>
						决定
					</td>
					<td>
						大队
						<br>
						审理
					</td>
					<td>
						案件
						<br>
						执行室
						<br>
						审查
					</td>
					<td>
						支队长
						<br>
						审核
					</td>
					<td>
						政策
						<br>
						法规处
						<br>
						审批
					</td>
					<td>
						局长
						<br>
						签批
					</td>
					<td>
						告知
					</td>
					<td>
						听证
					</td>
					<td>
						更改
						<br>
						意见
					</td>
					<td>
						大队
						<br>
						审查
					</td>
					<td>
						执行室
						<br>
						审查
					</td>
					<td>
						支队
						<br>
						审核
					</td>
					<td>
						法规处
						<br>
						意见
					</td>
					<td>
						分管
						<br>
						局长
						<br>
						签批
					</td>
					<td>
						下达
						<br>
						处罚
						<br>
						决定
					</td>
					<td>
						执行
					</td>
					<td>
						移送
					</td>
					<td>
						结案
					</td>
					<td>
						结案
						<br>
						审核
					</td>
					<td>
						结案
						<br>
						审查
					</td>
					<td>
						结案
						<br>
						审批
					</td>
					<td>
						归档
					</td>
				</tr>
				<tr>
					<td>
						一大队
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[0][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						二大队
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[1][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						三大队
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[2][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						四大队
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[3][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						案件审查执行室
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[4][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						支队长
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[5][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						政策法规处
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[6][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						局长
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[7][i]%>">
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>
						综合处
					</td>
					<%
						for (int i = 0; i <31; i ++) {
					%>
					<td>
						<input type="text" name="" id="" value="<%=list[8][i]%>">
					</td>
					<%
						}
					%>
				</tr>
			</table>
		</center>
	</body>
</html>
