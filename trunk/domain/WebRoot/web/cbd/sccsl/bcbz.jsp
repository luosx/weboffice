<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.cbd.sccsl.XzlzjjcManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Map<String, Object>> list = null;
	XzlzjjcManager xzl = new XzlzjjcManager();
	list = xzl.getBCBZ();
	
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
	function save(){
	var xh=document.getElementById("xh").value;
	var sj=document.getElementById("sj").value
	var sjbl=document.getElementById("sjbl").value
	var bmjbr=document.getElementById("bmjbr").value
	var bz=document.getElementById("bz").value
	if(xh==null||xh==''||sj==null||sj==''||sjbl==null||sjbl==''||bmjbr==null||bmjbr==''||bz==null||bz==''){
	 alert("请填写完整之后再保存！！"); 
	}else{
	alert("");
	putClientCommond("xmmanager","saveBLGC");
	putRestParameter("xh",xh);
	putRestParameter("sj",sj);
	putRestParameter("sjbl",sjbl);
	putRestParameter("bmjbr",bmjbr);
	putRestParameter("bz",bz);
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	}
	}
</script>
	</head>
	<body bgcolor="#FFFFFF" style="overflow: scroll;">
		<div align="center" style="width:100%">
			<table width="90%" cellpadding="0" cellspacing="0">
				<tr class="tr11">
					<td align="center" width="60%" height="35px" colspan="2">
						住宅补偿标准
					</td>
					<td align="center" width="40%" rowspan="2">
						非住宅补偿标准
					</td>
				</tr>
				<tr align="center">
					<td width="30%" >补偿费</td>
					<td width="30%">补助费</td>
				</tr>
				<tr align="center">
					<td width="30%"><%=list.get(0).get("bcf") %></td>
					<td width="30%"><%=list.get(0).get("bzf") %></td>
					<td width="40%"><%=list.get(0).get("fzzbcbz") %></td>
				</tr>
			</table>
			<div id="addtable" style="width: 90%" align="right">
				<button onclick="save()">
					保存
				</button>
			</div>
		</div>
	</body>
</html>
