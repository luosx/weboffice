<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
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
    <title>CBD租售情况一览表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script type="text/javascript"
		src="<%=basePath%>/web/cbd/yzt/RowEditor.js"></script>
	<style type="text/css">
.list_title_c {
	height: 30px;
	text-align: center;
	margin-top: 3px;
	border-bottom: 1px solid #D0D0D0;
}

.tableheader {
	color: #000000;
	font-size: 12px;
	height: 30px;
	width: 100%;
	margin-bottom: 0px;
	border-bottom: 1px solid #8DB2E3;
}
	</style>
	<script type="text/javascript">
		var myData;
		var grid;
		Ext.onReady(function(){
			Ext.QuickTips.init();
			var editor = new Ext.ux.grid.RowEditor({
    			saveText: ' 保存 ',
            	cancelText:' 取消 '
    		});
			window.onscroll = function(){ 
   				editor.positionButtons();
  			 }
  			width = document.body.clientWidth;
			var tableWidth = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			
			putClientCommond("scjcHandle", "getScjc");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
				fields:[
	           		{name: 'SSQY'},
	           		{name: 'XH'},
		           	{name: 'XQMC'},
		           	{name: 'ESFZL'},
		           	{name: 'ESFJJ'},
		           	{name: 'ESJJZF'},
		           	{name: 'CZL'},
		           	{name: 'CZFJJ'},
		           	{name: 'CZFJJZF'},
		           	{name: 'BZ'},
		           	{name: 'YW_GUID'}
				]
			});
			store.load({params:{start:0, limit:10}});
			grid = new Ext.grid.GridPanel({
				title:'CBD住宅租售一览表',
		        store: store,
		        region:'center',
		        columns: [
		           {header: '所属区域', dataIndex:'SSQY',width: width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},       
		           {header: '序号', dataIndex:'XH', width: width*0.03, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '小区名称', dataIndex:'XQMC', width: width*0.07, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '二手房总量', dataIndex:'ESFZL',width: width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '二手房均价', dataIndex:'ESFJJ',width: width*0.07, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '二手房均价涨幅', dataIndex:'ESJJZF', width: width*0.09, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '出租量', dataIndex:'CZL',width: width*0.07, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '出租房均价', dataIndex:'CZFJJ',width: width*0.07, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '出租房均价涨幅', dataIndex:'CZFJJZF',width: width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '备注', dataIndex:'BZ',width: width*0.5, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}
		        ], 
        	tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
        		viewConfig: {
        		},      
		        stripeRows: true,
		        width:width*1.49+5,
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
         
         function toRecord(){
         
         }
         
         function toSave(obj,changes,r,num,change){
	 var cc=new Array();
     cc.push(changes);
     var result = "";
     if(change == "true"){
	     putClientCommond("scjcHandle","updateScjc");
	     putRestParameter("tbbh",r.data.YW_GUID); 
	     putRestParameter("tbchanges",escape(escape(Ext.encode(cc)))); 
	     var result = restRequest();
     }
     if(result == "" || result.success){
     	Ext.Msg.alert('提示',"更新成功"); 
     }else{
     	Ext.Msg.alert('提示',"更新失败");
     }
     }
	</script>


	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
		<div id="mygrid_container" ></div>
		
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>
