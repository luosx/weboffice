<%@page language="java"    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
  <head>
    <title>指挥调度监控中心</title>
    <script>
function openURL(url){
	top.center.mapView.openURL(url);
}
</script>
</head>

<frameset id="index" rows="90,*" frameborder="no" border="0"  framespacing="0" >
		<frame id="flash" name="flash" scrolling="NO" noresize src="<%=basePath%>main/menu.jsp" />
		<frame id="menu" name="menu" scrolling="NO" noresize src="<%=basePath%>flexviewer/index.jsp" />

</frameset>
</html>

