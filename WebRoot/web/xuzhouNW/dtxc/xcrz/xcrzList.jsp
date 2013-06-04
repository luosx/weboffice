<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
	String userXzqh = ManagerFactory.getRoleManager().getRoleWithUserID(((User)principal).getUserID()).get(0).getXzqh();
	List childXzqhList = UtilFactory.getXzqhUtil().getChildListByParentId(userXzqh);
	List showList = new ArrayList();
	String showData = "";
	for(int i = 0; i < childXzqhList.size(); i++){
		showList.add(childXzqhList.get(i));
	}
	String[] xzqh = userXzqh.split(",");
	for(int i = 0; i < xzqh.length; i++){
		showList.add(UtilFactory.getXzqhUtil().getBeanById(xzqh[i]));
	}
	showData = UtilFactory.getXzqhUtil().generateOptionByList(showList);
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
		
			var choseLocation = new Ext.data.JsonStore({
				fields:['code', 'name'],
				data:<%=showData%>
			});
			
			var choseCombo = new Ext.form.ComboBox({
				id:'chose',
				store:choseLocation,
				displayField:'name',
				valueField:'code',
				editable:false,
				width:120,
				mode:'local',
				forceSelection:false,
				triggerAction:'all',
				emptyText:'请选择区域',
				selectOnFocus:false
			});
		
			putClientCommond("dtxc", "getXcrzListByUserId");
			putRestParameter("userId", "<%=userId%>");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'YW_GUID'},
						{name:'XCRQ'},
						{name:'XCDW'},
						{name:'XCQY'},
						{name:'XCRY'},
						{name:'XCLX'},
						{name:'SFYWF'},
						{name:'PSQK'},
						{name:'CLYJ'},
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
					{header: '巡查日期', dataIndex:'XCRQ', width: 80, sortable: true},
            		{header: '巡查单位', dataIndex:'XCDW', width: width*0.15, sortable: true},
            		{header: '巡查区域', dataIndex:'XCQY', width: 70, sortable: true},
            		{header: '巡查人员', dataIndex:'XCRY', width: width*0.2, sortable: true},
					{header: '巡查路线', dataIndex:'XCLX', width: width*0.25, sortable: true},
            		{header: '是否违法', dataIndex:'SFYWF', width: 50, sortable: true},
            		{header: '批示情况', dataIndex:'PSQK', width: width*0.2, sortable: true},
            		{header: '处理意见', dataIndex:'CLYJ', width: width*0.2, sortable: true},
            		{header:'查看', dataIndex:'RUNNUM1', width:50, renderer:view }
		        ], 
		        
		        tbar:[
			    			{xtype:'label',text:'巡查区域:',width:60},
			    			choseCombo,
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
		var url = "<%=basePath%>web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=" + yw_guid;
		document.location.href = url;
	}
		
	function query(){
		var xzqh = Ext.getCmp('chose').getValue();
		var keyword = Ext.getCmp('keyword').getValue();
		putClientCommond("dtxc", "getXcrzListByXzqh");
		putRestParameter("xzqh", xzqh);
		putRestParameter("keyword", keyword)
		myData = restRequest();
		store = new Ext.data.JsonStore({
		    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
				{name:'YW_GUID'},
				{name:'XCRQ'},
				{name:'XCDW'},
				{name:'XCQY'},
				{name:'XCRY'},
				{name:'XCLX'},
				{name:'SFYWF'},
				{name:'PSQK'},
				{name:'CLYJ'},
				{name:'RUNNUM1'}
	        ]
		});
			 
		grid.reconfigure(store, new Ext.grid.ColumnModel([
        	new Ext.grid.RowNumberer(),
			{header: '巡查日期', dataIndex:'XCRQ', width: width*0.12, sortable: true},
          	{header: '巡查单位', dataIndex:'XCDW', width: width*0.16, sortable: true},
          	{header: '巡查区域', dataIndex:'XCQY', width: width*0.12, sortable: true},
          	{header: '巡查人员', dataIndex:'XCRY', width: width*0.16, sortable: true},
			{header: '巡查路线', dataIndex:'XCLX', width: width*0.12, sortable: true},
          	{header: '是否违法', dataIndex:'SFYWF', width: width*0.16, sortable: true},
          	{header: '批示情况', dataIndex:'PSQK', width: width*0.12, sortable: true},
          	{header: '处理意见', dataIndex:'CLYJ', width: width*0.16, sortable: true},
          	{header:'查看', dataIndex:'RUNNUM1', width:width * 0.25, renderer:view }
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
