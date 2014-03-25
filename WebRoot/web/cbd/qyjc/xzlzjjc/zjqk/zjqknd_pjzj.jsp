<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.qyjc.common.ModelFactory"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
int year = Calendar.getInstance().get(Calendar.YEAR);
String list = ModelFactory.getZjqk_nd(year+"");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<base href="<%=basePath%>"/>
<title>二手房租售情况录入</title>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
<meta http-equiv="description" content="This is my page"/>
<%@ include file="/base/include/restRequest.jspf"%>
</head>
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
width: 40px;
text-align: left;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.tr01 {
	background-color: #C0C0C0;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
.tr04 {
	background-color:#D5E1F3;
	line-height: 30px;
	text-align: center;
}
</style>
<script type="text/javascript">
var datepjzj_id_cols_value="";
var datepjlm_id_cols_value="";

function chang(dom){
if(!isNaN(dom.value)){
	if(trim(dom.value)==""){
		dom.value=0;
	}
	if(datepjlm_id_cols_value!=null&&datepjlm_id_cols_value!=""){
		 datepjlm_id_cols_value=datepjlm_id_cols_value+"@"+dom.id+"_"+dom.value
	}else{
	 datepjlm_id_cols_value=dom.id+"_"+dom.value
	}
	}else{
	alert("写入数据有误！");
	dom.value="";
	}
	}
function cha(dom){
if(!isNaN(dom.value)){
	if(trim(dom.value)==""){
		dom.value=0;
	}
	if(datepjzj_id_cols_value!=null&&datepjzj_id_cols_value!=""){
		 datepjzj_id_cols_value=datepjzj_id_cols_value+"@"+dom.id+"_"+dom.value
	}else{
	 datepjzj_id_cols_value=dom.id+"_"+dom.value
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
		//putRestParameter("tabName","XZLZJQKND_PJZJ");
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
	   putClientCommond("qyjcManager", "Save_Zjqk");
		putRestParameter("datepjlm_id_cols_value",datepjlm_id_cols_value);
		putRestParameter("datepjzj_id_cols_value",datepjzj_id_cols_value);
		putRestParameter("tabName","XZLZJQKND_PJZJ");
		putRestParameter("year",year);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
		}
	  }
	  
	  
function trim(str){   
     str = str.replace(/^(\s|\u00A0)+/,'');   
     for(var i=str.length-1; i>=0; i--){   
         if(/\S/.test(str.charAt(i))){   
             str = str.substring(0, i+1);   
             break;   
         }   
     }   
     return str;   
 } 
</script>
<body>
	<div align="center">
		平均租金录入-----年度： <select onchange="newtab()" id="selt">
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
			<option value=2020 >2020年</option>
		</select>
		<button onClick="save()" >保存</button>
		</div>
		<%=list %>
		<div id ="newTable" ></div>
		<input style='width: 50px'>
</body>
</html>
