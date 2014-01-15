<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.yzt.kgzb.Control"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String type=request.getParameter("type");
	type= new String(type.getBytes("iso-8859-1"), "utf-8");
	String table=new Control().getTable(type).toString();
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
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>

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
	text-align: center;
	width: 80px;
}
input{
border:none;
height: 25px;
width: 50px;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.tr01 {
	background-color:#BCD2EF;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
	
}
.tr02 {
	background-color:#FFCC99;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
.tr03 {
	background-color:#FFCC99;
	line-height: 20px;
	text-align: center;
}
.tr04 {
	background-color:#CCFFFF;
	line-height: 30px;
	text-align: center;
}
.tr05 {
	background-color:#FFF69A;
	background-color:#FFCC99;
	line-height: 20px;
	text-align: center;
}
</style>
<script type="text/javascript">
var newRow;
var id='';
function delet(id){
var delet=document.getElementById(id);
var type=escape(escape("<%=type%>"));
    delet.parentNode.removeChild(delet);//删除行
	putClientCommond("kgzbmanager","delet");
	putRestParameter("type",type);
	putRestParameter("yw_guid",id);
	var msg=restRequest();
	if(msg=="success"){
	alert("删除成功！");
	}
}
function modify(id){
id=id;
     var type=escape(escape("<%=type%>"));
	  var checkedTr=document.getElementById(id);
	    checkedTr.style.display = 'none';
	    putClientCommond("kgzbmanager","quey");
		putRestParameter("type",type);
		putRestParameter("yw_guid",id);
		var msg=restRequest();
		var oldTable=document.getElementById("oldTable");
		var index=checkedTr.rowIndex+1;
		newRow=oldTable.insertRow(index);
		var c0 = newRow.insertCell(0);
		c0.innerHTML =checkedTr.rowIndex ;
		var c1 = newRow.insertCell(1);
		c1.innerHTML = "<input id='DKMC' value='"+msg[0].DKMC+"'/>";
		var c2 = newRow.insertCell(2);
		c2.innerHTML = "<input id='YDXZDH' value='"+msg[0].YDXZDH+"'/>";
		var c3 = newRow.insertCell(3);
		c3.innerHTML ="<input id='YDXZ' value='"+msg[0].YDXZ+"'/>";
		var c4 = newRow.insertCell(4);
		 c4.innerHTML = "<input id='JSYDMJ' value='"+msg[0].JSYDMJ+"'/>";
		var c5 = newRow.insertCell(5);
		c5 .innerHTML ="<input id='RJL' value='"+msg[0].RJL+"'/>";
		var c6 = newRow.insertCell(6);
		c6.innerHTML ="<input id='GHJZGM' value='"+msg[0].GHJZGM+"'/>";
		var c7 = newRow.insertCell(7);
		c7.innerHTML = "<input id='JZKZGD' value='"+msg[0].JZKZGD+"'/>";
		var c8 = newRow.insertCell(8);
		c8.innerHTML = "<input id='JZMD' value='"+msg[0].JZMD+"'/>";
		var c9 = newRow.insertCell(9);
		c9.innerHTML = "<input id='LHL' value='"+msg[0].LHL+"'/>";
		var c10 = newRow.insertCell(10);
		 c10.innerHTML = "<input id='DBZS' value='"+msg[0].DBZS+"'/>";
		var c11 = newRow.insertCell(11);
		c11.innerHTML = "<input id='DXMK' value='"+msg[0].DXMK+"'/>";
		var c12 = newRow.insertCell(12);
		c12.innerHTML ="<input id='GHSJLY' value='"+msg[0].GHSJLY+"'/>";
		var c13 = newRow.insertCell(13);
		c13.innerHTML = "<input id='BZ' value='"+msg[0].BZ+"'/>";
		var c14 = newRow.insertCell(14);
		c14.innerHTML =" <img  width='40px' height='40px' src='web/cbd/yzt/kgzb/image/s.png' onclick='save()'></img>";
}
function save(){
var DKMC=document.getElementById("DKMC");
var YDXZDH=document.getElementById("YDXZDH");
var YDXZ=document.getElementById("YDXZ");
var JSYDMJ=document.getElementById("JSYDMJ");
var RJL=document.getElementById("RJL");
var GHJZGM=document.getElementById("GHJZGM");
var JZKZGD=document.getElementById("JZKZGD");
var JZMD=document.getElementById("JZMD");
var LHL=document.getElementById("LHL");
var DBZS=document.getElementById("DBZS");
var DXMK=document.getElementById("DXMK");
var GHSJLY=document.getElementById("GHSJLY");
var BZ=document.getElementById("BZ");
if(DKMC==null||DKMC==""){
alert("请填写地块名称之后再保存！");
}else{



}



}

</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
     <div align="center" style="margin-top: 5px"><h3><%=type %>控规指标一览表</h3></div>
	 <%=table %>
	</body>

</html>
