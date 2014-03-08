<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userid = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>我的短信列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript">
		var myData;
		var width;
		var height;
		var store;
		var grid;
		var limitNum;
		Ext.onReady(function(){
	  		putClientCommond("dxManager","getOwnerList");
	  		putRestParameter("userid","<%=userid%>");
			myData = restRequest();			
			width = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			limitNum = parseInt(height/32);			
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'YW_GUID'},
						{name:'DXBH'},
						{name:'DXNR'},
						{name:'JSRY'},
						{name:'FSSJ'},
						{name:'FSR_NAME'},
						{name:'FSR_ID'},
						{name:'FSR_XZQH'}									
					]
			});
			store.load({params:{start:0, limit:limitNum}});
			sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});
				
			grid = new Ext.grid.GridPanel({
				title:'我的短息列表',
		        store: store,
		        sm:sm,
		        columns: [
		        new Ext.grid.RowNumberer(),
		        sm,
		        //{header: '业务主键', dataIndex:'YW_GUID', width: width*0.1 , sortable: true,hidden:true},
		        {header: '短信编号', dataIndex:'DXBH', width: width*0.1 , sortable: true},
				{header: '短信内容', dataIndex:'DXNR', width: width*0.5 , sortable: true},
				{header: '接收人员', dataIndex:'JSRY', width: width*0.25, sortable: true},		
				{header: '发送时间', dataIndex:'FSSJ', width: width*0.1, sortable: true}
				//{header: '发送人', dataIndex:'FSR_NAME', width: width*0.1,sortable: true},
				//{header: '发送人ID', dataIndex:'FSR_ID', width: width*0.1, sortable: true},		
				//{header: '发送人行政区划', dataIndex:'FSR_XZQH', width: width*0.1,sortable: true}																										
		        ],  
		        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
		        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
		        	{xtype: 'button',text:'查询',handler: query}
			    ], 
			    listeners:{
		  			rowclick : function(grid, rowIndex, e)
					{
					}
        		},
		        stripeRows: true,
		        width:width,
		        height: height-28 ,
		        stateful: true,
		        stateId: 'grid',
		        buttonAlign:'right',
		        bbar: new Ext.PagingToolbar({
			        pageSize: limitNum,
			        store: store,
			        displayInfo: true,
			            displayMsg: '共{2}条，当前为：{0} - {1}条',
			            emptyMsg: "无记录",
			        plugins: new Ext.ux.ProgressBarPager()
		        }),
		        buttons: [{
		        	text:'导出Excel',
		        	handler: expExcel
		        }]
        	});         	 				
			grid.render('mygrid_container');
	});
	
	//导出Excel
	function expExcel(){
		downloadViewData(grid);	
	}
	
	function downloadViewData(grid){		
	  if(grid.getSelectionModel().hasSelection()){
	   		var records=grid.getSelectionModel().getSelections();
			try {
				var xls = new ActiveXObject("Excel.Application");
				} catch (e) {
					alert("要打印该表，您必须安装Excel电子表格软件，同时浏览器须使用“ActiveX 控件”，您的浏览器须允许执行控件。 请点击【帮助】了解浏览器设置方法！");
					return "";  
				}
				var cm = grid.getColumnModel();
		   		var colCount = cm.getColumnCount();
		   		xls.visible = true; // 设置excel为可见
		   		var xlBook = xls.Workbooks.Add;
		   		var xlSheet = xlBook.Worksheets(1);    
		   		var temp_obj = [];
		   		// 只下载没有隐藏的列(isHidden()为true表示隐藏,其他都为显示)    
		   		for (i = 2; i < colCount; i++) {
		    		if (cm.isHidden(i) == true) {
		    		} else {
		     			temp_obj.push(i);   
		     		}
		   		}
	   			for (l = 1; l <= temp_obj.length; l++) {
	    			xlSheet.Cells(1, l).Value = cm.getColumnHeader(temp_obj[l-1]); 
	   			}
    			var store = grid.getStore();
   				var recordCount = store.getCount();
   				var view = grid.getView();
   				for (k = 1; k <= records.length; k++) {
    				for (j = 1; j <= temp_obj.length; j++) {
     					xlSheet.Cells(k + 1, j).Value = records[k-1].get(records[k-1].fields.items[j].name);
     				}		   					
				}
				xlSheet.Columns.AutoFit;
   				xls.ActiveWindow.Zoom = 75;
   				xls.UserControl = true; // 很重要,不能省略,不然会出问题 意思是excel交由用户控制
   				xls = null;
   				xlBook = null;
   				xlSheet = null;
   		    }else{
    			Ext.Msg.alert('提示','请选择短信！');
  		}
	}	
		
    function query(){
    	  var keyWord = Ext.getCmp('keyword').getValue();
		  putClientCommond("dxManager","getOwnerList");
	  	  putRestParameter("userid","<%=userid%>");
          putRestParameter("keyword",escape(escape(keyWord)));
          var myData = restRequest();
           
          store = new Ext.data.JsonStore({
		  	proxy:new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
			fields:[
				{name:'YW_GUID'},
				{name:'DXBH'},
				{name:'DXNR'},
				{name:'JSRY'},
				{name:'FSSJ'},
				{name:'FSR_NAME'},
				{name:'FSR_ID'},
				{name:'FSR_XZQH'}			
			]
		});
		
        grid.reconfigure(store, new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
		    sm,
	        //{header: '业务主键', dataIndex:'YW_GUID', width: width*0.1 , sortable: true,hidden:true},
			{header: '短信编号', dataIndex:'DXBH', width: width*0.1 , sortable: true},
			{header: '短信内容', dataIndex:'DXNR', width: width*0.5 , sortable: true},
			{header: '接收人员', dataIndex:'JSRY', width: width*0.25, sortable: true},		
			{header: '发送时间', dataIndex:'FSSJ', width: width*0.1, sortable: true}
			//{header: '发送人', dataIndex:'FSR_NAME', width: width*0.1,sortable: true},
			//{header: '发送人ID', dataIndex:'FSR_ID', width: width*0.1, sortable: true},		
			//{header: '发送人行政区划', dataIndex:'FSR_XZQH', width: width*0.1,sortable: true}			
        ]));
        //重新绑定分页工具栏
		grid.getBottomToolbar().bind(store);
		//重新加载数据集
		store.load({params:{start:0,limit:limitNum}}); 
   }
</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
</body>
</html>
