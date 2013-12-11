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
    <title>写字楼列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript" src="<%=basePath%>/web/cbd/yzt/RowEditor.js"></script>
	<style type="text/css">
  		.list_title_c{height:30px; text-align:center; margin-top:3px;border-bottom:1px solid #D0D0D0;}
		.tableheader{color:#000000;font-size: 12px;height:30px;width:100%;margin-bottom:0px;border-bottom:1px solid #8DB2E3;}
	</style>
	<script type="text/javascript">
		var myData;
		var grid;
		Ext.onReady(function(){
			Ext.QuickTips.init();
			    // use RowEditor for editing
    		var editor = new Ext.ux.grid.RowEditor({
    			saveText: ' 保存 ',
            	cancelText:' 取消 '
    		});
 			window.onscroll = function(){ 
   				editor.positionButtons();
  			}
			width = document.body.clientWidth ;
			var tableWidth = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;

			//获取数据
			putClientCommond("xzlzjjc", "getXZL");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
				fields:[
	           		{name: 'BH'},
	           		{name: 'XZLMC'},
		           	{name: 'KFS'},
		           	{name: 'WYGS'},
		           	{name: 'TZF'},
		           	{name: 'KPSJ'},
		           	{name: 'YSXKZ'},
		           	{name: 'CBCS'},
		           	{name: 'ZJ'},
		           	{name: 'SJ'},
		           	{name: 'SYL'},
		           	{name: 'XIANGXI'}
				]
			});
			store.load({params:{start:0, limit:10}});
			grid = new Ext.grid.GridPanel({
				title:'写字楼列表',
		        store: store,
		        region:'center',
                margins: '0 5 5 5',
        		//hideHeaders: true,
		        columns: [
		     	   {header: '编号', dataIndex:'BH',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '写字楼名称', dataIndex:'XZLMC',width:width*0.12, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '开发商', dataIndex:'KFS',width:width*0.15, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '物业公司', dataIndex:'WYGS',width:width*0.15, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '投资方', dataIndex:'TZF',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}, 
		     	   {header: '开盘时间', dataIndex:'KPSJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '预售许可证', dataIndex:'YSXKZ',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '成本测算', dataIndex:'CBCS',width:width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '租金', dataIndex:'ZJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '售价', dataIndex:'SJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '使用率', dataIndex:'SYL',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '详细',dataIndex:'XIANGXI',width:width*0.05, sortable: false,renderer:view}
		        ], 
		        tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
        			'cellmousedown':function(grid,r,c,e){
        			  if(c==2){
        			  	 var bh=grid.getStore().getAt(r).data.XMBH;
        			 	  showLocation(bh);
        			   }
        			} 
        		},  
        		viewConfig: {
        		},      
		        stripeRows: true,
		        width:width,
		        height: height-20 ,
		        stateful: true,
		        stateId: 'grid',
		        buttonAlign:'center',
		        plugins: [editor],
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
           var keyWord=Ext.getCmp('keyword').getValue();
           putClientCommond("hxxmHandle","getQuery");
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
		           {name: 'BH'},
	           		{name: 'XZLMC'},
		           	{name: 'KFS'},
		           	{name: 'WYGS'},
		           	{name: 'TZF'},
		           	{name: 'KPSJ'},
		           	{name: 'YSXKZ'},
		           	{name: 'CBCS'},
		           	{name: 'ZJ'},
		           	{name: 'Sj'},
		           	{name: 'SYL'},
		           	{name: 'XIANGXI'}
					]
			});
          grid.reconfigure(store, new Ext.grid.ColumnModel([
		           {header: '编号', dataIndex:'BH',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '写字楼名称', dataIndex:'XZLMC',width:width*0.12, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '开发商', dataIndex:'KFS',width:width*0.15, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '物业公司', dataIndex:'WYGS',width:width*0.15, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '投资方', dataIndex:'TZF',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}, 
		     	   {header: '开盘时间', dataIndex:'KPSJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '预售许可证', dataIndex:'YSXKZ',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '成本测算', dataIndex:'CBCS',width:width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '租金', dataIndex:'ZJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '售价', dataIndex:'SJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '使用率', dataIndex:'SYL',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '详细',dataIndex:'XIANGXI',width:width*0.03, sortable: false,renderer:view}
          ]));
          	//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:10}}); 
        }

  		function view(id){
 			return "<a href='#' onclick='showDetail("+id+");return false;'><img src='base/form/images/view.png' alt='详细信息'></a>";
 		}
 		
 		function showDetail(id){
 			 var url = "<%=basePath%>web/cbd/sccsl/xzlinfotab.jsp?bh="+myData[id].BH+"&yw_guid="+myData[id].YW_GUID;  
			//document.location.href=url;
			var height = window.screen.availHeight;
			var width = window.screen.availWidth;
			window.showModalDialog(url,"","dialogWidth="+width+";dialogHeight="+height);
 		}

        function changKeyword(val){
            var key=Ext.getCmp('keyword').getValue().toUpperCase();
            if(key!=''&& val!=null){
              var temp=val.toUpperCase();
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
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
		<div id="importForm"></div>
	</div>
</body>
</html>
