<%@ page language="java" pageEncoding="utf-8"%>
<%String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
  <div style="position:absolute; bottom:20px; right:20px; width:50px; height:50px;" align="right"><img src="<%=basePath%>/base/form/images/go.png" width="50px" height="50px" title="系统设计图" onClick="javascript:window.location.href='jgs.jsp'"  /></div>
<iframe  style="width: 100%;height:100%; overflow: hidden;" src='<%=basePath%>/base/fxgis/framework/gisViewFrame.jsp'></iframe>
  </body>
</html>
