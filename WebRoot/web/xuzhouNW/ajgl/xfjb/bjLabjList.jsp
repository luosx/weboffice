<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String flag=request.getParameter("flag");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user=null;
        if (principal instanceof User) {
            user =(User) principal;
        }
    String status=request.getParameter("status");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
			
		<title>执法监察总体数据预览</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<style>
		input,img{vertical-align:middle;cursor:hand;}
		</style>
		<script type="text/javascript">
		var myData;
		var store;
		var grid;
		var _$ID = '';
		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight; 
    	var width;
    	var sm;
Ext.onReady(function(){
	putClientCommond("anjianManager","getXfjbList");
    putRestParameter("flag",<%=flag%>);
    putRestParameter("status",<%=status%>);
	myData = restRequest();
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'XSH'},
	           {name: 'DJR'},
	           {name: 'DJRQ'},
	           {name: 'BJBDW'},
	           {name: 'WTFSD7'},
	           {name: 'XSZY'},
	           {name: 'YW_GUID'},
	           {name: 'ROWNUM1'}  
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    width=document.body.clientWidth;
    var height = document.body.clientHeight;
  	sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    grid = new Ext.grid.GridPanel({
        store: store,
        id:'gridID',
        sm:sm,
        columns: [
            //sm,
            new Ext.grid.RowNumberer(),
			{header: '线索号', dataIndex:'XSH',width: width*0.15, sortable: false},
            {header: '登记人', dataIndex:'DJR', width: width*0.1, sortable: false},
            {header: '被举报单位', dataIndex:'BJBDW', width: width*0.15, sortable: false},
            {header: '登记日期', dataIndex:'DJRQ', width: width*0.10, sortable: false},
            {header: '问题发生地', dataIndex:'WTFSD7', width: width*0.17, sortable: false},
            {header: '线索摘要', dataIndex:'XSZY', width: width*0.1, sortable: false},
            {header: 'YW_GUID', dataIndex:'YW_GUID', hidden:true, width: width*0.1, sortable: false},
            {header: '状态', dataIndex:'zhuangtai', width: width*0.08, sortable: false,renderer:check},
            {header: '信息', dataIndex:'ROWNUM1', width: width*0.05, sortable: false, renderer:xinxi},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.05, sortable: false, renderer:view}
        ],
         listeners:{
		       rowdblclick: viewDetail
         },
         tbar:[
	    	{xtype:'label',text:'快速查找:',width:60},
	    	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
	    	{xtype: 'button',text:'查询',handler: query}
	    ],
        stripeRows: true,
        height: height,
        width:width,
        //title: '任务信息列表',
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

function xinxi(id){
	return "<a href='#' onclick='xinxiview("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
function xinxiview(id){
   // var id = grid.store.indexOf(grid.getSelectionModel().getSelected());
    var yw_guid=myData[id].YW_GUID;
 window.location.href="<%=basePath%>web/hotline/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&yw_guid="+yw_guid;
}


function view(id){
	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
function viewDetail(id){
   // var id = grid.store.indexOf(grid.getSelectionModel().getSelected());
    var yw_guid=myData[id].YW_GUID;
    var zfjcType=9;
    //if('<%=flag %>'=='9'){
     zfjcType=7;
   // }
   var activityName='承办';
   var url="<%=basePath%>model/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&activityName="+activityName+"&yw_guid="+yw_guid;
   location.href=url;
}
//查询按钮
function query()
{
	var keyWord = Ext.getCmp('keyword').getValue();
	keyWord=escape(escape(keyWord)); 
	parameters="&keyWord="+keyWord;
	putClientCommond("anjianManager","getXfjbList");
    putRestParameter("keyWord",keyWord);
     putRestParameter("flag",<%=flag%>);
      putRestParameter("status",<%=status%>);
   	var myData = restRequest(); 
	store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'XSH'},
           {name: 'DJR'},
           {name: 'DJRQ'},
           {name: 'BJBDW'},
           {name: 'WTFSD7'},
           {name: 'XSZY'},
           {name: 'YW_GUID'},
           {name: 'ROWNUM1'}  
        ]
    });
//var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn}); 
grid.reconfigure(store,new Ext.grid.ColumnModel([
            // sm,
            new Ext.grid.RowNumberer(),
			{header: '线索号', dataIndex:'XSH',width: width*0.15, sortable: false, renderer:changKeyword},
            {header: '登记人', dataIndex:'DJR', width: width*0.1, sortable: false, renderer:changKeyword},
            {header: '被举报单位', dataIndex:'BJBDW', width: width*0.15, sortable: false},
            {header: '登记日期', dataIndex:'DJRQ', width: width*0.10, sortable: false, renderer:changKeyword},
            {header: '问题发生地', dataIndex:'WTFSD7', width: width*0.17, sortable: false},
            {header: '线索摘要', dataIndex:'XSZY', width: width*0.1, sortable: false},
            {header: 'YW_GUID', dataIndex:'YW_GUID', hidden:true, width: width*0.1, sortable: false},
            {header: '状态', dataIndex:'zhuangtai', width: width*0.08, sortable: false, renderer:check},
            {header: '信息', dataIndex:'ROWNUM1', width: width*0.05, sortable: false, renderer:view}
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);
//重新加载数据集
store.load({params:{start:0,limit:10}});  
}
function changKeyword(val){
var key=Ext.getCmp('keyword').getValue();
if(key!=''){
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
function check(){
	return "<font size='1'>办结</font>"; 
}
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" ></div>	
	</body>
</html>
