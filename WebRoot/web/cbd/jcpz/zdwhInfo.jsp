<%@ page language="java" import="java.util.*,java.lang.*"
	pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.cbd.yzt.table.TableFieldManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	String userId = ((User) principal).getUserID();
	String tablename = request.getParameter("roleId");
	String[][] head = TableFieldManager.TABLE_INF;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>基础配置-字段维护</title>
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
	    var Employee = Ext.data.Record.create([{
	        name: 'TABLENAME',
	        type: 'string'
	    }, {
	        name: 'FIELD',
	        type: 'string'
	    }, {
	        name: 'DATATYPE',
	        type: 'string'
	    },{
	        name: 'ISSHOW',
	        type: 'bool'
	    },{
	        name: 'SHOWNAME',
	        type: 'string'
	    },{
	    	name: 'ANNOTATION',
	    	type: 'string'
	    },{
	    	name: 'ISDELETE',
	    	type: 'string'
	    }]);
		Ext.onReady(function(){
			Ext.QuickTips.init();
    		var editor = new Ext.ux.grid.RowEditor({
    			saveText: ' 保存 ',
            	cancelText:' 取消 '
    		});
 			window.onscroll = function(){ 
   				editor.positionButtons();
  			 }
			width = document.body.clientWidth - 150;
			var tableWidth = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;

    	
			//获取数据
			putClientCommond("tableField", "getTableInf");
			putRestParameter("tablename","<%=tablename%>");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
				fields:[
	           		<%for(int i = 0; i < head.length - 1; i++){%>
						{name: '<%=head[i][0]%>'},
					<%}%>
						{name: '<%=head[head.length - 1][0]%>'}
				]
			});
			store.load({params:{start:0, limit:15}});
			grid = new Ext.grid.GridPanel({
		        store: store,
		        region:'center',
                margins: '0 5 5 5',
		        tbar: [{
		            text: 'Add Employee',
		            handler: function(){	                
		                var e = new Employee({
		                    TABLENAME: '<%=tablename%>',
		                    FIELD: '',
		                    DATATYPE: '',
		                    ISSHOW: true,
		                    SHOWNAME: '',
		                    ANNOTATION:''
		                });
		                editor.stopEditing();
		                store.insert(0, e);
		                grid.getView().refresh();
		                grid.getSelectionModel().selectRow(0);
		                editor.startEditing(0);
		            }
		        },{
		            ref: '../removeBtn',
		            text: 'Remove Employee',
		            disabled: true,
		            handler: function(){
		               // editor.stopEditing();
		                var s = grid.getSelectionModel().getSelections();
		                var r = s[0];
		                putClientCommond("tableField","deleteTableField");
     					putRestParameter("tablename",r.data.TABLENAME); 
     					putRestParameter("fieldname",r.data.FIELD);
     					var result = restRequest(); 
				     	if(result){
				     		Ext.Msg.alert('提示',"更新成功"); 
				     	}else{
				     		Ext.Msg.alert('提示',"更新失败");
				     		return ;
				     	}
		                for(var i = 0, r; r = s[i]; i++){
		                    store.remove(r);
		                }
		            }
		        }],
		        columns: [
					new Ext.grid.RowNumberer(),
					<%for(int i = 0; i < head.length - 1; i++){
						if(!"hiddlen".equals(head[i][2])){
							if(!"TABLENAME".equals(head[i][0])){
							    if("ISSHOW".equals(head[i][0])){%>
							    {header: '<%=head[i][2]%>', dataIndex:'<%=head[i][0]%>', width: width*<%=Float.parseFloat(head[i][1])%>, sortable: true, editor: {xtype: 'checkbox',allowBlank: true}},
							    <%}else{
							%>
							{header: '<%=head[i][2]%>', dataIndex:'<%=head[i][0]%>', width: width*<%=Float.parseFloat(head[i][1])%>, sortable: true, editor: {xtype: 'textfield',allowBlank: true}},
						<%}
					}else{%>
						{header: '<%=head[i][2]%>', dataIndex:'<%=head[i][0]%>', width: width*<%=Float.parseFloat(head[i][1])%>, sortable: true},
					<%}}}%>
		        	{header: '<%=head[head.length - 1][2]%>', dataIndex:'<%=head[head.length - 1][0]%>', width: width*<%=Float.parseFloat(head[head.length - 1][1])%>, sortable: true, editor: {xtype: 'textfield',allowBlank: true}}
		        ],         
		        stripeRows: true,
		        width:width/2+80,
		        height: height-80 ,
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
    	grid.getSelectionModel().on('selectionchange', function(sm){
        	grid.removeBtn.setDisabled(sm.getCount() < 1);
    	});
	}); 						
	     
	 function toSave(obj,changes,r,num){
     	putClientCommond("tableField","addTableField");
     	putRestParameter("tablename",r.data.TABLENAME); 
     	putRestParameter("fieldname",r.data.FIELD); 
     	putRestParameter("type",r.data.DATATYPE); 
     	putRestParameter("showname",escape(escape(r.data.SHOWNAME))); 
     	putRestParameter("isshow",r.data.FIELD); 
     	var result = restRequest(); 
     	if(result){
     		Ext.Msg.alert('提示',"更新成功"); 
     	}else{
     		Ext.Msg.alert('提示',"更新失败");
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
