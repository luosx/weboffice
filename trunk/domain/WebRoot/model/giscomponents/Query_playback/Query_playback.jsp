<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
        <%@ include file="../componentsbase.jspf" %>
        <%@ include file="/common/include/ext.jspf" %>
		<style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }

    .upload-icon { background: url('<%=basePath%>ext/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;}
</style>
	</head>
	<body bgcolor="#FFFFFF">
	    <div id="form-dr" style="width:30%; "></div>
		<div id="form-ct" style="width:70%; "></div>
	</body>
</html>
