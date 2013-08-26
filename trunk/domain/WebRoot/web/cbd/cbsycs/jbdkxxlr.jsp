<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String strMsg = request.getParameter("msg");
String yw_guid = request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>基本地块信息录入</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
	<%@ include file="/base/include/newformbase.jspf"%>
  </head>
  <script type="text/javascript">
  	//初始化基本地块页面
  	function initjbdk(){
  		initXZQ();
  		init();
		bindData();
	}
  	//保存表单方法
	function save(){
		if(checkNotNull()){
			document.forms[0].submit(); 
			alertMsg();
		}			  
	}
	//初始化select级联
	function initXZQ(){
		putClientCommond("basicInfo","getXZQ");
     	var res_parent = restRequest();
     	var e_parent = document.forms[0].parent_select; 
		for (var i = 0; i < res_parent.length; i++){
			e_parent.options.add(new Option(res_parent[i].NAME, res_parent[i].CODE)); 
			if(i == 0){
				selectChange(res_parent[i].CODE);
			}
     	}
	}
	//级联选择
	function selectChange(strSelect){
		putClientCommond("basicInfo","getXZQ");
		putRestParameter("strSelect",strSelect);
 		var res_child = restRequest();
 		var e_child = document.forms[0].child_select;
 		e_child.innerHTML = "";
 		for(var j = 0; j < res_child.length; j++){
 			e_child.options.add(new Option(res_child[j].NAME, res_child[j].CODE)); 
 		}
	}
	//字段非空验证
	function checkNotNull(){
		var reg = new RegExp("^[0-9]+(.[0-9]{2})?$");
		
		var dkname = document.getElementById('dkname').value;
		
		var ghzd = document.getElementById('ghzd').value;
		var ghjsyd = document.getElementById('ghjsyd').value;
		var ghghyt = document.getElementById('ghghyt').value;//规划用途不是数字
		var ghgjjzgm = document.getElementById('ghgjjzgm').value;
		var ghszjzgm = document.getElementById('ghszjzgm').value;
		
		var cqzzzsgm = document.getElementById('cqzzzsgm').value;
		var cqzzzshs = document.getElementById('cqzzzshs').value;
		var cqfzzzsgm = document.getElementById('cqfzzzsgm').value;
		var cqfzzjs = document.getElementById('cqfzzjs').value;
		if(dkname == ''||ghzd == ''||ghjsyd == ''||ghghyt == ''||ghgjjzgm ==''||ghszjzgm == ''||cqzzzsgm ==''||cqzzzshs ==''||cqfzzzsgm ==''||cqfzzjs ==''){
			alert('基本信息字段不能为空');
			return false;
		}else{
			if(!reg.test(ghzd)||!reg.test(ghjsyd)||!reg.test(ghgjjzgm)||!reg.test(ghszjzgm)||!reg.test(cqzzzsgm)||!reg.test(cqzzzshs)||!reg.test(cqfzzzsgm)||!reg.test(cqfzzjs)){
				alert('请输入正确格式的数字');
				return false;
			}
		}
		return true;
	}
	//提示信息
	function alertMsg(){
		if("<%=strMsg%>" == "success"){
			alert("数据保存成功");
		}
	}
	//保存之后初始化级联选择
	function bindData(){
		if("<%=yw_guid%>" == "" || "<%=yw_guid%>" == "null"){
		
		}else{
			putClientCommond("basicInfo","bindData");
			putRestParameter("yw_guid","<%=yw_guid%>");
			var res = restRequest();
			res = res + "";
			var parent_res = res.substr(0,2) + "0000";
			document.getElementById('parent_select').value=parent_res;
			selectChange(parent_res);
			document.getElementById('child_select').value=res;
		}
	}
  </script>
  <style type="text/css">
	table{
		border-left-color:#000000;
		border-left-style:solid;
		border-left-width:1px;
		border-top-color:#000000;
		border-top-style:solid;
		border-top-width:1px;
	}
       td{
		border-right-color:#000000;
		border-right-style:solid;
		border-right-width:1px;
		border-bottom-color:#000000;
		border-bottom-style:solid;
		border-bottom-width:1px;
	}
  </style>
  <body bgcolor="#FFFFFF" style="margin:0 0;padding:0 0;">
  	<div align="left" id="fixed" class="Noprn" style="position: fixed; top: 5px; left:0px"></div>
  	<div align="center">
		<h1 style="font-size: 30">
			基本地块数据登记表
		</h1>
	</div>
	<form method="post">
		<table cellpadding="0" cellspacing="0" align="center" style="border:1px, #000000, solid">
			<tr>
				<td>
					<label>&nbsp;基本地块编号</label>
				</td>
				<td width="160">
					<input type="text" id="dkname" name="dkname" >
				</td>
				<td >
					<label>&nbsp;所属区域</label>
				</td>
				<td width="240">
					<select id="parent_select" onchange="selectChange(this.value)">
					</select>
					<select id="child_select" name="dkxzq">
					</select>
				</td>
			</tr>
			
			<tr><td colspan="4" bgcolor="#0099CC"><label>&nbsp;规划数据（公顷、万㎡）</label></td></tr>
			<tr>
				<td><label>&nbsp;占地</label></td>
				<td><input type="text" id="ghzd" name="ghzd"></td>
				<td><label>&nbsp;建设用地</label></td>
				<td><input type="text" id="ghjsyd" name="ghjsyd"></td>
			</tr>
			<tr>
				<td><label>&nbsp;规划用途</label></td>
				<td><input type="text" id="ghghyt" name="ghghyt"></td>
				<td><label>&nbsp;公建建筑规模</label></td>
				<td><input type="text" id="ghgjjzgm" name="ghgjjzgm"></td>
			</tr>
			<tr>
				<td><label>&nbsp;市政建筑规模</label></td>
				<td><input type="text" id="ghszjzgm" name="ghszjzgm"></td>
				<td><label>&nbsp;居住建筑规模</label></td>
				<td><input type="text" id="ghjzjzgm" name="ghjzjzgm" readonly></td>
			</tr>
			<tr>
				<td><label>&nbsp;容积率</label></td>
				<td><input type="text" id="ghrjl" name="ghrjl" readonly></td>
				<td><label>&nbsp;建筑规模</label></td>
				<td><input type="text" id="ghjzgm" name="ghjzgm" readonly></td>
			</tr>
			
			<tr><td colspan="4" bgcolor="#0099CC"><label>&nbsp;拆迁数据（万㎡、户）</label></td></tr>
			<tr>
				<td><label>&nbsp;住宅征收规模</label></td>
				<td><input type="text" id="cqzzzsgm" name="cqzzzsgm"></td>
				<td><label>&nbsp;住宅征收户数</label></td>
				<td><input type="text" id="cqzzzshs" name="cqzzzshs"></td>
			</tr>
			<tr>
				<td><label>&nbsp;非住宅征收规模</label></td>
				<td><input type="text" id="cqfzzzsgm" name="cqfzzzsgm"></td>
				<td><label>&nbsp;非住宅家数</label></td>
				<td><input type="text" id="cqfzzjs" name="cqfzzjs"></td>
			</tr>
			<tr>
				<td><label>&nbsp;总征收规模</label></td>
				<td><input type="text" id="cqzzsgm" name="cqzzsgm" readonly></td>
				<td><label>&nbsp;户均面积</label></td>
				<td><input type="text" id="cqhjmj" name="cqhjmj" readonly></td>
			</tr>
			
			<tr><td colspan="4" bgcolor="#0099CC"><label>&nbsp;成本及收益情况(亿元、元/㎡)</label></td></tr>
			<tr>
				<td><label>&nbsp;开发成本</label></td>
				<td><input type="text" id="cbsykfcb" name="cbsykfcb" readonly></td>
				<td><label>&nbsp;楼面成本</label></td>
				<td><input type="text" id="cbsylmcb" name="cbsylmcb" readonly></td>
			</tr>
			<tr>
				<td><label>&nbsp;地面成本</label></td>
				<td><input type="text" id="cbsydmcb" name="cbsydmcb" readonly></td>
				<td><label>&nbsp;预计政府土地收益&nbsp;</label></td>
				<td><input type="text" id="cbsyyjzftdsy" name="cbsyyjzftdsy" readonly></td>
			</tr>
			<tr>
				<td><label>&nbsp;存蓄比</label></td>
				<td colspan="3"><input type="text" id="cbsycxb" name="cbsycxb" readonly></td>
			</tr>
			
			<tr><td colspan="4" bgcolor="#0099CC"><label>&nbsp;拆迁强度（万㎡/公顷）</label></td></tr>
			<tr>
				<td><label>&nbsp;拆迁强度（万㎡/公顷）</label></td>
				<td colspan="3"><input type="text" id="qtcqqd" name="qtcqqd" readonly></td>
			</tr>
			
			<tr><td colspan="4" bgcolor="#0099CC"><label>&nbsp;成本覆盖率</label></td></tr>
			<tr>
				<td><label>&nbsp;成本覆盖率</label></td>
				<td colspan="3"><input type="text" id="qtcbfgl" name="qtcbfgl" readonly></td>
			</tr>
		</table>
	</form>
  </body>
  <script type="text/javascript">
	document.body.onload = initjbdk;
  </script>
</html>
