<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "zrbHandle";
String keyIndex = "1";
ITableStyle its = new TableStyleEditRow();
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
	<%@ include file="/base/include/reportEdit.jspf"%>
	<script src="base/include/jquery-1.10.2.js"></script>
	<%@ include file="/base/include/restRequest.jspf"%>	
	<script src="web/cbd/yzt/zrb/showR/js/zrbRowEditor.js"></script>
	<script src="web/cbd/yzt/zrb/js/table.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	
	
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

  	function hideywguid(){
  		var obj = document.getElementById("ZRB");
  		var rowlength = obj.rows.length;
  		for(var i=0;i< rowlength;i++){
  			if(i!=1){
  				obj.rows[i].cells[obj.rows[i].cells.length-1].style.display="none";
  				obj.rows[i].cells[obj.rows[i].cells.length-1].innerText;
  			}
  		}
  		var width = document.body.clientWidth;
		var height = document.body.clientHeight;
       	FixTable("ZRB", 1,2, width, height);
  	}
  	  </script>
  <body onload="hideywguid();">
  	<div id='show'>
  		<%=new CBDReportManager().getReport("ZRB",new Object[]{"false"},its)%>
  	</div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
