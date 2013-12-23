﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  Xmmanager hxzm=Xmmanager.getXmmanager();
List<Map<String, Object>> list=hxzm.getHXXM();

%>

<html>
  <head>
    <title>CBD核心区储备开发及资金管理研究辅助决策系统</title>
   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <style type="text/css">
    
table{
border-right:1px solid #C1DAD7;
border-bottom:1px solid #C1DAD7;
background-color:  #FDEFAC;
}
table td{
border-left:1px solid #C1DAD7;
border-top:1px solid #C1DAD7;

} 
    </style>
 <script type="text/javascript">
  Ext.onReady(function() {
        
	    var tree = new Ext.tree.TreePanel({
	        useArrows:true,
	        autoScroll:true,
	        animate:true,
	        enableDD:true,
	        margins: '0 0 0 0',
	        border: false,
	        containerScroll: true,
	        rootVisible: false,
	        frame: true,
	        loader: new Ext.tree.TreeLoader(),
	        root: new Ext.tree.AsyncTreeNode({
	            expanded: true,
	            children: [
	                <%for(int i=0;i<list.size()-1;i++){%>
	            	{text:'<%=list.get(i).get("xmname")%>',leaf:1,id:'<%=list.get(i).get("yw_guid")%>'},
	            	<%}%>
	            	{text:'<%=list.get(list.size()-1).get("xmname")%>',leaf:1,id:'<%=list.get(list.size()-1).get("yw_guid")%>'}
	            ]
	        }),
	         listeners: {//单击右侧进行修改
	         'click': function(node, e){
	                var nodeid=node.attributes.id;
	                var nodetest = node.attributes.text;
	                var parentMenuTreeId;
	                if(node.leaf){
	                parentMapTreeId=node.attributes.parentId;
	                }else{
	                parentMapTreeId='0';
	                }
	                parent.right.location.href="<%=basePath%>web/cbd/xmgl/contentTab.jsp?yw_guid="+nodeid+"&xmmc="+nodetest;
	             }
	         }
	    });
	    //表单FormPanel
        var form = new Ext.form.FormPanel({
        renderTo: 'mapTree',
        title   : '项目列表',
        autoHeight: true,
        width   : 500,
       
        bodyStyle: 'padding: 0px',
        defaults: {
            anchor: '0'
        },
        items   : [
        		tree
   				]
    });
   function lint(yw_guid,xmmc){
    var url=parent.right.location.href=('<%=basePath%>web/cbd/xmgl/contentTab.jsp?yw_guid='+yw_guid+'&xmmc='+xmmc);
    document.location.reload();
    }
    });
    
    </script>
</head>
<body bgcolor="#FFFFFF" >
		<div id="mapTree"  style="width:500px;height:500px;OVERFLOW-y:auto;  "/>
	</div></body>
</html>
