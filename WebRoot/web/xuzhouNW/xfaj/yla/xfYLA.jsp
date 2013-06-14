<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
   String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	String fullName = ((User) principal).getFullName();
	String buttonHidden="la,delete,tran,back";
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
		<script src="<%=basePath%>/base/include/ajax.js"></script>
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
   putClientCommond("xfaj","getYlaList");
   putRestParameter("status","1");
   putRestParameter("fullName",escape(escape("<%=fullName%>")));
	myData = restRequest();
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'WH'},
	           {name: 'LWJG'},
	           {name: 'JBDZ'},
	           {name: 'LWSJ'},
	           {name: 'JBLX'},
	           {name: 'CBBM_1'},
	           {name: 'CBRY'},
	           {name: 'TASKID'},
	           {name: 'BJQK'},
	           {name: 'INDEX'},
	           {name:'WFINSTASKID'},
	           {name:'ACTIVITYNAME'}
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    var width=document.body.clientWidth  ;
    var height=document.body.clientHeight - 10;
        grid = new Ext.grid.GridPanel({
           title:'立案查处列表',
        store: store,
        sm:sm,
        columns: [
        	new Ext.grid.RowNumberer(),
        	  {header: '文号', dataIndex:'WH', width: width*0.22, sortable: true,renderer:changKeyword},
            {header: '县市区', dataIndex:'XSQ', width: width*0.20, sortable: true,renderer:changKeyword},
            {header: '来文时间', dataIndex:'LWSJ', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '来文机关', dataIndex:'LWJG', width: width*0.18, sortable: true,renderer:changKeyword},
            {header: '类型', dataIndex:'JBLX', width: width*0.12, sortable: true,renderer:changKeyword},
           // {header: '承办部门', dataIndex:'CBBM_1', width: width*0.12, sortable: true,renderer:changKeyword},
           // {header: '承办人员', dataIndex:'CBRY', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '查看', dataIndex:'INDEX', width: width*0.12, sortable: true,renderer:pro}
        ], 
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    ],
               
        listeners:{
		     //  rowdblclick: viewDetail1
         },   
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
        })});
    grid.render('mygrid_container');

}
);
function pro(id){
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/default/lacc/image/view.png' alt='办理'></a>";
}
function process(id){
    var wfInsTaskId=myData[id].TASKID;
	var activityName=myData[id].ACTIVITYNAME;
	var wfInsId=myData[id].WFINSID;
	var yw_guid=myData[id].YW_GUID;
	var zfjcType=myData[id].ZFJCTYPE;
	var returnPath=window.location.href;
	//var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&wfInsTaskId='+wfInsTaskId+'&activityName='+escape(escape(activityName))+'&zfjcType=7&wfInsId='+wfInsId+'&zfjcName='+escape(escape('信访案件查处'))+'&wfId='+zfjcType+'&returnPath='+returnPath+'&buttonHidden=<%=buttonHidden%>';  
	var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&wfInsTaskId='+wfInsTaskId+'&activityName='+escape(escape(activityName))+'&zfjcType=7&wfInsId='+wfInsId+'&zfjcName='+escape(escape('违法案件查处'))+'&wfId=ZFJC-1&returnPath='+returnPath+'&edit=false';  
				
	//window.open(url); 
	document.location.href=url;
}


function query(){
	var keyWord=Ext.getCmp('keyword').getValue();
           keyWord=keyWord.toUpperCase();
           putClientCommond("xfaj","getYlaList");
           putRestParameter("status","1");
           putRestParameter("fullName",escape(escape("<%=fullName%>")));
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
	store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	             {name: 'WH'},
	           {name: 'LWJG'},
	           {name: 'JBDZ'},
	           {name: 'LWSJ'},
	           {name: 'JBLX'},
	           {name: 'CBBM_1'},
	           {name: 'CBRY'},
	           {name: 'TASKID'},
	           {name: 'BJQK'},
	           {name: 'INDEX'},
	           {name:'WFINSTASKID'},
	           {name:'ACTIVITYNAME'}
	        ]
    });   
    var width=document.body.clientWidth  ;
    var height=document.body.clientHeight - 10; 
	grid.reconfigure(store, new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
         {header: '文号', dataIndex:'WH', width: width*0.22, sortable: true,renderer:changKeyword},
            {header: '县市区', dataIndex:'XSQ', width: width*0.20, sortable: true,renderer:changKeyword},
            {header: '来文时间', dataIndex:'LWSJ', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '来文机关', dataIndex:'LWJG', width: width*0.18, sortable: true,renderer:changKeyword},
            {header: '类型', dataIndex:'JBLX', width: width*0.12, sortable: true,renderer:changKeyword},
           // {header: '承办部门', dataIndex:'CBBM_1', width: width*0.12, sortable: true,renderer:changKeyword},
           // {header: '承办人员', dataIndex:'CBRY', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '查看', dataIndex:'INDEX', width: width*0.12, sortable: true,renderer:pro}
	        ]));
	//重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:15}}); 
}

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
		</body>
</html>