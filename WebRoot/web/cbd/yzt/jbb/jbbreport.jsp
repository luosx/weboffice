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
			var form=document.getElementById("attachfile");
			form.action +="?reprotId=JBZR";
			form.submit();
			/*
			    var curTbl = document.getElementById("report"); 
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
			  */
			
		}
		function getXlsFromTbl(inTblId, inWindow) { 
    try { 
        var allStr = ""; 
        var curStr = ""; 
        //alert("getXlsFromTbl"); 
        if (inTblId != null && inTblId != "" && inTblId != "null") { 
            curStr = getTblData(inTblId, inWindow); 
        } 
        if (curStr != null) { 
            allStr += curStr; 
        } 
        else { 
            alert("你要导出的表不存在！"); 
            return; 
        } 
        var fileName = getExcelFileName(); 
        doFileExport(fileName, allStr); 
    } 
    catch(e) { 
        alert("导出发生异常:" + e.name + "->" + e.description + "!"); 
    } 
} 
function getTblData(inTbl, inWindow) { 
    var rows = 0; 
    //alert("getTblData is " + inWindow); 
    var tblDocument = document; 
    if (!!inWindow && inWindow != "") { 
        if (!document.all(inWindow)) { 
            return null; 
        } 
        else { 
            tblDocument = eval(inWindow).document; 
        } 
    } 
    var curTbl = tblDocument.getElementById(inTbl); 
    var outStr = ""; 
    if (curTbl != null) { 
        for (var j = 0; j < curTbl.rows.length; j++) { 
            //alert("j is " + j); 
            for (var i = 0; i < curTbl.rows[j].cells.length; i++) { 
                //alert("i is " + i); 
                if (i == 0 && rows > 0) { 
                    outStr += " \t"; 
                    rows -= 1; 
                } 
                outStr += curTbl.rows[j].cells[i].innerText + "\t"; 
                if (curTbl.rows[j].cells[i].colSpan > 1) { 
                    for (var k = 0; k < curTbl.rows[j].cells[i].colSpan - 1; k++) { 
                        outStr += " \t"; 
                    } 
                } 
                if (i == 0) { 
                    if (rows == 0 && curTbl.rows[j].cells[i].rowSpan > 1) { 
                        rows = curTbl.rows[j].cells[i].rowSpan - 1; 
                    } 
                } 
            } 
            outStr += "\r\n"; 
        } 
    } 
    else { 
        outStr = null; 
        alert(inTbl + "不存在!"); 
    } 
    return outStr; 
} 
function getExcelFileName() { 
    var d = new Date(); 
    var curYear = d.getYear(); 
    var curMonth = "" + (d.getMonth() + 1); 
    var curDate = "" + d.getDate(); 
    var curHour = "" + d.getHours(); 
    var curMinute = "" + d.getMinutes(); 
    var curSecond = "" + d.getSeconds(); 
    if (curMonth.length == 1) { 
        curMonth = "0" + curMonth; 
    } 
    if (curDate.length == 1) { 
        curDate = "0" + curDate; 
    } 
    if (curHour.length == 1) { 
        curHour = "0" + curHour; 
    } 
    if (curMinute.length == 1) { 
        curMinute = "0" + curMinute; 
    } 
    if (curSecond.length == 1) { 
        curSecond = "0" + curSecond; 
    } 
    var fileName = "leo_zhang" + "_" + curYear + curMonth + curDate + "_" 
            + curHour + curMinute + curSecond + ".csv"; 
    //alert(fileName); 
    return fileName; 
} 
function doFileExport(inName, inStr) { 
    var xlsWin = null; 
    if (!!document.all("glbHideFrm")) { 
        xlsWin = glbHideFrm; 
    } 
    else { 
        var width = 6; 
        var height = 4; 
        var openPara = "left=" + (window.screen.width / 2 - width / 2) 
                + ",top=" + (window.screen.height / 2 - height / 2) 
                + ",scrollbars=no,width=" + width + ",height=" + height; 
        xlsWin = window.open("", "_blank", openPara); 
    } 
    xlsWin.document.write(inStr); 
    xlsWin.document.close(); 
    xlsWin.document.execCommand('Saveas', true, inName); 
    xlsWin.close(); 
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
