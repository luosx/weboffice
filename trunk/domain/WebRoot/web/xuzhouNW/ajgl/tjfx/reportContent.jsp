<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.ManagerFactory"%>
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
		<script src="<%=basePath%>/base/include/ajax.js"></script>
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
        
        putClientCommond("reportManage","getReportListExtJson");
        putRestParameter("type","");
        putRestParameter("root","100");
	   
//        	    myData =[
//{name:'信访举报',children:[
//{name:'处理状态统计',reportid:'RPT11',data_type:'实时数据',remark:'处理状态统计',data_generarion_time:'2012-07-08',parentid:'14',id:'239031CD3A4A4C2DB3244393B67B7C72'},
//{name:'案件合法性统计',reportid:'RPT10',data_type:'实时数据',remark:'案件合法性统计',data_generarion_time:'2012-07-08',parentid:'14',id:'xfhfxtj.xml'},
//{name:'立案率统计',reportid:'RPT18',data_type:'实时数据',remark:'立案率统计',data_generarion_time:'2012-07-08',parentid:'14',id:'239031CD3A4A4C2DB3244393B67B7C73'}
//{name:'立案率同比统计',reportid:'RPT19',data_type:'实时数据',remark:'立案率同比统计',data_generarion_time:'2012-07-08',parentid:'14',id:'xflaltb.xml'},
//{name:'案件查处率',reportid:'RPT14',data_type:'实时数据',remark:'案件查处率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfccltj.xml'},
//{name:'案件结案率',reportid:'RPT15',data_type:'实时数据',remark:'案件结案率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfjaltj.xml'},
//{name:'挽回损失率',reportid:'RPT16',data_type:'实时数据',remark:'挽回损失率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfwhssltj.xml'},
//{name:'案件制止率',reportid:'RPT17',data_type:'实时数据',remark:'案件制止率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfzzltj.xml'}
//]},
//{name:'卫片执法',children:[
//{name:'卫片处理状态',reportid:'RPT12',data_type:'实时数据',remark:'卫片处理状态',data_generarion_time:'2012-07-08',parentid:'13',id:'2ba20b7741e0b0b0139b0f157d48dcaa'},
//{name:'卫片合法性状态',reportid:'RPT3',data_type:'实时数据',remark:'卫片合法性状态',data_generarion_time:'2012-07-08',parentid:'13',id:'4363216b7714bb582e5b73502c18af48'},
//{name:'卫片立案率',reportid:'RPT2',data_type:'实时数据',remark:'卫片立案率',data_generarion_time:'2012-07-08',parentid:'13',id:'15fbc6ea4d58d729624cf7db1ca141e3'}]},
//{name:'巡查发现',children:[
//{name:'巡查发现立案率',reportid:'RPT11',data_type:'实时数据',remark:'巡查发现立案率',data_generarion_time:'2012-07-08',parentid:'14',id:'c6369ca16ebbc97a80e710866bd81e1'},
//{name:'巡查发现制止率',reportid:'RPT10',data_type:'实时数据',remark:'巡查发现制止率',data_generarion_time:'2012-07-08',parentid:'14',id:'b3eb41f17a50638acc5582b5f20bbde9'},
//{name:'巡查发现处理统计',reportid:'RPT7',data_type:'实时数据',remark:'巡查发现处理统计',data_generarion_time:'2012-07-08',parentid:'14',id:'239031CD3A4A4C2DB3244393B67B7C74'}
//{name:'巡查发现查处率',reportid:'RPT6',data_type:'实时数据',remark:'巡查发现查处率',data_generarion_time:'2012-07-08',parentid:'14',id:'55ff44c9a20739f332d7b1f3e8a915f5'}
///]}
//];
        myData = restRequest();
      
      
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
        	//tbar:[
        	//{xtype:'label',text:'快速查找:',width:60},
        	//{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	//{xtype: 'button',text:'查询',handler: queryReport1}
        //],
           listeners: {
         	'click': function(node, e){
                var id=node.attributes.id;
                var reportid=node.attributes.reportid;
               if(id.indexOf("xnode")<0){
            
                window.open("<%=basePath%>model/report/showReport.jsp?id="+id,'_blank', 'height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no, fullscreen=yes');
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