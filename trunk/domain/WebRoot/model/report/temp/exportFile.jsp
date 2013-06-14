<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@ page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRXlsExporterParameter"%>
<%@ page import="net.sf.jasperreports.engine.export.JRHtmlExporterParameter"%>
<%@ page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@ page import="net.sf.jasperreports.engine.JasperReport"%>
<%@ page import="net.sf.jasperreports.engine.JRRuntimeException"%>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.OutputStream"%>
<%@page import="com.klspta.model.report.impl.DataBean"%>
<%@page import="com.klspta.model.report.ReportUtil"%>
<%@page import="com.klspta.model.report.ReportBean"%>
<%
    String sty = request.getParameter("sty");
    String id = request.getParameter("id");
    String condition = request.getParameter("condition");System.out.println(condition);
    
    ReportBean reportBean = new ReportUtil().getReportBeanById(id);
    String jasperPath = reportBean.getJasperPath();
    String reportId=reportBean.getReportId();
  
    String reportFileName = application.getRealPath(jasperPath);
    File reportFile = new File(reportFileName);
    if (!reportFile.exists())
        throw new JRRuntimeException(
                "File WebappReport.jasper not found. The report design must be compiled first.");

    JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportFile.getPath());

    Map imageMap = new HashMap();
    request.getSession().setAttribute("IMAGES_MAP", imageMap);
    Map parameters = new HashMap();
    parameters.put("ReportTitle", "Address Report");
    parameters.put("BaseDir", reportFile.getParentFile());
    JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new DataBean(
            reportId, condition));

    if (sty.equals("excel")) {
        // 声明导出对象
        JRXlsExporter exporter = new JRXlsExporter();
        session.setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
        // 设置导出模板
        exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
        // 设置输出流
        exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, response.getOutputStream());
        // 设置Xls属性
        exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
        exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
        // 告诉浏览器执行导出Xls操作
        response.setHeader("Content-Disposition", "attachment;filename=gdbylfx.xls");
        response.setContentType("application/vnd.ms-excel");
        // 下面2个out的方法是为了解决tomcat输入流和输出流冲突，若不设置会报异常
        out.clear();
        out = pageContext.pushBody();
        exporter.exportReport();
    } else if (sty.equals("pdf")) {

        OutputStream outputStream = response.getOutputStream();
        //发送文件类型及编码
        response.setContentType("application/pdf");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=gdbylfx.pdf");
        JRPdfExporter exporter = new JRPdfExporter();
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
        outputStream.flush();
         out.clear();
        out = pageContext.pushBody();
        exporter.exportReport();
        outputStream.close();
    } else if (sty.equals("html")) {

        //声明导出类
        JRHtmlExporter exporter = new JRHtmlExporter();
        //设置导出jasper_print
        exporter.setParameter(JRHtmlExporterParameter.JASPER_PRINT, jasperPrint);
        //设置导出流
        exporter.setParameter(JRHtmlExporterParameter.OUTPUT_WRITER, response.getWriter());
        //设置
        exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
        //导出编码：
        exporter.setParameter(JRHtmlExporterParameter.CHARACTER_ENCODING, "utf-8");
        response.setCharacterEncoding("utf-8");
        //导出：
        response.setContentType("application/html");
        response.setHeader("Content-Disposition", "attachment;filename=gdbylfx.html");
        // 下面2个out的方法是为了解决tomcat输入流和输出流冲突，若不设置会报异常
        out.clear();
        out = pageContext.pushBody();
        exporter.exportReport();

    }
%>
