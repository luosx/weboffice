<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>

<%
	String path = request.getContextPath();
   String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   
   Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
    String userName = ((User) principal).getUsername();
	String fullName = ((User) principal).getFullName();
	String buttonHidden="la,delete";
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
	    var temp='';
	     var temp2='';
	    var buttonHidden;
Ext.onReady(function(){
     putClientCommond("xfaj","getTodoList");
     putRestParameter("fullName",escape(escape("<%=fullName%>")));
	myData = restRequest();
//----------------------------------------------------

var chaxunData=[
                {TEXT:'上级交办',VALUE:'上级交办'},
                {TEXT:'转办',VALUE:'转办'},
                 {TEXT:'群众上访',VALUE:'群众上访'},
                 {TEXT:'其他',VALUE:'其他'}
                ];
var dtServiceData= new Ext.data.JsonStore({
		data: chaxunData,
		fields: ["TEXT","VALUE"]
	});
	
	var ss='';
	var chaData=[
                 {TEXT:'无',VALUE:'5'}
                ];
var dtS= new Ext.data.JsonStore({
		data: chaData,
		fields: ["TEXT","VALUE"]
	});
	
	   var Combo1 = new Ext.form.ComboBox({
			    id:'Combo1',
                store: dtServiceData,
                mode:"local", 
                displayField:'TEXT',
	            valueField: 'VALUE',
	            //hiddenName: "URL",
	            //emptyText:'请选择图层...',
                accelerate: true,
                triggerAction:'all',
                editable:false ,
			        listeners:{
				    	'select':function(){ 
			 			    Ext.getCmp("Combo2").getStore().clearData();
			 				Ext.getCmp("Combo2").clearValue();
			        		temp = Ext.getCmp("Combo1").getValue();
			        		
			        	  // var landData=getData(temp);
			        	   if(temp=='上级交办'){
			        	   ss=  [{TEXT:'国土资源部',VALUE:'国土资源部'},
			        	         {TEXT:'土地督察局',VALUE:'土地督察局'},
			        	          {TEXT:'省国土资源厅',VALUE:'省国土资源厅'}, 
			        	           {TEXT:'市政府',VALUE:'市政府'}];
			        	   dtS.loadData(ss);
			        	  // landStore.loadData(landData[0]);     
			        	   }else if(temp=='转办'){
			        	   ss=[ {TEXT:'12345',VALUE:'12345'}, 
			        	      {TEXT:'新闻媒体',VALUE:'新闻媒体'}];
			        	        dtS.loadData(ss);
			        	   }	      		         
			       	 	}   
			       } 
			    });
			    
			      var Combo2 = new Ext.form.ComboBox({
			        id:'Combo2',
			        store: dtS,
			        displayField:'TEXT',
	                valueField: 'VALUE',
			        editable:false,
			        typeAhead: true,
			        width:120,
			        mode: 'local',
			        forceSelection: true,
			        triggerAction: 'all',
			        emptyText:'',
			        selectOnFocus:true,
			         listeners:{
				    	'select':function(){ 
			        		temp2 = Ext.getCmp("Combo2").getValue();
			        		}}
			    });
			       
	//------------------------------------------------------------------------------
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	            {name:'YW_GUID'},
	            {name: 'WH'},
	           {name: 'LWJG'},
	           {name: 'JBDZ'},
	           {name: 'LWSJ'},
	            {name: 'XSQ'},
	           {name: 'JBLX'},
	           {name: 'CBBM_1'},
	           {name: 'CBRY'},
	            {name: 'BJQK'},
	           {name: 'INDEX'},
	           {name:'STATUS'},
	            {name:'WFINSTASKID'},
	           {name:'ACTIVITY_NAME_'}
	          
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    var width=document.body.clientWidth  ;
    var height=document.body.clientHeight - 10;
        grid = new Ext.grid.GridPanel({
           title:'信访案件待办列表',
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
            {header: '办理', dataIndex:'INDEX', width: width*0.12, sortable: true,renderer:pro}
          //  {header: '信息', dataIndex:'INDEX', width: width*0.10, sortable: false,renderer:view}
        ], 
        tbar:[     {xtype:'label',text:'选择来文类型:',width:60},
                    Combo1,
                   {xtype:'label',text:'选择类型:',width:60},
                     Combo2,
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:80,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    ],
               
        listeners:{
		       //rowdblclick: viewDetail1
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

function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
}

function viewDetail(id){
	var tbbh=myData[id].TBBH;
	window.open("<%=basePath%>web/jinan/wpzf/pdaStatus.jsp?yw_guid=" + tbbh);
}

function viewDetail1(id1,id2,id3){ 
var tbbh=store.getAt(id2).get('TBBH');
window.open("<%=basePath%>web/jinan/wpzf/pdaStatus.jsp?yw_guid=" + tbbh);
}   

function pro(id){
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/default/lacc/image/view.png' alt='办理'></a>";
}


function process(id){
	 var wfInsTaskId=myData[id].WFINSTASKID;
	var activityName=myData[id].ACTIVITY_NAME_;
	var wfInsId=myData[id].WFINSID;
	var yw_guid=myData[id].YW_GUID;
	var status=myData[id].STATUS;
	
	if(activityName=='结案'){
	if(status!=0){
	buttonHidden='la,delete';
	}else{
	 buttonHidden='delete';
	 }
	}else{
	  buttonHidden='la,delete';
	}
	var zfjcType=myData[id].ZFJCTYPE;
	var returnPath=window.location.href;
	var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&wfInsTaskId='+wfInsTaskId+'&activityName='+escape(escape(activityName))+'&zfjcType=8&wfInsId='+wfInsId+'&zfjcName='+escape(escape('信访案件查处'))+'&wfId='+zfjcType+'&returnPath='+returnPath+'&buttonHidden='+buttonHidden;  
	//window.open(url); 
	document.location.href=url;
}


function query(){
	 var keyWord=Ext.getCmp('keyword').getValue();
           keyWord=keyWord.toUpperCase();
           putClientCommond("xfaj","getTodoList");
           putRestParameter("fullName",escape(escape("<%=fullName%>")));
           putRestParameter("keyWord",escape(escape(keyWord)));
           putRestParameter("Combo1",escape(escape(temp)));
            putRestParameter("Combo2",escape(escape(temp2)));
           var myData = restRequest(); 
      	store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	             {name:'YW_GUID'},
	            {name: 'WH'},
	           {name: 'LWJG'},
	           {name: 'JBDZ'},
	           {name: 'LWSJ'},
	            {name: 'XSQ'},
	           {name: 'JBLX'},
	           {name: 'CBBM_1'},
	           {name: 'CBRY'},
	            {name: 'BJQK'},
	           {name: 'INDEX'},
	           {name:'STATUS'},
	            {name:'WFINSTASKID'},
	           {name:'ACTIVITY_NAME_'}
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
            {header: '办理', dataIndex:'INDEX', width: width*0.12, sortable: true,renderer:pro}
          //  {header: '信息', dataIndex:'INDEX', width: width*0.10, sortable: false,renderer:view}
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