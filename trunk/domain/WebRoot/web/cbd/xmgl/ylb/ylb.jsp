<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid=request.getParameter("yw_guid");
String xmmc=request.getParameter("xmmc");
String type=request.getParameter("type");
String editor=request.getParameter("editor");
if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	} else {
		xmmc = "";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>content</title>
</head>
  <frameset id="main" name="main" cols="0,9,*" frameborder="no" border="0" framespacing="0">
    <frame id="left" name="left"  src="<%=basePath%>web/cbd/xmgl/ylb/ylbTree.jsp?yw_guid=<%= yw_guid%>&xmmc=<%=xmmc%>&year=2014&type=<%=type%>&editor=<%=editor %>" scrolling="No" noresize="noresize" />
   <frame id="partline" name="partline" src="<%=basePath%>web/cbd/xmgl/ylb/partline.jsp"  scrolling="No" noresize="noresize" />
    <frame id="right" name="right" src="<%=basePath%>web/cbd/xmgl/ylb/mergepage.jsp?yw_guid=<%= yw_guid%>&xmmc=<%=xmmc%>&year=2014&type=<%=type%>&editor=<%=editor %>" />
  </frameset>
