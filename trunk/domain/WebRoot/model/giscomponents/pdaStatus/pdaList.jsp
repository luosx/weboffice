﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.gisapp.components.pdastatus.PdaStatusOperation"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "ext/";
        String type=request.getParameter("type");
    	String tree=PdaStatusOperation.getInstance().getTree(type);
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
		<script type="text/javascript" src="<%=basePath%>/common/js/ajax.js"></script>
		<%@ include file="/common/include/ext.jspf" %>
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
	</head>
	<script>

var tree;
var loadFlag=true;
var showAlltimer;
var showOnlinetimer;
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
                if(checked==true){
				  doLocation(node.attributes.id);
			    }else{
                 parent.parent.center.clearSimple(node.attributes.text.replace('<font color=green>','').replace('<font color=gray>','').replace('</font>',''));
                }
             }
        }
        
    });
   //tree.on('click', function(node, checked){
   //   if(node.attributes.checked = checked){
   //       doLocation(node.attributes.id);
   //   }
   //})
 tree.render();
  //先展开用于初始化ext的checked选项,否则无法获取mapService的可见图层
 tree.getRootNode().expand(true); 

//再合并
 //tree.getRootNode().collapse(true); 
});
/*
*根据手持机编号，在地图上进行定位
*
*/
function showOnline(){
window.location.href="<%=basePath%>gisapp/pages/components/pdaStatus/pdaList.jsp?type=1";
}

function showAll(){
  window.location.href="<%=basePath%>gisapp/pages/components/pdaStatus/pdaList.jsp?type=0";
}

function runShowAll(){
    if('<%=type%>'=='0'){
     showAlltimer = setTimeout("showAll()",300000);
    }else{
     showOnlinetimer = setTimeout("showOnline()",300000);
    }
}

function showAllGps(){
document.getElementById("check").style.color='#FF0';
    parent.parent.center.clearOverlays();
    parent.parent.center.setMapEnv();
    var path = "<%=basePath%>";
        var actionName = "pdaStatusAC";
        var actionMethod = "getOnlineGpsId";
        var result = ajaxRequest(path,actionName,actionMethod);
        var ids=result.split("@");
        for(var i=0;i<ids.length-1;i++){
           doLocation(ids[i]);
        }
}

function doLocation(id){
//根据id获取手持机坐标，如果在线则获取当前坐标，不在线获取上次坐标
	var actionName = "pdaStatusAC";
	var actionMethod = "getCurrentPositon";
	var parameter="id="+id;
	var result = ajaxRequest('<%=basePath%>',actionName,actionMethod,parameter);
//根据坐标在地图上进行定位
	var title=tree.getNodeById(id).attributes.text.replace('<font color=green>','').replace('<font color=gray>','').replace('</font>','');
	if(result.split(',')[0]!="null"){
	   parent.parent.center.mark(result.split(',')[0],result.split(',')[1],true,false,title,id);
	}else{
	   alert("无坐标信息！");
	}
}
</script>
	<body bgcolor="#FFFFFF" onload="runShowAll()">
         <%
            if("0".equals(type)){
         %>
            <div style="margin-top:10px"><input id="online" type="button" value="在线" style="background-color:#2E77C6;color:#FFF;" onclick="showOnline()" />&nbsp&nbsp&nbsp<input id="all" type="button" value="全部" style="background-color:#2E77C6;color:#FF0;" onclick="showAll()" />&nbsp&nbsp&nbsp<input id="check" type="button" value="全局监控" style="background-color:#2E77C6;color:#FFF;" onclick="showAllGps()" /></div>
         <%
            }else{
         %>
           <div style="margin-top:10px"><input id="online" type="button" value="在线" style="background-color:#2E77C6;color:#FF0;" onclick="showOnline()" />&nbsp&nbsp&nbsp<input id="all" type="button" value="全部" style="background-color:#2E77C6;color:#FFF;" onclick="showAll()" />&nbsp&nbsp&nbsp<input id="check" type="button" value="全局监控" style="background-color:#2E77C6;color:#FFF;" onclick="showAllGps()" /></div>
         <%   	 	
            }
         %>
	   
		<div id="mapTree"  style="margin-Left:0px;margin-Right:0px;margin-Top:5px;margin-Bottom:0px;"/>
	</body>
</html>
