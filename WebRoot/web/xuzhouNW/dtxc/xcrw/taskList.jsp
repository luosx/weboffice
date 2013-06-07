<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "base/thirdres/ext/";
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
		<script type="text/javascript" src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
		<script type="text/javascript">
		var myData;
		var grid;
		var store;
		var height;
		var width;
Ext.onReady(function(){
	putClientCommond("dtxcList","getXcrwList");
	myData = restRequest();
	//myData= [['XC2012001234','杭州西湖区','张梅武','2012-1-21','2012-1-24','查看是否有违法占用土地','西湖区整个区域','1','1'],
	//['XC2012124321','杭州余杭区','王一山','2012-3-18','2012-3-20','查看是否有违法占用土地','余杭区整个区域','2','2'],
	//['XC2012843454','杭州江干区','赵强','2012-5-18','2012-5-20','查看是否有违法占用土地','江干区整个区域','3','3'],
	//['XC2012001234','宁波市辖区','张国庆','2012-1-21','2012-1-24','查看是否有违法占用土地','市辖区整个区域','4','4'],
	//['XC2012124321','宁波海曙区','李洪','2012-3-18','2012-3-20','查看是否有违法占用土地','海曙区整个区域','5','5'],
	//['XC2012843454','温州市辖区','王三运','2012-5-18','2012-5-20','查看是否有违法占用土地','市辖区整个区域','6','6']
	//];//采用json格式存储的数组
    // create the data store
    store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'YW_GUID'},
           {name: 'XCDW'},
           {name: 'XCZZXM'},
           {name: 'XCZCYMD'},
           {name: 'XCSJ'},
           {name: 'XCDY'},
           {name: 'XCWT'},
           {name: 'ROWNUM1'},
           {name: 'ROWNUM1'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
     width=document.body.clientWidth;
     height=document.body.clientHeight*0.9;
        grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '编号',dataIndex:'YW_GUID',width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '巡查单位',dataIndex:'XCDW',width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '巡查组长姓名',dataIndex:'XCZZXM', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '巡查组成员名单',dataIndex:'XCZCYMD',width: width*0.175, sortable: true,renderer:changKeyword},
            {header: '巡查时间',dataIndex:'XCSJ', width: width*0.08, sortable: false,renderer:changKeyword},
            {header: '巡查地域',dataIndex:'XCDY', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '巡查问题',dataIndex:'XCWT', width: width*0.175, sortable: true,renderer:changKeyword},
            {header: '查看',dataIndex:'ROWNUM1', width: width*0.05, sortable: false,renderer:view},
            {header: '删除',dataIndex:'ROWNUM1', width: width*0.05, sortable: false, renderer:del}
        ],
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    ],
        listeners:{
		       rowdblclick: viewDetail
         },      
        stripeRows: true,
        height: height +40,
        title:'巡查任务列表',
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        buttons: [{
            text: '新增',handler: createTask
        }],
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        })
    });
    
    grid.render('mygrid_container'); 
}
)

function del(id){
 return "<a href='#' onclick='delteTask("+id+");return false;'><img src='base/gis/images/delete.png' alt='删除'></a>";
}
function delteTask(id){
var yw_guid=myData[id].YW_GUID
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
  if(btn=='yes'){
	var path = "<%=basePath%>";
    var actionName = "dtxcList";
    var actionMethod = "deleteXcrw";
    var parameter="yw_guid="+yw_guid;
	var result = ajaxRequest(path,actionName,actionMethod,parameter);
	if(result=='success'){
		document.location.reload();
	}else{
		Ext.Msg.alert("删除失败！");
	}
  }else{
	   return false;
	}
});
}
function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
}
function viewDetail(id){
var yw_guid=myData[id].YW_GUID
var url="<%=basePath%>web/default/dtxc/xcrw/xcdjk.jsp?open=view&yw_guid="+yw_guid+"&jdbcname=YWTemplate"; 
location.href=url; 
}

function createTask(){
window.open("<%=basePath%>/web/default/dtxc/xcrw/xcdjk.jsp?open=open");
}

function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("dtxcList","getXcrwList");
putRestParameter("keyWord",keyWord);
var myData = restRequest(); 
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'YW_GUID'},
           {name: 'XCDW'},
           {name: 'XCZZXM'},
           {name: 'XCZCYMD'},
           {name: 'XCSJ'},
           {name: 'XCDY'},
           {name: 'XCWT'},
           {name: 'ROWNUM1'},
           {name: 'ROWNUM1'}
        ]
    });
grid.reconfigure(store, new Ext.grid.ColumnModel([
            {header: '编号',dataIndex:'YW_GUID',width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '巡查单位',dataIndex:'XCDW',width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '巡查组长姓名',dataIndex:'XCZZXM', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '巡查组成员名单',dataIndex:'XCZCYMD',width: width*0.175, sortable: true,renderer:changKeyword},
            {header: '巡查时间',dataIndex:'XCSJ', width: width*0.08, sortable: false,renderer:changKeyword},
            {header: '巡查地域',dataIndex:'XCDY', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '巡查问题',dataIndex:'XCWT', width: width*0.175, sortable: true,renderer:changKeyword},
            {header: '查看',dataIndex:'ROWNUM1', width: width*0.05, sortable: false,renderer:view},
            {header: '删除',dataIndex:'ROWNUM1', width: width*0.05, sortable: false, renderer:del}
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);//
//重新加载数据集
store.load({params:{start:0,limit:15}}); 
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
		<div id="mygrid_container"></div>
		</body>
</html>