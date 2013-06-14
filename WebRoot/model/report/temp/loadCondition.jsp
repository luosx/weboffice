<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ page import="java.util.Map.Entry"%>
<%@page import="com.klspta.model.report.ReportUtil"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
            
    //取出查询条件的检索信息    
    StringBuffer sb = new StringBuffer();
    Map map = request.getParameterMap();
    Iterator it = map.entrySet().iterator();
    while (it.hasNext()) {
        Entry entry = (Entry) (it.next());
        String id = entry.getKey().toString().trim();
        String value = new String(request.getParameter(id).trim().getBytes("ISO-8859-1"), "utf-8");
        int i = value.indexOf("\"");
        if (i != -1) {
            int a = value.indexOf("\"", i + 1);
            value = value.substring(i + 1, a);
        }
        sb.append(id + "=" + value);
        if (it.hasNext()) {
            sb.append("&");
        }
    }

    String id = request.getParameter("id");
    boolean isHaveChart = new ReportUtil().getReportBeanById(id).getIsHaveChart();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>report result</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		
	</head>

	<body>
		
		<script language="javaScript">
			if(<%=isHaveChart%>){
			var win;
			var height=document.body.clientWidth-360;
	        if(!win){
	            win = new Ext.Window({
					layout:'fit',
					id: 'win',
	                width:340,
	                height:370,
	                x:height,
	                y:0,
	                closeAction: 'hide',
	                html:"<iframe leftmargin='0' topmargin='0' id='myFrame' width='350' height='350' src='<%=basePath%>/model/report/chart.jsp?<%=sb.toString()%>'></iframe>",
	                plain: true
	                
	            });
				
	        }win.show();
	   	}
	   	</script>
	   	<iframe id="ifr" name="ifr" width="100%" height="100%" frameborder="0"
			src="<%=basePath%>model/report/loadReport.jsp?<%=sb.toString()%>"></iframe>
	</body>

</html>
