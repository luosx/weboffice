<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
				String name = ProjectInfo.getInstance().PROJECT_NAME;
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
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script type="text/javascript"
			src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>/common/css/query.css" />
		<script type="text/javascript">
		var myData;
		var win;
		var form;
		var store;
		var grid;
		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight; 
    	var flag;
Ext.onReady(function(){
    var myData = ajaxRequest("<%=basePath%>","xfxs12336","getAllData","");
     myData=eval(myData);
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: ' JBRDW'},
	           {name: 'JBFS'},
	           {name: 'XSH'},
	           {name: 'JBRDZ'},
	           {name: 'JBRLXDH'},
	           {name: 'DJBM'},
	           {name: 'DJRQ'},
	           {name: 'BJBDW'},
	           {name: 'WTFSD'},
	           {name: 'YW_GUID'}
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight*0.9;
    grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
        	new Ext.grid.RowNumberer(),
        	{header: '线索号', dataIndex:'XSH',width: width*0.10, sortable: false},
            {header: '举报方式', dataIndex:'JBFS', width: width*0.07, sortable: false},
            {header: '登记部门', dataIndex:'DJBM', width: width*0.09, sortable: false},
            {header: '登记时间', dataIndex:'DJRQ', width: width*0.08, sortable: false},
            {header: '被举报单位', dataIndex:'BJBDW', width: width*0.14, sortable: false},
            {header: '举报人地址', dataIndex:'JBRDZ', width: width*0.14, sortable: false},
             {header: '举报人联系电话', dataIndex:'JBRLXDH', width: width*0.10, sortable: false},
            {header: '问题发生地', dataIndex:'WTFSD', width: width*0.20, sortable: false},
            {header: '查看',  width: width*0.05, sortable: false, renderer:view}
        ],
       
        stripeRows: true,
        height: height+20,
        title: '12336线索列表',
        stateful: true,
        stateId: 'grid',
        buttonAlign:'center',
         buttons: [{
        	text:'新增线索',
        	handler: xzxs
        } ] ,		
        bbar: new Ext.PagingToolbar({
	        pageSize: 15,
	        store: store,
	        displayInfo: true,
	            displayMsg: '共{2}条，当前为：{0} - {1}条',
	            emptyMsg: "无记录",
	        plugins: new Ext.ux.ProgressBarPager()
        })
    }); 
    
    store.sort("登记时间","desc"); 
    grid.render('mygrid_container'); 
    
  })

function view(id){
	
	return "<a href='#' onclick='viewDetail();return false;'><img src='web/<%=name%>/framework/images/listbutton/view.png'></a>";
}
 

function viewDetail(){
	var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
    var yw_guid=grid.store.getAt(rowIndex).get('YW_GUID');
    window.location.href="<%=basePath%>web/xuzhouWW/xsjb/xfxsTab.jsp?jdbcname=YWTemplate&style=1&yw_guid="+yw_guid;
}
function xzxs(){
    var yw_guid = ajaxRequest("<%=basePath%>","xfxs12336","getXzxsYW_GUID","");
    window.location.href("<%=basePath%>web/xuzhouWW/xsjb/xfxsTab.jsp?jdbcname=YWTemplate&style=0&yw_guid="+yw_guid); 
}
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 102%; height: 90%;"></div>
	</body>
</html>