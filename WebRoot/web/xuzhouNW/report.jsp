<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/"; 
    String phone=request.getParameter("phone");
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user=null;
    if (principal instanceof User) {
       user =(User) principal;
    }
    String xzqh = user.getXzqh(); 
    String userName=user.getUsername();  
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
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/common/css/query.css"/>
		<style>
		input,img{vertical-align:middle;}
		</style>
		<script type="text/javascript">
		var myData;
		var win;
		var form;
		var store;
		var grid;
		var _$ID = '';
		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight;
    	var flag; 
Ext.onReady(function(){
    if('<%=phone%>'!='null'){
		putClientCommond("daibanList","checkRepeat");
	    putRestParameter("phone","<%=phone%>");
		flag = restRequest();
	}
	if(flag){
		putClientCommond("daibanList","getDataPreviewList");
	    putRestParameter("xzqh","<%=xzqh%>");
		myData = restRequest();
	}
    store = new Ext.data.ArrayStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: '线索号'},
	           {name: '举报方式'},
	           {name: '登记部门'},
	           {name: '登记时间'},
	           {name: '被举报单位'},
	           {name: '问题发生地'},
	           {name: '问题发生时间'},
	           {name: '查看'}
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight*0.95;
    grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
        	new Ext.grid.RowNumberer(),
        	{header: '线索号', dataIndex:'线索号',width: width*0.15, sortable: false},
            {header: '举报方式', dataIndex:'举报方式', width: width*0.1, sortable: false},
            {header: '登记部门', dataIndex:'登记部门', width: width*0.1, sortable: false},
            {header: '登记时间', dataIndex:'登记时间', width: width*0.1, sortable: false},
            {header: '被举报单位', dataIndex:'被举报单位', width: width*0.15, sortable: false},
            {header: '问题发生地', dataIndex:'问题发生地', width: width*0.15, sortable: false},
            {header: '问题发生时间', dataIndex:'问题发生时间', width: width*0.12, sortable: false},
            {header: '查看', dataIndex:'查看', width: width*0.05, sortable: false, renderer:view}
        ],
        listeners:{
		       'rowdblclick' : function(grid, rowIndex, e){ 
		          var record = grid.store.getAt(rowIndex);
		          var id = record.get('线索号'); 
                  window.open("<%=basePath%>web/jinan/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&yw_guid="+id);
		       }
         },
        stripeRows: true,
        height: height,
        title: '待办线索列表',
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
    store.sort("登记时间","desc"); 
    grid.render('mygrid_container'); 
    if(!flag){
    
    window.location.href("<%=basePath%>service/rest/createxs/getxsh?way=phone&username=<%=userName%>&phonenumber=<%=phone%>"); 
    }
  })

function view(id){
	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
 

function viewDetail(id){
    var id=myData[id][0];
    window.open("<%=basePath%>web/jinan/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&yw_guid="+id);
}
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
		</body>
</html>