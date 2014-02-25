<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<base href="<%=basePath%>">
	<title>商务区分中心资金筹集情况表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/base/include/ext.jspf"%>
	<script src="base/include/jquery-1.10.2.js"></script>
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
	function exportExcel(){
		    var curTbl = document.getElementById("XZLZJ"); 
 			try{
		    	var oXL = new ActiveXObject("Excel.Application");
		    }catch(err){
		    	Ext.Msg.alert('提示','Excel生成失败，请先确定系统已安装office，并在浏览器的\'工具\' - Internet选项 -安全 - 自定义级别 - ActiveX控件和插件 - 对未标记为可安全执行脚本的ActiveX控件.. 标记为\'启用\'');
		    	return;
		    } 
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
		    //oSheet.Paste(); 
		    oSheet.Paste(); 
		    //粘贴到活动的EXCEL中       
		    oXL.Visible = true; 
		    //设置excel可见属性 
		}
function shows(){
	var year = document.getElementById("sel").value;
	year=escape(escape(year));
	putClientCommond("swqfzxzjcqkbManager","getlistByYear");
	putRestParameter("year",year);
	var list = restRequest();
}	
</script>

<body>
<div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;
  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="javascript:exportExcel();"  />&nbsp;&nbsp;&nbsp;
	</div>
	<div align="center" style="margin-left: 10px;  width:1100px;">
	      <h1>商务区分中心资金筹集情况表</h1>
	</div>
	<!-- 
	<div  align="left" style="margin-left: 20px;  width:1100px;">
	      年份选择 <select id="sel" onchange="shows"> 
			<option value="2010">2010</option>
			<option value="2011">2011</option>
			<option value="2012">2012</option>
			<option value="2013">2013</option>
			<option  value="2014" selected="selected">2014</option>
			<option value="2015">2015</option>
			<option value="2016">2016</option>
			<option value="2017">2017</option>
			<option value="2018">2018</option>
			<option value="2019" >2019</option>
			</select>
	</div>
	 -->
	<div  align="right" style="margin-left: 10px;  width:1000px;">
	      单位：亿元&nbsp;
	</div>
	<div style="margin-left:20px">
		<%=new CBDReportManager().getReport("ZXCJQK",new Object[]{"false"})%>
		<!-- 
		<table id='SWQFZXZJCJQKB' width='1100' border='1' cellpadding='1' cellspacing='0'>
			<tr class='tr01' >
				<td id='0_0' height='10' width='50' class='tr01'>序号</td>
				<td id='0_1' height='10' width='150' class='tr01'>项目</td>
				<td id='0_2' height='10' width='150' class='tr01'>筹集总额</td>
				<td id='0_3' height='10' width='150' class='tr01'>金融机构贷款</td>
				<td id='0_4' height='10' width='150' class='tr01'>实施主体带资</td>
				<td id='0_5' height='10' width='150' class='tr01'>国有土地收益基金</td>
				<td id='0_6' height='10' width='150' class='tr01'>出让回笼资金</td>
				<td id='0_7' height='10' width='150' class='tr01'>其他资金</td>
			</tr>
			<tr class='tr02' >
				<td id='1_0' height='10' width='50' class='tr02'>1</td>
				<td id='1_1' height='10' width='150' class='tr02'></td>
				<td id='1_2' height='10' width='150' class='tr02'></td>
				<td id='1_3' height='10' width='150' class='tr02'></td>
				<td id='1_4' height='10' width='150' class='tr02'></td>
				<td id='1_5' height='10' width='150' class='tr02'></td>
				<td id='1_6' height='10' width='150' class='tr02'></td>
				<td id='1_7' height='10' width='150' class='tr02'></td>
			</tr>
			<tr class='tr02' >
				<td id='2_0' height='10' width='50' class='tr02'>2</td>
				<td id='2_1' height='10' width='150' class='tr02'></td>
				<td id='2_2' height='10' width='150' class='tr02'></td>
				<td id='2_3' height='10' width='150' class='tr02'></td>
				<td id='2_4' height='10' width='150' class='tr02'></td>
				<td id='2_5' height='10' width='150' class='tr02'></td>
				<td id='2_6' height='10' width='150' class='tr02'></td>
				<td id='2_7' height='10' width='150' class='tr02'></td>
			</tr>
			<tr class='tr02' >
				<td id='3_0' height='10' width='50' class='tr02'>3</td>
				<td id='3_1' height='10' width='150' class='tr02'></td>
				<td id='3_2' height='10' width='150' class='tr02'></td>
				<td id='3_3' height='10' width='150' class='tr02'></td>
				<td id='3_4' height='10' width='150' class='tr02'></td>
				<td id='3_5' height='10' width='150' class='tr02'></td>
				<td id='3_6' height='10' width='150' class='tr02'></td>
				<td id='3_7' height='10' width='150' class='tr02'></td>
			</tr>
			<tr class='tr02' >
				<td id='4_0' height='10' width='50' class='tr02'>4</td>
				<td id='4_1' height='10' width='150' class='tr02'></td>
				<td id='4_2' height='10' width='150' class='tr02'></td>
				<td id='4_3' height='10' width='150' class='tr02'></td>
				<td id='4_4' height='10' width='150' class='tr02'></td>
				<td id='4_5' height='10' width='150' class='tr02'></td>
				<td id='4_6' height='10' width='150' class='tr02'></td>
				<td id='4_7' height='10' width='150' class='tr02'></td>
			</tr>
			<tr class='tr02' >
				<td id='5_0' height='10' width='50' class='tr02'>5</td>
				<td id='5_1' height='10' width='150' class='tr02'></td>
				<td id='5_2' height='10' width='150' class='tr02'></td>
				<td id='5_3' height='10' width='150' class='tr02'></td>
				<td id='5_4' height='10' width='150' class='tr02'></td>
				<td id='5_5' height='10' width='150' class='tr02'></td>
				<td id='5_6' height='10' width='150' class='tr02'></td>
				<td id='5_7' height='10' width='150' class='tr02'></td>
			</tr>
			<tr class='tr02' >
				<td id='6_0' height='10' width='50' class='tr02'>6</td>
				<td id='6_1' height='10' width='150' class='tr02'></td>
				<td id='6_2' height='10' width='150' class='tr02'></td>
				<td id='6_3' height='10' width='150' class='tr02'></td>
				<td id='6_4' height='10' width='150' class='tr02'></td>
				<td id='6_5' height='10' width='150' class='tr02'></td>
				<td id='6_6' height='10' width='150' class='tr02'></td>
				<td id='6_7' height='10' width='150' class='tr02'></td>
			</tr>
			<tr class='tr01' >
				<td id='7_0' height='10' width='200' colspan="2" class='tr01'>合计</td>
				<td id='7_1' height='10' width='150' class='tr01'></td>
				<td id='7_2' height='10' width='150' class='tr01'></td>
				<td id='7_3' height='10' width='150' class='tr01'></td>
				<td id='7_4' height='10' width='150' class='tr01'></td>
				<td id='7_5' height='10' width='150' class='tr01'></td>
				<td id='7_6' height='10' width='150' class='tr01'></td>
			</tr>
		</table>
		 -->
	</div>
</body>
</html>
