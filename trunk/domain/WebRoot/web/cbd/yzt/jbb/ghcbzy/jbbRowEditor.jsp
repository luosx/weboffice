<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "jbbHandle";
String keyIndex = "0";
ITableStyle its = new TableStyleEditRow();
String query = "";
int type = Integer.parseInt(request.getParameter("type"));
switch(type){
case 1:
	query = "产业功能改造区";
	break;
case 2:
	query = "民生改善区";
	break;
case 3:
	query = "城市形象提升区";
	break;
case 4:
	query = "保留微调区";
	break;
default:
	query = "%%";
	break;
}
Map<String, Object> conditionMap = new HashMap<String, Object>();
conditionMap.put("query", " where t.ssqy like '%" + query + "%'");
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
	<script src="web/cbd/yzt/jbb/ghcbzy/js/table.js"></script>
	<script src="web/cbd/yzt/jbb/ghcbzy/js/panel.js"></script>

	<script src="web/cbd/yzt/jbb/ghcbzy/js/jbbRowEditor.js"></script>
	<script src="base/include/jquery-1.10.2.js"></script>
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/base/include/reportEdit.jspf"%>
	
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
		    line-height: 30px;
			margin-top: 3px;
		  }
	  	.trtotal{
	  		background-color: #C0C0C0;
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
  	var query = "<%=query%>";
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		var width = document.body.clientWidth+10;
		var height = document.body.clientHeight;
       	FixTable("JBB", 1,2, width, height);
	});
  </script>
  <body>
 	<div id='show'>
  		<%=new CBDReportManager().getReport("JBB",new Object[]{"false",conditionMap},its)%>
  	</div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
