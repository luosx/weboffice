<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>执法监察线索管理</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/base/include/restRequest.jspf"%>
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
<script type="text/javascript">
	function showTable() {
		if (document.getElementById('table1').checked) {
			document.getElementById('kftl4').style.display = '';
			document.getElementById('kftl3').style.display = '';
			document.getElementById('kftl2').style.display = '';
			document.getElementById('kftl1').style.display = '';
		} else {
			document.getElementById('kftl4').style.display = 'none';
			document.getElementById('kftl3').style.display = 'none';
			document.getElementById('kftl2').style.display = 'none';
			document.getElementById('kftl1').style.display = 'none';
		}
		if (document.getElementById('table2').checked) {
			document.getElementById('azfjs4').style.display = '';
			document.getElementById('azfjs3').style.display = '';
			document.getElementById('azfjs2').style.display = '';
			document.getElementById('azfjs1').style.display = '';
		} else {
			document.getElementById('azfjs4').style.display = 'none';
			document.getElementById('azfjs3').style.display = 'none';
			document.getElementById('azfjs2').style.display = 'none';
			document.getElementById('azfjs1').style.display = 'none';
		}

	}
	function showCross(){
		if (document.getElementById('table5').checked) {
			document.getElementById('leftright').style.display = '';
			document.getElementById('topdown').style.display = '';
		}else{
			document.getElementById('leftright').style.display = 'none';
			document.getElementById('topdown').style.display = 'none';
		}
	}
	
	//页面加载初始化
	function onInit(){
	
		//录入开发体量数据
		putClientCommond("planHandle", "getPlanQuertly");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		var showTable = document.getElementById("planTable");
		var hang = 1;
		var lie = 3;
		showTable.rows[hang].cells[lie].innerHTML = "innertHTML";
		var k = 0;
		for(var i = 2012; i < 2021; i++){
			hang = 1;
			for(var j = 1; j <= 4; j++){
				if(k < baseInformation.length && i == baseInformation[k].年度 && j == baseInformation[k].季度){
					showTable.rows[hang++].cells[lie].innerHTML = baseInformation[k].征收户数;
					showTable.rows[hang++].cells[lie].innerHTML = baseInformation[k].完成开发地量;
					showTable.rows[hang++].cells[lie].innerHTML = baseInformation[k].完成开发规模;
					showTable.rows[hang++].cells[lie].innerHTML = baseInformation[k].储备红线投资;
					k++;
				}
				lie++;
				//当表中年龄和字段年龄完全不对应时对应
				var boolean = true;
				while(boolean){
					if(k < baseInformation.length && parseInt(i) > parseInt(baseInformation[k].年度)){
						k++;
					}else{
						boolean = false;
					}
				}
			}
		}
	
	
	}
	
