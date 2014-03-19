<%@ page language="java" pageEncoding="UTF-8"%>

<%
    String path = request.getContextPath();
%>  
<html>
<head>
<title>请 登 录</title>
<script>
document.location.href='<%=path%>/login/login.jsp';
</script>
</head>
</html>

