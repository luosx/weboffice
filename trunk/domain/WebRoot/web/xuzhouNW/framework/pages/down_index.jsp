<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.common.download.GetDownloadInfoList"%>
<%@page import="com.klspta.common.download.DownloadService"%>
<%@page import="com.klspta.common.download.DownloadInfoBean"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
	String type = request.getParameter("type");
	String text = request.getParameter("value");
	if(text==null||"null".equals(text)){
	text="办事指南";
	}
    GetDownloadInfoList gdil = new GetDownloadInfoList();
    List<DownloadInfoBean> list = gdil.getDownloadInfoList(type);
    DownloadService ds = new DownloadService();
    String data = ds.getDate(list);
  
    if(type.equals(GetDownloadInfoList.BSZN)){
    	type = "办事指南";
    }else if(type.equals(GetDownloadInfoList.SFBZ)){
    	type = "收费标准";
    }else if(type.equals(GetDownloadInfoList.JZDJ)){
    	type = "基准地价";
    }else{
        type = "办事指南";
    }
%>
<!-- 李如意 Date:2011-07-04 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/common/include/ext.jspf"%>
		<script
			src="<%=basePath%>ext/examples/ux/fileuploadfield/FileUploadField.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="gridToExcel.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>ext/examples/ux/fileuploadfield/css/fileuploadfield.css" />
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>

		<style>
html, body { 
				margin-left: 0px;
				margin-top: -25px;
				margin-right: 0px;
				margin-bottom: 0px;
	            font: normal 11px verdana;
}
</style>
<script type="text/javascript">
 var grid;
 Ext.onReady(function(){
	myData= <%=data%>;//采用json格式存储的数组
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '序号'},
           {name: '名称'},
           {name: '日期'},
           {name: '查看'}
        ]
    });   
    var width=document.body.clientWidth;
    var height=document.body.clientHeight; 
    store.load({params:{start:0, limit:5}});   
     	grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '序号', width: 0, sortable: true},
            {header: '名称', width: width*0.4, sortable: false},   
            {header: '日期', width: width*0.38, sortable: false},
            {header: '查看', width: width*0.2, sortable: false,renderer: look}        
        ],
        stripeRows: true,
        height: height,
        width:width,
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize:5,
        store: store
        })
    });   
    grid.render('jsydGrid');           
}) 

function look(id){ 
	 return "<a href='#' onclick='lookDetail("+id+");return false;'><img src='../../../gisapp/images/view.png' alt='查看'></a>";       
}

function lookDetail(id){  
	var title = myData[id][1];		 
	var date = myData[id][2];  
	var content = myData[id][4];
	var isHaveAccessory = myData[id][5]; 
	window.showModalDialog(encodeURI("<%=basePath%>/common/pages/download/download_detail.jsp?title="+title+"&date="+date+"&content="+content+"&isHaveAccessory="+isHaveAccessory,"","dialogWidth=1000px;dialogHeight=700px;status=no;scroll=no"));                   
}

</script>
	</head>
	<body bgcolor="#FFFFFF">
		<div id="jsydGrid" style="width: 100%; height: 100%"></div>
	</body>
</html>


