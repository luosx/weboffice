<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String type=request.getParameter("type");
String title="增加人数窗口";
if("delete".equals(type)){
	title="删除人数窗口";
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=title%></title>
</head>
<style type="text/css">
body{
	font-size: 14px;
	text-align: center;
	vertical-align: middle;
}
table{
	margin-top: 50px;
}
input{
	border:1px solid #ccc;
	width:100px;
}
select{
	width:80px;
}

</style>
<%if(!"delete".equals(type)){ %>
<body>
<center>
<form name="wl" >
<table cellpadding="0" cellspacing="0" border="0">
<tr>
	<td>
		姓名:
	</td>
	<td>
		<input type="text" name="name" id="name" >&nbsp;&nbsp;&nbsp;
	</td>
	<td>
		性别:
	</td>
	<td>
		<select name="gender" id="gender">
			<option value="男">男</option>
			<option value="女">女</option>
		</select>
	</td>
</tr>
<tr><td colspan="4">&nbsp;</td></tr>
<tr>
	<td>
		职务:
	</td>
	<td>
		<input type="text" name="position" id="position">&nbsp;&nbsp;&nbsp;
	</td>
	<td>
		级别:
	</td>
	<td>
		<select name="level" id="level">
			<option value="厅级">厅级</option>
			<option value="处级">处级</option>
			<option value="科级">科级</option>
			<option value="科以下">科以下</option>
			<option value="其他">其他</option>
		</select>
	</td>
</tr>
<tr><td colspan="4">&nbsp;</td></tr>
<tr>
<td colspan="2"><input type="button" value="确定" onclick="returnValues()" style="width:60px;"></td>
<td colspan="2"><input type="reset" value="重置"  style="width:60px;"></td>
</tr>
</table>
</form>
</center>
</body>
<%}else{ %>
<body onload="initData()">
<center>
<form name="wl" >
<table cellpadding="0" cellspacing="0" border="0">
<tr>
	<td>
		姓名:
	</td>
	<td>
		<select name="name" id="name">
		</select>&nbsp;&nbsp;&nbsp;
	</td>
	<td>
		性别:
	</td>
	<td>
		<select name="gender" id="gender">
		</select>
	</td>
</tr>
<tr><td colspan="4">&nbsp;</td></tr>
<tr>
	<td>
		职务:
	</td>
	<td>
		<select name="position" id="position">
		</select>&nbsp;&nbsp;&nbsp;
	</td>
	<td>
		级别:
	</td>
	<td>
		<select name="level" id="level">
		</select>
	</td>
</tr>
<tr>
<td colspan="4">&nbsp;</td>
</tr>
<tr>
<td colspan="2"><input type="button" value="确定" onclick="returnValues()" style="width:60px;"></td>
<td colspan="2"><input type="reset" value="重置"  style="width:60px;"></td>
</tr>
</table>
</form>
</center>
</body>
<%} %>
<script type="text/javascript">
function returnValues(){
	var array=new Array(4);
	array[0]=document.getElementById('name').value;
	array[1]=document.getElementById('gender').value;
	array[2]=document.getElementById('position').value;
	array[3]=document.getElementById('level').value;
	window.returnValue=array;  
	window.close();  
}

function initData(){
	var res=window.dialogArguments;
	var names=res[0].split("\n");
	var genders=res[1].split("\n");
	var positions=res[2].split("\n");
	var levels=res[3].split("\n");
	for(var i=0;i<names.length-1;i++){
		document.getElementById("name").options.add(new Option(names[i],names[i])); 
		document.getElementById("gender").options.add(new Option(genders[i],genders[i])); 
		document.getElementById("position").options.add(new Option(positions[i],positions[i])); 
		document.getElementById("level").options.add(new Option(levels[i],levels[i])); 
	}
}

</script>
</html>