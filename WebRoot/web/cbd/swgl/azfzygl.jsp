<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@ page import="com.klspta.web.cbd.swkgl.Fyzcmanager"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.cbd.swkgl.AzfzcManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String list = AzfzcManager.getInstcne().getList();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<base href="<%=basePath%>">
		<title>My JSP 'JbbZrb.jsp' starting page</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/restRequest.jspf"%>
		<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
	text-align: center;
	width: 1800px;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align: center;
	width: 50px;
}

.tr01 {
	background-color: #C0C0C0;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
	width: 100px;
}

.tr02 {
	background-color: #FCFCFC;
}

.tr03 {
	background-color: #FCFCFC;
}

input {
	text-align: center;
}
</style>

	</head>
	<script type="text/javascript">
	var yw_guid_xh_value = "";
	var selectedTr;
	var newRow;
	function addRow(){
		selectedTr = document.getElementById("newRow");
		selectedTr.style.display = '';
	}
	
	function modify(i) {
		if (selectedTr != null && newRow != null) {
			cancel2();
		}
		selectedTr = document.getElementById("row" + i);
		selectedTr.style.display = 'none';
		var tb = document.getElementById("azftable");
		newRow = tb.insertRow(i + 2);
		var c0 = newRow.insertCell(0);
		c0.innerHTML = selectedTr.cells[0].childNodes[0].nodeValue;//序号
		var c1 = newRow.insertCell(1);
		if(isUndefined(selectedTr.cells[1].childNodes[0])){
			c1.innerHTML = "<input id='ydmc1' size=10 value="+selectedTr.cells[1].childNodes[0].nodeValue+">";//序号
		}else {
			c1.innerHTML = "<input id='ydmc1' size=10 value=''>";//序号
		}
		var c2 = newRow.insertCell(2);
		if(isUndefined(selectedTr.cells[2].childNodes[0])){
			c2.innerHTML = "<input id='tdyjkfzt1' size=10 value="+selectedTr.cells[2].childNodes[0].nodeValue+">";//序号
		}else {
			c2.innerHTML = "<input id='tdyjkfzt1' size=10 value=''>";//序号
		}
		var c3 = newRow.insertCell(3);
		if(isUndefined(selectedTr.cells[3].childNodes[0])){
			c3.innerHTML = "<input id='zdmj1' size=10 value="+selectedTr.cells[3].childNodes[0].nodeValue+">";//序号
		}else {
			c3.innerHTML = "<input id='zdmj1' size=10 value=''>";//序号
		}
		var c4 = newRow.insertCell(4);
		if(isUndefined(selectedTr.cells[4].childNodes[0])){
			c4.innerHTML = "<input id='jsyd1' size=10 value="+selectedTr.cells[4].childNodes[0].nodeValue+">";//序号
		}else {
			c4.innerHTML = "<input id='jsyd1' size=10 value=''>";//序号
		}
		var c5 = newRow.insertCell(5);
		if(isUndefined(selectedTr.cells[5].childNodes[0])){
			c5.innerHTML = "<input id='ghrjl1' size=10 value="+selectedTr.cells[5].childNodes[0].nodeValue+">";//序号
		}else {
			c5.innerHTML = "<input id='ghrjl1' size=10 value=''>";//序号
		}
		var c6 = newRow.insertCell(6);
		if(isUndefined(selectedTr.cells[6].childNodes[0])){
			c6.innerHTML = "<input id='ghjzgm1' size=10 value="+selectedTr.cells[6].childNodes[0].nodeValue+">";//序号
		}else {
			c6.innerHTML = "<input id='ghjzgm1' size=10 value=''>";//序号
		}
		var c7 = newRow.insertCell(7);
		if(isUndefined(selectedTr.cells[7].childNodes[0])){
			c7.innerHTML = "<input id='ghyt1' size=10 value="+selectedTr.cells[7].childNodes[0].nodeValue+">";//序号
		}else {
			c7.innerHTML = "<input id='ghyt1' size=10 value=''>";//序号
		}
		var c8 = newRow.insertCell(8);
		if(isUndefined(selectedTr.cells[8].childNodes[0])){
			c8.innerHTML = "<input id='kg1' size=10 value="+selectedTr.cells[8].childNodes[0].nodeValue+">";//序号
		}else {
			c8.innerHTML = "<input id='kg1' size=10 value=''>";//序号
		}
		var c9 = newRow.insertCell(9);
		if(isUndefined(selectedTr.cells[9].childNodes[0])){
			c9.innerHTML = "<input id='tdcb1' size=10 value="+selectedTr.cells[9].childNodes[0].nodeValue+">";//序号
		}else {
			c9.innerHTML = "<input id='tdcb1' size=10 value=''>";//序号
		}
		var c10 = newRow.insertCell(10);
		if(isUndefined(selectedTr.cells[10].childNodes[0])){
			c10.innerHTML = "<input id='yjkxcazfts1' size=10 value="+selectedTr.cells[10].childNodes[0].nodeValue+">";//序号
		}else {
			c10.innerHTML = "<input id='yjkxcazfts1' size=10 value=''>";//序号
		}
		var c11 = newRow.insertCell(11);
		if(isUndefined(selectedTr.cells[11].childNodes[0])){
			c11.innerHTML = "<input id='gdfs1' size=10 value="+selectedTr.cells[11].childNodes[0].nodeValue+">";//序号
		}else {
			c11.innerHTML = "<input id='gdfs1' size=10 value=''>";//序号
		}
		var c12= newRow.insertCell(12);
		if(isUndefined(selectedTr.cells[12].childNodes[0])){
			c12.innerHTML = "<input id='tdkfjsbcxy1' size=10 value="+selectedTr.cells[12].childNodes[0].nodeValue+">";//序号
		}else {
			c12.innerHTML = "<input id='tdkfjsbcxy1' size=10 value=''>";//序号
		}
		var c13 = newRow.insertCell(13);
		if(isUndefined(selectedTr.cells[13].childNodes[0])){
			c13.innerHTML = "<input id='tdyj1' size=10 value="+selectedTr.cells[13].childNodes[0].nodeValue+">";//序号
		}else {
			c13.innerHTML = "<input id='tdyj1' size=10 value=''>";//序号
		}
		var c14 = newRow.insertCell(14);
		if(isUndefined(selectedTr.cells[14].childNodes[0])){
			c14.innerHTML = "<input id='azfjsdw1' size=10 value="+selectedTr.cells[14].childNodes[0].nodeValue+">";//序号
		}else {
			c14.innerHTML = "<input id='azfjsdw1' size=10 value=''>";//序号
		}
		var c15 = newRow.insertCell(15);
		if(isUndefined(selectedTr.cells[15].childNodes[0])){
			c15.innerHTML = "<input id='tdcrht1' size=10 value="+selectedTr.cells[15].childNodes[0].nodeValue+">";//序号
		}else {
			c15.innerHTML = "<input id='tdcrht1' size=10 value=''>";//序号
		}
		var c16 = newRow.insertCell(16);
		if(isUndefined(selectedTr.cells[16].childNodes[0])){
			c16.innerHTML = "<input id='crhtydkgsj1' size=10 value="+selectedTr.cells[16].childNodes[0].nodeValue+">";//序号
		}else {
			c16.innerHTML = "<input id='crhtydkgsj1' size=10 value=''>";//序号
		}
		var c17 = newRow.insertCell(17);
		if(isUndefined(selectedTr.cells[17].childNodes[0])){
			c17.innerHTML = "<input id='tdz1' size=10 value="+selectedTr.cells[17].childNodes[0].nodeValue+">";//序号
		}else {
			c17.innerHTML = "<input id='tdz1' size=10 value=''>";//序号
		}
		var c18 = newRow.insertCell(18);
		if(isUndefined(selectedTr.cells[18].childNodes[0])){
			c18.innerHTML = "<textarea id='bz1' cols='36' rows='3'>"
				+ selectedTr.cells[18].childNodes[0].nodeValue + "</textarea>";//备注
		}else {
			c18.innerHTML = "<textarea id='bz1' cols='36' rows='3'></textarea>";//备注
		}
		var c19 = newRow.insertCell(19);
		c19.innerHTML = "<a href='javascript:save2()'>保存</a>&nbsp;&nbsp;<a href='javascript:cancel2()'>取消</a>"//操作
	}
	
	function isUndefined(value){
		if("undefined" == typeof value){
			return false;
		}else {
			return true;
		}
	}
	
	function save2(){
		var ydmc = document.getElementById("ydmc1").value;
	        var tdyjkfzt = document.getElementById("tdyjkfzt1").value;
	        var zdmj = document.getElementById("zdmj1").value;
	        var jsyd = document.getElementById("jsyd1").value;
	        var ghrjl = document.getElementById("ghrjl1").value;
	        var ghjzgm = document.getElementById("ghjzgm1").value;
	        var ghyt = document.getElementById("ghyt1").value;
	        var kg = document.getElementById("kg1").value;
	        var tdcb = document.getElementById("tdcb1").value;
	        var yjkxcazfts = document.getElementById("yjkxcazfts1").value;
	        var gdfs = document.getElementById("gdfs1").value;
	        var tdkfjsbcxy = document.getElementById("tdkfjsbcxy1").value;
	        var tdyj = document.getElementById("tdyj1").value;
	        var azfjsdw = document.getElementById("azfjsdw1").value;
	        var tdcrht = document.getElementById("tdcrht1").value;
	        var crhtydkgsj = document.getElementById("crhtydkgsj1").value;
	        var tdz = document.getElementById("tdz1").value;
	        var bz = document.getElementById("bz1").value;
	       	var yw_guid = selectedTr.cells[19].childNodes[0].nodeValue;
	        ydmc = escape(escape(ydmc));
	        tdyjkfzt = escape(escape(tdyjkfzt));
	        ghyt = escape(escape(ghyt));
	        gdfs = escape(escape(gdfs));
	        tdkfjsbcxy = escape(escape(tdkfjsbcxy));
	        tdyj = escape(escape(tdyj));
	        azfjsdw = escape(escape(azfjsdw));
	        tdcrht = escape(escape(tdcrht));
	        tdz = escape(escape(tdz));
	        bz = escape(escape(bz));
	    
		putClientCommond("zafzc", "updateAZFzc");
		putRestParameter("yw_guid", yw_guid);
		putRestParameter("ydmc",ydmc);
		putRestParameter("tdyjkfzt",tdyjkfzt);
		putRestParameter("zdmj",zdmj);
		putRestParameter("jsyd",jsyd);
		putRestParameter("ghrjl",ghrjl);
		putRestParameter("ghjzgm",ghjzgm);
		putRestParameter("ghyt",ghyt);
		putRestParameter("kg",kg);
		putRestParameter("tdcb",tdcb);
		putRestParameter("yjkxcazfts",yjkxcazfts);
		putRestParameter("gdfs",gdfs);
		putRestParameter("tdkfjsbcxy",tdkfjsbcxy);
		putRestParameter("tdyj",tdyj);
		putRestParameter("azfjsdw",azfjsdw);
		putRestParameter("tdcrht",tdcrht);
		putRestParameter("crhtydkgsj",crhtydkgsj);
		putRestParameter("tdz",tdz);
		putRestParameter("bz",bz);

		var msg=restRequest();
		if('success'==msg){
		alert("保存成功！");
		document.location.reload();
		}else{
		alert("保存失败！");
		}
	}
	
	function save(){
		var ydmc = document.getElementById("ydmc").value;
	        var tdyjkfzt = document.getElementById("tdyjkfzt").value;
	        var zdmj = document.getElementById("zdmj").value;
	        var jsyd = document.getElementById("jsyd").value;
	        var ghrjl = document.getElementById("ghrjl").value;
	        var ghjzgm = document.getElementById("ghjzgm").value;
	        var ghyt = document.getElementById("ghyt").value;
	        var kg = document.getElementById("kg").value;
	        var tdcb = document.getElementById("tdcb").value;
	        var yjkxcazfts = document.getElementById("yjkxcazfts").value;
	        var gdfs = document.getElementById("gdfs").value;
	        var tdkfjsbcxy = document.getElementById("tdkfjsbcxy").value;
	        var tdyj = document.getElementById("tdyj").value;
	        var azfjsdw = document.getElementById("azfjsdw").value;
	        var tdcrht = document.getElementById("tdcrht").value;
	        var crhtydkgsj = document.getElementById("crhtydkgsj").value;
	        var tdz = document.getElementById("tdz").value;
	        var bz = document.getElementById("bz").value;
	       
	        ydmc = escape(escape(ydmc));
	        tdyjkfzt = escape(escape(tdyjkfzt));
	        ghyt = escape(escape(ghyt));
	        gdfs = escape(escape(gdfs));
	        tdkfjsbcxy = escape(escape(tdkfjsbcxy));
	        tdyj = escape(escape(tdyj));
	        azfjsdw = escape(escape(azfjsdw));
	        tdcrht = escape(escape(tdcrht));
	        tdz = escape(escape(tdz));
	        bz = escape(escape(bz));
		putClientCommond("zafzc", "addAZFzc");
		putRestParameter("ydmc",ydmc);
		putRestParameter("tdyjkfzt",tdyjkfzt);
		putRestParameter("zdmj",zdmj);
		putRestParameter("jsyd",jsyd);
		putRestParameter("ghrjl",ghrjl);
		putRestParameter("ghjzgm",ghjzgm);
		putRestParameter("ghyt",ghyt);
		putRestParameter("kg",kg);
		putRestParameter("tdcb",tdcb);
		putRestParameter("yjkxcazfts",yjkxcazfts);
		putRestParameter("gdfs",gdfs);
		putRestParameter("tdkfjsbcxy",tdkfjsbcxy);
		putRestParameter("tdyj",tdyj);
		putRestParameter("azfjsdw",azfjsdw);
		putRestParameter("tdcrht",tdcrht);
		putRestParameter("crhtydkgsj",crhtydkgsj);
		putRestParameter("tdz",tdz);
		putRestParameter("bz",bz);

		var msg=restRequest();
		if('success'==msg){
		alert("添加成功！");
		document.location.reload();
		}else{
		alert("添加失败！");
		}
	}
	
	function del(yw_guid) {
		if (confirm("确定要删除当前记录吗？")) {
			putClientCommond("zafzc", "delByYwGuid");
			putRestParameter("yw_guid", yw_guid);
			var reslut = restRequest();
			if (reslut == 'success') {
				alert('删除成功！');
				window.location.reload();
			}
		}
	}
	
	function chang(yw){
	if (yw_guid_xh_value != null && yw_guid_xh_value != "") {
			yw_guid_xh_value = yw_guid_xh_value+"@"+yw.id + "_" + yw.value
		} else {
			yw_guid_xh_value = yw.id + "_" + yw.value
		}
	
	}
	
	function cancel() {
		document.getElementById("newRow").style.display = 'none';
	}
	function cancel2() {
		selectedTr.style.display = 'none';
		newRow.parentNode.removeChild(newRow);//删除行
	}

			
  </script>
	<body>
		<div id="fixed" style="position: fixed; top: 1px; left: 3px">
			&nbsp;
			<img src="base/form/images/add.png" width="20px" height="20px"
				title="添加" onClick="addRow();" />
			&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<%=list%>
	</body>
</html>
