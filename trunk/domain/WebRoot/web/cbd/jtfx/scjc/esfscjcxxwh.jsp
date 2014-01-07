<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.jtfx.scjc.ScjcManager"%>

<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String list = ScjcManager.getInstcne().getList();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<base href="<%=basePath%>">
<title>二手房市场监测信息维护</title>
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
  .tr01{
  	background-color: #C0C0C0;
  	font-weight:bold;
    line-height: 30px;
    text-align:center;
  }
  .tr02{
  	background-color: #FCFCFC;
  }
   .tr03{
  	background-color: #FCFCFC;
  }
</style>
</head>
<script type="text/javascript">
	var selectedTr;
	var newRow;
	function modify(i) {
		if (selectedTr != null && newRow != null) {
			cancel2();
		}
		selectedTr = document.getElementById("row" + i);
		selectedTr.style.display = 'none';
		var tb = document.getElementById("esftable");
		newRow = tb.insertRow(i + 2);
		var c0 = newRow.insertCell(0);
		c0.innerHTML = selectedTr.cells[0].childNodes[0].nodeValue;//序号
		var c1 = newRow.insertCell(1);
		var ssqy = selectedTr.cells[1].childNodes[0].nodeValue;
		if (ssqy == 'CBD中心区') {
			c1.innerHTML = "<select id='ssqy1'><option value='CBD中心区'  selected = 'selected'>CBD中心区</option><option value='CBD东扩区'>CBD东扩区</option></select>";//所属区域
		} else if (ssqy == 'CBD东扩区') {
			c1.innerHTML = "<select id='ssqy1'><option value='CBD中心区'  >CBD中心区</option><option value='CBD东扩区' selected = 'selected'>CBD东扩区</option></select>";//所属区域
		}
		var c2 = newRow.insertCell(2);
		c2.innerHTML = "<input id='xqmc1' size=10 value="+selectedTr.cells[2].childNodes[0].nodeValue+">";//名称
		var c3 = newRow.insertCell(3);
		var xqlb = selectedTr.cells[3].childNodes[0].nodeValue;
		if (xqlb == '老旧房') {
			c3.innerHTML = "<select id='xqlb1'><option value='老旧房'  selected = 'selected'>老旧房</option><option value='新居房'>新居房</option></select>";//所属区域
		} else if (xqlb == '新居房') {
			c3.innerHTML = "<select id='xqlb1'><option value='老旧房'  >老旧房</option><option value='新居房' selected = 'selected'>新居房</option></select>";//所属区域
		}
		var c4 = newRow.insertCell(4);
		c4.innerHTML = "<textarea id='bz1' cols='36' rows='3'>"
				+ selectedTr.cells[4].childNodes[0].nodeValue + "</textarea>";//备注
		var c6 = newRow.insertCell(5);
		c6.innerHTML = "<a href='javascript:save2()'>保存</a>&nbsp;&nbsp;<a href='javascript:cancel2()'>取消</a>"//操作
	}
	function del(yw_guid) {
		if (confirm("确定要删除当前记录吗？")) {
			putClientCommond("scjcManager", "delByYwGuid");
			putRestParameter("yw_guid", yw_guid);
			var reslut = restRequest();
			if (reslut == 'success') {
				alert('删除成功！');
				window.location.reload();
			}
		}

	}
	//添加一行
	function addRow(obj) {

		document.getElementById("addButton").disabled = 'disabled';
		document.getElementById("newRow").style.display = '';

	}
	function cancel() {
		document.getElementById("addButton").disabled = '';
		document.getElementById("newRow").style.display = 'none';
	}
	function cancel2() {
		selectedTr.style.display = '';
		newRow.parentNode.removeChild(newRow);//删除行
	}
	function save() {

		var xqmc = escape(escape(document.getElementById("xqmc").value));
		var ssqyObj = document.getElementById("ssqy");
		var ssqy = escape(escape(ssqyObj.options[ssqyObj.selectedIndex].value)); // 选中值
		var xqlbObj = document.getElementById("xqlb")
		var xqlb = escape(escape(xqlbObj.options[xqlbObj.selectedIndex].value)); // 选中值
		var yw_guid = document.getElementById("yw_guid").value;
		var bz = escape(escape(document.getElementById("bz").value));

		putClientCommond("scjcManager", "save");
		putRestParameter("yw_guid", yw_guid);
		putRestParameter("ssqy", ssqy);
		putRestParameter("xqmc", xqmc);
		putRestParameter("xqlb", xqlb);
		putRestParameter("bz", bz);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
			window.location.reload();
		}
	}
	function save2(){
		var xqmc1 = escape(escape(document.getElementById("xqmc1").value));
		var ssqyObj1 = document.getElementById("ssqy1");
		var ssqy1 = escape(escape(ssqyObj1.options[ssqyObj1.selectedIndex].value)); // 选中值
		var xqlbObj1 = document.getElementById("xqlb1")
		var xqlb1 = escape(escape(xqlbObj1.options[xqlbObj1.selectedIndex].value)); // 选中值
		var bz1 = escape(escape(document.getElementById("bz1").value));
		var yw_guid1 = selectedTr.cells[5].childNodes[0].nodeValue;
		putClientCommond("scjcManager", "save");
		putRestParameter("yw_guid", yw_guid1);
		putRestParameter("ssqy", ssqy1);
		putRestParameter("xqmc", xqmc1);
		putRestParameter("xqlb", xqlb1);
		putRestParameter("bz", bz1);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('修改成功！');
			window.location.reload();
		}
	}

</script>
<body>
	<div align="center">
		
		<button onClick='addRow()' id='addButton'>添加</button><button onClick="javascript:window.location.href='esfscjczsqk.jsp'" id='addButton'>录入租售情况</button>
	</div>

	<%=list%>
</body>
</html>
