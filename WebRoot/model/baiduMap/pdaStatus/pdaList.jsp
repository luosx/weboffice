﻿﻿﻿﻿﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.giscomponents.pdastatus.PdaStatusOperation"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String extPath = basePath + "ext/";
    String tree=PdaStatusOperation.getInstance().getTree();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
        <base href="<%=basePath%>">
		<title>outlookBar</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>  
		<%@ include file="/base/include/ext.jspf" %>
<style>
body {
	font-family: helvetica, tahoma, verdana, sans-serif;
	padding: 0px;
	scrollbar-3dlight-color:#D4D0C8; 
  	scrollbar-highlight-color:#fff; 
  	scrollbar-face-color:#E4E4E4; 
  	scrollbar-arrow-color:#666; 
 	scrollbar-shadow-color:#808080; 
  	scrollbar-darkshadow-color:#D7DCE0; 
  	scrollbar-base-color:#D7DCE0; 
 	scrollbar-track-color:#;	
}
</STYLE>
<style>
		a{
			color:#DD6F00; 
			text-decoration:none;
			margin-left:10px;
		 }
		a:hover{
			color:green;
		}
</style>
<script type="text/javascript" src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
<script type="text/javascript" src="<%=basePath%>gisapp/pages/framework/frameworkConfig.js"></script>
<script type="text/javascript" src="<%=basePath%>gisapp/pages/framework/frameworkApplication.js"></script>
<script type="text/javascript" src="<%=basePath%>gisapp/pages/framework/frameworkHttpRequest.js"></script>
<script type="text/javascript" src="<%=basePath%>gisapp/pages/components/pdaStatus/timer.js"></script>
</head>

<script>
var tree;
var showAlltimer;
var refreshtimer;
var checktimer;
var checkedNodes; 
var hasInfoWindow = true; 
var isAutoCenter=true;
var startzbs;
var startids;
var showids="";
Ext.onReady(function(){
    tree = new Ext.tree.TreePanel({ 
        el:'mapTree',  
        useArrows:true,  
        autoScroll:true, 
		frame: false, 			//显示树形列表样式   
        animate:true,
        enableDD:true,
        margins: '2 2 0 2',
        autoScroll: true,
        border: false,
        containerScroll: true,
        rootVisible: false,
        checkModel: 'cascade',
        onlyLeafCheckable: false,
        root: new Ext.tree.AsyncTreeNode({
            expanded: false,
            children: [<%=tree%>]
        }),
        listeners: {
            'checkchange': function(node, checked){
                   parent.parent.center.start=null;
                   parent.parent.center.clearSimpleGpsTimer();
		           if(checked){
		              doLocation(node.attributes.id);
				   }else{
				      //获取所有勾选的的设备Nodes集合，并在百度地图上显示      
		              checkedNodes = tree.getChecked();  
		              parent.parent.center.clearMarkerExceptChecked(checkedNodes,hasInfoWindow);   
				   }
		     }
        }      
    });
 tree.render();
 tree.getRootNode().expand(true); 
 showAll();
});

function checkNodes(){
	var nodevalue="";
	var nodeids;
    var rootNode=tree.getRootNode();//获取根节点
    findchildnode(rootNode); //开始递归
	nodevalue=nodevalue.substr(0, nodevalue.length - 1);
	 function findchildnode(node){
		var childnodes = node.childNodes;
		var nd;
		 for(var i=0;i<childnodes.length;i++){ //从节点中取出子节点依次遍历
				  nd = childnodes[i];
				  nodevalue += nd.id + ",";
				  if(nd.hasChildNodes()){ //判断子节点下是否存在子节点
				    findchildnode(nd); //如果存在子节点 递归
		}   
	   }
	 }
	nodeids=nodevalue.split(",");
    for(var i=0;i<nodeids.length;i++){
       alert(tree.getNodeById(nodeids[i]).attributes.checked);
       tree.getNodeById(nodeids[i]).attributes.checked=false;
    }
   }



/*
*刷新在线GPS设备
*/
function showAll(){
     var path = "<%=basePath%>";
     var actionName = "pdaStatusAC";
     var actionMethod = "getAllGpsId";
     var result = ajaxRequest(path,actionName,actionMethod);
     var ids=result.split("@");
     for(var i=0;i<ids.length/2;i++){
       var name=tree.getNodeById(ids[i*2]).attributes.text;
       if(ids[i*2+1]=='0'){
         name=name.replace('在线','离线').replace('<font color=green>','<font color=gray>');
       }else{
         name=name.replace('离线','在线').replace('<font color=gray>','<font color=green>');
       }
       tree.getNodeById(ids[i*2]).setText(name); 
     }
     refreshtimer = setTimeout("showAll()",10000);
 }
 
/*
* 选中监控
*/
function checkOnline(){
    parent.parent.center.sflag=1;
	document.getElementById("check1").style.color='FF0';
	document.getElementById("check").style.color='FFF';
	startzbs = null;
	startids = null;
    var nodes="";
    checkedNodes = tree.getChecked(); 
    if(checkedNodes.length==0){
       alert("请选择设备！")
    }else{
        document.getElementById("mapTree").disabled=true;
	    for(var i=0;i<checkedNodes.length;i++){
	       nodes=nodes+checkedNodes[i].id+"@";
	    }    
	    parent.parent.center.clearTimeout(parent.parent.center.showSimpleTimer);
	    clearTimeout(showAlltimer);
	    parent.parent.center.clearOverlays();
		if(document.getElementById("check1").value=='取消监控选中设备'){
		   document.getElementById("check1").value='监控选中设备';
		   document.getElementById("mapTree").disabled=false; 
		   document.getElementById("check").disabled=false;
		   parent.parent.center.clearOverlays();
		   clearTimeout(checktimer);
		   parent.parent.center.sflag=0;
		   parent.parent.center.clearMarkerExceptChecked(checkedNodes,hasInfoWindow);   
		}else{
		   document.getElementById("check").disabled=true;
		   var path = "<%=basePath%>";
		   var actionName = "pdaStatusAC";
		   var actionMethod = "getCheckedGpsId";
		   var parmeter="nodes="+nodes;
		   var result = ajaxRequest(path,actionName,actionMethod,parmeter);
		   var res=result.split(";");
		     document.getElementById("check1").value='取消监控选中设备';
		     var ids=res[0].split("@");
		     startids=res[0].split("@");
		     startzbs=res[1].split("@");
		     for(var i=0;i<ids.length;i++){
		        doLocation(ids[i]);
		     };
		     gpsChecked(nodes);
	     }
      }
}


