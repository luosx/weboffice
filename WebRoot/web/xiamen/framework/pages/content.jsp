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
  <frameset id="content" name="content" cols="211,9,*" frameborder="no" border="0" framespacing="0">
    <frame id="left" name="left"  src="<%=basePath%>web/<%=name%>/framework/pages/left.jsp" scrolling="No" noresize="noresize" />
    <frame id="partline" name="partline" src="<%=basePath%>web/<%=name%>/framework/pages/partline.jsp"  scrolling="No" noresize="noresize" />
    <frame id="right" name="right" src="<%=basePath%>web/<%=name%>/framework/pages/tongji.jsp" />
  </frameset>
</html>