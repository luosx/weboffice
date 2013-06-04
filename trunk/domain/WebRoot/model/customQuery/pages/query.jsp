<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.customQuery.QueryManager"%>
<%@ include file="/base/include/formbase.jspf"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>定制查询</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/model/customQuery/css/queryStyle.css">
 	<script type="text/javascript" src="<%=basePath%>/model/customQuery/js/customQuery.js"></script>
 <style type="text/css">
 <!--
 .container
{	
	text-align:left;
}
 -->
 </style>
  </head>
  <body>
  <div class="container">
	   <div id="columnsEdit" class="opearDiv">
		   <div class="dateTitle" onclick="showOrCloseDiv('queryContent')">定制查询</div>
		   <div class="queryContent" id="queryContent">
			   统计名称 <select id="columnsValueSelect"><%=QueryManager.getInstance().getQueryCOnditionByUserId(userId)%></select>&nbsp;&nbsp;
			   <input type="button" value="添加" onclick="addColumns()"/>&nbsp;&nbsp;
			   <input type="button" value="删除" onclick="deleteColumns()"/>&nbsp;&nbsp;
			   <input type="button" value="修改" onclick="updateColumns()"/>
	        </div>
	   </div>
	   <div id="dateEdit">
	   	   <div class="dateTitle" onclick="showOrCloseDiv('dateList')">统计时间</div>
	   	   <ul class="dateList" id="dateList">
	   	   		<li id="date1" style="margin-top:0;padding-top:10px;">
		   	   		<input  name="dateWay" id="way1" type="checkbox" onclick="selectWay()"/><span>按年度统计</span>
		   	   		<select disabled  id="datetime11"><option value="2012">2012</option></select>
	   	   		</li>
	   	   		<li id="date2">
	   	   			<input name="dateWay" id="way2"  type="checkbox" onclick="selectWay()"/><span>按季度统计</span>
	   	   			<select disabled id="datetime21"><option value="2012">2012</option></select>
		   	   		<select disabled id="datetime22">
		   	   			<option value="1">第一季度</option>
		   	   			<option value="2">第二季度</option>
		   	   			<option value="3">第三季度</option>
		   	   			<option value="4">第四季度</option>
		   	   		</select>   	   		
	   	   		</li>
	   	   		<li id="date3">
	   	   			<input name="dateWay" id="way3"  type="checkbox" onclick="selectWay()"/><span>按月份统计</span>
	   	   			<select disabled id="datetime31"><option value="2012">2012</option></select>
	   	   			<select disabled id="datetime32"></select>
	   	   		</li>
	   	   		<li id="date4">
	   	   			<input name="dateWay" id="way4"  type="checkbox" onclick="selectWay()"/><span>按周统计</span>
	   	   			<select disabled id="datetime41" onchange="yearOfWeekChange(this)"><option value="2012">2012</option></select>
	   	   			<select disabled id="datetime42"></select>
	   	   		</li>
	   	   		<li id="date5">
	   	   			<input name="dateWay" id="way5" type="checkbox" onclick="selectWay()"/><span>按时间统计</span>
	   	   			<input disabled type="text" id="datetime51" class="Wdate" style="width:161px;height:20px;" onClick="WdatePicker()" />
	   	   			<input disabled type="text" id="datetime52" class="Wdate" style="width:160px;height:20px;margin-left:6px;" onClick="WdatePicker()" />
	   	   		</li> 
	   	   		<li style="padding-left:4px;">
	   	   			<input type="button" value="统计" onclick="doQuery()"/>
	   	   		</li>
	   	   		
	   	   </ul>
	   </div>
	   <div class="operaButton">
		   <input type="button" value="导出" onclick="report()"/>
	   </div>
	   <div class="dateTitle" style="border:1px solid #2C2B29;margin-top:10px;" onclick="showOrCloseDiv('queryData')">查询结果</div>
	   <div id="columnData"><div id="columnDataContent"></div></div>
	   <div id="queryData" onscroll="columnScroll()"></div>
 </div>
 <!-- 管理 -->
 <div id="backgroundDiv" class="backgroundDiv"></div>
 <div id="contentDiv" class="columnContentDiv">
 	<div class="statisticsManagerTitle">统计管理</div>
	<div class="statisticsManagerContent">		
	 	统计名称：<input id="columnsName" type="text" value="" style="border:1px solid black;width:450px;height:25px;pading-left:2px"/>
	 	<span class="selectAll"><input id="selectAll" style="margin-right:3px;" type="checkbox" onclick="selectAll();"/>全选</span>
	 	<ul class="columns">
	 		<%=QueryManager.getInstance().getColumnsCode()%>
	 	</ul>
	 <span class="buttonSpan">
		 	<input type="button" value="保存" onclick="saveColumns()"/>
		 	<input type="button" value="取消" onclick="closeColumns()" style="margin-left:20px;"/>
	 </span>
	 </div>

 </div>
   <form action="<%=basePath%>" method="post">
   		<input type="hidden" id="queryName" name="queryName" value=""/>
   		<input type="hidden" id="beginTime" name="startTime" value=""/>
   		<input type="hidden" id="endTime" name="endTime" value=""/>
   		<input type="hidden" id="colums" name="columns" value=""/>
   </form>
   <input type="hidden" id="userId" name="userId" value="<%=userId%>"/>
  </body>
</html>
