<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.jtfx.scjc.ScjcManager"%>
<%@page import="java.util.Date"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String list = ScjcManager.getInstcne().getList2();
			String year = Calendar.getInstance().get(Calendar.YEAR)+"";		
			String month = Calendar.getInstance().get(Calendar.MONTH)+1+"";
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
		if(isNaN(yw.value)){
		alert("数字格式错误");
		return ;
		}
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
	
	function init(){
		var year = "<%=year%>";
		var my = document.getElementById(year);
		my.selected = true;
		my.text = year;
		var month = "<%=month%>";
		document.getElementById(month).selected=true;
		
	}
</script>
<body onload="init()">
	<div align="center">
		年度： <select id='year'
			onchange="change2(this.options[this.options.selectedIndex].value)">
			<option id="2010" value=2010>2010</option>
			<option id="2011" value=2011>2011</option>
			<option id="2012" value=2012>2012</option>
			<option id="2013" value=2013>2013</option>
			<option id="2014" value=2014>2014</option>
			<option id="2015" value=2015>2015</option>
			<option id="2016" value=2016>2016</option>
			<option id="2017" value=2017>2017</option>
			<option id="2018" value=2018>2018</option>
			<option id="2019" value=2019>2019</option>
			<option id="2020" value=2020>2020</option>
			<option id="2021" value=2021>2021</option>
			<option id="2022" value=2022>2022</option>
			<option id="2023" value=2023>2023</option>
			<option id="2024" value=2024>2024</option>
			<option id="2025" value=2025>2025</option>
			<option id="2026" value=2026>2026</option>
			<option id="2027" value=2027>2027</option>
			<option id="2028" value=2028>2028</option>
			<option id="2029" value=2029>2029</option>
			<option id="2030" value=2030>2030</option>
		</select> 月份： <select id='month'
			onchange="change2(this.options[this.options.selectedIndex].value)">
			<option id="1" value=1 selected="selected">1</option>
			<option id="2" value=2>2</option>
			<option id="3" value=3>3</option>
			<option id="4" value=4>4</option>
			<option id="5" value=5>5</option>
			<option id="6" value=6>6</option>
			<option id="7" value=7>7</option>
			<option id="8" value=8>8</option>
			<option id="9" value=9>9</option>
			<option id="10" value=10>10</option>
			<option id="11" value=11>11</option>
			<option id="12" value=12>12</option>
		</select>
		<button onClick='insert()'>保存</button>
		<button onClick="javascript:window.location.href='esfEditor.jsp'">返回</button>
		<%=list%>
		<div id="news"></div>
</body>
</html>
