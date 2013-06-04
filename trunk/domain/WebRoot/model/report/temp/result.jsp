<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.util.*"%>
<%@ page import="net.sf.jasperreports.engine.export.*"%>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*"%>
<%@ page import="java.util.Map.Entry"%>

<%@ page import="java.io.*"%>
<%@page import="com.klspta.model.report.impl.DataBean"%>
<%@page import="com.klspta.model.report.ReportBean"%>
<%@page import="com.klspta.model.report.ReportUtil"%>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";

    //取出所有参数包括查询条件参数组成url传递给chart.jsp
    StringBuffer sb = new StringBuffer();
    Map maps = request.getParameterMap();
    Iterator its = maps.entrySet().iterator();
    while (its.hasNext()) {
        Entry entry = (Entry) (its.next());
        String id = entry.getKey().toString().trim();
        String value = new String(request.getParameter(id).trim().getBytes("ISO-8859-1"), "utf-8");
        int i = value.indexOf("\"");
        if (i != -1) {
            int a = value.indexOf("\"", i + 1);
            value = value.substring(i + 1, a);
        }
        sb.append(id + "=" + value);
        if (its.hasNext()) {
            sb.append("&");
        }
    }

    //
    String id = request.getParameter("id");
    ReportBean rb = new ReportUtil().getReportBeanById(id);
    String jasperPath = rb.getJasperPath();
    String reportId = rb.getReportId();
    String reportFileName = application.getRealPath(jasperPath);
    String condition = request.getParameter("condition");

    File reportFile = new File(reportFileName);
    if (!reportFile.exists())
        throw new JRRuntimeException(
                "File WebappReport.jasper not found. The report design must be compiled first.");

    JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportFile.getPath());
    JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, new DataBean(reportId,
            condition));

    JRHtmlExporter exporter = new JRHtmlExporter();
    session.setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);

    exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
    exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());

    exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
    exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);

    exporter.exportReport();
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
		
	</head>
	
</html>
