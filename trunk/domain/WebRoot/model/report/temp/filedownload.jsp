<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String id = request.getParameter("id");
    String condition = request.getParameter("condition");
    String parameter = "id="+id + "&condition=" + condition;System.out.println(parameter);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>My JSP 'reportUpper.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script language="javaScript">


          
 function exporExcel(){
	window.open("exportFile.jsp?sty=excel&<%=parameter%>");
          };
          
 function exporPDF(){
	window.open("exportFile.jsp?sty=pdf&<%=parameter%>");
          };
          
 function  exportHTML(){
	window.open("exportFile.jsp?sty=html&<%=parameter%>");
          };

</script>
	</head>

	<body bgcolor="#FFFFFF" topmargin="10" leftmargin="0">
		<p class="noprint" style="float: right; margin-right: 10px">
			<img src="<%=basePath%>model/report/img/printer.png"
				onclick="print();" title="打印" style="cursor: hand" />
			<img src="<%=basePath%>model/report/img/excel.png"
				onclick="exporExcel();" title="导出Excel" style="cursor: hand" />
			<img src="<%=basePath%>model/report/img/pdf.png"
				onclick="exporPDF();" title="导出PDF" style="cursor: hand" />
			<img src="<%=basePath%>model/report/img/html.png"
				onclick="exportHTML();" title="导出HTML" style="cursor: hand" />

		</p>
	</body>
</html>
