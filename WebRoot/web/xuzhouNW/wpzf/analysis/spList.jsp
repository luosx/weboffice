<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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

    putClientCommond("wpzfList","getspList");
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
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields:[
          {name: '名称'},
           {name: '属性'}
        ]});
        
  var grid = new Ext.grid.GridPanel({
        store: store, 
        height:120,
        width:340,
        columns:[
            {header: '', width: 150},
            {header: '', width: 180}
        ],listeners:{
		       rowclick:function(grid,row){	}
         }      
    });  
  store.load(); 
  grid.render('status_grid');
    new Ext.Panel({
		preventBodyReset: false,
		renderTo: 'status_grid',
		width: 340,
		html: "<iframe leftmargin='0' topmargin='0' id='myFrame' width='340' height='380' src='<%=basePath%>/model/report/showReport.jsp?id=77D591C4DC4644989B555AA1A6E2C3BB&fieldValue=<%=yw_guid%>,<%=yw_guid%>' ></iframe>"	
	 
	}); 
	
	}
 });
  function test(){
  setTimeout(function() {document.location.reload();},800);
  }
</script>
	<body >
		<div id="status_grid"></div>
		<br>
	</body>
</html>