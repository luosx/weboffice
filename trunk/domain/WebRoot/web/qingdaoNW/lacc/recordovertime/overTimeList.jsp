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
    <title>超时未处理记录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
	<script type="text/javascript">
		var myData;
		var grid;
		Ext.onReady(function(){
			putClientCommond("overTime", "getAll");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'ASSIGNEE'},
						{name:'OUTCOME'},
						{name:'ISDONE'},
						{name:'OUTDATE'},
						{name:'ROWNUM'}	
					]
			});
			
			store.load({params:{start:0, limit:15}});
			width=document.body.clientWidth - 10;
			height = document.body.clientHeight * 0.995;
			grid = new Ext.grid.GridPanel({
		        store: store,
		        columns: [
		        	new Ext.grid.RowNumberer(),
					{header: '处理人员', dataIndex:'ASSIGNEE', width: width*0.20, sortable: true,renderer:changKeyword},
            		{header: '处理节点名称', dataIndex:'OUTCOME', width: width*0.30, sortable: true,renderer:changKeyword},
            		{header: '是否处理', dataIndex:'ISDONE', width: width*0.25, sortable: true,renderer:changKeyword},
            		{header: '超时天数', dataIndex:'OUTDATE', width: width*0.25, sortable: true,renderer:changKeyword}
		        ], 
		        tbar:[
			    			{xtype:'label',text:'快速查找:',width:60},
			    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
			    			{xtype: 'button',text:'查询',handler: query}
			    ],  
		        stripeRows: true,
		        width:width,
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
		
		function query(){
			var keyWord = Ext.getCmp('keyword').getValue();
			//keyWord = escape(escape(keyWord));
			var compare = "ASSIGNEE#OUTCOME";
			putClientCommond("overTime","getQuery");
	        putRestParameter("keyWord", keyWord);
	        putRestParameter("compare", compare);
			myData = restRequest();
			store = new Ext.data.JsonStore({
			    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
		        fields: [
					{name:'ASSIGNEE'},
					{name:'OUTCOME'},
					{name:'ISDONE'},
					{name:'OUTDATE'},
					{name:'ROWNUM'}	
		        ]
			});
				 
			grid.reconfigure(store, new Ext.grid.ColumnModel([
	            new Ext.grid.RowNumberer(),
					{header: '处理人员', dataIndex:'ASSIGNEE', width: width*0.20, sortable: true,renderer:changKeyword},
            		{header: '处理节点名称', dataIndex:'OUTCOME', width: width*0.30, sortable: true,renderer:changKeyword},
            		{header: '是否处理', dataIndex:'ISDONE', width: width*0.25, sortable: true,renderer:changKeyword},
            		{header: '超时天数', dataIndex:'OUTDATE', width: width*0.25, sortable: true,renderer:changKeyword}
			]));
			//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:15}});  			
		}
		
	function changKeyword(val){
		
		var key=Ext.getCmp('keyword').getValue();
		if(key!='' && val != 0 && val != 1){
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
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
		<div id="importForm"></div>
	</div>
</body>
</html>
