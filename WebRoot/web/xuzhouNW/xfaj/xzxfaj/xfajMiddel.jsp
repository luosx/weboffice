<%@ page language="java" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.jinan.xfaj.XfManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//获取当前登录用户
	Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	String fullName = ((User) principal).getFullName();
	String yw_guid = new XfManager().getXfajYW_GUID();
	String buttonHidden = "la,return,delete";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>" />
		<title>信访案件登记表</title>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script type="text/javascript">
	//初始化
function firstInit()
{
	 //立案操作
		 putClientCommond("startWorkflow","startWorkflow");
         putRestParameter("zfjcType","8");
         putRestParameter("yw_guid","<%=yw_guid%>");
         putRestParameter("flag","1");
         putRestParameter("lyType","XFJB");
         putRestParameter("buttonHidden","<%=buttonHidden%>");
         putRestParameter("fullName",escape(escape("<%=fullName%>")));
         var path=restRequest();
         path=eval(path);
         location.href="<%=basePath%>"+path+"&returnPath=http://localhost:8080/reduce/web/jinan/xfaj/dbxf/dbxf.jsp";
}  
</script>
	</head>
	<body onload="firstInit();">
	</body>
</html>