<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="com.klspta.web.cbd.jtfx.ztt.ZttDeal"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String zttId=request.getParameter("zttbh");
String url=basePath+ZttDeal.getInstance().getMapURL(zttId);
String img = basePath + "web/cbd/framework/images/cbsptl.png";
%>

<html>
<head>
<script type="text/javascript">

</script>
</head>
<body>
<iframe src="<%=basePath%>base/fxgis/fx/tongchou.html?i=false&initFunction=[{$name$:$setLayerVisiable$,$json$:$[{\\$servicename\\$:\\$cbd\\$,\\$visiableids\\$:[4]},{\\$servicename\\$:\\$cbdyx\\$,\\$visiableids\\$:[1]}]$}]" width="100%" height="100%"></iframe>
<div style="position:absolute; bottom:20px; right:30px; width:50px; height:50px;border: 0"><img src=<%=img%>></div>
</body>
</html>
