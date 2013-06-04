<%@page import="com.klspta.web.jinan.report.ReportManager"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/base/include/formbase.jspf"%>
<% 

%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>台账汇总</title>
<script type="text/javascript" src="js/DatePicker.js"></script>
   <script type="text/javascript" src="<%=_$basePath%>/base/gis/pages/framework/frameworkConfig.js"></script>
    <script type="text/javascript" src="<%=_$basePath%>/base/gis/pages/framework/frameworkHttpRequest.js"></script>
<script language="javascript">
var collects=['wfzs','wfydmj','gdmj','jbntmj','fhghmj','bfghmj','lazs','cfzs','ysfk','usfk','cczs','ccmj','ccgdmj','ysjjrs','ysgars','sqqzzx'];
function collect()
{
	var beginDate=document.getElementById("beginDate").value;
	var endDate=document.getElementById("endDate").value;
	var area="";
	var areas=document.getElementsByName("area");
	
	if(beginDate=="")
	{
		alert("请输入开始时间");
		return;
	}
	if(endDate!="")
	{
		var beginTime=beginDate.split("-");
		var endTime=endDate.split("-");
	
	
		
		if(parseInt(endTime[0])<parseInt(beginTime[0]))
		{
			alert("结束时间必须大于开始时间");
			return;
		}

		else if(parseInt(endTime[1])<parseInt(beginTime[1])&&parseInt(endTime[0])>=parseInt(beginTime[0]))
		{
			alert("结束时间必须大于开始时间");
			return;
		}
		
	}

	for(var i=0;i<areas.length;i++)
	{
	
		if(areas[i].checked)
			area+=areas[i].value+",";		
	}
	if(area!="")
	{
		area=area.substring(0,area.length-1);
	}
	else
	{
		alert("请选择地区");
		return;
	}
	putClientCommond("reportAction","collect");
 	putRestParameter("beginDate",beginDate);
	putRestParameter("endDate",endDate);
	putRestParameter("area",area);
 	
	var myData = restRequest();
	myData=eval('(' + myData + ')');
	myData=myData[0];
	for(var i=0;i<collects.length;i++)
	{
		document.getElementById(collects[i]).innerHTML=myData[collects[i]];
	}
	
	
}
</script>
<style type="text/css">
<!--

table
{
	border-top:1px solid #2C2B29;
	border-left:1px solid #2C2B29;
	background-color:#ffffff;
	margin-bottom:10px;
	width:722px;

}
table tr td
{
	border-right:1px solid #2C2B29;
	border-bottom:1px solid #2C2B29;
	padding:5px 10px 5px 5px;
}
.title
{
	text-align:right;
}
.top
{
	width:722px;
	text-align:left;
	margin-top:5px;
	margin-bottom:10px;

}
.top span
{
	width:720px;
	display:block;
	line-height:30px;
	margin-top:10px;
}
.area
{
	list-style:none;
	margin:20px 0 10px 0;;
	width:720px;

}
.area li
{
	list-style:none;
	display:block;
	width:80px;
	float:left;
}
.area li input
{
	margin-right:5px;
	vertical-align:middle;
}


-->
</style>
</head>
<body>
<div class="container">
	<div class="top">
	<span>
		时间：<input id="beginDate" type="text" name="QZZXSJ" id="QZZXSJ" class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;到&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		<input id="endDate" type="text" name="QZZXSJ" id="QZZXSJ" class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"/>		
    </span>
   
   
    <ul class="area">
    <%=ReportManager.getInstance().getAreaCheckCode(userId) %>
  	</ul>
      <input type="button" value="汇总" onclick="collect()" style="margin-top:10px;margin-bottom:10px;"/>
    </div>
   
	<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="250" class="title">违法用地宗数</td>
			<td width="110"><span class="text" id="wfzs"></span></td>
			<td width="250" class="title">违法用地面积（亩数、公顷数）</td>
			<td width="110"><span class="text" id="wfydmj"></span></td>
		</tr>
		<tr>
			<td class="title">其中耕地面积</td>
			<td><span class="text" id="gdmj"></span></td>
			<td class="title">其中基本农田面积</td>
			<td><span class="text" id="jbntmj"></span></td>
		</tr>
		<tr>
			<td class="title">符合规划面积</td>
			<td><span class="text" id="fhghmj"></span></td>
			<td class="title">不符合规划面积</td>
			<td><span class="text" id="bfghmj"></span></td>
		</tr>
		<tr>
			<td class="title">立案宗数</td>
			<td><span class="text" id="lazs"></span></td>
			<td class="title">处罚宗数</td>
			<td><span class="text" id="cfzs"></span></td>
		</tr>
		<tr>
			<td class="title">应收罚款数</td>
			<td><span class="text" id="ysfk"></span></td>
			<td class="title">已收缴罚款数</td>
			<td><span class="text" id="usfk"></span></td>
		</tr>
		<tr>
			<td class="title">拆除宗数</td>
			<td><span class="text" id="cczs"></span></td>
			<td class="title">拆除面积</td>
			<td><span class="text" id="ccmj"></span></td>
		</tr>
		<tr>
			<td class="title">其中耕地面积</td>
			<td><span class="text" id="ccgdmj"></span></td>
			<td class="title">移送纪检部门（人数，）</td>
			<td><span class="text" id="ysjjrs"></span></td>
		</tr>
		<tr>
			<td class="title">移送公安机关（人数）</td>
			<td><span class="text" id="ysgars"></span></td>
			<td class="title">申请法院强制执行数</td>
			<td><span class="text" id="sqqzzx"></span></td>
		</tr>
	
	</table>
		
</div>
</body>
</html>