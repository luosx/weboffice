<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>开发体量登记表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/newformbase.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
  <style type="text/css">
		table{
			border-left-color:#000000;
			border-left-style:solid;
			border-left-width:1px;
			border-top-color:#000000;
			border-top-style:solid;
			border-top-width:1px;
			background-color:#FFFFFF;
			font-family:"宋体";
			font-size:16px;
			}
		td{
			border-bottom-color:#000000;
			border-bottom-style:solid;
			border-bottom-width:1px;
			border-right-color:#000000;
			border-right-style:solid;
			border-right-width:1px;
			margin-bottom:5px;
			margin-top:5px;
			}
		select{
			background:#FFFFFF;
			border:none;
			}
		input{
			background:#FFFFFF;
			border:none;
			}
  </style>
	<script type="text/javascript">
		//获取所有项目的基础数据
		putClientCommond("jcsjHandler", "getjcsjList");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		function init(){
			var xmmc = document.getElementById("xmmc");
			xmmc.options.innerText = "";
			for(var i = 0; i < baseInformation.length; i++){
				var value = baseInformation[i].XMNAME;
				Addopt(xmmc, value);
			}
		}
		
		function Addopt(wflx, value){
			var opt = document.createElement('option');
			opt.text = value;
			opt.value = value;
			wflx.options.add(opt);
		}
		
		//选择项目过后，添加已经登记的基本信息
		function selectProject(){
			
			
		
		}
		
	</script>
  <body onLoad="init()">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
	 <div align="center">
		<h1>开发体量数据录入</h1>
	</div>
    <form method="post">
		<table align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2" align="center">
					<label>项目名称</label>
				</td>
				<td colspan="3">
					<select id='xmmc' name='xmmc'>
						<option> 联大 </option>
						<option> 国华一期 </option>
					</select>
				</td>
			</tr>
			<tr>
				<td  style="width:120px;" align="center">
					<label>年度</label>
				</td>
				<td style="width: 100px;" align="center">
					<label>季节</label>
				</td>
				<td style="width:120px;" align="center">
					<label>类型</label>
				</td>
				<td style="width:120px" align="center">
					<label>数值</label>
				</td>
				<td style="width:120px" align="center">
					<label>百分比</label>
				</td>
				
			</tr>
			<tr>
				<td align="center">
					<select id="nd" style="width:80px">
						<option value="2012">2012</option>
						<option value="2013">2013</option>
					</select>
				</td>
				<td align="center">
					<select id="jd" style=" width:80px">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
					</select>
				</td>
				<td align="center">
					<select id="lx" style="width:100px">
						<option value="户数">户数</option>
						<option value="地量">地量</option>
						<option value="规模">规模</option>
						<option value="投资">投资</option>
						<option value="住">住</option>
						<option value="企">企</option>
					</select>
				</td>
				<td align="center">
					<input type="text" id="wcl" style="width:100px" >
				</td>
				<td align="center">
					<input type="text" id="wcbfb" style="width:100px" >
				</td>
			</tr>
		</table>
	</form>
  </body>
</html>
