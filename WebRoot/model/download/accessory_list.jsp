<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.accessory.AccessoryOperation"%>
<%@page import="com.klspta.base.util.bean.ftputil.AccessoryBean"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String ywid = request.getParameter("ywid");
if(request.getAttribute("ywid")!=null){
    ywid = request.getAttribute("ywid").toString();
}
AccessoryOperation ao = AccessoryOperation.getInstance();
List<AccessoryBean> list = ao.getAccessorylist(ywid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'accessory.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="<%=basePath%>/base/include/ajax.js"></script>
	<%@ include file="/base/include/ext.jspf"%>
  </head>
  <script>
  	function del(file_id){
		parent.Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
		  if(btn=='yes'){
			var path = "<%=basePath%>";
			    var actionName = "accessac";
			    var actionMethod = "deleteFile";
			    var parameter="file_id="+file_id;
				var result = ajaxRequest(path,actionName,actionMethod,parameter);
				if(result=='true'){
					alert("删除成功！");
					document.location.reload();
				}
		  }else{
				return false;
		  }
		});	
  	}
  </script>
<body bgcolor="#FFFFFF">
    <%
    	if(list.size()>0){
    %>
    已上传附件:<br>	
    <% 		
    	for(int i=0;i<list.size();i++){ 
    		AccessoryBean ab = list.get(i);
    %>
    	<%=ab.getFile_name()%><img src='<%=basePath%>/base/gis/images/delete.png' alt='删除' onclick="del('<%=ab.getFile_id() %>')"><br>
    <%} }%>
</body>
</html>
