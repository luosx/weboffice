<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.TableStyleDefaultEdit"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "JBZR";
String keyIndex = "1";
ITableStyle its = new TableStyleDefaultEdit();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 

  <head>
    <title>My JSP 'JbbZrb.jsp' starting page</title>
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/base/include/reportEdit.jspf"%>
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
		
function getTblData(inTbl, inWindow) { 
    var rows = 0; 
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


		
  </script>
  
  <body>
  		<%=new CBDReportManager().getReport(reportID, its)%>
  </body>
</html>
