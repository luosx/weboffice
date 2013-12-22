<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.zjgl.Contorl" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid=request.getParameter("yw_guid");
	String table="";
	yw_guid="121312";
	List<Map<String, Object>> lr=null;
	List<Map<String, Object>> zc=null;
	if(!yw_guid.equals("")&&!yw_guid.equals("null")){
	  Contorl contorl=new Contorl();
	  table=contorl.getTextMode(yw_guid).toString();
System.out.print(contorl.getTextMode(yw_guid).toString());

   }
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
border-right:1px solid #000000;
border-bottom:1px solid #000000
}
table td{
border-left:1px solid #000000;
border-top:1px solid #000000;
} 

input{
border:none;
}
textarea{
border:none;
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
	putRestParameter("yw_guid","<%=yw_guid%>");
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
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
	 <div align="center" style="width: 1350px"><h3>资金管理</h3></div>
	   <%=table%>
	    <div id="addtable" style="width: 1000px" align="right" >
	    <img src="web/cbd/xmgl/image/bc.png" style="width: 100px;height:50px" onclick="save()"/>
	    </div>
	</body>
</html>
