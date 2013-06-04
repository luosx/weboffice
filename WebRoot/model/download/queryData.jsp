<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.download.GetDownloadInfoList"%>
<%@page import="com.klspta.model.download.DownloadInfoBean"%>
<%@page import="com.klspta.model.download.GetDownloadQueryResult"%>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    String content = request.getParameter("content");
    content = java.net.URLDecoder.decode(content, "UTF-8");
    GetDownloadInfoList gdil = new GetDownloadInfoList();
    List<DownloadInfoBean> list = gdil.getAllDownloadInfoList();
    GetDownloadQueryResult gdqr = new GetDownloadQueryResult();
    String data = gdqr.getGpsQueryDateResult(list);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf"%>
		<script
			src="<%=extPath%>/examples/ux/fileuploadfield/FileUploadField.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="gridToExcel.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=extPath%>/examples/ux/fileuploadfield/css/fileuploadfield.css" />
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>

		<style type="text/css">
html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 100%;
}

.upload-icon {
	background:
		url('<%=extPath%>/examples/shared/icons/fam/image_add.png')
		no-repeat 0 0 !important;
}
</style>
		<script>
var data = <%=data%>;
var grid;
var title;
Ext.onReady(function(){
   	Ext.QuickTips.init();
	
	
    var cm = new Ext.grid.ColumnModel([
		{header:'标题'},
		{header:'发布人员'},
		{header:'发布部门'},
		{header:'发布日期',sortable:true},
		{header:'类别'},
        {header:'编辑内容', renderer:view},
        {header:'删除', renderer: del}		
    ]);
	var width=document.body.clientWidth-10;
    var store = new  Ext.data.ArrayStore({
        proxy: new  Ext.data.PagingMemoryProxy(data),
        remoteSort: true,
        fields: [
            {name: '标题',width: width*0.15, sortable: false},
            {name: '发布人员',width: width*0.15, sortable: false},
            {name: '发布部门',width: width*0.15, sortable: false},
            {name: '发布日期',width: width*0.15, sortable: false},
            {name: '类别',width: width*0.15, sortable: false},
            {name: 'view',width: width*0.15, sortable: false},
            {name: 'del',width: width*0.1, sortable: false},
        ]
    });
    


    var linkButton = new Ext.Button({
	    text: '新增',
	    handler: function() {
	    	window.open("<%=basePath%>/model/download/addNewDownload.jsp?flag=1&uuid=");
	    }
	});

    grid = new  Ext.grid.GridPanel({
    	id:'grid',
    	renderTo:'data',
        height: 328,
        region: 'center',
        store: store,
        cm: cm,
        tbar: new Ext.Toolbar({buttons: [linkButton]}),
		bbar: new Ext.PagingToolbar({
			pageSize:10,
			store:store,
			displayInfo:true,
			displayMsg:'显示第{0}条到第{1}条记录，一共{2}条记录',
			emptyMsg:'没有记录'
		}),
		viewConfig:{forceFit:true}
    });
	store.load({params:{start:0,limit:10}});
  
});
/*处理删除操作*/
function del(id){
	return "<a href='#' onclick='delteTask("+id+");return false;'><img src='<%=basePath%>base/gis/images/delete.png' alt='删除'></a>";
}

function delteTask(id){
var yw_guid = data[id][8]
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
  if(btn=='yes'){
		var ds = grid.getStore(); 
		var selectedRow = ds.getAt(id); 
		ds.remove(selectedRow); 
		var path = "<%=basePath%>";
	    var actionName = "delRecord";
	    var actionMethod = "deleteTask";
	    var parameter="yw_guid="+yw_guid;
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		//document.location.reload();
  }else{
		return false;
  }
});
}

/*处理查看操作*/
function view(id){
	return "<a href='#' onclick='viewDetail(" + id + ");return false;'><img src='<%=basePath%>base/gis/images/view.png' alt='查看'></a>";
}
function viewDetail(id){
	var ywid = data[id][8];
	window.open("<%=basePath%>/model/download/addNewDownload.jsp?flag=2&ywid="+ywid);   
}  
</script>
	</head>
	<body bgcolor="#FFFFFF">
		<div id="data"></div>
	</body>
</html>


