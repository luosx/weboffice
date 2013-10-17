<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.cbxmjbsj.ProjectManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String extPath = basePath + "base/thirdres/ext/";
String yw_guid = request.getParameter("yw_guid");
ProjectManager projectManager = new ProjectManager();
String selectDkInfo = projectManager.getSelectDkJsonByProjectID(yw_guid);
String notSelectDkInfo = projectManager.getDkInfoArrayJsonByProjectID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>自然斑信息录入</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<%@ include file="/base/include/newformbase.jspf"%>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
	
  </head>
  <script type="text/javascript">
  
  	//保存表单方法
	function save(){
		if(checkNotNull()){
			document.forms[0].submit(); 
		}	
	}
	
	//初始化
	function initZiran(){
		init();
	}
	
	//字段非空验证
	function checkNotNull(){
		var reg = new RegExp("^[0-9]+(.[0-9]{2})?$");
		
		var zrbbh = document.getElementById('zrbbh').value;
		var zdmj = document.getElementById('zdmj').value;
		var lzmj = document.getElementById('lzmj').value;
		var cqgm = document.getElementById('cqgm').value;
		var zzlzmj = document.getElementById('zzlzmj').value;
		var zzcqgm = document.getElementById('zzcqgm').value;
		var yjhs = document.getElementById('yjhs').value;
		var fzzlzmj = document.getElementById('fzzlzmj').value;
		var bz = document.getElementById('bz').value;
		
		if(zrbbh == ''){
			alert('自然斑编号不能为空');
			return false;
		}else{
			if(!reg.test(zdmj)||!reg.test(lzmj)||!reg.test(cqgm)||!reg.test(zzlzmj)||!reg.test(zzcqgm)||!reg.test(yjhs)||!reg.test(fzzlzmj)){
				alert('请输入正确格式的数字');
				return false;
			}
		}
		return true;
	}
  </script>
  <style type="text/css">
  	.stytable{
		border-left-color:#000000;
		border-left-style:solid;
		border-left-width:1px;
		border-top-color:#000000;
		border-top-style:solid;
		border-top-width:1px;
	}
	.stytd{
		border-right-color:#000000;
		border-right-style:solid;
		border-right-width:1px;
		border-bottom-color:#000000;
		border-bottom-style:solid;
		border-bottom-width:1px;
		height:38px;
		border-top-width:0px; 
		border-bottom:1px solid #2C2B29; 
		border-left-width:0; 
		border-right:1px solid #2C2B29;
		font-size: 14px;
		FONT-FAMILY:"宋体","Verdana"; 
		vertical-align:middle;		
	}
	
  </style>
  <body bgcolor="#FFFFFF" style="margin:0 0;padding:0 0;">
  	<div align="left">
  		<img src="base/form/images/save.png" onclick="formSave()" style="cursor:hand" title="保存"/><br/>
  		<img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>
  	</div>
  	<div align="center">
		<h1  style="font-size: 30">
			自然斑基础数据登记表
		</h1>
	</div>
	<br>
	<br>
	<form method="post">
		<table cellpadding="0" cellspacing="0" align="center" class="stytable">
			<tr>
				<td  width="120"  class="stytd"><label>&nbsp;自然斑编号</label></td>
				<td  width="200"  class="stytd"><input type="text" id="zrbbh" name="zrbbh"></td>
				<td  width="120" class="stytd"><label>&nbsp;占地面积（㎡）</label></td>
				<td  width="200"  class="stytd"><input type="text" id="zdmj" name="zdmj"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;楼座面积</label></td>
				<td class="stytd"><input type="text" id="lzmj" name="lzmj"></td>
				<td class="stytd"><label>&nbsp;拆迁规模</label></td>
				<td class="stytd"><input type="text" id="cqgm" name="cqgm"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;住宅楼座面积</label></td>
				<td class="stytd"><input type="text" id="zzlzmj" name="zzlzmj"></td>
				<td class="stytd"><label>&nbsp;住宅拆迁规模</label></td>
				<td class="stytd"><input type="text" id="zzcqgm" name="zzcqgm"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;预计户数</label></td>
				<td class="stytd"><input type="text" id="yjhs" name="yjhs"></td>
				<td class="stytd"><label>&nbsp;非住宅楼座面积</label></td>
				<td class="stytd"><input type="text" id="fzzlzmj" name="fzzlzmj"></td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;非住宅拆迁规模</label></td>
				<td class="stytd"><input type="text" id="fzzcqgm" name="fzzcqgm"></td> 
				<td class="stytd"><label>&nbsp;备注</label></td>
				<td class="stytd"><input type="text" id="bz" name="bz"></td>
			</tr>
		</table>
	</form>
	<div id="jbdkInfo" />
  </body>
  <script type="text/javascript">
 	document.body.onload = initZiran;
  </script>
</html>