<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.cbsycs.jbxxlb.Jbxxlb" %>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   Jbxxlb jbxxlb= Jbxxlb.getInstance();
   LinkedList<String [][]> list= jbxxlb.getList();
   
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>CBD区域成本及收益测算一览表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style>
input,img {
	vertical-align: middle;
}

html,body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font: normal 13px verdana;
}

table {
	border-collapse: collapse;
	border: none;
}

td {
	border: solid #000 1px;
}
#leftright, #topdown{
position:absolute;
left:0;
top:0;
width:1px;
height:1px;
layer-background-color:#FF6905;
background-color:#FF6905;
z-index:0;
font-size:0px;
}
</style>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
<h2 align="center">CBD区域成本及收益测算一览表</h2>
	<table id='planTable' border=1  style="text-align: center; font: normal 13px verdana;" width='100%'>
		<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td rowspan="2">基本地块<br>编号</td>
		<td colspan="8">规划数据（公顷、万㎡）</td>
		<td colspan="6">拆迁数据（万㎡、户）</td>
		<td colspan="5">成本及收益情况(亿元、元/㎡)</td>
		<td rowspan="2">拆迁强度<br>（万㎡/公顷）</td>
		<td rowspan="2">成本<br>覆盖率</td>
		</tr>
		<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>占地</td>
		<td>建设用地</td>
		<td>容积率</td>
		<td>建筑规模</td>
		<td>规划用途</td>
		<td>公建建筑规模</td>
		<td>居住建筑规模</td>
		<td>市政建筑规模</td>
		<td>总征收规模</td>
		<td>住宅征收规模</td>
		<td>住宅征收户数</td>
		<td>户均面积</td>
		<td>非住宅征收规模</td>
		<td>非住宅家数</td>
		<td>开发成本</td>
		<td>楼面成本</td>
		<td>地面成本</td>
		<td>预计政府土地收益</td>
		<td>存蓄比</td>
		</tr>
	<%for(int i=0;i<list.size();i++){
	for(int j=0;j<list.get(i).length;j++){
	for(int k=0;k<22;k++){
	 %>
		<%=list.get(i)[j][k] %>
		
	<%} } }%>
	</table>
</body>
</html>
