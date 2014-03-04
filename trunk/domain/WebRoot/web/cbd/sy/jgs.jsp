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
	<div style="position:absolute; bottom: 20px;right: 30px" align="right"><img src="base/form/images/back1.png"  width="50px" height="50px" title="地图" onClick="javascript:window.location.href='sy.jsp'"  /></div>
   <div align="center" style="width: 100%;height: 95%">
     	<img src="web/cbd/sy/zkj.png" height="460px" width="850px" border="0" usemap="#planetmap" alt="总体设计图" />
              <map name="planetmap"  id="planetmap"><!--  
              <area shape="circle" coords="55,65,40" href ="<%=basePath%>web/cbd/jtfx/scjc/scdcb.jsp?flag=zs" alt="二手房市场监测" />  
              <area shape="circle" coords="160,65,40" href ="<%=basePath%>" alt="搬迁政策研究" /> 
              <area shape="circle"   coords="265,65,40" href ="<%=basePath%>web/cbd/sccsl/xzljcTab.jsp" alt="写字楼租金监测" />
              <area shape="circle" coords="370,65,40" href ="<%=basePath%>web/cbd/dtjc/jcmx/bbdfx/jzmjbbdfx.jsp" alt="租金保本点模型" /> 
               <area shape="circle" coords="475,65,40" href ="<%=basePath%>" alt="项目开发管理" /> 
               <area shape="circle" coords="580,65,40" href ="<%=basePath%>" alt="项目报告" /> 
               <area shape="circle" coords="685,65,40" href ="<%=basePath%>" alt="土地资产管理" /> 
               <area shape="circle" coords="790,65,40" href ="<%=basePath%>" alt="房源资产管理" /> 
              --></map>
              </div>
              <div align="center"><h3>系统总体设计图</h3></div>
</body>
</html>