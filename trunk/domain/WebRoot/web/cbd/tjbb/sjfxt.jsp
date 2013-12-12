<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/"; 
   // String tree =ManagerFactory.getReportManage().getReportListExtJson();
   //  System.out.println(tree);
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
        var scrWidth;
        var scrHeight;
        //putClientCommond("reportManage","getReportListExtJson");
        //putRestParameter("type","");
	    //myData = restRequest();

	var root;
 	Ext.onReady(function(){
        Ext.QuickTips.init();
		myData =[
			{name:'土地储备年度实施计划', id:'0',children:[
			{name:'住宅征收规模分析',reportid:'RPT1',data_type:'实时数据',remark:'描述住宅征收规模',data_generarion_time:'2013-08-23',parentid:'0',id:'zzzsgmfx.xml'},
			{name:'供应规模分析',reportid:'RPT2',data_type:'实时数据',remark:'描述供应规模',data_generarion_time:'2013-08-23',parentid:'0',id:'gygmfx.xml'},
			{name:'安置房使用情况分析',reportid:'RPT3',data_type:'实时数据',remark:'描述安置房用情况',data_generarion_time:'2013-08-23',parentid:'0',id:'azfyqkfx.xml'},
			{name:'资金使用情况分析',reportid:'RPT4',data_type:'实时数据',remark:'描述资金使用情况',data_generarion_time:'2013-08-23',parentid:'0',id:'zjsyqkfx.xml'},
			{name:'资金风险分析',reportid:'RPT5',data_type:'实时数据',remark:'描述资金风险',data_generarion_time:'2013-08-23',parentid:'0',id:'zjfxfx.xml'},
			{name:'融资需求分析',reportid:'RPT6',data_type:'实时数据',remark:'描述融资需求',data_generarion_time:'2013-08-23',parentid:'0',id:'rzxqfx.xml'},
			{name:'负债规模分析',reportid:'RPT7',data_type:'实时数据',remark:'描述负债规模',data_generarion_time:'2013-08-23',parentid:'0',id:'fzgmfx.xml'},
			{name:'投资比例分析',reportid:'RPT8',data_type:'实时数据',remark:'描述投资比例',data_generarion_time:'2013-08-23',parentid:'0',id:'tzblfx.xml'}
			]}
		];
         scrWidth = document.body.clientWidth;
         scrHeight = document.body.clientHeight;
        //创建treeGrid
            treeGrid = new Ext.ux.tree.TreeGrid({
        	renderTo:  Ext.getBody(),
        	enableDD: true,
            iconCls: 'your-iconCls',  
        	id:'gridID',
        	width: scrWidth,
        	height: scrHeight,
        	columns:[
        		{header:'报名名称',dataIndex:'name',width: 230,sortable: false},
        		{header:'报名编号',dataIndex:'reportid',width: 150,sortable: false},
        		{header:'数据类型',dataIndex:'data_type',width: 200,sortable: false},
        		{header:'描述',dataIndex:'remark',width: 300,sortable: false},
        		{header:'数据生成时间',dataIndex:'data_generarion_time',width: 200,sortable: false},
        		{header:'',dataIndex:'id',sortable: false,hidden:true}
        	],
  
           listeners: {
         	click: function(node, e){
                var id=node.attributes.id;
                var reportid=node.attributes.reportid;
                var parentid=node.attributes.parentid;
                var left=(screen.width-900)/2;
            	var top=(screen.height-600)/2;
            	if(id!='0'){
                setTimeout(function() {
		          window.open("<%=basePath%>web/cbd/tjbb/chart.jsp?xml="+id,'chart','height=600,width=900,left='+left+',top='+top+',toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
					},300);
				} 
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