﻿<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
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
	    <%@ include file="/base/include/ext.jspf" %>
	    <%@ include file="/base/include/restRequest.jspf" %>
	</head>
	<style>
	    a{TEXT-DECORATION:none}
	    a:link{TEXT-DECORATION: none;color: #000000}
	    a:hover{TEXT-DECORATION: none;color: #000000}
	    a:ACTIVE {TEXT-DECORATION: underline}
	    a:visited {text-decoration: underline}
	</style>
	<script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/menu.js"></script>
	<script type="text/javascript" src="model/fxgiscomponents/infoQuery/ringsToJson.js"></script>
	<script>
	var myData;
	var  grid;
	var  store;
	var d;
    Ext.onReady(function(){
        var width=document.body.clientWidth;
        
     d=eval(parent.rr);
     var fieldsArray = new Array();
     var columnArray = new Array();
     fieldsArray[0]={name: 'feature.geometry'}
     columnArray[0]=  {header: '标注',width:width*0.15,renderer: biaoZhu};
     for(var i=1;i<parent.queryfieldsinfo.length+1;i++){
      fieldsArray[i]= {name:'feature.attributes.'+parent.queryfields[i-1]};
      columnArray[i]={header:parent.queryfieldsinfo[i-1],dataIndex:'feature.attributes.'+parent.queryfields[i-1],width:width*(1/(parent.queryfieldsinfo.length+1))}   
     }

     var queryfieldsinfo = parent.queryfieldsinfo;
     store = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(d),
     remoteSort:true,
        fields: fieldsArray
    });  
    store.load({params:{start:0, limit:10}});

    var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store, 
        id:'gridID',
        columns: columnArray,
        stripeRows: true,
        stateful: true,
        stateId: 'grid',
        height:height-30,
        width:width,
        buttonAlign:'center',
        bbar: new Ext.PagingToolbar({
	        pageSize: 10,
	        store: store,
	      buttons: [{
        	text:'全局监控',
        	handler: qujuJK
        } ] 
        }),
        listeners:{
		       rowclick:function(grid,row){
		        var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
   				var rings = grid.getStore().getAt(rowIndex).get('feature.geometry');
   				var jsonstring=toJsonString(rings);
  				//图斑定位
  				parent.parent.center.frames["lower"].swfobject.getObjectById("FxGIS").doLocation(jsonstring);
		        
		        parent.selectRowIndex=rowIndex;
		       }
         } 
          
    });  
    grid.render('status_grid');
       grid.bbar.on("click", function(){
       parent.parent.center.frames["lower"].swfobject.getObjectById("FxGIS").clear();
         var  nu= grid.store.getCount();
	     var num = grid.getBottomToolbar().cursor; 
	     for(var i=0;i<nu;i++){
	      fanyebiaozhu(i);
	     }
    })    
 });
 function hqzb(rowIndex,a ){
  var zuobiaozu= grid.getStore().getAt(rowIndex).get('feature.geometry');
       var src='a.png';
       var xx= zuobiaozu.rings[0][0][0];
       var yy= zuobiaozu.rings[0][0][1];
      var point="[{\"y\":"+yy+",\"x\":"+xx+",\"icon\":\""+a+".png\",\"url\":\"\"}]";
      parent.parent.center.frames["lower"].swfobject.getObjectById("FxGIS").drawPoint(point);
 }
 function fanyebiaozhu(rowIndex){
   if(rowIndex%10==0){  
      var a='a';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==1){  
      var a='b';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==2){  
      var a='c';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==3){  
      var a='d';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==4){  
      var a='e';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==5){  
      var a='f';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==6){  
      var a='g';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==7){  
      var a='h';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==8){  
      var a='i';
      hqzb(rowIndex ,a);
   } if(rowIndex%10==9){  
      var a='j';
      hqzb(rowIndex ,a);
   }
 
 }
 
 
 
function biaoZhu(value, cellmeta, record, rowIndex){

   //var total = grid.getStrore().getCount();//数据总行数
   var total= grid.getStore().getTotalCount();//分页后当前页的数据总行数
   //rowIndex   gridpanel的行数
   if(rowIndex%10==0){  
      var a='a';
      hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;' ><img src='base/gis/images/a.png'></a>";
    
   }
   if(rowIndex%10==1){
     var a='b';
     hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/b.png'></a>";
   }
   if(rowIndex%10==2){
      var a='c';
    hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/c.png'></a>";
   }
   if(rowIndex%10==3){
       var a='d';
   hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/d.png'></a>";
   }
   if(rowIndex%10==4){
        var a='e';
   hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/e.png'></a>";
   }
   if(rowIndex%10==5){
      var a='f';
   hqzb(rowIndex,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/f.png'></a>";
   }
   if(rowIndex%10==6){
       var a='g';
    hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/g.png'></a>";
   }
   if(rowIndex%10==7){
      var a='h';
   hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/h.png'></a>";
   }
   if(rowIndex%10==8){
       var a='i';
     hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/i.png'></a>";
   }
   if(rowIndex%10==9){
      var a='j';
   hqzb(rowIndex ,a);
      return "<a href='#' onclick='biaozhu();return false;'><img src='base/gis/images/j.png'></a>";
   }
}

function biaozhu(){}
function tbbh(value, cellmeta, record, rowIndex){
   var XZQDM=d[rowIndex].feature.attributes.XZQDM;
   var JCBH=d[rowIndex].feature.attributes.JCBH;
   var tbbh=XZQDM+"-"+JCBH;
   return "<a href='#' onclick='tbbh1();return false;'>"+tbbh+"</a>";
}
function tbbh1(){
}
//全局监控
function qujuJK(){
   //重新调用图斑查询
   for(var i=0;i<6;i++){
 parent.parent.center.frames["lower"].swfobject.getObjectById("FxGIS").zoomOut();
  }
}
	</script>
	<body>
	    <div style="font-size:12px"></div>
		<div id="status_grid"></div>
	</body>
</html>