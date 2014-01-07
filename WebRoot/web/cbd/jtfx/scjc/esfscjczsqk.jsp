<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.jtfx.scjc.ScjcManager"%>
<%@page import="java.util.Date"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String list = ScjcManager.getInstcne().getList2();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<base href="<%=basePath%>">
<title>二手房租售情况录入</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/base/include/restRequest.jspf"%>
</head>
<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.tr01 {
	background-color: #C0C0C0;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
</style>
<script type="text/javascript">
	var yw_guid_xh_value = "";
	var today = new Date();//获得当前日期
	var year = today.getFullYear();//获得年份
	var month = today.getMonth() + 1;//此方法获得的月份是从0---11，所以要加1才是当前月份

	function insert() {
		var sj = yw_guid_xh_value;
		var yearObj = document.getElementById("year");
		var year = yearObj.options[yearObj.selectedIndex].text;
		var monthObj = document.getElementById("month");
		var month = monthObj.options[monthObj.selectedIndex].text;
		putClientCommond("scjcManager", "insert");
		putRestParameter("sj", sj);
		putRestParameter("year", year);
		putRestParameter("month", month);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');

		}

	}
	function chang(yw) {
		if (yw_guid_xh_value != null && yw_guid_xh_value != "") {
			yw_guid_xh_value = yw_guid_xh_value + "@" + yw.id + "_" + yw.value
		} else {
			yw_guid_xh_value = yw.id + "_" + yw.value
		}

	}
	function change2(day) {

		var yearObj = document.getElementById("year");
		var year = yearObj.options[yearObj.selectedIndex].text;
		var monthObj = document.getElementById("month");
		var month = monthObj.options[monthObj.selectedIndex].text;
		putClientCommond("scjcManager", "months_mm");
		putRestParameter("year", year);
		putRestParameter("month", month);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');

		}
		deleteDiv();
		document.getElementById("news").innerHTML = reslut;

	}

	function deleteDiv() {
		var my = document.getElementById("zsqktable");
		if (my != null)
			my.parentNode.removeChild(my);
	}
</script>
<body>
	<div align="center">
		年度： <select id='year'
			onchange="change2(this.options[this.options.selectedIndex].value)">
			<option value=2010>2010</option>
			<option value=2011>2011</option>
			<option value=2012>2012</option>
			<option value=2013>2013</option>
			<option value=2014 selected='selected'>2014</option>
			<option value=2015>2015</option>
			<option value=2016>2016</option>
			<option value=2017>2017</option>
			<option value=2018>2018</option>
			<option value=2019>2019</option>
			<option value=2020>2020</option>
		</select> 月份： <select id='month'
			onchange="change2(this.options[this.options.selectedIndex].value)">
			<option value=1 selected="selected">1</option>
			<option value=2>2</option>
			<option value=3>3</option>
			<option value=4>4</option>
			<option value=5>5</option>
			<option value=6>6</option>
			<option value=7>7</option>
			<option value=8>8</option>
			<option value=9>9</option>
			<option value=10>10</option>
			<option value=11>11</option>
			<option value=12>12</option>
		</select>
		<button onClick='insert()'>保存</button>
		<button onClick="javascript:window.location.href='esfscjcxxwh.jsp'">返回</button>
		<%=list%>
		<div id="news"></div>
</body>
</html>
