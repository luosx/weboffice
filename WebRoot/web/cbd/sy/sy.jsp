<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>首页</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<style type="text/css">
	 body { background-image: url();}
	</style>
	<script type="text/javascript">
		
   </script>
</head>
<body>
   <div align="center" style="width: 100%;height: 95%">
     	<img src="web/cbd/sy/zkj.png" height="460px" width="850px" border="0" usemap="#planetmap" alt="总体设计图" />
              <map name="planetmap"  id="planetmap">  
              <area shape="circle" coords="55,65,40" href ="venus.html" alt="二手房" />  
              <area shape="circle" coords="160,65,40" href ="mercur.html" alt="搬迁" /> 
              <area shape="circle"   coords="265,65,40" href ="sun.html" alt="写字楼" />
              <area shape="circle" coords="370,65,40" href ="venus.html" alt="租金" /> 
               <area shape="circle" coords="475,65,40" href ="venus.html" alt="项目" /> 
               <area shape="circle" coords="580,65,40" href ="venus.html" alt="项目报告" /> 
               <area shape="circle" coords="685,65,40" href ="venus.html" alt="土地" /> 
               <area shape="circle" coords="790,65,40" href ="venus.html" alt="房源" /> 
              </map>
              </div>
              <div align="center"><h3>系统总体设计图</h3></div>
</body>
</html>