<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>办理过程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=basePath%>/base/form/DatePicker/WdatePicker.js"></script>
		<style type="text/css">
table {
	border-right: 1px solid #000000;
	border-bottom: 1px solid #000000;
}

table td {
	border-left: 1px solid #000000;
	border-top: 1px solid #000000;
}

input {
	border: none;
	width: 70px;
}

textarea {
	border: none;
}

.tr01 {
	background-color: #969696;
	font-weight: bold;
	font-size: 15px;
	text-align: center;
	line-height: 50px;
	margin-top: 3px;
}

.tr02 {
	background-color: #FFFFCC;
	text-align: center;
	line-height: 30px;
}

.tr03 {
	background-color: #CCFFCC;
	text-align: center;
	line-height: 30px;
}

.tr04 {
	background-color: #969696;
	font-weight: bold;
	text-align: center;
	line-height: 30px;
}

.tr06 {
	background-color: #FFFFFF;
	text-align: center;
	line-height: 30px;
}

.tr07 {
	background-color: #CCCCFF;
	text-align: center;
	line-height: 30px;
}

.tr11 {
	background-color: #C0C0C0;
	text-align: center;
	line-height: 25px;
}

.tr16 {
	background-color: #FFCC99;
	text-align: center;
	font-weight: bold;
	line-height: 30px;
}
</style>
		<script type="text/javascript">
var newRow;
var yw_guid="";
	function save(){
	 var sj=document.getElementById("sj").value;
	 var sjbl=document.getElementById("sjbl").value;
	 var bmjbr=document.getElementById("bmjbr").value;
	 var bz=document.getElementById("bz").value;
	if(sj==null||sj==''||sjbl==null||sjbl==''||bmjbr==null||bmjbr==''){
	 alert("请填写完整之后再保存！！"); 
	}else{
	sjbl=escape(escape(sjbl));
	bmjbr=escape(escape(bmjbr));
	bz=escape(escape(bz));
	putClientCommond("xmmanager","saveBLGC");
	putRestParameter("yw_guid","");
	putRestParameter("sj",sj);
	putRestParameter("sjbl",sjbl);
	putRestParameter("bmjbr",bmjbr);
	putRestParameter("bz",bz);
	putRestParameter("BS","");
	document.getElementById("add").style.display="none";
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	}
	}
function saves(yw_guid){
	var sj=document.getElementById("sj1").value;
	var sjbl=document.getElementById("sjbl1").value;
	var bmjbr=document.getElementById("bmjbr1").value;
    var bz=document.getElementById("bz1").value;
	if(sj==null||sj==''||sjbl==null||sjbl==''||bmjbr==null||bmjbr==''){
	 alert("请填写完整之后再保存！！"); 
	}else{
	sjbl=escape(escape(sjbl));
	bmjbr=escape(escape(bmjbr));
	bz=escape(escape(bz));
	putClientCommond("xmmanager","saveBLGC");
	putRestParameter("yw_guid","");
	putRestParameter("sj",sj);
	putRestParameter("sjbl",sjbl);
	putRestParameter("bmjbr",bmjbr);
	putRestParameter("bz",bz);
	putRestParameter("BS",yw_guid);
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	}
	}
function modify(row,yw_guid){
	yw_guid=yw_guid;
	BS='xg';
	selectedTr = document.getElementById("row" +(row-1));
    selectedTr.style.display = 'none';
    var tb = document.getElementById("esftable");
     newRow = tb.insertRow(row);
    var c0 = newRow.insertCell(0);
    c0.align='center';
    c0.innerHTML = selectedTr.cells[0].childNodes[0].nodeValue ;//序号
    var c1 = newRow.insertCell(1);
    c1.align='center';
    c1.innerHTML="<textarea id='sj1' rows='4' cols='1' style=' width: 100px;overflow: hidden' onfocus='WdatePicker()' >"+ selectedTr.cells[1].childNodes[0].nodeValue+"</textarea>" ;//时间
     var c2 = newRow.insertCell(2);//事件
     c2.align='center';
    c2.innerHTML="<textarea id='sjbl1' rows='4' cols='10' style='width: 370px; overflow:auto'>"+selectedTr.cells[2].childNodes[0].nodeValue+"</textarea>";
     var c3 = newRow.insertCell(3);//部门/经办人
     c3.align='center';
    c3.innerHTML="<textarea id='bmjbr1' rows='4' cols='1' style='width: 120px; overflow: hidden'>"+selectedTr.cells[3].childNodes[0].nodeValue+"</textarea>";
      var c4 = newRow.insertCell(4);//备注
      c4.align='center';
    c4.innerHTML="<textarea id='bz1' rows='4' cols='20' style='width: 200px; overflow: auto'>"+selectedTr.cells[4].childNodes[0].nodeValue+"</textarea>";
    var c5 = newRow.insertCell(5);
    c5.align='center';
    //拼字符
    var s= "saves('"+yw_guid+"')";
    var d= "del('"+yw_guid+"')";
    var a='<a onclick="';
    var f='">保存&nbsp;&nbsp;&nbsp;</a>';
    var ff='">删除</a>';
    butt=a+s+f+a+d+ff;
    c5.innerHTML=butt;
	}
function del(bs){
	putClientCommond("xmmanager","delBLGC");
	putRestParameter("bs",bs);
	putRestParameter("yw_guid","");
	var msg=restRequest();
	if('success'==msg){
	alert("删除成功！");
	document.location.reload();
	}else{
	alert("删除失败！");
	}
	}
	function add(){
	document.getElementById("msg").style.display="";
	document.getElementById("add").style.display="none";
	
	}
</script>
	</head>
	<body bgcolor="#FFFFFF" style="overflow: scroll;">
		<div align="center" style="width: 100%">
			<div align="center" style="width: 95%; height: 20px">
				<h3>平均楼面均价测算 </h3>
			</div>
			<div>状态 <select> <option>编辑</option><option>查看</option></select>
			日期选择 <select> 
			<option>2013</option>
			<option>2014</option>
			<option>2015</option>
			<option>2016</option>
			<option>2017</option>
			<option>2018</option>
			<option>2019</option>
			<option>2020</option>
			</select>
			<font>----</font>
			<select> 
			<option>2013</option>
			<option>2014</option>
			<option>2015</option>
			<option>2016</option>
			<option>2017</option>
			<option>2018</option>
			<option>2019</option>
			<option>2020</option>
			</select>
			<button>确定</button>
			</div>
			<table width="95%" cellpadding="0" cellspacing="0" id='esftable'>
				<tr class="tr11">
					<td align="center" width="80px" height="50px"><h3>序号</h3></td>
					<td align="center" width="90px"><h3>信息</h3></td>
					<td align="center" width="90px"><h3>一月</h3></td>
					<td align="center" width="90px"><h3>二月</h3></td>
					<td align="center" width="90px"><h3>三月</h3></td>
					<td align="center" width="90px"><h3>四月</h3></td>
					<td align="center" width="90px"><h3>五月</h3></td>
					<td align="center" width="90px"><h3>六月</h3></td>
					<td align="center" width="90px"><h3>七月</h3></td>
					<td align="center" width="90px"><h3>八月</h3></td>
					<td align="center" width="90px"><h3>九月</h3></td>
					<td align="center" width="90px"><h3>十月</h3></td>
					<td align="center" width="90px"><h3>十一月</h3></td>
					<td align="center" width="90px"><h3>十二月</h3></td>
				</tr>
				
			</table>
		  <div align="right" style="width: 95%">	
		  <button style="display: " id="add" onclick="add() ">新增</button>
						</div>
		</div>
	</body>
</html>