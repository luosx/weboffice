<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    
    String status=request.getParameter("status");
    String flag=request.getParameter("flag");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user=null;
        if (principal instanceof User) {
            user =(User) principal;
        }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
			
		<title>执法监察总体数据预览</title>

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
		<style>
		input,img{vertical-align:middle;cursor:hand;}
		</style>
		<script type="text/javascript">
		var myData;
		var store;
		var grid;
		var _$ID = '';
		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight; 
    	var width;
Ext.onReady(function(){
	putClientCommond("anjianManager","getXcfxList");
	putRestParameter("status",<%=status%>);
    putRestParameter("flag",<%=flag%>);
	myData = restRequest();
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'GUID'},
	           {name: 'RWBH'},
	           {name: 'XMMC'},
	           {name: 'DWMC'},
	           {name: 'RWLX'},
	           {name: 'WFDD'},
	           {name: 'RWMS'},  
	           {name: 'XCQKMC'},  
	           {name: 'XCR'},  
	           {name: 'XCRQ'},  
	           {name: 'CJZB'},  
	           {name: 'JWZB'},
	           {name: 'IMGNAME'},
	           {name: 'SFWF'}, 
	           {name: 'GPSID'},  
	           {name: 'ROWNUM1'} 
	        ]
    });
    store.load({params:{start:0, limit:15}});
    width=document.body.clientWidth;
    var height = document.body.clientHeight;
  	var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        id:'gridID',
        columns: [
            //sm,
            new Ext.grid.RowNumberer(),
        	{header: '序号',dataIndex:'GUID',width: width*0.12, sortable: true},
            {header: '任务编号',dataIndex:'RWBH', width: width*0.1, sortable: true,hidden:true},
            {header: '项目名称',dataIndex:'XMMC', width: width*0.1, sortable: true},
            {header: '单位名称', dataIndex:'DWMC',width: width*0.1, sortable: true},
           // {header: '任务类型', dataIndex:'RWLX',width: width*0.1, sortable: true},
            {header: '违法地点', dataIndex:'WFDD',width: width*0.1, sortable: true},
            {header: '任务描述',dataIndex:'RWMS', width: width*0.1, sortable: true}, 
            {header: '现场情况描述', dataIndex:'XCQKMC',width: width*0.10, sortable: true}, 
            {header: '巡查人', dataIndex:'XCR',width: width*0.06, sortable: true},
            {header: '巡查时间', dataIndex:'XCRQ',width: width*0.09, sortable: false}, 
            {header: '采集坐标', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
           // {header: '照片编号', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '设备编号', dataIndex:'IMGNAME',width: width*0.04, sortable: false,hidden:true}, 
            //{header: '是否违法',dataIndex:'SFWF', width: width*0.05, sortable: true}, 
            {header: '状态', dataIndex:'SFWF',width:width*0.08, sortable: false},
            {header: '详细信息', dataIndex:'ROWNUM1',width: width*0.08, sortable: false,renderer:view}
        ],
        tbar:[
   			{xtype:'label',text:'快速查找:',width:60},
   			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
   			{xtype: 'button',text:'查询',handler: query}
	    ],
        stripeRows: true,
        height: height,
        width:width,
        stateful: true,
        stateId: 'grid',
        buttonAlign:'center',
        bbar: new Ext.PagingToolbar({
	        pageSize: 15,
	        store: store,
	        displayInfo: true,
	            displayMsg: '共{2}条，当前为：{0} - {1}条',
	            emptyMsg: "无记录",
	        plugins: new Ext.ux.ProgressBarPager()
        })	
    }); 
    grid.render('mygrid_container'); 
 });
//详细信息
function view(id){
	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
function viewDetail(id){
    var yw_guid=myData[id].GUID;
    var zfjcType=9;
    //if('<%=flag %>'=='9'){
     zfjcType=7;
    //}
    var activityName='承办';
    var url="<%=basePath%>model/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&activityName="+activityName+"&yw_guid="+yw_guid;
 	location.href=url;
 }
//查询按钮
function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("anjianManager","getXcfxList");
putRestParameter("flag","1");
putRestParameter("status",<%=status%>);
putRestParameter("keyWord",keyWord);
var myData = restRequest(); 
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'GUID'},
	           {name: 'RWBH'},
	           {name: 'XMMC'},
	           {name: 'DWMC'},
	           {name: 'RWLX'},
	           {name: 'WFDD'},
	           {name: 'RWMS'},  
	           {name: 'XCQKMC'},  
	           {name: 'XCR'},  
	           {name: 'XCRQ'},  
	           {name: 'CJZB'},  
	           {name: 'JWZB'},
	           {name: 'IMGNAME'},
	           //{name: 'SFWF'}, 
	           {name: 'GPSID'},  
	           {name: 'ROWNUM1'} 
        ]
    });
var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn}); 
grid.reconfigure(store, new Ext.grid.ColumnModel([
           	new Ext.grid.RowNumberer(),
           	{header: '序号',dataIndex:'GUID',width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '任务编号',dataIndex:'RWBH', width: width*0.1, sortable: true,hidden:true},
            {header: '项目名称',dataIndex:'XMMC', width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '单位名称', dataIndex:'DWMC',width: width*0.1, sortable: true},
            {header: '任务类型', dataIndex:'RWLX',width: width*0.1, sortable: true},
            {header: '违法地点', dataIndex:'WFDD',width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '任务描述',dataIndex:'RWMS', width: width*0.1, sortable: true,renderer:changKeyword}, 
            {header: '现场情况描述', dataIndex:'XCQKMC',width: width*0.12, sortable: true,renderer:changKeyword}, 
            {header: '巡查人', dataIndex:'XCR',width: width*0.06, sortable: true},
            {header: '巡查时间', dataIndex:'XCRQ',width: width*0.09, sortable: false,renderer:changKeyword}, 
            {header: '采集坐标', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '照片编号', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '设备编号', dataIndex:'IMGNAME',width: width*0.04, sortable: false,hidden:true}, 
            //{header: '是否违法',dataIndex:'SFWF', width: width*0.05, sortable: true}, 
            {header: '状态', dataIndex:'GPSID',width:width*0.06, sortable: false},
            {header: '详细信息', dataIndex:'ROWNUM1',width: width*0.08, sortable: false,renderer:view}
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);//
//重新加载数据集
store.load({params:{start:0,limit:15}});  
}
function changKeyword(val){
var key=Ext.getCmp('keyword').getValue();
if(key!=''){
  if(val.indexOf(key)>=0){
	return val.substring(0,val.indexOf(key))+"<font color='red'><b>"+val.substring(val.indexOf(key),val.indexOf(key)+key.length)+"</b></font>"
	+val.substring(val.indexOf(key)+key.length,val.length);
 }else{
    return val;
 }
}else{
   return val;
}
} 
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" ></div>	
	</body>
</html>
