<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid=request.getParameter("yw_guid");
StringBuffer tabl=new CBDReportManager().getReport("FYZC");
String table = tabl.toString();
String [] start=table.split("</table>");
String add="<tr ><td align='center' height='10' width='10'><input id='mc' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='gzfy' type='text'/></td>"+
			"<td align='center' height='10' width='10'><input id='gzgm' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='cbzj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='gzdj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lyfy' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lygm' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='qmfy' type='text'/></td>"+
			"<td align='center' height='10' width='10'><input id='jzmj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='zyzj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='pmft' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lyft' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='clft' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='ze' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='jhcb' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='xj' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='dj' type='text' /></td>"+
		"</tr>";
String all=start[0]+add+"</table>";
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
    background-color: #A9A9A9;
   }
  .trsingle{
    background-color: #F8F8FF;
    line-height: 20px;
    text-align:center;
    font-size: 15px;
   }
  .tr01{
  	background-color: #C0C0C0;
    line-height: 20px;
    text-align:center;
  }
  .tr02{
  	background-color: #FFFF00;
    line-height: 20px;
    text-align:center;
  }
  .tr03{
  	background-color: #87CEEB;
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

	function save(){
	var mc=document.getElementById("mc").value;
	var gzfy=document.getElementById("gzfy").value;
	var gzgm=document.getElementById("gzgm").value;
	var cbzj=document.getElementById("cbzj").value;
	var gzdj=document.getElementById("gzdj").value;
	var lyfy=document.getElementById("lyfy").value;
	var lygm=document.getElementById("lygm").value;
	var qmfy=document.getElementById("qmfy").value;
	var jzmj=document.getElementById("jzmj").value;
	var zyzj=document.getElementById("zyzj").value;
	var pmft=document.getElementById("pmft").value;
	var lyft=document.getElementById("lyft").value;
	var clft=document.getElementById("clft").value;
	var ze=document.getElementById("ze").value;
	var jhcb=document.getElementById("jhcb").value;
	var xj=document.getElementById("xj").value;
	var dj =document.getElementById("dj ").value;
	putClientCommond("xmmanager","saveBLGC");
	putRestParameter("yw_guid","<%=yw_guid%>");
	putRestParameter("xh",xh);
	putRestParameter("sj",sj);
	putRestParameter("sjbl",sjbl);
	putRestParameter("bmjbr",bmjbr);
	putRestParameter("bz",bz);
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	}
			
  </script>
  <body>
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="javascript:print();"  />
	</div>
	<div>
		<%=all%>
	</div>
	<div id="addtable"  align="left" >
		<button onclick="save()">保存</button>
	</div>
	
  		
  </body>
</html>
