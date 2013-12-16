<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid=request.getParameter("yw_guid");
	  Xmmanager hxzm=new Xmmanager();
   List<Map<String, Object>> list=hxzm.getBLGC();
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
table{
border-right:1px solid #F00;
border-bottom:1px solid #F00
}
table td{
border-left:1px solid #F00;
border-top:1px solid #F00;

} 



        </style>
<script type="text/javascript">
	
	function add(){
	var tab=" <table  width='1000px'><tr><td><input type='text' /></td><td><input type='text' /></td><td><input type='text' /></td><td><input type='text' /></td></tr></table>   ";
	document.getElementById("addtable").innerHTML=tab;
	}
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
	 <div align="center" style="width: 1000px"><h3>项目办理过程</h3></div>
		<table  width="1000px">
		<tr >
		<td align="center" width="100px">序号</td>
		<td align="center" width="100px">时间</td>
		<td align="center" width="500px">事件</td>
		<td align="center" width="100">部门/经办人</td>
		<td align="center" width="200">备注</td>
		</tr>
		<tr height="40px">
		<td></td>
		<td></td>
		<td>2323232332</td>
		<td>2323232323</td>
		<td>23423423423423</td>
		</tr>
		</table>
	    <div id="addtable" style="width: 1000px" ></div>
		<div><input   type="button" value="增加" onclick="add()"/> <input   type="button" value="保存" onclick="save()"/></div>
		
	</body>
</html>
