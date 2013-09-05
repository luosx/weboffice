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
  <frameset id="content" cols="180,7,*" frameborder="no" border="0" framespacing="0">
    <frame id="leftmenu" name="leftmenu" src="<%=basePath%>web/<%=name%>/dtxc/framework/leftmenu.jsp" scrolling="no" noresize="noresize" />
    <frame id="partline" name="partline" src="<%=basePath%>web/<%=name%>/dtxc/framework/partline.jsp"  scrolling="no" noresize="noresize" />
    <frame id="rightview" name="rightview" src="<%=basePath%>web/<%=name%>/tdMap/mapView.jsp" scrolling="auto" noresize="noresize" />
  </frameset>
</html>