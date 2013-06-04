<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Map.Entry"%>
<%@page import="com.klspta.model.report.ReportBean"%>
<%@page import="com.klspta.model.report.ReportUtil"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    
    String id = request.getParameter("id");
    ReportBean rb=new ReportUtil().getReportBeanById(id);
    String chartXmlPath = rb.getJasperPath().replace(".jasper",".xml");
    String reportbean_id = "reportChart_" + rb.getReportId();

    StringBuffer sb = new StringBuffer();
    Map maps = request.getParameterMap();
    Iterator its = maps.entrySet().iterator();
    while (its.hasNext()) {
        Entry entry = (Entry) (its.next());
        String key = entry.getKey().toString().trim();
        String value = new String(request.getParameter(key).trim().getBytes("ISO-8859-1"), "utf-8");
        int i = value.indexOf("\"");
        if (i != -1) {
            int a = value.indexOf("\"", i + 1);
            value = value.substring(i + 1, a);
        }
        sb.append(key + "=" + value);
        if (its.hasNext()) {
            sb.append("&");
        }
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>" />

		<title>chart</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/thirdres/anyChart/binaries/js/AnyChart.js"></script>
		
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf"%>
	</head>
	<script type="text/javascript" language="javascript">
      
    </script>

	<body leftmargin="0" topmargin="0">

		<script type="text/javascript" language="javascript"> 

   var result =ajaxRequest("<%=basePath%>", "<%=reportbean_id%>", "getData", "<%=sb.toString()%>");

    result = eval(result);
    var chart = new AnyChart('<%=basePath%>/base/thirdres/anyChart/binaries/swf/AnyChart.swf'); 
    chart.setXMLFile('<%=basePath%><%=chartXmlPath%>'); 
		chart.width = '100%';
		chart.height = '100%';
      /**
      *执行数据加载 add by 郭润沛 2011-6-7 须加时间间隔
      */
       setTimeout(function(){ 
        for(var j=0;j<result.length;j++){
        	//alert(result[j].length);
	       	for(var i=0;i<result[j].length;i++){
	       		//alert(result[j][i][1]);
	       		//alert(result[j][i][2]);
	       		var id = j+1;
	       		//alert(j+1);
				chart.addPoint("s"+id, "<point id='"+result[j][i][0]+"' name='"+result[j][i][1]+"' y='"+result[j][i][2]+"' />")
			}
		}
		chart.refresh()},
				2500);
				
    chart.write(); 
    </script>
	</body>
</html>
