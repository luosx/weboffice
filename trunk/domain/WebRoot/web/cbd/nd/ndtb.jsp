<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.nd.AnnualTB" %>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
  //获取实例
     AnnualTB annual= AnnualTB.getAnnualTB();
      //开发体量
    String [][] kftlTable= annual.getKFTL();
    String [][]kftlTable1= annual.getKFTL_D();
     //安置房
    String [][] anfjsTable=annual.getAZFJS();
    //供地体量
    String [][] gdtlTable=annual.getGDTL();
    String [][] gdtlTable1=annual.getGDTL_D();
   //投融资情况
    String [][] trzqkTable=  annual.getTRZQK();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>执法监察线索管理</title>
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
<script type="text/javascript">
	function showTable() {
		if (document.getElementById('table1').checked) {
			document.getElementById('kftl3').style.display = '';
			document.getElementById('kftl2').style.display = '';
			document.getElementById('kftl1').style.display = '';
		} else {
			document.getElementById('kftl3').style.display = 'none';
			document.getElementById('kftl2').style.display = 'none';
			document.getElementById('kftl1').style.display = 'none';
		}
		if (document.getElementById('table2').checked) {
			document.getElementById('azfjs2').style.display = '';
			document.getElementById('azfjs1').style.display = '';
		} else {
			document.getElementById('azfjs2').style.display = 'none';
			document.getElementById('azfjs1').style.display = 'none';
		}
		if (document.getElementById('table3').checked) {
			document.getElementById('gdtl1').style.display = '';
			document.getElementById('gdtl2').style.display = '';
			document.getElementById('gdtl3').style.display = '';
		} else {
			document.getElementById('gdtl1').style.display = 'none';
			document.getElementById('gdtl2').style.display = 'none';
			document.getElementById('gdtl3').style.display = 'none';
		}
		if (document.getElementById('table4').checked) {
			document.getElementById('trzqk1').style.display = '';
			document.getElementById('trzqk2').style.display = '';
			document.getElementById('trzqk3').style.display = '';
			document.getElementById('trzqk4').style.display = '';
			document.getElementById('trzqk5').style.display = '';
			document.getElementById('trzqk6').style.display = '';
			document.getElementById('trzqk7').style.display = '';
			document.getElementById('trzqk8').style.display = '';
		} else {
			document.getElementById('trzqk1').style.display = 'none';
			document.getElementById('trzqk2').style.display = 'none';
			document.getElementById('trzqk3').style.display = 'none';
			document.getElementById('trzqk4').style.display = 'none';
			document.getElementById('trzqk5').style.display = 'none';
			document.getElementById('trzqk6').style.display = 'none';
			document.getElementById('trzqk7').style.display = 'none';
			document.getElementById('trzqk8').style.display = 'none';
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
	
</script>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
<h2 align="center">北京商务中心区土地储备规划——年度实施计划动态决策</h2>
		<p>
	显示内容： <input type="checkbox" name="content" id="table1" checked='true'  onclick="showTable()">开发体量
		       <input type="checkbox" name="content" id="table2" checked='true' onclick="showTable()">安置房建设
		       <input type="checkbox" name="content" id="table3" checked='true' onclick="showTable()">供地体量
		        <input type="checkbox" name="content" id="table4" checked='true' onclick="showTable()">投融资情况
			   <input type="checkbox" name="content" id="table5" checked='false' onclick="showCross()">十字标尺
	</p>
	<table id='planTable' border=1
		style="text-align: center; font: normal 13px verdana;" width='100%'>
		<tr
			style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
			<td colspan=2 width="10%">序号</td>
			<td width="10%">时序（年）</td>
			<td >2012年度</td>
			<td >2013年度</td>
			<td >2014年度</td>
			<td >2015年度</td>
			<td >2016年度</td>
			<td >2017年度</td>
			<td >2018年度</td>
			<td >2019年度</td>
			<td >2020年度</td>
			<td>合计</td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl1'>
			<td rowspan=3>开<br>发<br>体<br>量</td>
			<td>1</td>
			<td>征收户数<br>&nbsp;   </td>
		<td width=30><%=kftlTable[0][0] %></td>
			<td width=30><%=kftlTable[0][1] %></td>
			<td width=30><%=kftlTable[0][2] %></td>
			<td width=30><%=kftlTable[0][3] %></td>
			<td width=30><%=kftlTable[0][4] %></td>
			<td width=30><%=kftlTable[0][5] %></td>
			<td width=30><%=kftlTable[0][6] %></td>
			<td width=30><%=kftlTable[0][7] %></td>
			<td width=30><%=kftlTable[0][8] %></td>
			<td width=30><%=kftlTable[0][9] %></td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl2'>
			<td>2</td>
			<td>完成开发规模<br>（万㎡）</td>
			<td><%=kftlTable[1][0] %></td>
			<td><%=kftlTable[1][1] %></td>
			<td><%=kftlTable[1][2] %></td>
			<td><%=kftlTable[1][3] %></td>
			<td><%=kftlTable[1][4] %></td>
			<td><%=kftlTable[1][5] %></td>
			<td><%=kftlTable[1][6] %></td>
			<td><%=kftlTable[1][7] %></td>
			<td><%=kftlTable[1][8] %></td>
			<td><%=kftlTable[1][9] %></td>
		</tr>
		<tr style='background: #FFFF99;' id='kftl3'>
			<td>3</td>
			<td>储备红线投资<br>（亿元）</td>
			<td><%=kftlTable[2][0] %></td>
			<td><%=kftlTable[2][1] %></td>
			<td><%=kftlTable[2][2] %></td>
			<td><%=kftlTable[2][3] %></td>
			<td><%=kftlTable[2][4] %></td>
			<td><%=kftlTable[2][5] %></td>
			<td><%=kftlTable[2][6] %></td>
			<td><%=kftlTable[2][7] %></td>
			<td><%=kftlTable[2][8] %></td>
			<td><%=kftlTable[2][9] %></td>
		</tr>
		
		<%if(kftlTable1.length>0){ %>
		<tr>
		<td >1</td>
		<td rowspan=<%=kftlTable1.length%>>项<br>目<br>年<br>度<br>投<br>资<br>规<br>模</td>
			<td><%=kftlTable1[0][0] %></td>
			<td><%=kftlTable1[0][1] %></td>
			<td><%=kftlTable1[0][2] %></td>
			<td><%=kftlTable1[0][3] %></td>
			<td><%=kftlTable1[0][4] %></td>
			<td><%=kftlTable1[0][5] %></td>
			<td><%=kftlTable1[0][6] %></td>
			<td><%=kftlTable1[0][7] %></td>
			<td><%=kftlTable1[0][8] %></td>
			<td><%=kftlTable1[0][9] %></td>
			<td><%=kftlTable1[0][10] %></td>
		</tr>
		<!-- 开发体量循环 -->
		<% for(int i=1;i<kftlTable1.length;i++){%>
		<tr id='kf1'>
		    <td ><%=i+1%></td>
			<td ><%=kftlTable1[i][0] %></td>
			<td><%=kftlTable1[i][1] %></td>
			<td><%=kftlTable1[i][2] %></td>
			<td><%=kftlTable1[i][3] %></td>
			<td><%=kftlTable1[i][4] %></td>
			<td><%=kftlTable1[i][5] %></td>
			<td><%=kftlTable1[i][6] %></td>
			<td><%=kftlTable1[i][7] %></td>
			<td><%=kftlTable1[i][8] %></td>
			<td><%=kftlTable1[i][9] %></td>
			<td><%=kftlTable1[i][10] %></td>
		</tr>
		<%}} %>
	<!-- 安置房 -->
	<tr style='background:#CCFFFF;' id='azfjs1'>
			<td rowspan=2>安<br>置<br>房</td>
			<td>5</td>
			<td>开工量<br>（万㎡）   </td>
			<td width=30><%=anfjsTable[0][0] %></td>
			<td width=30><%=anfjsTable[0][1] %></td>
			<td width=30><%=anfjsTable[0][2] %></td>
			<td width=30><%=anfjsTable[0][3] %></td>
			<td width=30><%=anfjsTable[0][4] %></td>
			<td width=30><%=anfjsTable[0][5] %></td>
			<td width=30><%=anfjsTable[0][6] %></td>
			<td width=30><%=anfjsTable[0][7] %></td>
			<td width=30><%=anfjsTable[0][8] %></td>
			<td width=30><%=anfjsTable[0][9] %></td>
		</tr>
		<tr style='background:#CCFFFF' id='azfjs2'>
			<td>6</td>
			<td>投资<br>（亿元）</td>
			<td><%=anfjsTable[1][0] %></td>
			<td><%=anfjsTable[1][1] %></td>
			<td><%=anfjsTable[1][2] %></td>
			<td><%=anfjsTable[1][3] %></td>
			<td><%=anfjsTable[1][4] %></td>
			<td><%=anfjsTable[1][5] %></td>
			<td><%=anfjsTable[1][6] %></td>
			<td><%=anfjsTable[1][7] %></td>
			<td><%=anfjsTable[1][8] %></td>
			<td><%=anfjsTable[1][9] %></td>
		</tr>
		<!-- 供地体量 -->
		<tr style='background:#99CC00;' id='gdtl1'>
			<td rowspan=3>供<br>地<br>体<br>量</td>
			<td>9</td>
			<td>供应土地<br>（公顷） </td>
			<td width=30><%=gdtlTable[0][0] %></td>
			<td width=30><%=gdtlTable[0][1] %></td>
			<td width=30><%=gdtlTable[0][2] %></td>
			<td width=30><%=gdtlTable[0][3] %></td>
			<td width=30><%=gdtlTable[0][4] %></td>
			<td width=30><%=gdtlTable[0][5] %></td>
			<td width=30><%=gdtlTable[0][6] %></td>
			<td width=30><%=gdtlTable[0][7] %></td>
			<td width=30><%=gdtlTable[0][8] %></td>
			<td width=30><%=gdtlTable[0][9] %></td>
		</tr>
		<tr style='background:#99CC00' id='gdtl2'>
			<td>10</td>
			<td>供应规模<br>（万㎡）</td>
			<td><%=gdtlTable[1][0] %></td>
			<td><%=gdtlTable[1][1] %></td>
			<td><%=gdtlTable[1][2] %></td>
			<td><%=gdtlTable[1][3] %></td>
			<td><%=gdtlTable[1][4] %></td>
			<td><%=gdtlTable[1][5] %></td>
			<td><%=gdtlTable[1][6] %></td>
			<td><%=gdtlTable[1][7] %></td>
			<td><%=gdtlTable[1][8] %></td>
			<td><%=gdtlTable[1][9] %></td>
		</tr>
		<tr style='background: #99CC00' id='gdtl3'>
			<td>11</td>
			<td>储备库库存<br>（万㎡）</td>
			<td><%=gdtlTable[2][0] %></td>
			<td><%=gdtlTable[2][1] %></td>
			<td><%=gdtlTable[2][2] %></td>
			<td><%=gdtlTable[2][3] %></td>
			<td><%=gdtlTable[2][4] %></td>
			<td><%=gdtlTable[2][5] %></td>
			<td><%=gdtlTable[2][6] %></td>
			<td><%=gdtlTable[2][7] %></td>
			<td><%=gdtlTable[2][8] %></td>
			<td><%=gdtlTable[2][9] %></td>
		</tr>
<!-- 项目年度供应规模 -->
	<%if(gdtlTable1.length>0){ %>
 	<tr>
		<td >1</td>
		<td rowspan=<%=gdtlTable1.length%>>项<br>目<br>年<br>度<br>供<br>应<br>规<br>模</td>
			<td><%=gdtlTable1[0][0] %></td>
			<td><%=gdtlTable1[0][1] %></td>
			<td><%=gdtlTable1[0][2] %></td>
			<td><%=gdtlTable1[0][3] %></td>
			<td><%=gdtlTable1[0][4] %></td>
			<td><%=gdtlTable1[0][5] %></td>
			<td><%=gdtlTable1[0][6] %></td>
			<td><%=gdtlTable1[0][7] %></td>
			<td><%=gdtlTable1[0][8] %></td>
			<td><%=gdtlTable1[0][9] %></td>
			<td><%=gdtlTable1[0][10] %></td>
		</tr>
		<!-- 开发体量循环 -->
		<%for(int i=1;i<gdtlTable1.length;i++){%>
		<tr id='kf1'>
		<td ><%=i+1%></td>
			<td><%=gdtlTable1[i][0] %></td>
			<td><%=gdtlTable1[i][1] %></td>
			<td><%=gdtlTable1[i][2] %></td>
			<td><%=gdtlTable1[i][3] %></td>
			<td><%=gdtlTable1[i][4] %></td>
			<td><%=gdtlTable1[i][5] %></td>
			<td><%=gdtlTable1[i][6] %></td>
			<td><%=gdtlTable1[i][7] %></td>
			<td><%=gdtlTable1[i][8] %></td>
			<td><%=gdtlTable1[i][9] %></td>
			<td><%=gdtlTable1[i][10] %></td>
		</tr>
		<%} }%>
		<!-- 投融资情况 -->
		<tr style='background:#FFCC99;' id='trzqk1'>
			<td rowspan=8>投<br>融<br>资<br>情<br>况</td>
			<td>13</td>
			<td>年度投资需求<br>（亿元） </td>
			<td width=30><%=trzqkTable[0][0] %></td>
			<td width=30><%=trzqkTable[0][1] %></td>
			<td width=30><%=trzqkTable[0][2] %></td>
			<td width=30><%=trzqkTable[0][3] %></td>
			<td width=30><%=trzqkTable[0][4] %></td>
			<td width=30><%=trzqkTable[0][5] %></td>
			<td width=30><%=trzqkTable[0][6] %></td>
			<td width=30><%=trzqkTable[0][7] %></td>
			<td width=30><%=trzqkTable[0][8] %></td>
			<td width=30><%=trzqkTable[0][9] %></td>
		</tr>
		<tr style='background:#FFCC99' id='trzqk2'>
			<td>14</td>
			<td>年度回笼成本<br>（亿元）</td>
			<td><%=trzqkTable[1][0] %></td>
			<td><%=trzqkTable[1][1] %></td>
			<td><%=trzqkTable[1][2] %></td>
			<td><%=trzqkTable[1][3] %></td>
			<td><%=trzqkTable[1][4] %></td>
			<td><%=trzqkTable[1][5] %></td>
			<td><%=trzqkTable[1][6] %></td>
			<td><%=trzqkTable[1][7] %></td>
			<td><%=trzqkTable[1][8] %></td>
			<td><%=trzqkTable[1][9] %></td>
		</tr>
		<tr style='background:#FFCC99' id='trzqk3'>
			<td>15</td>
			<td>政府土地收益<br>（亿元）</td>
			<td><%=trzqkTable[2][0] %></td>
			<td><%=trzqkTable[2][1] %></td>
			<td><%=trzqkTable[2][2] %></td>
			<td><%=trzqkTable[2][3] %></td>
			<td><%=trzqkTable[2][4] %></td>
			<td><%=trzqkTable[2][5] %></td>
			<td><%=trzqkTable[2][6] %></td>
			<td><%=trzqkTable[2][7] %></td>
			<td><%=trzqkTable[2][8] %></td>
			<td><%=trzqkTable[2][9] %></td>
		</tr>
		<tr style='background:#FFCC99' id='trzqk4'>
			<td>16</td>
			<td>年度融资需求<br>（亿元）</td>
			<td><%=trzqkTable[3][0] %></td>
			<td><%=trzqkTable[3][1] %></td>
			<td><%=trzqkTable[3][2] %></td>
			<td><%=trzqkTable[3][3] %></td>
			<td><%=trzqkTable[3][4] %></td>
			<td><%=trzqkTable[3][5] %></td>
			<td><%=trzqkTable[3][6] %></td>
			<td><%=trzqkTable[3][7] %></td>
			<td><%=trzqkTable[3][8] %></td>
			<td><%=trzqkTable[3][9] %></td>
		</tr>
		<tr style='background:#FFCC99' id='trzqk5'>
			<td>17</td>
			<td>年度还款需求<br>（亿元）</td>
			<td><%=trzqkTable[4][0] %></td>
			<td><%=trzqkTable[4][1] %></td>
			<td><%=trzqkTable[4][2] %></td>
			<td><%=trzqkTable[4][3] %></td>
			<td><%=trzqkTable[4][4] %></td>
			<td><%=trzqkTable[4][5] %></td>
			<td><%=trzqkTable[4][6] %></td>
			<td><%=trzqkTable[4][7] %></td>
			<td><%=trzqkTable[4][8] %></td>
			<td><%=trzqkTable[4][9] %></td>
		</tr>
		<tr style='background:#FFCC99' id='trzqk6'>
			<td>18</td>
			<td>权益性资金注入<br>（亿元）</td>
			<td><%=trzqkTable[5][0] %></td>
			<td><%=trzqkTable[5][1] %></td>
			<td><%=trzqkTable[5][2] %></td>
			<td><%=trzqkTable[5][3] %></td>
			<td><%=trzqkTable[5][4] %></td>
			<td><%=trzqkTable[5][5] %></td>
			<td><%=trzqkTable[5][6] %></td>
			<td><%=trzqkTable[5][7] %></td>
			<td><%=trzqkTable[5][8] %></td>
			<td><%=trzqkTable[5][9] %></td>
		</tr>
		<tr style='background:#FFCC99' id='trzqk7'>
			<td>19</td>
			<td>负债余额<br>（亿元）</td>
			<td><%=trzqkTable[6][0] %></td>
			<td><%=trzqkTable[6][1] %></td>
			<td><%=trzqkTable[6][2] %></td>
			<td><%=trzqkTable[6][3] %></td>
			<td><%=trzqkTable[6][4] %></td>
			<td><%=trzqkTable[6][5] %></td>
			<td><%=trzqkTable[6][6] %></td>
			<td><%=trzqkTable[6][7] %></td>
			<td><%=trzqkTable[6][8] %></td>
			<td><%=trzqkTable[6][9] %></td>
		</tr>
		<tr style='background:#FFCC99;' id='trzqk8'>
			<td>20</td>
			<td>年度账面余额<br>（亿元）</td>
			<td><%=trzqkTable[7][0] %></td>
			<td><%=trzqkTable[7][1] %></td>
			<td><%=trzqkTable[7][2] %></td>
			<td><%=trzqkTable[7][3] %></td>
			<td><%=trzqkTable[7][4] %></td>
			<td><%=trzqkTable[7][5] %></td>
			<td><%=trzqkTable[7][6] %></td>
			<td><%=trzqkTable[7][7] %></td>
			<td><%=trzqkTable[7][8] %></td>
			<td><%=trzqkTable[7][9] %></td>
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