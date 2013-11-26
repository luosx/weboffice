<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="com.klspta.web.cbd.jtfx.ztt.ZttDeal"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String zttId=request.getParameter("zttbh");
String url=basePath+ZttDeal.getInstance().getMapURL(zttId);
%>

<html>
<head>
<script type="text/javascript">

</script>
</head>
<body>
<iframe src="<%=basePath%>base/fxgis/fx/tongchou.html?i=false" width="100%" height="100%"></iframe>
</body>
</html>
