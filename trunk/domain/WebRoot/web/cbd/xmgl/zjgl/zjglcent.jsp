<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.zjgl.Contorl" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.console.user.UserAction"%>
<%@page import="com.klspta.base.rest.ProjectInfo"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid=request.getParameter("yw_guid");
	String xmmc=request.getParameter("xmmc");
   	String year=request.getParameter("year");
   	String type=request.getParameter("type");
   	String editor=request.getParameter("editor");
	String table="";
	List<Map<String, Object>> lr=null;
	List<Map<String, Object>> zc=null;
	if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	} else {
		xmmc = "";
	}
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
	User user = ManagerFactory.getUserManager().getUserWithId(userId);
	List<Role>  role = ManagerFactory.getRoleManager().getRoleWithUserID(userId);
	String rolename = role.get(0).getRolename();
	if(!yw_guid.equals("")&&!yw_guid.equals("null")){
		if("all".equals(type)){
			  Contorl contorl=new Contorl(yw_guid,year);
			  table=contorl.getTextMode();
		}else {
			String types[] = type.split("@");
			String edirots[] = editor.split("@");
			Contorl contorl=  new Contorl(yw_guid,year,types,edirots,rolename);
			table= contorl.getTextMode_new();
		}
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
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
    table-layout:fixed;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align: center;
}
input{
border:none;
height: 25px;
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
	line-height: 20px;
	text-align: center;
}
.tr02 {
	background-color:#FFCC99;
	font-weight: bold;
	line-height: 15px;
	text-align: center;
}
.tr03 {
	background-color:#FFCC99;
	line-height: 15px;
	text-align: center;
}
.tr04 {
	background-color:#CCFFFF;
	line-height: 15px;
	text-align: center;
}
.tr05 {
	background-color:#FFF69A;
	background-color:#FFCC99;
	line-height: 15px;
	text-align: center;
}
</style>
<script type="text/javascript">

function addrzxq(check){

		var val = check.value;
if(!isNaN(val)){ 
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
	}else{
	alert("请填写有效数据！");
	check.value="";
	}
	}
function addzjlr(check){
		 var val = check.value;
if(!isNaN(val)){  
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
	}else{
	alert("请填写有效数据！");
	check.value="";
	}
 }
 
 function addds(){
 alert("");
 }
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
	 <div align="center" style="width: 1350px;margin-top: 10px"><h3><%=xmmc%>-资金管理</h3></div>
	   <%=table%>
	</body>

</html>
