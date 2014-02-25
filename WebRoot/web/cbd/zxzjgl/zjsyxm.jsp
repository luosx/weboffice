<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.dtjc.zxzjgl.ZjglManager"%>
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
	<%@ include file="/base/include/ext.jspf"%>
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
		    var curTbl = document.getElementById("XMCBZJ"); 
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
	 
	  function init(){
	   	  var xmname = document.getElementById("xmname");
		  putClientCommond("ZjglManager","getList");
		  var list = restRequest();
		  list=eval(list);
	  	  var obj=document.getElementById("tablename");
	  	  obj.innerHTML="<h1>"+list[0].XMNAME+"储备资金支出情况表</h1>";
	  	  for(var i=0;i<list.length;i++){
	  		xmname.options.add(new Option(list[i].XMNAME,list[i].XMNAME))
	  	  }
	  	  change();
	  }
	  
	  function change(){
	  	putClientCommond("ZjglManager","getReport");
	  	var obj = document.getElementById("xmname");
	  	var xmname=obj.options[obj.selectedIndex].value;
	  	var name=document.getElementById("tablename");
	  	name.innerHTML="<h1>"+xmname+"储备资金支出情况表</h1>";
	  	putRestParameter("xmname",escape(escape(xmname)));
	  	var table=document.getElementById("center");
	  	var reslut = restRequest();
		table.innerHTML = reslut;
	  }
  </script>
  <body onload="init();">
  <div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;
  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="javascript:exportExcel();"  />&nbsp;&nbsp;&nbsp;
	</div>
	<div id="tablename" align="center" style="margin-left: 10px;  width:1000px;">
	      <h1 >储备资金支出情况表</h1>
	</div>
	<div align="left" style="margin-left: 15px;  width:1000px;">
	    项目选择：<select id="xmname" onchange="change()" ></select>
	      
	</div>
	<div id="center">
		<%=new CBDReportManager().getReport("XMCBZJ",new Object[]{"公交总公司项目"})%>
	</div>
	<!-- 
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
  	  -->
  </body>
</html>
