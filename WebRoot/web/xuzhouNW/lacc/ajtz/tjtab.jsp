<%@page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>案件台账</title>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
	    <script src="<%=basePath%>/base/include/ajax.js"></script>
		<script type="text/javascript" src="js/DatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>

<style type="text/css">
<!--
body
{
 
 font-size:12px;

 
}
#tab table tr td
{
	text-align:center;
	padding:2px 5px 2px 5px
}

.trtd{
	display:block;
	width:180px;
	padding:2px 5px 2px 5px
}

input,img{vertical-align:middle;cursor:hand;}
.dateText
	{
	font-size:14px;
	color:#2C2B29;
	margin:0 0 0 3px;
	padding:3 0 0 3px;
	border:#999 1px solid;
	width:104px;
	height:23px;
	background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;
	}
.dateText2
	{
	font-size:14px;
	color:#2C2B29;
	margin:0 0 0 3px;
	padding:3 0 0 3px;
	border:#999 1px solid;
	width:240px;
	height:23px;
	background:white url(<%=basePath%>web/jinan/xxtj/js/open.png) no-repeat right;
	}
.dateText3
	{
	font-size:14px;
	color:#2C2B29;
	margin:0 0 0 3px;
	padding:3 0 0 3px;
	border:#999 1px solid;
	width:240px;
	height:23px;
	background:white url(<%=basePath%>web/jinan/xxtj/js/lxImage.png) no-repeat right;
	}
.backgroundDiv
{
	position:relative;
	z-index:3;
	background-color:#fffff;
	width:100%;
	height:100%;
	top:0;
	left:0;
	filter:alpha(opacity:30);
	opacity:0.3;
	display:none;
}

-->
</style>
<script type="text/javascript">
	var basePath="<%=basePath%>";
	var condition;
	var grid;
	var tbarPanel;
	var width;
    var treeList="";
	var  myData；
	var resultPanel;
	var msgWait;
	var scrWidth = screen.availWidth;
   	var scrHeight = screen.availHeight; 
Ext.onReady(function(){
	
	    width = document.body.clientWidth ;
	    var height = document.body.clientHeight * 0.92; 
	    tbarPanel = new Ext.form.FormPanel({
	        id:'gridId',
	        tbar:[
		        '年度违法案件：<input id="beginDate" type="text" name="beginDate" class="dateText"  readonly="true" onClick="setmonth(this)"/>&nbsp;——&nbsp;<input id="endDate" type="endDate" name="QZZXSJ"  class="dateText"   readonly="true" onClick="setmonth(this)"/>&nbsp;&nbsp;&nbsp;&nbsp;'+
		        '<input type="button" value="查 询" onclick="query();">&nbsp;&nbsp;&nbsp;&nbsp;',
		         {
							text : '导出',
							iconCls : 'blist',
							menu : [{
										text : '导出EXCEL',
										handler:exportExcel
									}, {
										text : '导出HTML',
										handler:exportHtml
									}, {
										text : '导出PDF',
										handler:exportPdf
									}]
						}
			  ],
	        stripeRows: true,
	        width: width,
	        height: 35,
	        stateful: true,
	        stateId: 'grid',
	        buttonAlign:'center'
	    });
      	tbarPanel.render('tbarPanel');
})

function exportExcel() {
    window.open(basePath+'model/report/exportFile.jsp?id=DBD6C6B1978D41808590EF04747C8600&type=excel&condition='+condition);
}
function exportHtml(){
	window.open(basePath+'model/report/exportFile.jsp?id=DBD6C6B1978D41808590EF04747C8600&type=html&condition='+condition);
}
function exportPdf(){
	window.open(basePath+'model/report/exportFile.jsp?id=DBD6C6B1978D41808590EF04747C8600&type=pdf&condition='+condition);
}

//查询
var isShow=false;
function query()
{
    //查询条件：treeList（行政区），beginDate，endDate,lx(类型)
      var beginDate = document.getElementById("beginDate").value;
	  var endDate = document.getElementById("endDate").value;
	  if(treeList==""||treeList==null){
	  	 alert("请选择行政区!!");
	  	return false;
	  }
	  if(beginDate==""){
	  	alert("请选择开始时间!!");
	  	return false;
	  }
	  if(endDate==""){
	  	alert("请选择结束时间!!");
	  	return false;
	  }
	  if(beginDate!="" && endDate!="")
	  {
		var beginTime=beginDate.split("-");
		var endTime=endDate.split("-");
		if(parseInt(endTime[0])<parseInt(beginTime[0]))
		{
			alert("结束时间必须大于开始时间");
			return false;
		}
		else if(endTime[1]<beginTime[1])
		{
			alert("结束时间必须大于开始时间");
			return false;
		}
	 }
	 
	 //各个选项都不为空时
	 if(treeList!="" && beginDate!="" && endDate!="" ){	
	  var yqs=treeList.split(',');
      var regions=new Array();
      for(var i=0;i<yqs.length;i++){
      	regions[i]="'"+yqs[i]+"'";
      }
      var region=regions.join(",");
      region=escape(escape(region));
      condition =" qy in ("+region+") and to_char(aydjrq,'yyyy-mm') between '"+beginDate+"' and '"+endDate+"'";
      document.getElementById('title').src="<%=basePath%>web/xuzhouNW/lacc/ajtz/title.jsp?beginDate="+beginDate+"&endDate="+endDate+"&region="+escape(escape(treeList));
      document.getElementById('content').src="<%=basePath%>model/report/showReport.jsp?id=DBD6C6B1978D41808590EF04747C8600&condition="+condition;
	}
}

</script>
</head>
    <form action="<%=basePath%>" method="post">
		
	</form>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">		
		<div id="tbarPanel" style="width: 100%; height: 10%;"></div>
		 <iframe frameborder="0" id="title" style="width:100%;height:30px;" scrolling="no"></iframe>
		 <iframe frameborder="0" id="content" scrolling="auto" style="width:100%;height:100%;"></iframe>
	</body>
</html>