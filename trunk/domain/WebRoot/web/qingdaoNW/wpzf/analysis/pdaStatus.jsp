<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid=request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>匹配分析结果</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
		<style>		
		html,body {
			font: normal 12px verdana;
			margin: 0;
			padding: 0;
			border: 0 none;
			overflow: hidden;
			height: 100%;
		}
	</style>
<script type="text/javascript">
Ext.onReady(function(){
	border =new Ext.Viewport( 
		{
		layout:"border",
		items:[
			    center =    new Ext.Panel({ 
                region: 'center',
                contentEl: 'center',
                id:'center-panel',
                collapsible: false,
                    margins:'0 0 0 0'
            }),
			{
                    region:'east',
                    contentEl: 'east',
                    id:'east-panel',
                    split:true,
                    width: 350,
                    minSize: 0,
                    maxSize: 300,
                    collapsible: true,
                    collapsed:false,
                    margins:'0 0 0 0'
                }
			  ]
		}
	);
}
);

</script>
  </head>
	<body>
		<iframe id="east"  name="east"  style="width: 100%; height: 100%;overflow: auto;"
			src="statusTab.jsp?yw_guid=<%=yw_guid %>"></iframe> 
	 	<iframe id="center" name="center"  style="width: 100%; height: 100%;overflow: auto;"
			src="<%=basePath%>base/fxgis/framework/menu.jsp?flag=1&yw_guid=<%=yw_guid%>"></iframe>
	</body>
</html>
