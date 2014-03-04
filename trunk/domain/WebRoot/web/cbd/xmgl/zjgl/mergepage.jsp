<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.accessory.dzfj.*"%>
<%@page import="com.klspta.base.util.bean.ftputil.*"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String xmmc = request.getParameter("xmmc");
			String reportID = "XMKGZBBCX";
			String keyIndex = "1";
			String yw_guid = request.getParameter("yw_guid");
			if (xmmc != null) {
				xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
			}
			String filepath = AccessoryOperation.getInstance()
					.getFilePathByywguid(yw_guid);
			String filepath1 = AccessoryOperation.getInstance()
					.getFilePathByywguid1(yw_guid);
			String filepath2 = AccessoryOperation.getInstance()
					.getFilePathByywguid2(yw_guid);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>一览表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<%@ include file="/base/include/ext.jspf"%>
<%@ include file="/base/include/restRequest.jspf"%>
<script src="DatePicker.js"></script>
<style>
.ab {
	border: 0 solid 1px;
	border-top: none;
	border-left: none;
	border-right: none;
	width: 100px;
}
.div1{
	float:left;margin-left:10px;position:relative;left:0px;
}
</style>
<script>
	
</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div>
		<img
			src='<%=basePath%>//model//accessory//dzfj//download//<%=filepath%>'
			width='500px' height='400px' border='0'> <img
			src='<%=basePath%>//model//accessory//dzfj//download//<%=filepath1%>'
			width='500px' height='400px' border='0'>
	</div>

<div><img
				src='<%=basePath%>//model//accessory//dzfj//download//<%=filepath2%>'
				height='400px' width='500px' border='0'></div>
<div class="div1">
	<table>
		
		<tr>
			<td>项目名称：<input type="text" name="txtName" class="ab">项目</td>
		</tr>
		<tr>
			<td>开发主体：<input type="text" name="txtName" class="ab"></td>
		</tr>
		<tr>
			<td>项目区位：东至<input type="text" name="txtName" class="ab">;南至<input
				type="text" name="txtName" class="ab">;</td>
		</tr>
		<tr>
			<td>西至<input type="text" name="txtName" class="ab">;北至<input
				type="text" name="txtName" class="ab">.</td>
		</tr>
		<tr>
			<td>规划情况：占地面积<input type="text" name="txtName" class="ab">公顷;
				建设用地<input type="text" name="txtName" class="ab">公顷;</td>
		</tr>
		<tr>
			<td>建筑规模<input type="text" name="txtName" class="ab">万㎡;
				容积率<input type="text" name="txtName" class="ab">.</td>
		</tr>
		<tr>
			<td>现状情况：住宅拆迁<input type="text" name="txtName" class="ab">户,
				<input type="text" name="txtName" class="ab">万㎡;</td>
		</tr>
		<tr>
			<td>非住宅拆迁<input type="text" name="txtName" class="ab">家,
				<input type="text" name="txtName" class="ab">万㎡;</td>
		</tr>
		<tr>
			<td>相关进展：<input type="text" name="txtName"
				style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px '>
			</td>
		</tr>
	</table>
</div>
</body>
</html>