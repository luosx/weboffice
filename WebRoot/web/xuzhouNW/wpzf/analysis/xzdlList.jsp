<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String type = request.getParameter("type");
    String yw_guid = request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>PDA列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
	</head>
	<script type="text/javascript">
    Ext.onReady(function(){
     putClientCommond("wpzfList","getxxdlList");
    putRestParameter("yw_guid","<%=yw_guid%>"); 
    var myData = restRequest();
     if(!myData){
	 var ss= new Ext.Panel({
	       title:"",
	       height:200,
			width: 340,
			html: "<br><br><br><h3 align='center'>无审批</h3>"
		}); 
		ss.render('status_grid');
    }else{
     var store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        fields: [
           {name: 'TBBH'},
           {name: 'DLMC'},
           {name: 'QSDWMC'},
           {name: 'YGMJ'}
        ]
    }); 
    var grid = new Ext.grid.GridPanel({
        store: store, 
        height:350,
        width:340,
        columns: [
            {header: '图斑编号', dataIndex:'TBBH', width: 70},
            {header: '地类名称',dataIndex:'DLMC', width: 80},
            {header: '权属单位名称', dataIndex:'QSDWMC',width: 100},
            {header: '压盖面积', dataIndex:'YGMJ',width: 70}
        ],
         listeners:{
		       rowclick:function(grid,row){	
		        
		       }
         }      
    });  
    store.load(); 
    grid.render('status_grid');
}
 });
	</script>
	<body>
		<div id="status_grid"></div>
	</body>
</html>