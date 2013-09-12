<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
    
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>执法监察线索管理</title>
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
	    var _$ID = '';
		Ext.onReady(function(){
		   	putClientCommond("xfjbManager","getAllDCLList");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort: true,
				fields:[
		           {name:'YW_GUID'},//YW_GUID
		           {name: 'XSH'},//线索号
		           {name: 'XSLX'},//线索类型
		           {name: 'BLFS'},//办理方式
		           {name: 'JBR'},//举报人
		           {name: 'BJBDW'},//被举报单位
		           {name: 'DJSJ'}//登记时间
				]
			});
    		store.load({params:{start:0, limit:13}});
    		var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    		var width=document.body.clientWidth;
    		var height=document.body.clientHeight;
        	grid = new Ext.grid.GridPanel({
          		title:'信访案件办理中列表',
        		store: store,
        		sm:sm,
        		columns: [
        			new Ext.grid.RowNumberer(),
        			{header: '线索号', dataIndex:'XSH', width:170, sortable: true},
		        	{header: '线索类型', dataIndex:'XSLX', width:100, sortable: true},
		            {header: '办理方式', dataIndex:'BLFS', width:80, sortable: true},
		            {header: '举报人', dataIndex:'JBR', width:80, sortable: true},
		            {header: '被举报单位', dataIndex:'BJBDW', width: width*0.48, sortable: true},
		            {header: '登记时间', dataIndex:'DJSJ', width:100, sortable: true},
		            {header: '查看', dataIndex:'YW_GUID', width:40, renderer:pro}
        		], 
        		tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:300,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',width:50,handler: query},
	    			{xtype: 'button',text:'新增信访',width:60,handler: add}
	    		],
        		listeners:{
        			rowdblclick : function(grid, rowIndex, e)
					{
				   		process(grid.getStore().getAt(rowIndex).data.YW_GUID);
					}
         		},   
        		stripeRows: true,
        		width:width,
        		height: height - 10,
        		stateful: true,
        		stateId: 'grid',
        		buttonAlign:'center',
        		bbar: new Ext.PagingToolbar({
        			pageSize: 13,
        			store: store,
        			displayInfo: true,
            		displayMsg: '共{2}条，当前为：{0} - {1}条',
            		emptyMsg: "无记录",
        			plugins: new Ext.ux.ProgressBarPager()
        		})
        	});
    		grid.render('mygrid_container');
}
);

//新增信访
function add(){
	var url = "<%=basePath%>web/jizeNW/xfjb/xfdj/xfajTab.jsp";
	document.location.href = url;
}

function pro(id){
 	return "<a href='#'onclick='process(\""+id+"\");return false;'><img src='base/form/images/view.png' alt='办理'></a>";
}

//点击查看时，查看详细信息
function process(id){
	var url = "<%=basePath%>web/jizeNW/xfjb/xfdj/xfajFrame.jsp?type=blz&yw_guid=" + id;
	document.location.href = url;
}

//模糊查询
function query(){
	var keyWord=Ext.getCmp('keyword').getValue();
   	putClientCommond("xfjbManager","getDCLListByKeyWords");
   	putRestParameter("keyword",escape(escape(keyWord)));
	var myData = restRequest();
	store = new Ext.data.JsonStore({
		proxy:new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort: true,
		fields:[
	       {name:'YW_GUID'},//YW_GUID
           {name: 'XSH'},//线索号
           {name: 'XSLX'},//线索类型
           {name: 'BLFS'},//办理方式
           {name: 'JBR'},//举报人
           {name: 'BJBDW'},//被举报单位
           {name: 'DJSJ'}//登记时间
		]
	});
    var width=document.body.clientWidth  ;
	var height=document.body.clientHeight;
	grid.reconfigure(store, new Ext.grid.ColumnModel([
		new Ext.grid.RowNumberer(),
   		{header: '线索号', dataIndex:'XSH', width:170, sortable: true},
       	{header: '线索类型', dataIndex:'XSLX', width:100, sortable: true},
        {header: '办理方式', dataIndex:'BLFS', width:80, sortable: true},
        {header: '举报人', dataIndex:'JBR', width:80, sortable: true},
        {header: '被举报单位', dataIndex:'BJBDW', width: width*0.48, sortable: true},
        {header: '登记时间', dataIndex:'DJSJ', width:100, sortable: true},
        {header: '查看', dataIndex:'YW_GUID', width:40, renderer:pro}
        ]));
        
    //重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:13}}); 
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