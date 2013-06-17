<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String condition = request.getParameter("condition");
	if (condition != null && !"".equals(condition)) {
		condition = UtilFactory.getStrUtil().unescape(condition);
	} else {
		condition = "";
	}
	String accord = request.getParameter("accord");
	String parameters = "&condition="
			+ UtilFactory.getStrUtil().escape(
					UtilFactory.getStrUtil().escape(condition))
			+ "&accord=" + accord;
	Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	String userName = ((User) principal).getUsername();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>立案查处未查处</title>

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
Ext.onReady(function(){
	//myData= ajaxRequest("<%=basePath%>", "processList", "getProcessList", 'userName=<%=userName%>');
	//myData=eval(myData);
	putClientCommond("processList","getProcessList");
	putRestParameter("userName","<%=userName%>");
	myData = restRequest();
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
       remoteSort:true,
        fields: [
           {name: '序号'},
           {name: '案由'},
           {name: '案件来源'},
           {name: '当事人'},
           {name: '受理日期'},
           {name: '办案状态'},
           {name: '移交时间'},
           {name: '办理'},
           {name: '核查'}
        ]
    });
    
    store.load({params:{start:0, limit:10}}); 
    var width=document.body.clientWidth-20;
    var height=document.body.clientHeight;//高度
    grid = new Ext.grid.GridPanel({
        title:'案件任务待办列表',
        store: store,
        columns: [
           {header: '序号',width: width*0.1, sortable: true},
           {header: '案由',width: width*0.25, sortable: true},
           {header: '案件来源',width: width*0.15, sortable: true},
           {header: '当事人',width: width*0.1, sortable: true},
           {header: '受理日期',width: width*0.1, sortable: true},
           {header: '办案状态',width: width*0.1, sortable: true},
           {header: '移交时间',width: width*0.15, sortable: true},
           {header: '办理',dataIndex:'序号',width: width*0.05, sortable: false,renderer:pro}
        ],
        tbar:[
        	{xtype:'label',text:'快速查找:',width:60},
        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	{xtype: 'button',text:'查询',handler: query}
        ],
        // stripeRows: true,
        height:380, 
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
    Ext.getCmp('keyword').setValue("<%=condition%>");
	
});


function pro(id){
id = id -1;
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/xuzhouNW/lacc/dbaj/images/view.png' alt='办理'></a>";
}


function process(id){
    var wfInsTaskId=myData[id][9];
	var activityName=myData[id][5];
	var wfInsId=myData[id][10];
	var yw_guid=myData[id][8];
	var returnPath=window.location.href;
	var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&wfInsTaskId='+wfInsTaskId+'&activityName='+escape(escape(activityName))+'&zfjcType=7&wfInsId='+wfInsId+'&zfjcName='+escape(escape('违法案件查处'))+'&wfId=ZFJC-1&returnPath='+returnPath;  
	//window.open(url); 
	document.location.href=url;
	//window.open(url,'_blank','height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no, fullscreen=yes'); 
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


function query(){
var condition=Ext.getCmp('keyword').getValue();
condition=escape(escape(condition));
document.location.href="<%=basePath%>web/xuzhouNW/lacc/dbaj/dbaj.jsp?condition="+condition;
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