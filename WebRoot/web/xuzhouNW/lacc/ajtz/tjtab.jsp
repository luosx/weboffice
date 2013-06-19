<%@page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>县审核中列表</title>
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
 background:url(<%=basePath%>/base/form/images/menu_bg2.gif);
 
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
		        '<input type="button" value="查 询" onclick="query();">&nbsp;&nbsp;&nbsp;&nbsp;'+
		        '<input type="button" value="导 出" onclick="report();">'
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
	  
       msgWait= Ext.Msg.wait('', '提示', 
        { 
       	 text: '数据加载中......'   //进度条文字 
       });
       // Ext.Ajax.request({                    
       // url: "http://" + window.location.href.split("/")[2] + "/reduce/service/rest/tjfxManager/getResult?treeList="+escape(escape(treeList))+"&beginDate="+beginDate+"&endDate="+endDate, 
       // callback:function(options,success,response){   
       // if(success)              
        //  { 
        //     document.getElementById("tab").innerHTML=response.responseText;
         //    Ext.Msg.hide();    
        //  }else{
            //alert('出错了');   
        //  }              
        //}
      //})
      query1();
	}
}
var action="";
function report(){
	var beginDate = document.getElementById("beginDate").value;
	var endDate = document.getElementById("endDate").value;
	alert(treeList);
	parameter="beginDate="+beginDate+"&endDate="+endDate+"&area="+treeList;
	if(action=="")
		action=	document.forms[0].action;
	
	document.forms[0].action=action+"/service/rest/reportAction/report?"+parameter;
    document.forms[0].submit();
			
}

function query1(){
     
	 var beginDate = document.getElementById("beginDate").value;
	 var endDate = document.getElementById("endDate").value;
	 //var lx=document.getElementById("lx").value;
	   putClientCommond("tjfxManager","getResult");
	   putRestParameter("treeList",escape(escape(treeList)));
	   putRestParameter("beginDate",beginDate);
       putRestParameter("endDate",endDate);
       //putRestParameter("lx",escape(escape(lx)));
	   myData = restRequest();
	   isShow=false;
       if(myData!=''){
	      document.getElementById("tab").innerHTML=myData;
	      isShow=true;
	       //document.getElementById("backgroundDiv").style.display="none";
       }
       if(isShow){
     	  msgWait.hide();
       }
}
</script>
</head>
    <form action="<%=basePath%>" method="post">
		
	</form>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		
		<div id="tbarPanel" style="width: 100%; height: 10%;"></div>
		
		<div id="resultPanel" style="width: 100%; height: 70%;">
		  <div id="backgroundDiv" class="backgroundDiv" style="font-weight:bold ;color:#000000;font-size:18;vertical-align:center;text-align:center;padding-top:200px;"><img src="<%=basePath%>/model/report/img/load.gif"/></div>
		  <div id="tab" align="center" style="width: 100%; height: 90%;"></div>
		</div>	
	</body>
</html>