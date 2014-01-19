<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.yzt.kgzb.Control"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String type=request.getParameter("type");
	type= new String(type.getBytes("iso-8859-1"), "utf-8");
	String table=new Control().getTable(type).toString();
	String reportID = "oldTable";
	String keyIndex = "1";
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
		<%@ include file="js/reportEdit.jspf"%>
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
<script src="web/cbd/yzt/kgzb/js/kgzbRowEditor.js"></script>
<script type="text/javascript">
var newRow;
var yw_guid='';
  var checkedTr;
  var QY="";
  var sign_add="n";
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
yw_guid=id;
if(newRow!=null&&checkedTr!=null){
        checkedTr.style.display = '';
		newRow.parentNode.removeChild(newRow);//删除行
}else if(newRow!=null){
	newRow.parentNode.removeChild(newRow);//删除行
}
     var type=escape(escape("<%=type%>"));
	 checkedTr=document.getElementById(id);
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
		c2.innerHTML = "<input id='YDXZ' value='"+msg[0].YDXZDH+"'/>";
		var c3 = newRow.insertCell(3);
		c3.innerHTML ="<input id='YDXZDH' value='"+msg[0].YDXZ+"'/>";
		var c4 = newRow.insertCell(4);
		 c4.innerHTML = "<input id='JSYDMJ' value='"+msg[0].JSYDMJ+"'  onchange='change(this)'/>";
		var c5 = newRow.insertCell(5);
		c5 .innerHTML ="<input id='RJL' value='"+msg[0].RJL+"'  onchange='change(this)'/>";
		var c6 = newRow.insertCell(6);
		c6.innerHTML ="<input id='GHJZGM' value='"+msg[0].GHJZGM+"'  onchange='change(this)'/>";
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
var DKMC=document.getElementById("DKMC").value;
var YDXZDH=document.getElementById("YDXZDH").value;
var YDXZ=document.getElementById("YDXZ").value;
var JSYDMJ=document.getElementById("JSYDMJ").value;
var RJL=document.getElementById("RJL").value;
var GHJZGM=document.getElementById("GHJZGM").value;

var JZKZGD=document.getElementById("JZKZGD").value;
var JZMD=document.getElementById("JZMD").value;
var LHL=document.getElementById("LHL").value;
var DBZS=document.getElementById("DBZS").value;
var DXMK=document.getElementById("DXMK").value;
var GHSJLY=document.getElementById("GHSJLY").value;
var BZ=document.getElementById("BZ").value;
DKMC=escape(escape(DKMC));
BZ=escape(escape(BZ));
YDXZ=escape(escape(YDXZ));
GHSJLY=escape(escape(GHSJLY));
if(sign_add=='y'){
if('<%=type%>'=="中心区"){
var  zxq=  document.getElementById("zxq");
QY=zxq.options[zxq.selectedIndex].value;
alert(QY);
}else{
var  dkq=  document.getElementById("dkq");
QY=dkq.options[dkq.selectedIndex].value;
alert(QY);
}
}
QY=escape(escape(QY));
if(DKMC==null||DKMC==""){
alert("请填写地块名称之后再保存！");
}else{
       var type=escape(escape("<%=type%>"));
		putClientCommond("kgzbmanager","save");
		putRestParameter("type",type);
		putRestParameter("yw_guid",yw_guid);
		
		putRestParameter("DKMC",DKMC);
		putRestParameter("YDXZDH",YDXZDH);
		putRestParameter("YDXZ",YDXZ);
		putRestParameter("JSYDMJ",JSYDMJ);
		putRestParameter("RJL",RJL);
		putRestParameter("GHJZGM",GHJZGM);
		
		putRestParameter("JZKZGD",JZKZGD);
		putRestParameter("JZMD",JZMD);
		putRestParameter("LHL",LHL);
		putRestParameter("DBZS",DBZS);
		putRestParameter("DXMK",DXMK);
		putRestParameter("GHSJLY",GHSJLY);
		putRestParameter("BZ",BZ);
		putRestParameter("QY",QY);
		var msg=restRequest();
		sign_add="n";
document.location.reload();

}
}
function change(put){
var vale=put.value;
if(isNaN(vale)){
alert("填写类型不正确！");
put.value="";
}
}

function addTr(){
 sign_add='y';
if(newRow!=null&&checkedTr!=null){
        checkedTr.style.display = '';
		newRow.parentNode.removeChild(newRow);//删除行
}
var  zxq=  document.getElementById("zxq");
var  dkq=  document.getElementById("dkq");
if('<%=type%>'=="中心区"){
zxq.style.display="";
dkq.style.display="none";

}else{
dkq.style.display="";
zxq.style.display="none";
}

     var type=escape(escape("<%=type%>"));
		var oldTable=document.getElementById("oldTable");
		var index=1;
		newRow=oldTable.insertRow(index);
		var c0 = newRow.insertCell(0);
		c0.innerHTML =0;
		var c1 = newRow.insertCell(1);
		c1.innerHTML = "<input id='DKMC' value=''/>";
		var c2 = newRow.insertCell(2);
		c2.innerHTML = "<input id='YDXZ' value=''/>";
		var c3 = newRow.insertCell(3);
		c3.innerHTML ="<input id='YDXZDH' value=''/>";
		var c4 = newRow.insertCell(4);
		 c4.innerHTML = "<input id='JSYDMJ' value=''  onchange='change(this)'/>";
		var c5 = newRow.insertCell(5);
		c5 .innerHTML ="<input id='RJL' value=''  onchange='change(this)'/>";
		var c6 = newRow.insertCell(6);
		c6.innerHTML ="<input id='GHJZGM' value=''  onchange='change(this)'/>";
		var c7 = newRow.insertCell(7);
		c7.innerHTML = "<input id='JZKZGD' value=''/>";
		var c8 = newRow.insertCell(8);
		c8.innerHTML = "<input id='JZMD' value=''/>";
		var c9 = newRow.insertCell(9);
		c9.innerHTML = "<input id='LHL' value=''/>";
		var c10 = newRow.insertCell(10);
		 c10.innerHTML = "<input id='DBZS' value=''/>";
		var c11 = newRow.insertCell(11);
		c11.innerHTML = "<input id='DXMK' value=''/>";
		var c12 = newRow.insertCell(12);
		c12.innerHTML ="<input id='GHSJLY' value=''/>";
		var c13 = newRow.insertCell(13);
		c13.innerHTML = "<input id='BZ' value=''/>";
		var c14 = newRow.insertCell(14);
		c14.innerHTML =" <img  width='40px' height='40px' src='web/cbd/yzt/kgzb/image/s.png' onclick='save()'></img>";
}



</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
     <div align="center" style="margin-top: 5px"><h3><%=type %>控规指标一览表</h3></div>
     <div style="width: 94%" align="left"> <img  width="30px"  height="30px"  src="web/cbd/yzt/kgzb/image/add.png" onclick="addTr()" alt="新增"></img>
     <select id='zxq' style="display: none">
     <option  selected="selected" value="西北区">西北区</option>
     <option value="西南区">西南区</option>
     <option value="东北区">东北区</option>
     <option value="东南区">东南区</option>
     </select>
      <select id='dkq' style="display: none">
     <option selected="selected" value="A街区">A街区</option>
     <option value="B街区">B街区</option>
     <option value="C街区">C街区</option>
     <option value="D街区">D街区</option>
     <option value="E街区">E街区</option>
     </select>
     
     
     
     </div>
	 <%=table %>
	</body>

</html>
