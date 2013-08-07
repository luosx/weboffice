<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>卫片监测图斑列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>		
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style>
		input,img{vertical-align:middle;}
		html, body { 
						margin-left: 0px;
						margin-top: 0px;
						margin-right: 0px;
						margin-bottom: 0px;
			            font: normal 11px verdana;
		}
        #main-panel td {
            padding:1.5px;
        }
        .x-grid3-cell-text-visible .x-grid3-cell-inner{overflow:visible;padding:3px 3px 3px 5px;white-space:normal;}
		</style>

		<script type="text/javascript">
		var myData;
	    var grid;
	    var store;
	    var win;
	    var form;
	    var width;
	    var height;
Ext.onReady(function(){
	putClientCommond("wpzfList","getWpJctbList");
    //putRestParameter("year","2011");
	myData = restRequest();
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'JCBH'},
	           {name: 'XMC'},
	           {name: 'JCMJ'},
	           {name: 'QSX'},
	           {name: 'HSX'},
	           {name: 'XZB'},
	           {name: 'YZB'},		           
	           {name: 'YEAR'},
	           {name: 'YW_GUID'}
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    width=document.body.clientWidth ;
    height=document.body.clientHeight *0.9;
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
        	new Ext.grid.RowNumberer(),
        	{header: '监测编号', dataIndex:'JCBH', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XMC', width: width*0.11, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'JCMJ', width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: 'X坐标', dataIndex:'XZB', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: 'Y坐标', dataIndex:'YZB', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '卫片年度', dataIndex:'YEAR', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '查看', dataIndex:'YW_GUID', width: width*0.05, sortable: false,renderer:view},
            {header: '立案', dataIndex:'YW_GUID', width: width*0.05, sortable: false,renderer:lian}
        ], 
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    ],
               
        listeners:{
		       rowdblclick: viewDetail
         },   
        stripeRows: true,
        width:width,
        height: height+40,
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
        })});
    grid.render('mygrid_container');

}
)

function view(id){
 	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='images/view.png' alt='查看'></a>";
}

function viewDetail(id){
	var width = window.screen.availWidth;
	var height = window.screen.availHeight;
	window.open("<%=basePath%>base/fxgis/framework/gisViewFrame.jsp?flag=1&yw_guid="+id,"","width="+width+",height="+height);
}


function lian(id){
   return "<a href='#' onclick='startLian("+id+");return false;'><img src='images/view.png' alt='立案'></a>";
} 

function startLian(id){
	//alert(id);
	if(confirm("确定要立案吗")){
		putClientCommond("startWorkflowLacc","initWorkflow");
	    putRestParameter("zfjcType","90");
	    putRestParameter("userId", "<%=userId%>");
	    var path=restRequest();
	    document.location.href="<%=basePath%>"+path+"&edit=true";
	}else{
		return;
	}
}


function changKeyword(val){
var key=Ext.getCmp('keyword').getValue();
if(key!=''){
  if(String(val).indexOf(key)>=0){
	return val.substring(0,val.indexOf(key))+"<font color='red'><b>"+val.substring(val.indexOf(key),val.indexOf(key)+key.length)+"</b></font>"
	+val.substring(val.indexOf(key)+key.length,val.length);
 }else{
    return val;
 }
}else{
   return val;
}
}   
  
//查询
function query(){
	var keyWord = Ext.getCmp('keyword').getValue();
	keyWord=escape(escape(keyWord));
	putClientCommond("wpzfList","getWpJctbList");
	putRestParameter("keyWord",keyWord);
	var myData = restRequest(); 
	var width=document.body.clientWidth-10 ;
    var height=document.body.clientHeight - 10;
	store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'JCBH'},
	           {name: 'XMC'},
	           {name: 'JCMJ'},
	           {name: 'QSX'},
	           {name: 'HSX'},
	           {name: 'XZB'},
	           {name: 'YZB'},	           
	           {name: 'YEAR'},
	           {name: 'YW_GUID'}
	        ]
    });   
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
	grid.reconfigure(store, new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
        	{header: '监测编号', dataIndex:'JCBH', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XMC', width: width*0.11, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'JCMJ', width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: 'X坐标', dataIndex:'XZB', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: 'Y坐标', dataIndex:'YZB', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '卫片年度', dataIndex:'YEAR', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '查看', dataIndex:'YW_GUID', width: width*0.10, sortable: false,renderer:view},
            {header: '立案', dataIndex:'YW_GUID', width: width*0.10, sortable: false,renderer:lian}
	        ]));
	//重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:15}}); 
}


</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>