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
        	    myData =[
{name:'信访举报',children:[
{name:'处理状态统计',reportid:'RPT11',data_type:'实时数据',remark:'处理状态统计',data_generarion_time:'2012-07-08',parentid:'14',id:'blzt_bing.xml'},
{name:'案件合法性统计',reportid:'RPT10',data_type:'实时数据',remark:'案件合法性统计',data_generarion_time:'2012-07-08',parentid:'14',id:'xfhfxtj.xml'},
{name:'立案率统计',reportid:'RPT18',data_type:'实时数据',remark:'立案率统计',data_generarion_time:'2012-07-08',parentid:'14',id:'xflal.xml'},
{name:'立案率同比统计',reportid:'RPT19',data_type:'实时数据',remark:'立案率同比统计',data_generarion_time:'2012-07-08',parentid:'14',id:'xflaltb.xml'},
{name:'案件查处率',reportid:'RPT14',data_type:'实时数据',remark:'案件查处率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfccltj.xml'},
{name:'案件结案率',reportid:'RPT15',data_type:'实时数据',remark:'案件结案率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfjaltj.xml'},
{name:'挽回损失率',reportid:'RPT16',data_type:'实时数据',remark:'挽回损失率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfwhssltj.xml'},
{name:'案件制止率',reportid:'RPT17',data_type:'实时数据',remark:'案件制止率',data_generarion_time:'2012-07-08',parentid:'14',id:'xfzzltj.xml'}]},
{name:'卫片执法',children:[
{name:'卫片执法处理状态统计',reportid:'RPT3',data_type:'实时数据',remark:'卫片执法处理状态统计',data_generarion_time:'2012-07-08',parentid:'13',id:'987B27EABFD14EC5AE85F55D075E601B'},
{name:'卫片执法立案率',reportid:'RPT2',data_type:'实时数据',remark:'卫片执法立案率',data_generarion_time:'2012-07-08',parentid:'13',id:'6384891BD938466CBCA0B135B70D5BAA'}]},
{name:'巡查发现',children:[
{name:'巡查发现处理状态立案率',reportid:'RPT11',data_type:'实时数据',remark:'巡查发现处理状态立案率',data_generarion_time:'2012-07-08',parentid:'13',id:'239031CD3A4A4C2DB3244393B67B7C74'},
{name:'巡查发现立案率',reportid:'RPT6',data_type:'实时数据',remark:'巡查发现立案率',data_generarion_time:'2012-07-08',parentid:'13',id:'239031CD3A4A4C2DB3244393B67B7C75'}]}
];
      
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
         	'click': function(node, e){
                var id=node.attributes.id;
                var reportid=node.attributes.reportid;
                var parentid=node.attributes.parentid;
                var left=(screen.width-900)/2;
            	var top=(screen.height-600)/2;
               if(parentid=='14'){
            	  setTimeout(function()
            			  {
            				  window.open("<%=basePath%>web/xuzhouNW/tjfx/chart.jsp?xml="+id,'chart','height=600,width=900,left='+left+',top='+top+',toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
            			  }
            			  ,10);
                   
                }else if(parentid=='13'){
                		 window.open("<%=basePath%>model/report/showReport.jsp?id="+id,'chart', 'height=600, width=900, left='+left+', top='+top+', toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
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