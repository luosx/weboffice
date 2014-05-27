<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String xml = request.getParameter("xml");
String lbxx = java.net.URLDecoder.decode(request.getParameter("lbxx"),"UTF-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>chart</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="<%=basePath%>/base/thirdres/anyChart/binaries/js/AnyChart.js"></script>
	<%@include file="/base/include/restRequest.jspf" %>
  </head>
<script type="text/javascript">
	function generateXml(){
		putClientCommond("staticReport","getReportData");
		putRestParameter("xml","<%=xml%>");
		putRestParameter("lbxx",escape(escape("<%=lbxx%>")));
		restRequest();
	}

</script>
  
<body leftmargin="0" topmargin="0"  onload="generateXml()"> 

    <script type="text/javascript" language="javascript"> 
    var chart = new AnyChart('<%=basePath%>/base/thirdres/anyChart/binaries/swf/AnyChart.swf');
    chart.initText ="加载中........." 
 
    chart.setXMLFile('<%=basePath%>web/cbd/tjbb/xml/<%=xml%>'); 
       window.focus();
		chart.width = '100%';
		chart.height = '100%';
      chart.write(); 
   // chart.Refresh();
    </script> 
</body> 
</html>
