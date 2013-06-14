<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user=null;
        if (principal instanceof User) {
            user =(User) principal;
        }
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
    	var sm ;
Ext.onReady(function(){
	putClientCommond("lacc","getXFdata");
	myData = restRequest();
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	            {name: 'XSH'},
           		{name: 'DJR'},
           		{name: 'BJBDW'},
           		{name: 'DJRQ'},
           		{name: 'WTFSD7'},
           		{name: 'XSZY'},
           		{name: 'YW_GUID'},
           		{name: 'ROWNUM1'}
	        ]
    });
    
    store.load({params:{start:0, limit:10}});
    width=document.body.clientWidth;
    var height = document.body.clientHeight * 0.955;
  	sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    grid = new Ext.grid.GridPanel({
        store: store,
        id:'gridID',
        sm:sm,
        columns: [
            sm,
            new Ext.grid.RowNumberer(),
        	{header: '线索号', dataIndex:'XSH',width: width*0.15, sortable: false},
            {header: '登记人', dataIndex:'DJR', width: width*0.1, sortable: false},
            {header: '被举报单位', dataIndex:'BJBDW', width: width*0.15, sortable: false},
            {header: '登记日期', dataIndex:'DJRQ', width: width*0.10, sortable: false},
            {header: '问题发生地', dataIndex:'WTFSD7', width: width*0.25, sortable: false},
            {header: '线索摘要', dataIndex:'XSZY', width: width*0.12, sortable: false},
            {header: 'YW_GUID', dataIndex:'YW_GUID', hidden:true, width: width*0.1, sortable: false},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.05, sortable: false, renderer:view}
            
        ],
         tbar:[
	    	{xtype:'label',text:'快速查找:',width:60},
	    	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
	    	{xtype: 'button',text:'查询',handler: query}
	    ],
        stripeRows: true,
        height: height,
        width: width,
        title: '任务信息列表',
        stateful: true,
        stateId: 'grid',
        buttonAlign:'center',
        buttons: [{
        	text:'下发核查任务',
        	handler: issuedTask
        },{
        	text:' 合 法 ',
        	handler: checkLegal
        }],
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

function view(id){
	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
//详细信息
function viewDetail(id){
    var yw_guid=myData[id].YW_GUID;
    window.location.href="<%=basePath%>web/hotline/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&yw_guid="+yw_guid;
}
//合法按钮
function checkLegal(){
  var ids="";
  if (grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('YW_GUID');
	   }else{
	      ids=ids+records[i].get('YW_GUID')+",";
	   }
     }
      Ext.Msg.confirm("请确认","是否要判定为合法案件", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
                	var path = "<%=basePath%>";
					putClientCommond("anjianManager","heFaAnJi");
   					putRestParameter("ids",ids);
					var result = restRequest();
    				if(result == '0'){
    					Ext.Msg.alert('提示','该案件已判定为合法案件!');  
    					document.location.reload();  
    				}
    				else{
    					Ext.Msg.alert('设置失败,请重试！'); 
    				}
               } 
            });  
  	
  }else{
    Ext.Msg.alert('提示','请选择任务！');
  }
}

function issuedTask(){
 	window.showModalDialog("<%=basePath%>web/default/ajgl/xfjb/xiafa.jsp","","dialogWidth=650px;dialogHeight=450px;status=no;scroll=no");
}

  function check(){
	  return "<font size='1'>未立案</font>";
}
//查询按钮
function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("lacc","getXFCX");
putRestParameter("keyWord",keyWord);
var myData = restRequest(); 
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
            {name: 'XSH'},
       		{name: 'DJR'},
       		{name: 'BJBDW'},
       		{name: 'DJRQ'},
       		{name: 'WTFSD7'},
       		{name: 'XSZY'},
       		{name: 'YW_GUID'},
       		{name: 'ROWNUM1'}
        ]
    });
grid.reconfigure(store,new Ext.grid.ColumnModel([
             sm,
            new Ext.grid.RowNumberer(),
        	{header: '线索号', dataIndex:'XSH',width: width*0.15, sortable: false,renderer:changKeyword},
            {header: '登记人', dataIndex:'DJR', width: width*0.1, sortable: false,renderer:changKeyword},
            {header: '被举报单位', dataIndex:'BJBDW', width: width*0.15, sortable: false},
            {header: '登记日期', dataIndex:'DJRQ', width: width*0.10, sortable: false,renderer:changKeyword},
            {header: '问题发生地', dataIndex:'WTFSD7', width: width*0.18, sortable: false},
            {header: '线索摘要', dataIndex:'XSZY', width: width*0.12, sortable: false},
            {header: 'YW_GUID', dataIndex:'YW_GUID', hidden:true, width: width*0.1, sortable: false},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.1, sortable: false, renderer:view}
            
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
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
		<br>
		<!--  <center><input type="button" value=" 合 法 " onclick="checkLegal()">&nbsp;&nbsp;&nbsp;<input type="button" value="下发核查任务" onclick="issuedTask()"></center>  -->
	</body>
</html>
<script>
</script>