<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.qyjc.common.ModelFactory"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";

String list = ModelFactory.getZjqk_pjlm();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<base href="<%=basePath%>">
<title>二手房租售情况录入</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/base/include/restRequest.jspf"%>
</head>
<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}
input{
border:none;
width: 50px;
}

.tr01 {
	background-color: #C0C0C0;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
</style>
<script type="text/javascript">
var date_id_cols_value="";

function chang(dom){
	if(!isNaN(dom.value)){
		if(date_id_cols_value!=null&&date_id_cols_value!=""){
			 date_id_cols_value=date_id_cols_value+"@"+dom.id+"_"+dom.value
		}else if(date_id_cols_value==""){
			date_id_cols_value=date_id_cols_value+"@"+dom.id+"_0";
		}else{
		 date_id_cols_value=dom.id+"_"+dom.value
		}
	}else{
		alert("写入数据有误！");
		dom.value="";
	}
}
function newtab(){
	var selt=document.getElementById("selt");
	var year=selt.options[selt.selectedIndex].value;
	    putClientCommond("qyjcManager", "getTable");
		putRestParameter("year",year);
		putRestParameter("tabName","XZLZJQKND_PJLM");
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
		}
    deleteDiv();
	document.getElementById("newTable").innerHTML=reslut;
	}
function deleteDiv(){
	 var my = document.getElementById("firstTable");
	  if (my != null) 
	  my.parentNode.removeChild(my);
	  }
	  
 function save(){
	  var selt=document.getElementById("selt");
	  var year=selt.options[selt.selectedIndex].value;
	  alert(year);
	   putClientCommond("qyjcManager", "Save_Zjqk");
		putRestParameter("date_id_cols_value",date_id_cols_value);
		//putRestParameter("tabName","XZLZJQKND_PJLM");
		putRestParameter("year",year);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
		}
	  }
</script>
<body>
	<div align="center">
	平均楼面均价录入-----	年度： <select onchange="newtab()" id="selt">
			<option value=2010>2010年</option>
			<option value=2011>2011年</option>
			<option value=2012>2012年</option>
			<option value=2013>2013年</option>
			<option value=2014 selected="selected">2014年</option>
			<option value=2015>2015年</option>
			<option value=2016>2016年</option>
			<option value=2017>2017年</option>
			<option value=2018>2018年</option>
			<option value=2019>2019年</option>
			<option value=2020>2020年</option>
		</select>
		<button onClick='save()'>保存</button>
		<button onClick="javascript:window.location.href='zjqkxx.jsp'">返回</button>
		</div>
		<%=list %>
		<div id ="newTable"></div>
</body>
</html>
