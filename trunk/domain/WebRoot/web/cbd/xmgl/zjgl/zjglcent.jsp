<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.zjgl.Contorl" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid=request.getParameter("yw_guid");
	String table="";
	List<Map<String, Object>> lr=null;
	List<Map<String, Object>> zc=null;
	if(!yw_guid.equals("")&&!yw_guid.equals("null")){
	  Contorl contorl=new Contorl(yw_guid);
	  table=contorl.getTextMode();
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
border-bottom:1px solid #000000;
 font-size: 14px;
    border-color:#000000;
background-color: #A8CEFF;
}
table td{
border-left:1px solid #000000;
border-top:1px solid #000000;
     text-align:center;
    border-color:#000000;
    background-color: #A8CEFF;
} 
tr{
    border-width: 0px;
    text-align:center;
    background-color: #A8CEFF;
}
.title{
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 30px;
	margin-top: 3px;
	background-color: #A8CEFF;
  }

input{
border:none;
background-color: #A8CEFF;
}
textarea{
border:none;
background-color: #A8CEFF;
}
 </style>
<script type="text/javascript">

function addrzxq(check){
		var val = check.value;
		var id=check.id;
		var ids=id.split("@");
		var status=ids[0];
		var lb=ids[1];
		lb=escape(escape(lb));
		var sort=ids[2];
		var cols=ids[3];
putClientCommond("xmmanager","saveZJGL_ZJZC");
	putRestParameter("yw_guid","<%=yw_guid%>");
	putRestParameter("val",val);
	putRestParameter("status",status);
	putRestParameter("lb",lb);
	putRestParameter("sort",sort);
	putRestParameter("cols",cols);
	var msg=restRequest(); 
	}
function addzjlr(check){
		 var val = check.value;
		 var id=check.id;
		 var ids=id.split("@");
		 var stye=ids[1];
		 var cols=ids[2];
putClientCommond("xmmanager","saveZJGL_ZJLR");
	putRestParameter("yw_guid","<%=yw_guid%>");
	putRestParameter("cols",cols);
	putRestParameter("stye",stye);
	putRestParameter("val",val);
	var msg=restRequest(); 
 }
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
	 <div align="center" style="width: 1350px"><h3>资金管理</h3></div>
	   <%=table%>
	</body>
</html>
