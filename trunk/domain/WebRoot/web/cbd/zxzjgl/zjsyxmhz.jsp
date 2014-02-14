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
		    background-color: #A8CEFF;
		   }
	  	.trsingle{
		    background-color: #D1E5FB;
		    line-height: 20px;
		    text-align:center;
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
	      <h1>商务区分中心资金使用情况表</h1>
	</div>
	<div>
		<%=new CBDReportManager().getReport("XMZXSY",new Object[]{"false"})%>
	</div>
	<!-- 
 	<table width='1200' border='1' cellpadding='1' cellspacing='0'>
 		
 		<tr >
			<td rowspan="3" colspan="1"  class='tr01'>序号</td>
			<td rowspan="3" colspan="1"  class='td0_0' height='10' width='120'></td>
			<td rowspan="3" colspan="1"  class='tr01'>资金到位总额</td>
			<td colspan="10" rowspan="1"  class='tr01' >资金支出总额</td>
			<td rowspan="3" colspan="1"  class='tr01'>资金余额</td>		 		
 		</tr>
 		<tr>
 			
 			<td class='tr01' rowspan="2" colspan="1" >合计</td>
 			<td class='tr01' rowspan="1" colspan="6" >储备开发支出（亿元）</td>
 			<td class='tr01' rowspan="1" colspan="3" >储备开发成本外支出（亿元）</td>
 			
 		</tr>
 		<tr>
 			<td class='tr01'>小计</td>
 			<td class='tr01'>前期费用</td>
 			<td class='tr01'>拆迁费用</td>
 			<td class='tr01'>市政费用</td>
 			<td class='tr01'>财务费用</td>
 			<td class='tr01'>管理费</td>
 			<td class='tr01'>小计</td>
 			<td class='tr01'>筹融资金返还</td>
 			<td class='tr01'>其他支出</td>
 		</tr>
 		
 			
 			
 		
 		<tr>
 			<td>1</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>2</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>3</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>4</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td>5</td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 			<td></td>
 		</tr>
 		<tr>
 			<td class='tr01'></td>
 			<td class='tr01'>合计</td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 			<td class='tr01'></td>
 		</tr>
 		
 	</table>
 	 -->
  </body>
</html>
