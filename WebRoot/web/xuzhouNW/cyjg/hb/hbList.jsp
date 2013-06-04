<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>巡查日志查看</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="<%=basePath%>/base/include/ajax.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript">
		var myData;
		var grid;
		Ext.onReady(function(){
			putClientCommond("hbjgcr", "getAllcrList");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'YW_GUID'},
						{name:'PC'},
						{name:'PFWH'},
						{name:'GD'},
						{name:'TDYT'},
						{name:'GDMJ'},
						{name:'SRR'},
						{name:'HBSJ'},
						{name:'HBJDSBH'},
						{name:'BZ'},
						{name:'RUNNUM1'}
					]
			});
			
			store.load({params:{start:0, limit:15}});
			width=document.body.clientWidth - 280;
			height = document.body.clientHeight * 0.995;
			grid = new Ext.grid.GridPanel({
		        store: store,
		        columns: [
		        	new Ext.grid.RowNumberer(),
					{header: '批次', dataIndex:'PC', width: 80, sortable: true},
            		{header: '批复文号', dataIndex:'PFWH', width: width*0.20, sortable: true},
            		{header: '供地', dataIndex:'GD', width: 100, sortable: true},
					{header: '土地用途', dataIndex:'TDYT', width: width*0.15, sortable: true},
            		{header: '供地面积', dataIndex:'GDMJ', width: 100, sortable: true},
            		{header: '受让人', dataIndex:'SRR', width: width*0.13, sortable: true},
            		{header: '划拨时间', dataIndex:'HBSJ', width: width*0.12, sortable: true},
            		{header: '划拨决定书编号', dataIndex:'HBJDSBH', width: width*0.1, sortable: true},
            		{header: '备注', dataIndex:'BZ', width: width*0.2, sortable: true},
            		{header:'查看', dataIndex:'RUNNUM1', width:50, renderer:view }
		        ], 
		        
		        tbar:[
			    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
			    			{xtype: 'button',text:'查询',handler: query}
			    ],  
		        stripeRows: true,
		        width:width + 280,
		        height: height,
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
	
	function view(id){
		return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
	}
	
	function viewDetail(id){
		var yw_guid = myData[id].YW_GUID;
		var returnPath = window.location.href;
		var url = "<%=basePath%>/web/xuzhouNW/cyjg/hb/showhb.jsp?jdbcname=YWTemplate&yw_guid=" + yw_guid;
		document.location.href = url;
	}
		
	function query(){
		var keyword = Ext.getCmp('keyword').getValue();
		putClientCommond("hbjgcr", "getcrList");
		putRestParameter("keyword", keyword);
		myData = restRequest();
		store = new Ext.data.JsonStore({
		    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
						{name:'YW_GUID'},
						{name:'PC'},
						{name:'PFWH'},
						{name:'GD'},
						{name:'TDYT'},
						{name:'GDMJ'},
						{name:'SRR'},
						{name:'HBSJ'},
						{name:'HBJDSBH'},
						{name:'BZ'},
						{name:'RUNNUM1'}
	        ]
		});
			 
		grid.reconfigure(store, new Ext.grid.ColumnModel([
        	new Ext.grid.RowNumberer(),
					{header: '批次', dataIndex:'PC', width: 80, sortable: true},
            		{header: '批复文号', dataIndex:'PFWH', width: width*0.20, sortable: true},
            		{header: '供地', dataIndex:'GD', width: 100, sortable: true},
					{header: '土地用途', dataIndex:'TDYT', width: width*0.15, sortable: true},
            		{header: '供地面积', dataIndex:'GDMJ', width: 100, sortable: true},
            		{header: '受让人', dataIndex:'SRR', width: width*0.13, sortable: true},
            		{header: '划拨时间', dataIndex:'HBSJ', width: width*0.12, sortable: true},
            		{header: '划拨决定书编号', dataIndex:'HBJDSBH', width: width*0.1, sortable: true},
            		{header: '备注', dataIndex:'BZ', width: width*0.2, sortable: true},
            		{header:'查看', dataIndex:'RUNNUM1', width:50, renderer:view }
		]));
		//重新绑定分页工具栏
		grid.getBottomToolbar().bind(store);
		//重新加载数据集
		store.load({params:{start:0,limit:15}});  			
	}
		

			
</script>

  </head>
  
<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
		<div id="importForm"></div>
	</div>
</body>
</html>
