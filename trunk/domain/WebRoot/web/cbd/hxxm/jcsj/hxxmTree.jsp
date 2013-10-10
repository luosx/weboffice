﻿<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="com.klspta.model.resourcetree.TreeOperation"%>
<%@page import="com.klspta.base.util.UtilFactory"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String zfjcType = request.getParameter("zfjcType");
	String yw_guid = request.getParameter("yw_guid");
	String returnPath = request.getParameter("returnPath");
	if(yw_guid == null || yw_guid.equals("")){
		yw_guid = UtilFactory.getStrUtil().getGuid();
	}
	HashMap<String, String> map = new HashMap<String, String>();
	map.put("zfjcType", zfjcType);
	map.put("yw_guid", yw_guid);
	String tree = TreeOperation.getInstance().getTree(map).getContent();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>详细信息</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
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
     var border;
     var tree;
     Ext.onReady(function(){
	 //定义树
	 tree = new Ext.tree.TreePanel({
	        region: 'west',
	        id:'west_tree',
	        title: '列表',
	        collapsible: true,
	        useArrows: true,
	        autoScroll: true,
	        animate: false,
	        enableDD: true,
	        autoHeight: false,
	        width: 200,
	        border: false,
	        margins: '2 2 0 2',
	        containerScroll: true,
	        rootVisible: false,
	        loader: new Ext.tree.TreeLoader(),
	        root: new Ext.tree.AsyncTreeNode({
	            expanded: false,
	            children: [<%=tree%>]
	        })	        	        
	    });
	    
	//定义布局形式	    
	border =new Ext.Viewport({
		layout:"border", 
		items:[tree,
				{
				 region:'center',
	             contentEl: 'center',	            
	             collapsible: false,        
	             margins:'2 2 0 0'
	            }]
		});
	//添加树的单击打开页面事件	 
	tree.on('click', function(n){
		var str = n.attributes.src;	
    	if(n.attributes.src!=null){
    		frames['center'].location='<%=basePath%>'+n.attributes.src + "?yw_guid=<%=yw_guid%>";	
     	}
    });
    //对树进行渲染  
	tree.render();
	//页面加载后树节点打开
	tree.getRootNode().expand(true);
	var rootNode=tree.getRootNode();//获取根节点
    /*让center显示资源树的第一个节点*/	 
	     var firstNode;
	     getFirstNode(rootNode);
	     function getFirstNode(node){
			  var childnodes = node.childNodes;
			  var nd=childnodes[0];
			  firstNode=nd.id;
			  if(nd.hasChildNodes()){ //判断子节点下是否存在子节点
				 getFirstNode(nd); //如果存在子节点 递归
			  } 
	     }
	     var st=tree.getNodeById(firstNode).attributes.src;
	     frames['center'].location='<%=basePath%>'+st + "?yw_guid=<%=yw_guid%>";
});

	function returnPage(){
		window.location.href = "<%=returnPath%>" ;
	}
</script>

	</head>
	<body style="background-color: white">
		<iframe id="center" name="center" style="width: 100%; height: 100%;" src=""></iframe>
		<div style="width:75px;height:25px; position:absolute; right:20px; top:10px; background:#E2EAF3; filter:alpha(opacity=100);">
			<input type="button" onClick="returnPage();return false;" style="width:75px; height:25px;" value="返  回" />
		</div>
	</body>
</html>
