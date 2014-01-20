<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<%@ include file="/base/include/restRequest.jspf"%>
	<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}
input{


}
td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 18px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align:center;
}
h1{
  font-size: 24px;
  }

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 18px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
	text-align:center;
}
  .tr01{
  	background-color: #C0C0C0;
  	font-weight:bold;
    line-height: 30px;
    text-align:center;
  }
  .tr02{
  	background-color: #FCFCFC;
  }
   .tr03{
  	background-color: #FCFCFC;
  }
	</style>
  </head>
  <script type="text/javascript">
  
  </script>
  <body>
  <div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;
  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="javascript:exportExcel();"  />&nbsp;&nbsp;&nbsp;
	</div>
	<div align="center" style="margin-left: 10px;  width:1200px;">
	      <h1>XX项目储备资金支出情况表</h1>
	</div>
 	<table width='1100' border='1' cellpadding='1' cellspacing='0'>
 		<tr >
			<td rowspan="2" colspan="1"  class='tr01'>序号</td>
			<td rowspan="2" colspan="1"  class='tr01'>科目</td>
			<td rowspan="2" colspan="1"  class='tr01'>预算费用</td>
			<td colspan="3" rowspan="1"  class='tr01' >已审批资金</td>
			<td rowspan="2" colspan="1"  class='tr01'>审批比列</td>
			<td rowspan="2" colspan="1" class='tr01'>未审批资金</td>			 		
 		</tr>
 		<tr>
 			
 			<td class='tr01' rowspan="1" colspan="1" >小计</td>
 			<td class='tr01' rowspan="1" colspan="1" >实际支出</td>
 			<td class='tr01' rowspan="1" colspan="1" >已批未付</td>
 			
 		</tr>
 		<tr>
 			<td>1</td>
 			<td>一级开发费用</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>1.1</td>
 			<td>前期费用</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>1.2</td>
 			<td>拆迁费用</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>1.3</td>
 			<td>市政费用</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>1.4</td>
 			<td>财务费用</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>1.2</td>
 			<td>管理费用</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>2</td>
 			<td>筹资本金返还</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>3</td>
 			<td>其他支出</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td colspan="2" class='tr01'>合计</td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 		</tr>
 	</table>
  	 
  </body>
</html>
