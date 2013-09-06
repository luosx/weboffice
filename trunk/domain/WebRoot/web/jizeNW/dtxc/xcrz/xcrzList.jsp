<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>巡查日志列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript">
		var myData;
		var grid;
		Ext.onReady(function(){
			//将是这个用户填写的巡查日志查询出来
			putClientCommond("dtxcManager", "getXcrzListByUserId");
			putRestParameter("userId", "<%=userId%>");
			myData = restRequest();
			
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'YW_GUID'},
						{name:'XCBH'},
						{name:'XCRQ'},
						{name:'XCDW'},
						{name:'XCQY'},
						{name:'XCRY'},
						{name:'SFYWF'},
						{name:'SPQK'},
						{name:'CLYJ'},
						{name:'RUNNUM1'}
					]
			});
			
			store.load({params:{start:0, limit:15}});
			width = document.body.clientWidth - 280;
			height = document.body.clientHeight * 0.995;
			
			grid = new Ext.grid.GridPanel({
				title:'巡查日志列表',
		        store: store,
		        columns: [
		        	new Ext.grid.RowNumberer(),
					{header: '巡查编号', dataIndex:'XCBH', width: 110, sortable: true},
            		{header: '巡查日期', dataIndex:'XCRQ', width: width*0.15, sortable: true},
            		{header: '巡查单位', dataIndex:'XCDW', width: 70, sortable: true},
            		{header: '巡查区域', dataIndex:'XCQY', width: width*0.2, sortable: true},
					{header: '巡查人员', dataIndex:'XCRY', width: width*0.2, sortable: true},
            		{header: '是否违法', dataIndex:'SFYWF', width: 60, sortable: true},
            		{header: '审批情况', dataIndex:'SPQK', width: width*0.2, sortable: true},
            		{header: '处理意见', dataIndex:'CLYJ', width: width*0.2, sortable: true},
            		{header:'查看', dataIndex:'RUNNUM1', width:50, renderer:view }
		        ], 
		        tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
				   		// showDetail(grid.getStore().getAt(rowIndex).data.XIANGXI);
				   		viewDetail(grid.getStore().getAt(rowIndex).data.RUNNUM1);
					}
        		},
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
		return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='web/jizeNW/dtxc/images/view.png' alt='查看'></a>";
	}
	
	function viewDetail(id){
		var keyWord=Ext.getCmp('keyword').getValue();
		var yw_guid = myData[id].YW_GUID;
		var url = "<%=basePath%>web/jizeNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=" + yw_guid + "&num=" + myData[id].RUNNUM1 + "&isView=false&choseWord=" + escape(escape(keyWord)) + "&returnPath=web/jizeNW/dtxc/xcrz/xcrzList.jsp";
		document.location.href = url;
	}
		<!--查询方法 add by 姚建林 2013-6-20-->
        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
           putClientCommond("dtxcManager","getXcrzListByUserId");
           putRestParameter("userId","<%=userId%>");
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'YW_GUID'},
						{name:'XCBH'},
						{name:'XCRQ'},
						{name:'XCDW'},
						{name:'XCQY'},
						{name:'XCRY'},
						{name:'SFYWF'},
						{name:'SPQK'},
						{name:'CLYJ'},
						{name:'RUNNUM1'}
					]
			});
          grid.reconfigure(store, new Ext.grid.ColumnModel([
            new Ext.grid.RowNumberer(),
			{header: '巡查编号', dataIndex:'XCBH', width: 110, sortable: true},
         	{header: '巡查日期', dataIndex:'XCRQ', width: width*0.15, sortable: true},
         	{header: '巡查单位', dataIndex:'XCDW', width: 70, sortable: true},
         	{header: '巡查区域', dataIndex:'XCQY', width: width*0.2, sortable: true},
			{header: '巡查人员', dataIndex:'XCRY', width: width*0.2, sortable: true},
          	{header: '是否违法', dataIndex:'SFYWF', width: 60, sortable: true},
          	{header: '审批情况', dataIndex:'SPQK', width: width*0.2, sortable: true},
          	{header: '处理意见', dataIndex:'CLYJ', width: width*0.2, sortable: true},
          	{header:'查看', dataIndex:'RUNNUM1', width:50, renderer:view }
          ]));
          	//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:15}}); 
        }
</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
		<div id="importForm"></div>
	</div>
</body>
</html>
