<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 

  <head>
    <base href="<%=basePath%>" >
    <title>My JSP 'JbbZrb.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		  table{
    font-size: 14px;
    background-color: #A8CEFF;
    border-color:#000000;
    /**
    border-left:1dp #000000 solid;
    border-top:1dp #000000 solid;
    **/
    color:#000000;
    border-collapse: collapse;
  }
  tr{
    border-width: 0px;
    text-align:center;
  }
  td{
    text-align:center;
    border-color:#000000;
    /**
    border-bottom:1dp #000000 solid;
    border-right:1dp #000000 solid;
    **/
  }
  .title{
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 50px;
	margin-top: 3px;
  }
  .trtotal{
  	text-align:center;
    font-weight:bold;
    line-height: 30px;
   }
  .trsingle{
    background-color: #D1E5FB;
    line-height: 20px;
    text-align:center;
   }
	</style>
  </head>
  <script type="text/javascript">
  		function print(){
			//var form=document.getElementById("attachfile");
			//form.action +="?reprotId=JBZR";
			//form.submit();
			/*
			var excel = new ReportExcel();
			excel.Init();
			excel.setCells(7);
			excel.setRows(56);
			excel.buildTable("report", "3", "1");
			excel.showTable();
			*/
			    var curTbl = document.getElementById("JBZR"); 
			    var oXL = new ActiveXObject("Excel.Application"); 
			    //创建AX对象excel 
			    var oWB = oXL.Workbooks.Add(); 
			    //获取workbook对象 
			        var oSheet = oWB.ActiveSheet; 
			    //激活当前sheet 
			    var sel = document.body.createTextRange(); 
			    sel.moveToElementText(curTbl); 
			    //把表格中的内容移到TextRange中 
			    sel.select(); 
			    //全选TextRange中内容 
			    sel.execCommand("Copy"); 
			    //复制TextRange中内容  
			    oSheet.Paste(); 
			    //粘贴到活动的EXCEL中       
			    oXL.Visible = true; 
			    //设置excel可见属性 
		
			
		}

		
  </script>
  <body>
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="javascript:print();"  />
	</div>
  		<%=new CBDReportManager().getReport("JBZR")%>
  	<form id="attachfile" action="<%=basePath%>service/rest/jbbHandle/getExcel" method="post">
	</form> 
  </body>
</html>