</script>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" onLoad="onInit(); return false;">
	<p>
		显示内容： <input type="checkbox" name="content" id="table1" checked='true'
			onclick="showTable()">开发体量 <input type="checkbox"
			name="content" id="table2" checked='true' onClick="showTable()">安置房建设
		<input type="checkbox" name="content" id="table3" checked='true'
			onclick="showTable()">供地体量 <input type="checkbox"
			name="content" id="table4" checked='true' onClick="showTable()">投融资情况
			 <input type="checkbox"
			name="content" id="table5" checked='true' onClick="showCross()">十字标尺
	</p>
	<table id='planTable' border=1
		style="text-align: center; font: normal 13px verdana;" width='130%'>
		<tr
			style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
			<td colspan=2>序号</td>
			<td>时序（年）</td>
			<td colspan=4>2012年度<br>1&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;4</td>
			<td colspan=4>2013年度</td>
			<td colspan=4>2014年度</td>
			<td colspan=4>2015年度</td>
			<td colspan=4>2016年度</td>
			<td colspan=4>2017年度</td>
			<td colspan=4>2018年度</td>
			<td colspan=4>2019年度</td>
			<td colspan=4>2020年度</td>
			<td>合计</td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl1'>
			<td rowspan=4>开<br>发<br>体<br>量</td>
			<td>1</td>
			<td>征收户数</td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=30></td>
			<td width=50></td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl2'>
			<td>2</td>
			<td>完成开发地量<br>（公顷）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl3'>
			<td>3</td>
			<td>完成开发规模<br>（万㎡）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl4'>
			<td>4</td>
			<td>储备红线投资<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<!-- 开发体量循环 -->
		<tr id='kf1'>
			<td rowspan=8>1</td>
			<td>户数</td>
			<td rowspan=8 style='background: #FFCC00;'>首经贸</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf2'>
			<td>地量</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'>1/100%</td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf3'>
			<td>规模</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'>2/100%</td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf4'>
			<td>投资</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'>3/27%</td>
			<td style='background: #FFCC00;'>2/14%</td>
			<td style='background: #FFCC00;'>1/11%</td>
			<td style='background: #FFCC00;'>0/3%</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'>7</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf5'>
			<td>住</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf6'>
			<td>企</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'>3/50%</td>
			<td style='background: #FFCC00;'>2/25%</td>
			<td style='background: #FFCC00;'>1/20%</td>
			<td style='background: #FFCC00;'>0/5%</td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf7'>
			<td>楼面</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td colspan=4 style='background: #FFCC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf8'>
			<td>成交</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td colspan=4 style='background: #FFCC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #FFCC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<!-- 开发体量循环结束 -->
		<!-- 开发体量循环 -->
		<tr id='kf1'>
			<td rowspan=8>1</td>
			<td>户数</td>
			<td rowspan=8 style='background: #C0C0C0;'>联大</td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>

		</tr>
		<tr id='kf2'>
			<td>地量</td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'>1/100%</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf3'>
			<td>规模</td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'>2/100%</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf4'>
			<td>投资</td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'>3/27%</td>
			<td style='background: #99CC00;'>2/14%</td>
			<td style='background: #99CC00;'>1/11%</td>
			<td style='background: #99CC00;'>0/3%</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'>7</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf5'>
			<td>住</td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf6'>
			<td>企</td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'>3/50%</td>
			<td style='background: #99CC00;'>2/25%</td>
			<td style='background: #99CC00;'>1/20%</td>
			<td style='background: #99CC00;'>0/5%</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf7'>
			<td>楼面</td>
			<td></td>
			<td></td>
			<td></td>
			<td colspan=4 style='background: #99CC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr id='kf8'>
			<td>成交</td>
			<td></td>
			<td></td>
			<td></td>
			<td colspan=4 style='background: #99CC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style='background: #99CC00;'>2.00</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<!-- 开发体量循环结束 -->
		<tr style='background: #CCFFFF;' id='azfjs1'>
			<td rowspan=4>安<br>置<br>房<br>建<br>设</td>
			<td>5</td>
			<td>开工及购房量<br>（万㎡）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #CCFFFF;' id='azfjs2'>
			<td>6</td>
			<td>投资<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #CCFFFF;' id='azfjs3'>
			<td>7</td>
			<td>使用量<br>（万㎡）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #CCFFFF;' id='azfjs4'>
			<td>8</td>
			<td>安置房存量<br>（万㎡）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>







		<tr style='background: #99CC00;'>
			<td rowspan=4>供<br>地<br>体<br>量</td>
			<td>9</td>
			<td>供应土地<br>（公顷）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #99CC00;'>
			<td>10</td>
			<td>供应规模<br>（万㎡）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #99CC00;'>
			<td>11</td>
			<td>储备库库存<br>（万㎡）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #99CC00;'>
			<td>12</td>
			<td>储备库融资能力<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>

		<tr style='background: #FFCC99;'>
			<td rowspan=10>投<br>融<br>资<br>情<br>况</td>
			<td>13</td>
			<td>政府土地收益<br> （亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>14</td>
			<td>本期回笼成本<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>15</td>
			<td>政府土地收益<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>16</td>
			<td>本期融资需求<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>17</td>
			<td>本期还款需求<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>18</td>
			<td>权益性资金注入<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>19</td>
			<td>负债余额<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>20</td>
			<td>储备库融资缺口<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>21</td>
			<td>资金风险<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style='background: #FFCC99;'>
			<td>22</td>
			<td>本期账面余额<br>（亿元）</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>

	</table>
	<div id="leftright" style="width:expression(document.body.clientWidth)"></div>
<div id="topdown" style="height:expression(document.body.clientHeight)"></div>
</body>
</html>
<script>
if (document.all&&!window.print){
	leftright.style.width=document.body.clientWidth-6
	topdown.style.height=document.body.clientHeight-1
	}
	else if (document.layers){
	document.leftright.clip.width=window.innerWidth
	document.leftright.clip.height=5
	document.topdown.clip.width=5
	document.topdown.clip.height=window.innerHeight
	}
	function followmouse1(){
	//move cross engine for IE 4+
	leftright.style.pixelTop=document.body.scrollTop+event.clientY+1
	topdown.style.pixelTop=document.body.scrollTop
	if (event.clientX<document.body.clientWidth-2)
	topdown.style.pixelLeft=document.body.scrollLeft+event.clientX+1
	else
	topdown.style.pixelLeft=document.body.clientWidth-2
	}
	function followmouse2(e){
	//move cross engine for NS 4+
	document.leftright.top=e.y+6
	document.topdown.top=pageYOffset
	document.topdown.left=e.x+6
	}
	if (document.all)
	document.onmousemove=followmouse1
	else if (document.layers){
	window.captureEvents(Event.MOUSEMOVE)
	window.onmousemove=followmouse2
	}
	function regenerate(){
	window.location.reload()
	}
	function regenerate2(){
	setTimeout("window.onresize=regenerate",400)
	}
	if ((document.all&&!window.print)||document.layers)
	//if the user is using IE 4 or NS 4, both NOT IE 5+
	window.onload=regenerate2

</script>