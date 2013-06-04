<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.download.Tree_list"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Tree_list tl = new Tree_list();
String tree = tl.getTree();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>>		
	</head>
  
<body body style="background-color:#FFFFFF">
<script type="text/javascript">	
	
Ext.onReady(function(){ 
	Ext.QuickTips.init();
	
	var tree = new Ext.tree.TreePanel({
		region: 'west',
		width: 150,
		autoHeight: true,
		loadMask: true,
		collapsible: false,
		rootVisible: false,
		border: false,
		loader: new Ext.tree.TreeLoader() 
	});
	
	var root = new Ext.tree.AsyncTreeNode({
		id: 'config',
		children: [<%=tree%>]
	});

	tree.setRootNode(root);

	var panel = new Ext.form.FormPanel({
		region: 'center',
		title: '下载浏览',
		header: false,
		frame: true,
		html: "<iframe id='iframe' width='100%' height='100%' src='model/download/download_service.jsp?type=1'></iframe>"
	});
	
	tree.on('click', function(node){
		var id = node.id;
		var value=node.text;	
		//alert(value)
		document.getElementById("iframe").src = "model/download/download_service.jsp?type="+id+"&value="+value;
    });

	
	var viewport = new Ext.Viewport({
		layout: 'border',
		items:[tree,panel]
	})

});
</script>

</body>
</html>