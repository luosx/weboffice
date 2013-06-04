<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.download.GetDownloadInfoList"%>
<%@page import="com.klspta.model.download.DownloadInfoBean"%>
<%@page import="com.klspta.model.download.DownloadService"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "base/thirdres/ext/";
	String type = request.getParameter("type");
	String text = request.getParameter("value");
	if(text==null||"null".equals(text)){
	text="办事指南";
	}else{
	text=new String(text.getBytes("ISO-8859-1"), "utf-8");
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
           {name: '时间'},
           {name: '查看'}
        ]
    });   
    store.load({params:{start:0, limit:13}});   
     	grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '序号', width: 60, sortable: true},
            {header: '名称', width: 350, sortable: false},   
            {header: '时间', width: 145, sortable: false},
            {header: '查看', width: 50, sortable: false,renderer: look}        
        ],
        stripeRows: true,
        height: 405,
        title: '<span style="font-size:12px">当前位置：下载专区 > 下载服务 > <%=text %></span>', 
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 13,
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        })
    });   
    grid.render('jsydGrid');           
}) 

function look(id){ 
	 return "<a href='#' onclick='lookDetail("+id+");return false;'><img src='<%=basePath%>/base/gis/images/view.png' alt='查看'></a>";       
}

function lookDetail(id){  
	var title = myData[id][1];		 
	var date = myData[id][2];  
	var content = myData[id][4];
	var isHaveAccessory = myData[id][5]; 
	window.showModalDialog(encodeURI("<%=basePath%>/model/download/download_detail.jsp?title="+title+"&date="+date+"&content="+content+"&isHaveAccessory="+isHaveAccessory,"","dialogWidth=1000px;dialogHeight=700px;status=no;scroll=no"));                   
}

</script>
	</head>
	<body bgcolor="#FFFFFF">
		<div id="jsydGrid" style="width: 100%; height: 100%"></div>
	</body>
</html>


