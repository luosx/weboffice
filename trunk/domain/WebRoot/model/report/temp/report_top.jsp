<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.report.ReportUtil"%>
<%@page import="com.klspta.model.report.ReportBean"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=request.getParameter("id");
ReportBean reportBean=new ReportUtil().getInstance().getReportBeanById(id);
String reportName=reportBean.getReportName();
String parentid=reportBean.getParentid();
String parentName = ManagerFactory.getReportManage().getParentName(parentid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%=reportName %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <div style="float:left"><img src="<%=basePath%>model/report/img/report3.JPG" width="80" height="60" align="middle" valign="center">&nbsp;&nbsp;&nbsp;</div>
    <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <div style="float:center"><label style="font-size:14;font-family:微软雅黑; width="70" height="60"><b>报表类型：<%=parentName%></b></label><br>
        <label style="font-size:18;color:#B0C4DE;font-family:微软雅黑; width="70" height="60"> <%=reportName %></label>
    </div> 
  
  </body>
</html>
