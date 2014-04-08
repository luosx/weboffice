<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="com.klspta.web.cbd.jtfx.ztt.ZttDeal"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String img =  basePath + "web/cbd/framework/images/tdzcfbt.png";
	String url = basePath + ZttDeal.getInstance().getMapURL("5");
%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript">
//alert.show('<%=url%>');
//document.location.href='<%=url%>'

</script>
	</head>
	<body>
	<iframe id="center" width="100%" height="100%" src='<%=url%>'></iframe>
	<div style="position:absolute; bottom:20px; right:30px; width:30px; height:30px;border: 0"><img src=<%=img%>></div>
	</body>
</html>