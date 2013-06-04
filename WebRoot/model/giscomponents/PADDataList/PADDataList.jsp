<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.common.util.UtilFactory"%>
<%@page import="com.klspta.gisapp.components.pad.PADDataList"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    PADDataList padlist=new PADDataList();
    String condition=request.getParameter("condition");
	if(condition!=null&&!"".equals(condition)){
	condition=UtilFactory.getStrUtil().unescape(condition);
	}else{
		condition="";
	}
	String accord=request.getParameter("accord");
	List list=new ArrayList();
	list.add(condition);
	list.add(accord);
    String rows=padlist.getPADDataList(list);  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Pad外业采集数据列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/common/js/ajax.js"></script>
		<%@ include file="/common/include/ext.jspf" %>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
		<style>
		input,img{vertical-align:middle;}
		</style>
		<script type="text/javascript">
var myData;
var win;
var store;
var grid;
Ext.onReady(function(){
	myData= <%=rows%>;//采用json格式存储的数组
    // create the data store
    store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '序号'},
           {name: '图斑编号'},
           {name: '位置'},
           {name: '违法类型'},
           {name: '填报时间'},
           {name: '坐标'},
           {name: '采集人'},
           {name: '详细信息'},
           {name: '删除'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '序号', width: width*0.1, sortable: true},
            {header: '图斑编号', width: width*0.1, sortable: true},
            {header: '位置', width: width*0.15, sortable: true},
            {header: '违法类型', width: width*0.1, sortable: true},
            {header: '填报时间', width: width*0.1, sortable: false},
            {header: '坐标', width: width*0.2, sortable: true},
            {header: '采集人', width: width*0.1, sortable: true},
            {header: '详细信息', width: width*0.05, sortable: false,renderer:view},
            {header: '删除', width: width*0.05, sortable: false,renderer:del}
        ],
        stripeRows: true,
        listeners:{
		       rowdblclick: showDetail
        },
        height: height*0.9,
        stateful: true,
        stateId: 'grid',
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
    document.getElementById('accord').checked=<%=accord%>;
	document.getElementById('condition').value="<%=condition%>";
     win = new Ext.Window({
					applyTo : 'result-win',
					layout : 'fit',
					width : 320,
					height : 320,
					closeAction : 'hide',
					plain : true,
					items : new Ext.TabPanel({
								applyTo : 'result-tabs',
								autoTabs : true,
								activeTab : 0,
								deferredRender : false,
								border : false
							}),

					buttons : [{
								text : '关闭',
								handler : function() {									
									win.hide();
								}
							}]
				})     
}
)

function view(id){
return "<a href='#' onclick='showDetail("+id+");return false;'><img src='gisapp/images/view.png' alt='详细信息'></a>";
}
function del(id){
 return "<a href='#' onclick='delTask("+id+");return false;'><img src='gisapp/images/delete.png' alt='删除'></a>";
}

function delTask(id){
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
  if(btn=='yes'){
    var path = "<%=basePath%>";
    var actionName ="padManageAC";
    var actionMethod ="delPAD";
    var parameter="xh="+store.getAt(id).get('序号')+"&sj="+store.getAt(id).get('填报时间')+"&cjr="+store.getAt(id).get('采集人');
	var result = ajaxRequest(path,actionName,actionMethod,parameter);
	document.location.reload();
	}
	else{
	return false;
	}
});
}
function showDetail(id){
var id = grid.store.indexOf(grid.getSelectionModel().getSelected());
var mes='序号：'+store.getAt(id).get('序号');
mes+='<br>图斑编号：'+ store.getAt(id).get('图斑编号');
mes+='<br>位置：&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'+store.getAt(id).get('位置');
mes+='<br>违法类型：'+store.getAt(id).get('违法类型');
mes+='<br>填表时间：'+store.getAt(id).get('填报时间'); 
var t= store.getAt(id).get('坐标').split(';');
mes+='<br>坐标:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'+t[0];
for(var i=1;i<t.length;i++){
mes+='<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'+t[i];
}
mes+='<br>采集人：'+store.getAt(id).get('采集人');
document.all.properties.innerHTML=mes;  
win.show();
}

function query(){
var condition=document.getElementById('condition').value;
var accord=document.getElementById('accord').checked;
condition=escape(escape(condition));
document.location.href="<%=basePath%>gisapp/pages/components/PADDataList/PADDataList.jsp?condition="+condition+"&accord="+accord;
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
</script>
</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<common:queryLabel/>
		<div id="mygrid_container" style="width: 100%; height: 90%;"></div>
    <div id="result-win" class="x-hidden">
    <div class="x-window-header">详细信息</div>
    <div id="result-tabs">
        <div id='properties' class="x-tab" title="信息列表">
        </div>
    </div>
</div>
	</body>
</html>