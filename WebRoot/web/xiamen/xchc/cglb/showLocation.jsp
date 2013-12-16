<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xiamen.jcl.BuildDTPro"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid=request.getParameter("yw_guid");
String type = request.getParameter("type");
String pra = "";
if(!(type == null || type.equals("") || type.equals("null"))){
    pra = BuildDTPro.getPar(yw_guid, Integer.parseInt(type));
}
//String url=basePath+"base/fxgis/fx/FxGIS.html?debug=true&i=true&is=xq,0,parea,123.05";
String url=basePath+"base/fxgis/fx/FxGIS.html?debug=true&i=false";
url += "&"+pra;
System.out.println(url);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>中上</title>
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
  </head>
      <script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/menu.js"></script>
      <script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/flexCallback.js"></script>
      <script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
<script type="text/javascript">
	document.location.href = "<%=url%>";
</script>
  <body>

  </body>

</html>
