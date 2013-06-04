<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.dc.MarkList"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    MarkList ml=new MarkList();
    String type=request.getParameter("type");
    String rows=ml.getMarkList(type);
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
		<script src="<%=basePath%>/common/js/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>/common/css/query.css" />
	</head>
<script>
	var win;
	var grid;
	var store;
	var myData;
  Ext.onReady(function(){
	myData =<%=rows%>;
    store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        fields: [
        {name: '编号'},
           {name: '序号'},
           {name: '任务名称'},
           {name: '是否备案'},
           {name: '坐标'},
           {name: '查看'},
           {name: '删除'}
        ]
    });  
        store.load({params:{start:0, limit:10}});
        var width=document.body.clientWidth;
        var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store, 
        height: height*0.5,
        columns: [
        {header: '编号', width: width*0.15},
            {header: '序号', hidden:true,width: width*0.6},
            {header: '任务名称', width: width*0.4},
            {header: '是否备案', hidden:true, width: width*0.15},
            {header: '坐标', hidden:true, width: width*0.15},
            {header: '查看', width: width*0.17, sortable: false, renderer: modify},        
            {header: '删除', width: width*0.16, sortable: false, renderer: del}
        ],
        bbar: new Ext.PagingToolbar({
        pageSize: 10,
        store: store,
        plugins: new Ext.ux.ProgressBarPager()
        }),
        listeners:{
		       rowclick:function(grid,row){	
		       var id=store.getAt(row).get('序号');
		       parent.parent.parent.parent.center.queryAndLocation("DC_EDIT",0,"yw_guid='"+id+"'",7,true);
		       parent.parent.parent.parent.center.queryAndLocation("DC_EDIT",1,"yw_guid='"+id+"'",7,true);
		       parent.parent.parent.monitor.isMonitor=false;
			   parent.parent.todo.document.getElementById("isMonitor").value='开始导航';
			   parent.parent.todo.document.getElementById("isMonitor").disabled=false;
		       if(parent.parent.parent.monitor.start_x!=''){
			       parent.parent.parent.monitor.mdd_x=zb.split(',')[0];
			       parent.parent.parent.monitor.mdd_y=zb.split(',')[1];
		       }
		 }
       }        
    });  
    store.reload(); 
    store.sort("时间","desc"); 
    grid.render('status_grid');
   })
  function del(){
   return "<a href='#' onclick='delInfo();return false;'><img src='gisapp/images/delete.png' alt='删除'></a>";
  }
  function modify(id){
     return "<a href='#' onclick='modifyShtc("+id+");return false;'><img src='gisapp/images/view.png' alt='修改'></a>";
  }
  	
  function modifyShtc(id){
     if(myData[id][3]=="0"){
      window.showModalDialog("/hotline/supervisory/dc/pages/2/dc_ydqkdcb.jsp?jdbcname=ywJdbcTemplate&yw_guid="+myData[id][1],"","dialogWidth=800px;dialogHeight=700px;status=no;scroll=no");
     }else{
      window.showModalDialog("/hotline/supervisory/dc/pages/1/dc_ydqkdcb.jsp?jdbcname=ywJdbcTemplate&yw_guid="+myData[id][1],"","dialogWidth=800px;dialogHeight=700px;status=no;scroll=no");
     }
  }
  function delInfo(){ 
    var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
    Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
    if(btn=='yes'){
	    var path = "<%=basePath%>";
	    var actionName = "shtcDataOperationAC";
	    var actionMethod = "delShtc";
	    var parameter="id="+store.getAt(rowIndex).get('序号');
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		if(result){
           document.location.reload();
		}
	}
   });
  } 

 </script>
	<body>
	<button onclick='document.location.reload()'>刷新</button>
		 <div id="status_grid"  style="margin-top:0px;width:100%;height:100%;"  ></div>
	</body>
</html>