<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.getInstance().PROJECT_NAME;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>content</title>
</head>
  <frameset id="content" name="content" cols="261,7,*" frameborder="no" border="0" framespacing="0">
    <frame id="leftv" name="left"  src="<%=basePath%>web/<%=name%>/carMonitor/carMonitor.jsp" scrolling="auto" noresize="noresize" />
    <frame id="partline" name="partline" src="<%=basePath%>web/<%=name%>/framework/pages/partline.jsp"  scrolling="no" noresize="noresize" />
     <frame id="mapView" name="mapView"  src="<%=basePath%>web/<%=name%>/tdmap/mapView.jsp" scrolling="no" noresize="noresize" />
  </frameset>
</html>