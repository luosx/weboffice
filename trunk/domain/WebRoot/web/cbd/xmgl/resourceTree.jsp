<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>

<%@page import="com.klspta.common.util.UtilFactory"%>
<%@page import="com.klspta.common.resourcetree.TreeOperation"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    HashMap map = UtilFactory.getRequestUtil().fullRequest(request);
    String parameter = UtilFactory.getRequestUtil().getStrParameters(request);
	String tree = "{text:'开发管理模块',leaf:0,id:'1',children:[{text:'办理经过',leaf:1,id:'101',src:'web/jizeNW/lacc/lacp/lacpb.jsp?jdbcname=YWTemplate&'}, {text:'资金管理',leaf:1,id:'102',src:'web/jizeNW/lacc/cljdcp/cljdcpb.jsp?jdbcname=YWTemplate&'} ]}{text:'电子附件',leaf:1,id:'3',src:'model/accessory/dzfj/accessorymain.jsp'}";
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
    <%@ include file="/ext/ext.jspf" %>
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
	        animate: true,
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
    		if(str.substr(str.length-4,str.length)!='.jsp'){ 			
       			frames['center'].location='<%=basePath%>'+n.attributes.src+'&<%=parameter%>';
       		}else{
       			frames['center'].location='<%=basePath%>'+n.attributes.src+'?<%=parameter%>';	
       		}
     	}
    });
    //对树进行渲染  
	tree.render();
	//页面加载后树节点打开
	tree.getRootNode().expand(true);
	
	if(tree.getNodeById("101")==null){
	 frames['center'].location='<%=basePath%>'+tree.getNodeById("11").attributes.src+'?<%=parameter%>';
	}else{
     frames['center'].location='<%=basePath%>'+tree.getNodeById("101").attributes.src+'&<%=parameter%>';
    }
});
function showWindow(showUrl,width,height){
if(width==0 || height==0){
width=document.body.clientWidth;
height=document.body.clientHeight;
}
            win = new Ext.Window({
                layout:'fit',
                width:width,
                height:height,
                closable : true,
                closeAction:'close',
                shadow : true, 
                html: "<iframe id='process'  style='height:100%;width=100%;' src='"+showUrl+"' ></iframe>"
            });
        win.show(this);
}



</script>
</head>
	<body style="background-color:white">		
		<iframe id="center" name="center" style="width:100%; height:100%;" src=""></iframe>
	</body>
</html>
