<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.cbd.qyjc.common.ModelFactory"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
            String []year={"2013","2014"};
            String ta=new ModelFactory().getMoreTab(year,"XZLZJQKND_PJLM");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=basePath%>/base/form/DatePicker/WdatePicker.js"></script>
<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
	   /***
   table-layout:fixed;
   ***/
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
width: 50px;
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
.tr02 {
	background-color:#FFCC99;
	line-height: 30px;
	text-align: center;
}
.tr03 {
	background-color:#CCFFFF;
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

function chang1(){
var selt1=document.getElementById("selt1");
var index=selt1.selectedIndex;
var selt2=document.getElementById("selt2");
  selt2.options[index].selected ="true";
}

function chang2(){
var selt2=document.getElementById("selt2");
var index=selt2.selectedIndex;
var selt1=document.getElementById("selt1");
    selt1.options[index].selected ="true";
}


function setNewTable(){
var selt1=document.getElementById("selt1");
var year1=selt1.options[selt1.selectedIndex].value;
var selt2=document.getElementById("selt2");
var year2=selt2.options[selt2.selectedIndex].value;
        putClientCommond("qyjcManager", "getXzl_ND");
		putRestParameter("year1", year1);
		putRestParameter("year2", year2);
		putRestParameter("tabName", "XZLZJQKND_PJLM");
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
		}
     deleteDiv();
	document.getElementById("newTab").innerHTML=reslut;
}

 
function deleteDiv(){
	 var my = document.getElementById("firstTable");
	  if (my != null) 
	  my.parentNode.removeChild(my);
	  }
	  
</script>
	</head>
	<body bgcolor="#FFFFFF" style="overflow: scroll;">
		<div align="center" style="width: 100%">
			<div align="center" style="width: 95%; height: 20px">
				<h3>平均楼面均价测算 </h3>
			</div>
	     	
			日期选择 <select id="selt1" onchange="chang1()"> 
			<option value="2010">2010</option>
			<option value="2011">2011</option>
			<option value="2012">2012</option>
			<option value="2013" selected="selected">2013</option>
			<option  value="2014">2014</option>
			<option value="2015">2015</option>
			<option value="2016">2016</option>
			<option value="2017">2017</option>
			<option value="2018">2018</option>
			<option value="2019" >2019</option>
			</select>
			<font >----</font>
			<select id="selt2" onchange="chang2()" > 
			<option value="2011">2011</option>
			<option value="2012">2012</option>
		    <option value="2013">2013</option>
			<option selected="selected" value="2014">2014</option>
			<option value="2015">2015</option>
			<option value="2016">2016</option>
			<option value="2017">2017</option>
			<option value="2018">2018</option>
			<option value="2019" >2019</option>
			<option value="2020">2020</option>
			</select>
			<button onclick="setNewTable()">确定</button>
			</div>
			<%=ta %>
             </div>
  <div id="newTab">

   </div>		
	</body>
</html>
