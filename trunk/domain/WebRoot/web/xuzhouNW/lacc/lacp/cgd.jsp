<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.net.URLDecoder"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String yw_guid = request.getParameter("yw_guid");
    String permission = request.getParameter("permission");
    if(permission==null){
        permission = "no";
    }
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    if(permission==null){
        permission = "no";
    }
    String edit = request.getParameter("edit");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>"/>
		<TITLE>立案呈批表</TITLE>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/commonForm.css"  type="text/css" />
		<link rel="stylesheet" href="<%=basePath%>web/default/ajgl/css/lacpb.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<%} %>	
		<script type="">
			function save(){
			   document.forms[0].submit();
           }
           function refresh(){
				document.location.refresh();
			}
		</script>
		<style>
  .divContent{
	   font-size:20px;
	   margin-top:20px;
	   margin:auto;
	   width:550px;
	   margin-top:10px;
	   text-align:left;
	  }
</style>
	</head>

<body bgcolor="#FFFFFF" onLoad="init();">
  	<% if(fixed!=null && fixed.equals("fixedPrint")){%>
	<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
	<%	}else{%>
	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
	<% } %>
 <form method="post" id="form" name="yyx">
  <div style="text-align:center; color:#F00;font-size:28px"><b>徐州市国土资源局<input type="text" style="width:120px" name="fjmc" class="noborder" />分局</b></div><br />
  <div style="text-align:center; color:#F00;font-size:28px">违法用地项目（单位）抄告单</div><br />
  <div style="text-align:center;font-size:20px">〔<input type="text" style="width:70px" name="hao" class="noborder" />〕   号</div>
  <div style="text-align:center; margin-top:20px"><hr style=" border:1px solid red; width:650px" /></div>
  <div class="divContent" style="margin-top:20px">土地执法管理共同责任机制工作领导小组各成员单位：</div>
  <div class="divContent">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经我局巡查发现，<input type="text" name="qu" class="noborder" style="width:150px" />区<input type="text" name="zhen" class="noborder" style="width:113px" />镇</div>
  <div class="divContent">（办事处）<input type="text" name="cun" class="noborder" style="width:70px" /> 村辖区内<input type="text" name="xmmc" class="noborder" style="width:228px" />项</div>
  <div class="divContent">目（单位），位于<input type="text" name="location" class="noborder" style="width:170px"/>，面积约<input type="text" name="mj" class="noborder" style="width:65px" />亩，</div>
  <div class="divContent">未经有关部门批准，于<input type="text" name="ydyear" class="noborder" style="width:55px" />年<input type="text" name="ydmonth" class="noborder" style="width:55px" />月擅自占用土地进行</div>
  <div class="divContent">违法建设，现将情况抄告给贵单位。按照《市政府关于落实</div>
  <div class="divContent">土地执法监管共同责任机制的意见》（徐政发〔2012〕98号）</div>
  <div class="divContent">文件规定，请贵单位在该项目（单位）未完善用地手续前，</div>
  <div class="divContent">停止办理相关审批、行政许可等事项，并依据本部门职能予</div>
  <div class="divContent">以监管处理到位。</div>
  <div class="divContent">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;特此函告。</div>
  <div class="divContent" style="text-align:right"><input type="text" name="djyear" class="noborder"  style="width:60px" />年<input type="text" name="djmonth" class="noborder"  style="width:60px" />月<input type="text" name="djday" class="noborder" style="width:60px" />日</div>
  <div class="divContent">抄报：<input type="text" name="cbqu" class="noborder"  style="width:80px" /> 区人民政府；徐州市国土资源局。</div>
</form>
</body>
<script>

<%
	String msg = (String)request.getParameter("msg");
%>

if("<%=msg%>" == "success"&&"<%=permission%>"=="yes"){
	alert("表单权限保存成功");
}else if("<%=msg%>" == "success"){
	alert("表单保存成功");  
}

</script>	
</html>
