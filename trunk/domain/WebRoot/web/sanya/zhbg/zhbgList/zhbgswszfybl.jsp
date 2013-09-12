<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
   String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   String dbts = UtilFactory.getConfigUtil().getConfig("sanyadb");
   Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>综合办公文件管理管理</title>
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
		   	putClientCommond("wjspHandler","getSWSZFYCLList");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort: true,
				fields:[
		           {name:'WJSPSX'},
		           {name: 'WJLX'},
		           {name: 'BLSX'},
		           {name: 'WJSQ'},
		           {name: 'BLQK'},
		           {name: 'YW_GUID'},
		           {name: 'CREATEDATE'}				
				]
			});
    		store.load({params:{start:0, limit:13}});
    		var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    		var width=document.body.clientWidth  ;
    		var height=document.body.clientHeight - 15;
        	grid = new Ext.grid.GridPanel({
          		title:'已办理案件列表',
        		store: store,
        		sm:sm,
        		columns: [
        			new Ext.grid.RowNumberer(),
		        	{header: '文件审批事项', dataIndex:'WJSPSX', width: (width - 510), sortable: true,renderer:changKeyword},
		            {header: '文件类型', dataIndex:'WJLX', width: 130, sortable: true,renderer:changKeyword},
		            {header: '办理时限', dataIndex:'BLSX', width: 80, sortable: true,renderer:changKeyword},
		            {header: '文件申请', dataIndex:'WJSQ', width: 80, sortable: true,renderer:changKeyword},
		            {header: '办理情况', dataIndex:'BLQK', width: 70, sortable: true,renderer:changKeyword},
		            {header: '创建时间', dataIndex:'CREATEDATE', width:80, sortable: true,renderer:changKeyword},
		            {header: '查看', dataIndex:'YW_GUID', width: 40, sortable: true,renderer:pro}
        		], 
        		tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:300,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',width:50,handler: query}
	    		],
        		listeners:{
	        		rowdblclick : function(grid, rowIndex, e)
						{
					   		viewDetail(rowIndex+1);
						}
         		},  
        		stripeRows: true,
        		width:width,
        		height: height,
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

function pro(id){
 	return "<a href='#'onclick='process(\""+id+"\");return false;'><img src='base/form/images/view.png' alt='办理'></a>";
}

function viewDetail(id){	
	var url = "<%=basePath%>web/sanya/zhbg/zhbgdj/wjspTab.jsp?type=swszf&yw_guid=" + myData[id-1].YW_GUID;
	document.location.href = url;	
}

//点击查看时，查看详细信息
function process(id){
	var url = "<%=basePath%>web/sanya/zhbg/zhbgdj/wjspTab.jsp?type=swszf&yw_guid=" + id;
	document.location.href = url;
	//window.open(url);
}

//模糊查询
function query(){
	var keyWord=Ext.getCmp('keyword').getValue();
   	putClientCommond("wjspHandler","getSWSZFYCLListByKeyWords");
   	putRestParameter("keyword",escape(escape(keyWord)));
	var myData = restRequest();
	store = new Ext.data.JsonStore({
		proxy:new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort: true,
		fields:[
           {name:'WJSPSX'},
           {name: 'WJLX'},
           {name: 'BLSX'},
           {name: 'WJSQ'},
           {name: 'BLQK'},
           {name: 'YW_GUID'},
           {name: 'CREATEDATE'}					
		]
	});
    var width=document.body.clientWidth  ;
	var height=document.body.clientHeight - 10;
	grid.reconfigure(store, new Ext.grid.ColumnModel([
		new Ext.grid.RowNumberer(),
        	{header: '文件审批事项', dataIndex:'WJSPSX', width: (width - 550), sortable: true,renderer:changKeyword},
            {header: '文件类型', dataIndex:'WJLX', width: 130, sortable: true,renderer:changKeyword},
            {header: '办理时限', dataIndex:'BLSX', width: 80, sortable: true,renderer:changKeyword},
            {header: '文件申请', dataIndex:'WJSQ', width: 80, sortable: true,renderer:changKeyword},
            {header: '办理情况', dataIndex:'BLQK', width: 70, sortable: true,renderer:changKeyword},
            {header: '创建时间', dataIndex:'CREATEDATE', width:80, sortable: true,renderer:changKeyword},
            {header: '查看', dataIndex:'YW_GUID', width: 40, sortable: true,renderer:pro}
        ]));    
    //重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:13}}); 
}

//给关键字添加颜色
function changKeyword(val){
      var key=Ext.getCmp('keyword').getValue();
      if(key!=''&& val!=null){
        var temp=(""+val);
        if(temp.indexOf(key)>=0){
        return val.substring(0,temp.indexOf(key))+"<B style='color:black;background-color:#CD8500;font-size:120%'>"+val.substring(temp.indexOf(key),temp.indexOf(key)+key.length)+"</B>"
          +temp.substring(temp.indexOf(key)+key.length,temp.length);
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
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
		<br/>
		</body>
</html>