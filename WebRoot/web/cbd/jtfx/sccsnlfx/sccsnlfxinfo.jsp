<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.web.cbd.yzt.jbb.JbbManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Map<String, Object> list = null;
	JbbManager xzl = new JbbManager();
	list = xzl.getJHCB();
	
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
	<body bgcolor="#FFFFFF" style="overflow: hidden;">
		<div align="center" style="width:100%;height: 100%" >
			<div align="center"><h1>CBD规划储备资源成本分析汇总表</h1></div>
			<table width="100%" height="70%" cellpadding="0" cellspacing="0">
				<tr align="center" class="tr11">
					
					<td width="25%" >开发成本(亿元)</td>
					<td width="25%">楼面成本(元/㎡)</td>
					<td width="25%">地面成本(元/㎡)</td>
					<td width="25%">租金保本点(元/㎡·日)</td>
				</tr>
				<tr align="center">
					<td width="25%"><%=list.get("KFCB") %></td>
					<td width="25%"><%=list.get("LMCB") %></td>
					<td width="25%"><%=list.get("DMCB") %></td>
					<td width="25%"><%=list.get("BBD") %></td>		
				</tr>
			</table>
		</div>
	</body>
</html>
