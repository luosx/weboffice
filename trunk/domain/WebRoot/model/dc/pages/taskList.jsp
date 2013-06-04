<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.dc.MarkList"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    MarkList ml=new MarkList();
    String rows=ml.getMarkList("task");
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
			<style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    height: 100%;
    }
</style>
<script>
	var grid;
	var store;
	var myData;
	var tempData;
	var len=0.04;//缓冲区分析大小
	var bufferResult;//缓冲区分析结果
  Ext.onReady(function(){
	myData =<%=rows%>;
	tempData=<%=rows%>;
    store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        fields: [
           {name: '编号'},
           {name: '序号'},
           {name: '坐标'},
           {name: '图斑编号'},
           {name: '核查'},
           {name: '删除'}
        ]
    });  
        var width=document.body.clientWidth;
        var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store, 
        height: height,
        columns: [
        	{header: '编号', hidden:true, width: width*0.15},
        	{header: '序号', hidden:true, width: width*0.15},
        	{header: '坐标', hidden:true, width: width*0.15},
            {header: '图斑编号',width: width*0.6,renderer: change},
            {header: '核查', width: width*0.17, sortable: false, renderer: modify},
            {header: '删除', width: width*0.16, sortable: false, renderer: del}
        ],
        height: height*0.75,
        listeners:{
		       rowclick:function(grid,row){	
		       var id=store.getAt(row).get('图斑编号');
		       var zb=store.getAt(row).get('坐标');
		       parent.parent.parent.center.queryAndLocation("DC_YW",5,"tbbh='"+id+"'",17,true);
			       parent.parent.monitor.isMonitor=false;
			      document.getElementById("isMonitor").value='开始导航';
			       document.getElementById("isMonitor").disabled=false;
		       if(parent.parent.monitor.start_x!=''){
			       // var start=parent.parent.parent.center.getPoint(parent.parent.monitor.end_x,parent.parent.monitor.end_y);
			       // var end=parent.parent.parent.center.getPoint(zb.split(',')[0] ,zb.split(',')[1] );
			       parent.parent.monitor.mdd_x=zb.split(',')[0];
			       parent.parent.monitor.mdd_y=zb.split(',')[1];
			       // var geometry=parent.parent.parent.center.getPolyline(start,end);
			       // parent.parent.parent.center.addToMap(geometry);
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
     return "<a href='#' onclick='modifyShtc("+id+");return false;'><img src='gisapp/images/view.png' alt='开始核查'></a>";
  }
  
  function modifyShtc(id){
    var tbbh=myData[id][3];
    var res;
    var basePath="<%=basePath %>"; 
    var actionName = "mapFunctionAC";
    var actionMethod = "markBeiAnJudge";
	var parameter="TBBH="+tbbh;
    var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
    var arr=result.split("@");
    var response=parent.parent.parent.center.queryAndLocation("DC_YW",5,"tbbh='"+tbbh+"'",17,true);
    if(response){
    //弹出条件
     if(arr[1]=="1"){
       res=window.showModalDialog(
				"/hotline/supervisory/dc/pages/1/dc_ydqkdcb.jsp?status=0&jdbcname=ywJdbcTemplate&yw_guid="+arr[0], "",
				"dialogWidth=800px;dialogHeight=700px;status=no;scroll=no");
      }else{
       res=window.showModalDialog(
				"/hotline/supervisory/dc/pages/2/dc_ydqkdcb.jsp?status=0&jdbcname=ywJdbcTemplate&yw_guid="+arr[0], "",
				"dialogWidth=800px;dialogHeight=700px;status=no;scroll=no");
      }
        if(!res){document.location.reload();}
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

  function addTask(){
     parent.parent.parent.center.showAddTask();
  }
  function startMonitor(){
  if(parent.parent.monitor.isMonitor){
  parent.parent.monitor.isMonitor=false;
  document.getElementById("isMonitor").value='开始导航';
  if(top.graphic!=null){
			parent.parent.parent.center.map.graphics.remove(top.graphic);
			}
  }else{
  parent.parent.monitor.isMonitor=true;
  document.getElementById("isMonitor").value='停止导航';
  }
  }
   function buffer(){
 if(parent.parent.monitor.start_x!='' && parent.parent.monitor.start_y!=''){
 				parent.parent.parent.center.putClientCommond("location","doit");
		        parent.parent.parent.center.putRestParameter("_$sid","aaa");
		        parent.parent.parent.center.putRestParameter("x",parent.parent.monitor.start_x);
		        parent.parent.parent.center.putRestParameter("y",parent.parent.monitor.start_y);
		        parent.parent.parent.center.putRestParameter("len",len);
			    bufferResult = parent.parent.parent.center.restRequest();

			    var size=0;
			    
			    if(bufferResult!=null){
			    //周围图斑赋值
     for(var i=0;i<bufferResult.length;i++){
     for(var j=0;j<myData.length;j++){
     if(bufferResult[i]==myData[j][2]){
      tempData[size++]=myData[j];
     }
     }
     }
     //其余图斑
     var redSize=size;
     for(var i=0;i<myData.length;i++){
      for(var j=0;j<redSize;j++){
      if(myData[i][2]==tempData[j][2]){
      break;
      }
      }
      if(j==redSize){
      tempData[size++]=myData[i];
      }
     }

 }
 			    store.loadData(tempData);
 }
 }
     function change(val){
     if(bufferResult!=null){
     for(var i=0;i<bufferResult.length;i++){
     if(val==bufferResult[i]){
            return '<span style="color:red;">' + val + '</span>';
     }
     }
     }
      return val;
    }
 </script>
	<body>
		 <input type="button" onclick="addTask()" value="添加卫片图斑任务" style="color:#00509F"/>
		 <input  type="button" id="isMonitor" name=""isMonitor""  onclick='startMonitor()' value="开始导航" style="color:#00509F" />
		 <div id="status_grid"  style="margin-top:0px;width:100%;height:95%;" ></div>
	</body>
</html>