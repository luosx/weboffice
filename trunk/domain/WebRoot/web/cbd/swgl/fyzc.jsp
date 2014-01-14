<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@ page import="com.klspta.web.cbd.swkgl.Fyzcmanager" %>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.cbd.swkgl.Fyzcmanager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String list = Fyzcmanager.getInstcne().getList();
String yw_guid=request.getParameter("yw_guid");


String [] start=list.split("</table>");
String add="<tr ><td align='center' height='10' width='10'><input id='mc' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='gzfy' type='text'/></td>"+
			"<td align='center' height='10' width='10'><input id='gzgm' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='cbzj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='gzdj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lyfy' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lygm' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='qmfy' type='text'/></td>"+
			"<td align='center' height='10' width='10'><input id='jzmj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='zyzj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='pmft' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lyft' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='clft' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='ze' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='jhcb' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='xj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='dj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='jhcbs' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='xjs' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='djs' type='text' /></td>"+
		"</tr>";
String all=start[0]+add+"</table>";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 

  <head>
    <base href="<%=basePath%>" >
    <title>My JSP 'JbbZrb.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
	text-align:center;
	width:50px;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align:center;
	width:50px;
}


  .tr01{
  	background-color: #C0C0C0;
  	font-weight:bold;
    line-height: 30px;
    text-align:center;
    width:50px;
  }

</style>
  </head>
  <script type="text/javascript">


	function save(){
	var mc=document.getElementById("mc").value;
	var gzfy=document.getElementById("gzfy").value;
	var gzgm=document.getElementById("gzgm").value;
	var cbzj=document.getElementById("cbzj").value;
	var gzdj=document.getElementById("gzdj").value;
	var lyfy=document.getElementById("lyfy").value;
	var lygm=document.getElementById("lygm").value;
	var qmfy=document.getElementById("qmfy").value;
	var jzmj=document.getElementById("jzmj").value;
	var zyzj=document.getElementById("zyzj").value;
	var pmft=document.getElementById("pmft").value;
	var lyft=document.getElementById("lyft").value;
	var clft=document.getElementById("clft").value;
	var ze=document.getElementById("ze").value;
	var jhcb=document.getElementById("jhcb").value;
	var xj=document.getElementById("xj").value;
	var dj =document.getElementById("dj").value;
	var jhcbs=document.getElementById("jhcbs").value;
	var xjs=document.getElementById("xjs").value;
	var djs =document.getElementById("djs").value;
	mc=escape(escape(mc));
	putClientCommond("fyzcHandle","saveFyzc");
	putRestParameter("yw_guid","<%=yw_guid%>");
	putRestParameter("mc",mc);
	putRestParameter("gzfy",gzfy);
	putRestParameter("gzgm",gzgm);
	putRestParameter("cbzj",cbzj);
	putRestParameter("gzdj",gzdj);
	putRestParameter("lyfy",lyfy);
	putRestParameter("lygm",lygm);
	putRestParameter("qmfy",qmfy);
	putRestParameter("jzmj",jzmj);
	putRestParameter("zyzj",zyzj);
	putRestParameter("pmft",pmft);
	putRestParameter("lyft",lyft);
	putRestParameter("clft",clft);
	putRestParameter("ze",ze);
	putRestParameter("jhcb",jhcb);
	putRestParameter("xj",xj);
	putRestParameter("dj",dj);
	putRestParameter("jhcbs",jhcbs);
	putRestParameter("xjs",xjs);
	putRestParameter("djs",djs);
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	}
	
	function set(){
		var dklx=escape(escape(document.getElementById("dklx").value));
		var jzrq=escape(escape(document.getElementById("jzrq").value));
		var jzrqs=escape(escape(document.getElementById("jzrqs").value));
		putClientCommond("fyzcHandle","set");
		putRestParameter("dklx",dklx);
		putRestParameter("jzrq",jzrq);
		putRestParameter("jzrqs",jzrqs);
		var msg=restRequest();
		if('success'==msg){
		alert("设置成功！");
		document.location.reload();
		}else{
		alert("设置失败！");
		}
	}
			
  </script>
  <body>
  	
	<div>
		贷款利息<input id='dklx' type='text' />截止日期一<input id='jzrq' type='text' />截止日期二<input id='jzrqs' type='text' /><button onclick="set()">设置</button>
	</div>
	<div>
		<%=all%>
	</div>
	<div id="addtable"  align="left" >
		<button onclick="save()">保存</button>
	</div>
  </body>
</html>
