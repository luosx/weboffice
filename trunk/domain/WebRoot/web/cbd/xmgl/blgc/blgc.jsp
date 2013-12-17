<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid=request.getParameter("yw_guid");
	List<Map<String, Object>> list=null;
	if(!yw_guid.equals("")&&!yw_guid.equals("null")){
	   Xmmanager hxzm=new Xmmanager();
	   list= hxzm.getBLGC(yw_guid);
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
border-right:1px solid #C1DAD7;
border-bottom:1px solid #C1DAD7
}
table td{
border-left:1px solid #C1DAD7;
border-top:1px solid #C1DAD7;
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
	 <div align="center" style="width: 1000px"><h3>项目办理过程</h3></div>
		<table  width="1000px">
		<tr bgcolor="#FEA639" >
		<td align="center" width="100px" height="50px"><h3>序号</h3></td>
		<td align="center" width="100px"><h3>时间</h3></td>
		<td align="center" width="500px"><h3>事件</h3></td>
		<td align="center" width="100"><h3>部门/经办人</h3></td>
		<td align="center" width="200"><h3>备注</h3></td>
		</tr>
		<% if(list!=null){for(int i=0;i<list.size();i++){%>
		<tr align="center" >
		<td align="center" > <%=list.get(i).get("xh").toString() %></td>
		<td align="center" ><%=list.get(i).get("sj").toString() %></td>
		<td align="center" ><%=list.get(i).get("sjbl").toString() %></td>
		<td align="center" ><%=list.get(i).get("bmjbr").toString() %></td>
		<td align="center" ><%=list.get(i).get("bz").toString() %></td>
		</tr>
		<%}} %>
		<tr>
		<td align="center" ><input id='xh' type="text" width="95px"/></td>
		<td align="center" ><input id='sj' type="text"/ width="95px"></td>
		<td align="center" ><textarea id='sjbl' rows="4" cols="10" style="width: 370px"></textarea>  </td>
		<td align="center" ><input id='bmjbr' type="text" width="95px"/></td>
		<td align="center" ><textarea id='bz' rows="4" cols="20" style="width: 120px"></textarea> </td>
		</tr>
		</table>
	    <div id="addtable" style="width: 1000px" align="right" >
	    <img src="web/cbd/xmgl/image/bc.png" style="width: 100px;height:50px" onclick="save()"/>
	    </div>
	</body>
</html>
