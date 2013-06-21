<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="com.klspta.console.user.User" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
				Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    String userid = ((User)userprincipal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>立案查处已查处</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript">
var myData;
var grid;
var width;
Ext.onReady(function(){
	putClientCommond("lacc","getajdcCompleteList");
	putRestParameter("userid","<%=userid%>");
	myData = restRequest();
    var store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
       remoteSort:true,
        fields: [
           {name: 'AJBH'},
           {name: 'QY'},
           {name: 'AY'},
           {name: 'AJLY'},
           {name: 'DSR'},
           {name: 'SLRQ'},
           {name: 'CREATE_'},
           {name: 'END_'},
           {name: 'INDEX'}
        ]
    });
    
    store.load({params:{start:0, limit:10}}); 
    
    var xflyStore = new Ext.data.JsonStore({
		fields: ['code', 'name'],
		data : [{"code":"1","name":"上级交办"},{"code":"2","name":"转办"},{"code":"3","name":"群众上访"},{"code":"4","name":"其他"}] 
	});
			    
	var childStore=new Ext.data.JsonStore({
		fields: ['code', 'name'],
		data : [] 
	});
			    
    var xflyCombo = new Ext.form.ComboBox({
		id:'xfly',
		store: xflyStore,
		displayField:'name',
		valueField: 'name',
		editable:false,
		width:120,
		mode: 'local',  
		forceSelection: false,    
		triggerAction: 'all',
		emptyText:'请选择信访来源...',
		selectOnFocus:false,
		listeners:{
			'select':function(){ 
			 Ext.getCmp("child").getStore().clearData();
			 Ext.getCmp("child").clearValue();
			 var temp = Ext.getCmp("xfly").getValue();
			 if(temp=='1'){
				 var childData=eval('[[{"code":"1","name":"国土资源部"},{"code":"1","name":"土地督察局"},{"code":"1","name":"国土资源厅"},{"code":"1","name":"市政府"}]]');	
				 childStore.loadData(childData[0]) 		 	
			 }else if(temp=='2'){
			 	 var childData=eval('[[{"code":"2","name":"12345"},{"code":"2","name":"新闻媒体"}]]');	
			 	 childStore.loadData(childData[0]) 		 	
			 }   			 		      		         
			}   
		} 
		});
			    
	var childCombo = new Ext.form.ComboBox({
		id:'child',
		store: childStore,
		displayField:'name',
		valueField: 'name',
		editable:false,
		typeAhead: true,
		width:120,
		mode: 'local',
		forceSelection: true,
		triggerAction: 'all',
		emptyText:'请选择...',
		selectOnFocus:true
	});
	
     width=document.body.clientWidth-10;
    var height=document.body.clientHeight;//高度
    grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
        	new Ext.grid.RowNumberer(),
           {header: '立案编号',dataIndex:'AJBH',width: width*0.13, sortable: true},
           {header: '区域',dataIndex:'QY',width: width*0.05, sortable: true},
           {header: '案由',dataIndex:'AY',width: width*0.2, sortable: true},
           {header: '案件来源',dataIndex:'AJLY',width: width*0.05, sortable: true},
           {header: '当事人',dataIndex:'DSR',width: width*0.1, sortable: true},
           {header: '受理日期',dataIndex:'SLRQ',width: width*0.12, sortable: true},
           {header: '接收时间',dataIndex:'CREATE_',width: width*0.08, sortable: true},
           {header: '移交时间',dataIndex:'END_',width: width*0.15, sortable: true},
           {header: '详细',dataIndex:'INDEX',width: width*0.08, sortable: false,renderer:pro}
        ],
        tbar:[
        	{xtype:'label',text:'快速查找:',width:60},      
        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	{xtype: 'button', id:'button',text:'查询',handler: query}
        ],
        // stripeRows: true,
        height:380, 
        width:width+10,
        // config options for stateful behavior
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 10,
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        })
   
    });
    
    grid.render('mygrid_container'); 
});


function pro(id){
 //id = id -1;
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/xuzhouNW/lacc/dbaj/images/view.png' alt='详细'></a>";
}

function process(id){
    var wfInsId=myData[id].WFINSID;
	var yw_guid=myData[id].YW_GUID;
	var returnPath=window.location.href;
	var buttonHidden = "delete,la,tran,back";
	var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&zfjcName=立案查处&zfjcType=90&wfInsId='+wfInsId+'&returnPath='+returnPath+'&buttonHidden='+buttonHidden;
	//window.open(url); 
	document.location.href=url;
}
function viewDetail(){
	var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
	process(grid.getSelectionModel().getSelected().json[0]-1);  
}



function document.onkeydown() 
{ 
var e=event.srcElement; 
if(event.keyCode==13) 
{ 
document.getElementById("button").click(); 
return false; 
} 
} 


       <!--查询方法 add by 赵伟 2012-9-7-->
        function query(){
           var keyWord="";
          		keyWord=Ext.getCmp('keyword').getValue();
           keyWord=keyWord.toUpperCase();
           putClientCommond("lacc","getajdcCompleteList");
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           var store = new Ext.data.JsonStore({
                proxy: new Ext.ux.data.PagingMemoryProxy(myData),
                remoteSort:true,
                fields: [
                 {name: 'AJBH'},
                 {name: 'QY'},
                 {name: 'AY'},
                 {name: 'AJLY'},
                 {name: 'DSR'},
                 {name: 'SLRQ'},
                 {name: 'CREATE_'},
                 {name: 'END_'},
                 {name: 'INDEX'}
                ]
          });
          grid.reconfigure(store, new Ext.grid.ColumnModel([
        	    new Ext.grid.RowNumberer(), 
        	    {header: '立案编号',dataIndex:'AJBH',width: width*0.13, sortable: true},   
        	    {header: '区域',dataIndex:'QY',width: width*0.05, sortable: true},    
                {header: '案由',dataIndex:'AY',width: width*0.2, sortable: true},
                {header: '案件来源',dataIndex:'AJLY',width: width*0.05, sortable: true},
                {header: '当事人',dataIndex:'DSR',width: width*0.1, sortable: true},
                {header: '受理日期',dataIndex:'SLRQ',width: width*0.12, sortable: true},
                {header: '接收时间',dataIndex:'CREATE__',width: width*0.08, sortable: true},
                {header: '移交时间',dataIndex:'END_',width: width*0.15, sortable: true},
                {header: '详细',dataIndex:'INDEX',width: width*0.08, sortable: false,renderer:pro}
          ]));
          grid.getBottomToolbar().bind(store);
          store.load({params:{start:0,limit:10}});  
        }
         <!--改变关键字方法 add by 赵伟 2012-9-7-->
         function changKeyword(val){
           var key="";
          		key=Ext.getCmp('keyword').getValue().toUpperCase();;
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

		<div id="mygrid_container" style="width: 100%; height: 80%;"></div>
		<div id="win1" class="x-hidden">
			<div id="import"></div>
		</div>
	</body>
</html>