<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.accessory.AccessoryOperation"%>
<%@page import="com.klspta.base.util.bean.ftputil.AccessoryBean"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String title = new  String(request.getParameter("title").getBytes("ISO-8859-1"), "utf-8");  
String content = new  String(request.getParameter("content").getBytes("ISO-8859-1"), "utf-8");  
String date = request.getParameter("date");
String ywid = request.getParameter("isHaveAccessory");
AccessoryOperation ao = AccessoryOperation.getInstance();
List<AccessoryBean> list = ao.getAccessorylist(ywid);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%=title %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script>
		function down(file_id){
			window.open(encodeURI("<%=basePath%>/web/default/dzfj/getAccessory.jsp?file_id="+file_id));
		}
	</script>
  </head>
  
  <body>
    <h1 align="center"><%=title %></h1>
    <hr></hr>
    <div style="text-align:center"><%=date %></div>
    <p><%=content %></p><br><br>
    <%
    	if(list.size()>0){
    %>
    附件下载:<br>	
    <% 		
    	for(int i=0;i<list.size();i++){ 
    		AccessoryBean ab = list.get(i);
    %>
    	<a href="javascript:down('<%=ab.getFile_id()%>');"><%=ab.getFile_name()%></a><br>
    <%} }%>
  </body>
</html>