function gpsChecked(nodes){  
        parent.parent.center.clearSimpleOverlay();
        var path = "<%=basePath%>";
        var actionName = "pdaStatusAC";
        var actionMethod = "getCheckedGpsId";
        var parmeter="nodes="+nodes;
	    var result = ajaxRequest(path,actionName,actionMethod,parmeter);
        var res=result.split(";");
        var ids=res[0].split("@");
        var zbs=res[1].split("@");
        for(var i=0;i<ids.length;i++){
           doLocation(ids[i]);
           parent.parent.center.drawLine(startzbs[i*2+1],startzbs[i*2],zbs[i*2+1],zbs[i*2]);
        } 
        startids=res[0].split("@");
        startzbs=res[1].split("@"); 
        checktimer = setTimeout("gpsChecked('"+nodes+"')",5000);
} 

/*
* 全局监控
*/
function showAllGps(){
startzbs = null;
startids = null;
showids="";
checkedNodes = tree.getChecked(); 
document.getElementById("check").style.color='FF0';
document.getElementById("check1").style.color='FFF';
parent.parent.center.clearTimeout(parent.parent.center.showSimpleTimer);
clearTimeout(checktimer);
if( document.getElementById("check").value=='取消监控在线设备'){
	   document.getElementById("check").value='监控在线设备';
	   document.getElementById("check1").disabled=false;
	   parent.parent.center.clearOverlays();
	   clearTimeout(showAlltimer);
	   document.getElementById("mapTree").disabled=false; 
	   parent.parent.center.sflag=0;
	   parent.parent.center.clearMarkerExceptChecked(checkedNodes,hasInfoWindow);   
}else{
        var path = "<%=basePath%>";
        var actionName = "pdaStatusAC";
        var actionMethod = "getOnlineGpsId";
        var result = ajaxRequest(path,actionName,actionMethod);
        var res=result.split(";");
        if(res[0]==""||res[0]==null){
          alert("无在线设备！");
        }else{
          document.getElementById("check1").disabled=true;
          parent.parent.center.clearOverlays();
          document.getElementById("check").value='取消监控在线设备';
          document.getElementById("mapTree").disabled=true; 
          var ids=res[0].split("@");
          startids=res[0].split("@");
          startzbs=res[1].split("@");
          for(var i=0;i<ids.length;i++){
           doLocation(ids[i]);
          };
          gpsStatusCheck();
        }
     }
}


function gpsStatusCheck(){
        parent.parent.center.clearSimpleOverlay();
        var path = "<%=basePath%>";
        var actionName = "pdaStatusAC";
        var actionMethod = "getOnlineGpsId";
        var result = ajaxRequest(path,actionName,actionMethod);
        var res=result.split(";");
        if(res[0]!=""||res[0]!=null){
	        var ids=res[0].split("@");
	        var zbs=res[1].split("@");
	        for(var i=0;i<ids.length;i++){
	           doLocation(ids[i]);
	           for(var j=0;j<startids.length;j++){
	              if(ids[i]==startids[j]){
	                 parent.parent.center.drawLine(startzbs[j*2+1],startzbs[j*2],zbs[i*2+1],zbs[i*2]);
	              }
	           }
	        }
	      }
	      for(var i=0;i<startids.length;i++){
	            var flag=true;
	            for(var j=0;j<ids.length;j++){
	               if(ids[j]==startids[i]){
	                  flag=false; 
	               }         
	            }
	            if(flag){
	              showids=showids+startids[i]+"@";
	            }
	        }
	        var sids=showids.split("@");
	        for(var i=0;i<sids.length-1;i++){
	          if(sids[i]!=null||sids[i]!=""){
	              doLocation(sids[i]);
	           }
	        } 
	        startids=res[0].split("@");
	        startzbs=res[1].split("@"); 
	        showAlltimer = setTimeout("gpsStatusCheck()",5000);
} 
 

function doLocation(id){
    var path = "<%=basePath%>";
    var actionName = "pdaStatusAC";
    var actionMethod = "getPositionById";
    var parmeter="gpsId="+id;
    var res = ajaxRequest(path,actionName,actionMethod,parmeter);
    var result=res.split("@");
	if(result[0] != null){
	  parent.parent.center.marker(result[0],result[1],isAutoCenter,hasInfoWindow,id,'shouchiji.png','car.png');     
	}else{
	   alert("无坐标信息！");
	}
} 


</script>
	<body>
	   <div style="margin-top:-10px"><input id="check1" type="button" value="监控选中设备" style="background-color:#2E77C6;color:#FFF;" onclick="checkOnline()"  /><input id="check" type="button" value="监控在线设备" style="background-color:#2E77C6;color:#FFF;" onclick="showAllGps()" /></div> 
	   <div id="mapTree"  style="margin-Left:0px;margin-Right:0px;margin-Top:5px;margin-Bottom:0px;"/>
	</body>
</html>
