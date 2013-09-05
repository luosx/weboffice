<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/"; 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>统计报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		 <%@ include file="/base/include/ext.jspf" %>
		 <%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		 <script type="text/javascript" src="<%=basePath%>base/thirdres/ext/ux/treegrid/TreeGridSorter.js"></script>
        <script type="text/javascript" src="<%=basePath%>base/thirdres/ext/ux/treegrid/TreeGridColumnResizer.js"></script>
        <script type="text/javascript" src="<%=basePath%>base/thirdres/ext/ux/treegrid/TreeGridNodeUI.js"></script>
        <script type="text/javascript" src="<%=basePath%>base/thirdres/ext/ux/treegrid/TreeGridLoader.js"></script>
        <script type="text/javascript" src="<%=basePath%>base/thirdres/ext/ux/treegrid/TreeGridColumns.js"></script>
        <script type="text/javascript" src="<%=basePath%>base/thirdres/ext/ux/treegrid/TreeGrid.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/ux/treegrid/treegrid.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/common/css/query.css"/>
		<style>
		input,img{vertical-align:middle;}
		</style>
<script type="text/javascript">
        var myData;
        var scrWidth = screen.availWidth;
        var scrHeight = screen.availHeight;
        putClientCommond("reportManage","getReportListExtJson");
        putRestParameter("type","");
	    myData = restRequest();
	     var root;
 	Ext.onReady(function(){
        Ext.QuickTips.init();
        //创建treeGrid
            treeGrid = new Ext.ux.tree.TreeGrid({
        	renderTo:  Ext.getBody(),
        	enableDD: true,
            iconCls: 'your-iconCls',  
        	id:'gridID',
        	defaultType:'textfield',
        	width: document.body.clientWidth,
        	height: document.body.clientHeight*0.9,
        	columns:[
        		{header:'报名名称',dataIndex:'name',width: 230,sortable: false},
        		{header:'报名编号',dataIndex:'reportid',width: 150,sortable: false},
        		{header:'数据类型',dataIndex:'data_type',width: 200,sortable: false},
        		{header:'描述',dataIndex:'remark',width: 300,sortable: false},
        		{header:'数据生成时间',dataIndex:'data_generarion_time',width: 200,sortable: false},
        		{header:'',dataIndex:'id',sortable: false,hidden:true}
        	],
        	tbar:[
        	{xtype:'label',text:'快速查找:',width:60},
        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	{xtype: 'button',text:'查询',handler: queryReport1}
        ],
           listeners: {
         	'click': function(node, e){
                document.location.href="<%=basePath%>web/jizeWW/tjAnalyse/fxjg_main.jsp";
             }
         }
        });
         root = new Ext.tree.TreeNode({
        	text: '根节点',
       	 	expanded: true
    	});
 		treeGrid.setRootNode(root);
 		var nodes = {}; 
  nodes.children = myData;/*TreeGrid的json数据[{……},{……}]*/
 function appendChild(node, o){
  if (o.children != null && o.children.length > 0) {
   for (var a = 0; a < o.children.length; a++) {
    var n = new Ext.tree.TreeNode({
     name:o.children[a].name,
     reportid:o.children[a].reportid,
     data_type:o.children[a].data_type,
     remark:o.children[a].remark,
     data_generarion_time:o.children[a].data_generarion_time,
     parentid:o.children[a].parentid,
     id:o.children[a].id
    });
    node.appendChild(n);
    appendChild(n, o.children[a]);
   }
  }
 }
 appendChild(root, nodes);
 treeGrid.getRootNode().expand(true);
});

//查询按钮
function queryReport1(){
	var keyWord = Ext.getCmp('keyword').getValue();
	keyWord=escape(escape(keyWord)); 
	parameters="&keyWord="+keyWord;
   	//得到menu数
     putClientCommond("reportManage","getReportListExtJson");
     putRestParameter("keyWord",keyWord);
	 var myData = restRequest();
	   root = new Ext.tree.TreeNode({
        	text: '根节点',
       	 	expanded: true
    	});
 		treeGrid.setRootNode(root);
 		var nodes = {}; 
  nodes.children = myData;/*TreeGrid的json数据[{……},{……}]*/
 function appendChild(node, o){
  if (o.children != null && o.children.length > 0) {
   for (var a = 0; a < o.children.length; a++) {
    var n = new Ext.tree.TreeNode({
     name:o.children[a].name,
     reportid:o.children[a].reportid,
     data_type:o.children[a].data_type,
     remark:o.children[a].remark,
     data_generarion_time:o.children[a].data_generarion_time,
     jasperpath:o.children[a].jasperpath,
     querypath:o.children[a].querypath,
     isHaveChart:o.children[a].isHaveChart,
     id:o.children[a].id
    });
    node.appendChild(n);
    appendChild(n, o.children[a]);
     treeGrid.getRootNode().expand(true);
   }
  }
 }
 appendChild(root, nodes);
}
</script>
<script type="text/css">
.x-tree-node.your-iconCls{background-image: url(<%=basePath%>/model/report/img/r.JPG)}   
</script>
</head> 
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	</body>
</html>