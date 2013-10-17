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
    
    <title>基本斑信息录入</title>
    
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
	function initJiben(){
		init();
	}
	
	//字段非空验证
	function checkNotNull(){
		var reg = new RegExp("^[0-9]+(.[0-9]{2})?$");
		
		var dkmc = document.getElementById('dkmc').value;
		var ghyt = document.getElementById('ghyt').value;
		
		var zd = document.getElementById('zd').value;
		var jsyd = document.getElementById('jsyd').value;
		var rjl = document.getElementById('rjl').value;
		var jzgm = document.getElementById('jzgm').value;
		var ghyt = document.getElementById('ghyt').value;
		var gjjzgm = document.getElementById('gjjzgm').value;
		var jzjzgm = document.getElementById('jzjzgm').value;
		var szjzgm = document.getElementById('szjzgm').value;
		var zzsgm = document.getElementById('zzsgm').value;
		var zzzsgm = document.getElementById('zzzsgm').value;
		var zzzshs = document.getElementById('zzzshs').value;
		var hjmj = document.getElementById('hjmj').value;
		var fzzzsgm = document.getElementById('fzzzsgm').value;
		var fzzjs = document.getElementById('fzzjs').value;
		var kfcb = document.getElementById('kfcb').value;
		var lmcb = document.getElementById('lmcb').value;
		var yjzftdsy = document.getElementById('yjzftdsy').value;
		var cxb = document.getElementById('cxb').value;
		var cqqd = document.getElementById('cqqd').value;
		var cbfgl = document.getElementById('cbfgl').value;
		
		if(dkmc == ''){
			alert('地块名称不能为空');
			return false;
		}else{
			if(!reg.test(cbfgl)||!reg.test(cqqd)||!reg.test(cxb)||!reg.test(yjzftdsy)||!reg.test(lmcb)||!reg.test(kfcb)||!reg.test(fzzjs)||!reg.test(fzzzsgm)||!reg.test(hjmj)||!reg.test(zzzshs)||!reg.test(zzzsgm)||!reg.test(zzsgm)||!reg.test(jsyd)||!reg.test(rjl)||!reg.test(jzgm)||!reg.test(jzgm)||!reg.test(ghyt)||!reg.test(gjjzgm)||!reg.test(jzjzgm)||!reg.test(szjzgm)){
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
		    基本斑基础数据登记表
		</h1>
	</div>
	<br>
	<br>
	<form method="post">
		<table cellpadding="0" cellspacing="0" align="center" class="stytable">
			<tr>
				<td class="stytd">
					<label>&nbsp;地块名称</label>
				</td>
				<td width="200" class="stytd">
					<input type="text" id="dkmc" name="dkmc" >
				</td>
				<td class="stytd">
					<label>&nbsp;包含自然斑</label>
				</td>
				<td width="200" class="stytd">
					&nbsp;<input type="button" onclick="openWinForm()" value="添加自然斑">
				</td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;占地（公顷）</label></td>
				<td class="stytd"><input type="text" id="zd" name="zd"></td>
				<td class="stytd"><label>&nbsp;建设用地</label></td>
				<td class="stytd"><input type="text" id="jsyd" name="jsyd"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;容积率</label></td>
				<td class="stytd"><input type="text" id="rjl" name="rjl"></td>
				<td class="stytd"><label>&nbsp;建筑规模</label></td>
				<td class="stytd"><input type="text" id="jzgm" name="jzgm"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;规划用途</label></td>
				<td class="stytd"><input type="text" id="ghyt" name="ghyt"></td>
				<td class="stytd"><label>&nbsp;公建建筑规模</label></td>
				<td class="stytd"><input type="text" id="gjjzgm" name="gjjzgm"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;居住建筑规模</label></td>
				<td class="stytd"><input type="text" id="jzjzgm" name="jzjzgm"></td>
				<td class="stytd"><label>&nbsp;市政建筑规模</label></td>
				<td class="stytd"><input type="text" id="szjzgm" name="szjzgm"></td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;总征收规模</label></td>
				<td class="stytd"><input type="text" id="zzsgm" name="zzsgm"></td> 
				<td class="stytd"><label>&nbsp;住宅征收规模</label></td>
				<td class="stytd"><input type="text" id="zzzsgm" name="zzzsgm"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;住宅征收户数</label></td>
				<td class="stytd"><input type="text" id="zzzshs" name="zzzshs"></td>
				<td class="stytd"><label>&nbsp;户均面积</label></td>
				<td class="stytd"><input type="text" id="hjmj" name="hjmj"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;非住宅征收规模</label></td>
				<td class="stytd"><input type="text" id="fzzzsgm" name="fzzzsgm"></td>
				<td class="stytd"><label>&nbsp;非住宅家数</label></td>
				<td class="stytd"><input type="text" id="fzzjs" name="fzzjs"></td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;开发成本</label></td>
				<td class="stytd"><input type="text" id="kfcb" name="kfcb"></td>
				<td class="stytd"><label>&nbsp;楼面成本</label></td>
				<td class="stytd"><input type="text" id="lmcb" name="lmcb"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;地面成本</label></td>
				<td class="stytd"><input type="text" id="dmcb" name="dmcb"></td>
				<td class="stytd"><label>&nbsp;预计政府土地收益&nbsp;</label></td>
				<td class="stytd"><input type="text" id="yjzftdsy" name="yjzftdsy"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;存储比</label></td>
				<td class="stytd"><input type="text" id="cxb" name="cxb"></td>
				<td class="stytd"><label>&nbsp;拆迁强度&nbsp;</label></td>
				<td class="stytd"><input type="text" id="cqqd" name="cqqd"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;成本覆盖率</label></td>
				<td class="stytd" colspan="3"><input type="text" id="cbfgl" name="cbfgl"></td>
			</tr>
		</table>
	</form>
	<div id="jbdkInfo" />
  </body>
  <script type="text/javascript">
  	document.body.onload = initJiben;
  </script>
</html>