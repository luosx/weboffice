<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.dtjc.kfgl.*"%>

<%
    String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

String yw_guid = request.getParameter("yw_guid");
String type=request.getParameter("type");
List<Map<String, Object>> list = new XmgljgManager().getXmgljg();
String returnPath = request.getParameter("returnPath");
String edit = request.getParameter("edit");
if (edit == null || !edit.equals("false")) {
	edit = "true";
}
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>现场巡查情况</title>
		<script src="SlideTrans.js"></script>
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/newformbase.jspf"%>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
			
				<style type="text/css">
body {
	height: 700px;
}

.container,.container img {
	width: 600px;
	height: 400px;
	border: 0;
	vertical-align: top;
}

.container ul,.container li {
	list-style: none;
	margin: 0;
	padding: 0;
}

</style>
			
		<script language="javascript">
	  function back(){
	   this.parent.location.href="<%=returnPath%>";
	  }
	  function save(){
	      putClientCommond("xzlzjjc","saveXzlzj");
	      var zj = document.getElementById("zj").value;
	      var sj = document.getElementById("sj").value;
	      var xzlmc = document.getElementById("xzlmc").value;
	      putRestParameter("zj",zj);
	      putRestParameter("sj",sj);
	      putRestParameter("xzlmc",escape(escape(xzlmc)));
	      putRestParameter("yw_guid","<%=yw_guid%>");
	      myData = restRequest();
	      document.forms[0].submit();
	      if(myData){
	      alert("保存成功！");
	      }else{
	      alert("保存失败！");
	      }
	  }
	  
</script>
	</head>

	<body onload="init();" style="text-align: left;">&nbsp; 
 
		<% 
			if (list.size()>0) { 
		%>
		
	<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
		项目办理经过
	</div>
			<br>
		<form id="form" method="post">
		<table width="800px" cellspacing="0" cellpadding="0"
			 align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29">
			<tr>
				<td>序号</td>
				<td>时间</td>
				<td>事件</td>
				<td>部门/经办人</td>
				<td>备注</td>
			</tr>
			<%for(int i=0;i<(list.size()<10?10:list.size());i++){
				Map<String,Object> map =null;
				try{
					map = list.get(i);
				}catch (Exception e){
					map =null;
				}
				if(map!=null){
			%>
				<tr>
					<td><%=list.get(i).get("xh")==null?i:list.get(i).get("xh") %></td>
					<td><%=list.get(i).get("sj")==null?i:list.get(i).get("sj")%> </td>
					<td width="60%"><%=list.get(i).get("event")==null?i:list.get(i).get("event")%> </td>
					<td><%=list.get(i).get("department")==null?i:list.get(i).get("department")%> </td>
					<td><%=list.get(i).get("remark")==null?i:list.get(i).get("remark")%> </td>
				</tr>
			<%}else {}%>
				<tr>
					<td></td>
					<td></td>
					<td> </td>
					<td> </td>
					<td></td>
				</tr>
			<%} %>
		</table>
		</form>
		<%} %>
		<br>
		

	</body>
</html>
