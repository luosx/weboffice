<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>配置计算公式</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="/base/form/css/commonForm.css" type="text/css" />
	<%@ include file="/base/include/newformbase.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	
  	</head>
	<style type="text/css">
		.name{
			width:150;
		}
		.value{
			width:400px;
			height:70px;
		}
		.valuearea{
			width:390px;
			height:68px;
		}
		h1{
			font-size:24px;
			font:"宋体";
			font-weight:bold;
		}
		table{
			border-left-color:#000000;
			border-left-style:solid;
			border-left-width:1px;
			border-top-color:#000000;
			border-top-style:solid;
			border-top-width:1px;
			background-color:#FFFFFF;
			}
		td{
			border-bottom-color:#000000;
			border-bottom-style:solid;
			border-bottom-width:1px;
			border-right-color:#000000;
			border-right-style:solid;
			border-right-width:1px;
			}
		input{
			background-color:#FFFFFF;
			border:none;
			}
		textarea{
			background-color:#FFFFFF;
			border:none;
			overflow:hidden;
			}
	</style>
   <script>
    var flusdown;
  	function save(){
		document.forms[0].submit();
	}
	
	//增加计算公式
	function addformula(){
		var number = document.getElementById("num");
		var num = String(parseInt(number.value) + 1);
		number.value = num;
		var newContent = new Array();
		newContent.push("<div><input type=\"checkbox\" id=\"check" + num + "\" /> </div>");
		newContent.push("<input type=\"text\" id='fulaname_" + num +"' name=\"fulaname_" + num + "\" />");
		newContent.push("<textarea id=\"fulavalue_" + num + "\"name=\"fulavalue_" + num +"\" style=\"width:100%; height:100%\" onKeyUp=\"wirteDown(this)\" onMouseUp=\"wirteDown(this)\"></textarea>");
		
		//添加一个新行
		var addtable = document.getElementById("configtable");
		var newRow = addtable.insertRow(1 + parseInt(num));
		for(var i = 0; i < newContent.length; i++){
			var newCell = newRow.insertCell(i);
			newCell.innerHTML = newContent[i];
			if(i == 1){
				newCell.className = "name";
			}else if(i == 2){
				newCell.className = "value";
			}
		}
	}
	
	//删除计算公式
	function delformula(){
		var number = document.getElementById("num");
		var name = new Array("check", "fulaname_" , "fulavalue_");
		var num = number.value;
		var deletable = document.getElementById("configtable");
		for(var i = 1; i <= num; i++){
			var isdelete = document.getElementById("check" + String(i));
			if(isdelete.checked){
				for(var j = i; j < num; j++){
					replace(j+1, j, name);
				}
				deletable.deleteRow(parseInt(num)+ 1);
				num--;
				i--;
				number.value = num;
			}
		}
	}
	
	//表单内容替换
	function replace(newnum, oldnum, name){
		var oldfieldcheck = document.getElementById(name[0] + String(oldnum));
		var newfieldcheck = document.getElementById(name[0] + String(newnum));
		oldfieldcheck.checked = newfieldcheck.checked;
		for(var i = 1; i < name.length; i++){
			var fieldname = name[i];
			var oldfieldname = document.getElementById(fieldname + oldnum);
			var newfieldname = document.getElementById(fieldname + newnum);
			oldfieldname.value = newfieldname.value;
		}
	}
	
	//表单初始化
	function onInit(){
		init();
		var reg = /FULANAME_\w?/;
		var number = document.getElementById("num");
		var num = parseInt(number.value);
		for(var i in json){
			if(reg.test(i)){
				if(num == 1){
					num++;
				}else{
					num++;
					addformula();
				}
			}
		}
		insertData(json);
		
		//添加可用字段
		var variable = document.getElementById("variable");
		putClientCommond("property","getAllAlias");
		myData = restRequest();
		var content = "";
		for(var i = 0; i < myData.length; i++){
			content = content + "&nbsp;<input type=\"button\" id=\""+ myData[i].BIEMING +"\"  value=\""+ myData[i].ZIDUANMING+"\"  onClick=\"addflus(this)\" style=\"margin-bottom:5px; margin-top:5px\"/>";
		}
		variable.innerHTML = content;
		
	}
	//记录光标所在Dom
	function wirteDown(check){
		flusdown = check;
	}
	//添加字段
	function addflus(check){
		if(flusdown != undefined){
			flusdown.value = flusdown.value + check.id;
		}
	}
  </script>
  <body onLoad="onInit()">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<div align="center">
		<h1>计算公式配置</h1>
	</div>
  	<form method="post">
	<div>
  	<table align="center" cellpadding="0" cellspacing="0" style="margin-top:30px" id="configtable">
		<tr align="center" bgcolor="#E6F0FD">
		  <td colspan="3">
				<div style="font-size:18px; margin-top:5px">计算公式配置</div>
				<div align="right" style="margin-bottom:5px">
					<input align="right" type="button" id="add" value="增加" onClick="addformula();" />
					<input type="text" value="1" id="num" name="num" style="display:none" />
			    	<input name="button" type="button" id="dle" onClick="delformula();" value="删除" align="right" style="margin-right:5px"/>
				</div>	
			</td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<div>公式名称</div>			</td>
			<td>
				<div>公式算法</div>			</td>
		</tr>
		<tr>
			<td>
				<div>
					<input type="checkbox" id="check1" />
				</div>			</td>
			<td class="name">
				<input type="text" id="fulaname_1" name="fulaname_1" />		
			</td>
			<td class="value">
				<!-- <input type="text" id="fulavalue_1" name="fulavalue_1" style="width:100%"/> -->
				<textarea id="fulavalue_1" name="fulavalue_1" style="width:100%; height:100%" onKeyUp="wirteDown(this)" onMouseUp="wirteDown(this)" ></textarea>		
			</td>
		</tr>
		<tr>
			<td colspan="3" id="variable" style="margin-bottom:10px; margin-top:10px">
				<input type="button" value="占地"  onClick="addflus(this)"/>
			</td>
		</tr>
	</table>
	</div>
	
	</form>
  </body>
</html>
