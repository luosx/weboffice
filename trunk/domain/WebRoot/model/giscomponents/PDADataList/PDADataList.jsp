<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.common.util.UtilFactory"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%@ page import="com.klspta.gisapp.components.pda.pdadataList.PDADataList" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    String zfjcType=request.getParameter("zfjcType");
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
    PDADataList pdataList=new PDADataList();
    String rows=pdataList.getPDADataList(list);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>PDA发回的外业核查成果列表</title>

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
		var grid;
Ext.onReady(function(){
	myData= <%=rows%>;//采用json格式存储的数组
    // create the data store
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '序号'},
           {name: 'PDA编号'},
           {name: 'PDA名称'},
           {name: 'PDA所属单位'},
           {name: '接收时间'},
           {name: '数据类型'},
           {name: '所在政区'},
           {name: '查看'},
           {name: '删除'},
           {name: '导出'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '序号', width: width*0.1, sortable: true},
            {header: 'PDA编号', width: width*0.1, sortable: true},
            {header: 'PDA名称', width: width*0.1, sortable: true},
            {header: 'PDA所属单位', width: width*0.2, sortable: true},
            {header: '接收时间', width: width*0.1, sortable: false},
            {header: '数据类型', width: width*0.1, sortable: true},
            {header: '所在政区', width: width*0.1, sortable: true},
            {header: '查看', width: width*0.05, sortable: false,renderer:view},
            {header: '删除', width: width*0.05, sortable: false, renderer: del},
            {header: '导出', width: width*0.05, sortable: false, renderer: exp}
        ],
         listeners:{
		       rowdblclick: viewDetail
         },
        stripeRows: true,
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
}
)
/*处理删除操作 add by 郭 2011-1-20*/
function del(id){
 return "<a href='#' onclick='delteTask("+id+");return false;'><img src='gisapp/images/delete.png' alt='删除'></a>";
}
/*处理查看操作 add by 郭 2011-1-20*/
function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='gisapp/images/view.png' alt='查看'></a>";
}
/*导出成功包*/
function exp(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='gisapp/images/export.png' alt='导出'></a>";
}
function createTask(){
window.open("<%=basePath%>/createTask.do?method=createTask");
}
function viewDetail(id){
var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
var yw_guid=myData[rowIndex][9];
window.open("<%=basePath%>/common/pages/resourcetree/resourceTree.jsp?yw_guid="+yw_guid+"&zfjcType=<%=zfjcType%>");   

}
/*删除 add by 郭 2011-1-20*/
function delteTask(id){
var pdaId=myData[id][11];
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
  if(btn=='yes'){
var path = "<%=basePath%>";
    var actionName = "pdaManageAC";
    var actionMethod = "delPDA";
    var parameter="pdaId="+pdaId;
	var result = ajaxRequest(path,actionName,actionMethod,parameter);
	document.location.reload();
	}
	else{
	return false;
	}
});
}
function query(){
var condition=document.getElementById('condition').value;
var accord=document.getElementById('accord').checked;
condition=escape(escape(condition));
document.location.href="<%=basePath%>gisapp/pages/components/PDADataList/PDADataList.jsp?condition="+condition+"&accord="+accord+"&zfjcType=1";
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
		<div id="mygrid_container"></div>
	</body>
</html>