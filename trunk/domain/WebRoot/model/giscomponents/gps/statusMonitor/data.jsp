<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.gisapp.components.gpsequipmentmanage.GpsInfoBean"%>
<%@page import="com.klspta.gisapp.components.gpsstatusmonitor.GpsStatusUtil"%>
<%@page import="com.klspta.common.util.GpsDataSort" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String extPath = basePath + "ext/";
	
	String type = request.getParameter("type");
	//String no = new String(request.getParameter("no").getBytes("ISO8859-1"),"utf-8");
	String no = request.getParameter("no");
	no = java.net.URLDecoder.decode(no,"UTF-8");
	String begin_date = request.getParameter("begin_date");
	String end_date = request.getParameter("end_date");

	GpsStatusUtil gsu = GpsStatusUtil.getInstance();
	List<GpsInfoBean> list = gsu.getGpsInfo(type,no,begin_date,end_date);
	GpsDataSort eds = new GpsDataSort();
	String data = eds.getDataSort(list);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
        <%@ include file="/ext/ext.jspf" %>
		<script src="<%=basePath%>ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<script type="text/javascript" src="gridToExcel.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>

   <style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }
    .upload-icon { background: url('<%=basePath%>ext/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;}
   </style>
   <script>

Ext.onReady(function(){
   	Ext.QuickTips.init();
	
	
    var cm = new Ext.grid.ColumnModel([
        {header:'终端类型',dataIndex:'type',sortable:true},
		{header:'编号',dataIndex:'id',sortable:true},
		{header:'经度',dataIndex:'longitude'},
		{header:'纬度',dataIndex:'latitude'},
		{header:'速度',dataIndex:'speed'},
		{header:'方向',dataIndex:'orientation'},
        //{header:'地址',dataIndex:'address'},
        {header:'时间',dataIndex:'time'}
    ]);

    var store = new  Ext.data.Store({
        proxy: new  Ext.data.PagingMemoryProxy(<%=data%>),
        reader: new Ext.data.ArrayReader({}, [
            {name: 'type'},
            {name: 'id'},
            {name: 'longitude',type:'float'},
            {name: 'latitude',type:'float'},
            {name: 'time'},
            {name: 'speed',type:'float'},
            {name: 'orientation'}
        ])
    });
    


    var linkButton = new Ext.Button({
	    text: '导出Excel',
	    handler: function() {
	        var vExportContent = Ext.getCmp('grid').getExcelXml();
	        if (Ext.isIE6 || Ext.isIE7 || Ext.isIE8 || Ext.isSafari || Ext.isSafari2 || Ext.isSafari3) {
	            var fd=Ext.get('frmDummy');
	            if (!fd) {
	                fd=Ext.DomHelper.append(Ext.getBody(),{tag:'form',method:'post',id:'frmDummy',action:'exportexcel.jsp', target:'_blank',name:'frmDummy',cls:'x-hidden',cn:[
	                    {tag:'input',name:'exportContent',id:'exportContent',type:'hidden'}
	                ]},true);
	            }
	            fd.child('#exportContent').set({value:vExportContent});
	            fd.dom.submit();
	        } else {
	            document.location = 'data:application/vnd.ms-excel;base64,'+Base64.encode(vExportContent);
	        }}
	});


    var grid = new  Ext.grid.GridPanel({
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
  
</script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="data"></div>	
	</body>
</html>


