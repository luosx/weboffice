<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String zfjcType=request.getParameter("zfjcType");
    String year=request.getParameter("year");
     String type=request.getParameter("type");//卫片类型
     String zqbm=request.getParameter("zqbm");//政区编码
     String hczt=request.getParameter("hczt");//核查状态
     String status=request.getParameter("status");//案件状态
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
	    var width;
Ext.onReady(function(){
	putClientCommond("anjianManager","getWpzfList");
    putRestParameter("year","2011");
    putRestParameter("hczt","<%=hczt%>");
    putRestParameter("status","<%=status%>");
    putRestParameter("sfhf","1");
	myData = restRequest();
    store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'TBBH'},
           {name: 'XZQHMC'},
           {name: 'TBMJ'},
           {name: 'QSX'},
           {name: 'HSX'},
           {name: 'ISHF'},
           {name: 'ROWNUM1'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    width=document.body.clientWidth  ;
    var height=document.body.clientHeight ;
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
        	//sm,
        	new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.16, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.14, sortable: true},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.2, sortable: true},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.2, sortable: true},
            {header: '分析结果', dataIndex:'ROWNUM1', width: width*0.08, sortable:false,renderer:fxjg},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.05, sortable: false,renderer:view}
            
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
        })});
    grid.render('mygrid_container');
}
)
function impTask(){
   win.show();
}

//分析结果
function fxjg(id){
 return "<a href='#' onclick='fxjgDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='分析结果'></a>";
}
function fxjgDetail(id){
var yw_guid=myData[id].TBBH;
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp?id="+yw_guid);
}
//信息
function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
}
function viewDetail(id){
   var yw_guid=myData[id].TBBH;
   zfjcType=9;
   var url="<%=basePath%>model/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&yw_guid="+yw_guid;
   location.href=url;
}

function viewDetail1(id1,id2,id3){ 
var yw_guid=store.getAt(id2).get('图斑编号');
window.open("<%=basePath%>web/default/wpzf/pdaStatus.jsp");
}

function query(){
var zqbm=document.getElementById('zqbm').value;
var type=document.getElementById('type').value;
document.location.href="<%=basePath%>web/xuzhouNW/wpzf/nw_wptask/wpzfjc_dkxxb.jsp?zqbm="+zqbm+"&hczt=<%=hczt%>&type="+type+"&year=<%=year%>&zfjcType=<%=zfjcType%>";
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
//查询按钮
function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("anjianManager","getWpzfList");
putRestParameter("flag","1");
putRestParameter("status","<%=status%>");
putRestParameter("keyWord",keyWord);
var myData = restRequest(); 
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
            {name: 'TBBH'},
           {name: 'XZQHMC'},
           {name: 'TBMJ'},
           {name: 'QSX'},
           {name: 'HSX'},
           {name: 'ISHF'},
           {name: 'ROWNUM1'}
        ]
    });
var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn}); 
grid.reconfigure(store, new Ext.grid.ColumnModel([
           	new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.16, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.14, sortable: true},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.2, sortable: true},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.2, sortable: true},
            {header: '分析结果', dataIndex:'ROWNUM1', width: width*0.08, sortable:false,renderer:fxjg},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.05, sortable: false,renderer:view}
            
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);//
//重新加载数据集
store.load({params:{start:0,limit:12}});  
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
	<!-- 
	<div align='left' style='font-size: 13px;width:500px;'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所在政区：
	<select id="zqbm" >
	<option value="全部">全部</option>
	<option value="370783001">杭州</option>
	<option value="370783003">宁波</option>
	</select>
	卫片图斑类别：
	<select id="type" >
	<option value="全部">全部</option>
	<option value="1">第一类</option>
	<option value="2">第二类</option>
	<option value="3">第三类</option>
	<option value="4">第四类</option>
	<option value="5">第五类</option>
	<option value="6">第六类</option>
	</select>
	<img src='<%=basePath%>web/default/phjg/images/query.png' id='button' onClick='query()' style='border-bottom-width:0px;cursor : hand;position:relative;top:0px;'>
	</div>
	 -->
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
		</body>
</html>