﻿﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.giscomponents.infoquery.InfoQueryLayer"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";	
	String queryLayer=InfoQueryLayer.getInstance().getQueryLayer();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>infoQuery</title>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="../componentsbase.jspf" %>
		<script src="<%=basePath%>/common/js/ajax.js"></script>
		<style type="text/css">
html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 100%;
}
.btn {
	background: url('<%=basePath%>common/images/button.png');
	height:23;
	width:73;
	CURSOR: hand;
	FONT-SIZE: 12px;
	color:#CC3300 ;
	BORDER: #002D96 0px solid;
	}
</style>
<script type="text/javascript">
var basePath="<%=basePath%>";
</script>
	</head>
	<body bgcolor="#FFFFFF">
		<div id="form-ct" style="width: 100%; height: 18%;"></div>
		 <div id='result'  title="图斑查询结果" style="width:300px;height:300px;overflow: auto; ">
	</body>
	<script>
	//页面加载前激活地图选项卡
	//parent.center_tabs.setActiveTab(0); 		
	var myData;
	function strToJson(str){
    var json = eval('(' + str + ')');
    return json;
}

var index;
Ext.onReady(function() {
	
    var queryForm = new Ext.FormPanel({
        labelWidth: 60, // label settings here cascade unless overridden
        labelAlign:"center",
        frame:true,
        bodyStyle:'padding:0px 0px 0',
        width: 300,
        defaultType: 'textfield',
        items: [{  
	                xtype: 'textfield',
	                id      : 'keyWord',
	                fieldLabel: '查询内容',
	                value:'街道',
	                anchor    : '0'
	            	},{
           		   xtype: 'radiogroup',
                   fieldLabel: '所在图层',
                   id:'treeid',
                   columns: 1,
                   items:<%=queryLayer%>          
              },{
       		       xtype: 'button',
       		       text: '查询',
       		       listeners:{
       			   'click':function(t,e){
       				var treeid=queryForm.getForm().getValues().treeid;
       				//alert(treeid)
       				var keyWord = queryForm.get('keyWord').getValue();
					if(keyWord == null ||  keyWord == "" ){
						return;
					}else{
					//从后台数据库查询，将查询结果在列表中进行展现
					    var actionName = "infoQueryAC";
					    var actionMethod = "query";
					    var parameter="treeid="+treeid+"&keyWord="+escape(escape(keyWord));
						var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
						myData=unescape(result);
						//alert(myData)
						index=-1;
						nextPage();
            		}
       			}
       		}
   		}
        ]
    });
    queryForm.render('form-ct');  
});

function previousPage(){
index=index-1;
var t=myData.split('@@')[index];
document.getElementById('result').innerHTML=t;
if(index>0){
document.getElementById('result').innerHTML+="<button class='btn' style='position:relative;left:-140px;' onclick='previousPage()'>上一页</button>";
}else{
document.getElementById('result').innerHTML+="<button class='btn' style='position:relative;left:-140px;' disabled='disabled'>上一页</button>";
}
}
function  nextPage(){
index++;
var t=myData.split('@@')[index];
document.getElementById('result').innerHTML=t;
if(index!=0){
document.getElementById('result').innerHTML+="<button class='btn' style='position:relative;left:-140px;' onclick='previousPage()'>上一页</button>";
}else{
if(myData!=''){
document.getElementById('result').innerHTML+="<button class='btn' style='position:relative;left:-140px;' disabled='disabled'>上一页</button>";
}
}	
}

function  overview(serid,layid,objList,pointList){	
//parent.center.queryTB(serid,layid,objList,pointList);
var Barray;//图斑objectid数组
var tburl;//图斑url
var tbindex;//序号        
var pl;//图斑四至数组

    Barray=objList;
    tbindex=0;
    pl=pointList;
    for (var i = 0; i < mapServices.length; i++) {
        if (mapServices[i].id == serviceId) {
            tburl=mapServices[i].url+"/"+layerId;
            break;
        }
    }
    parent.center.navigationToolbar.zoomToFullExtent();
    parent.center.clearHighlight();
    parent.center.queryTbAndLocation(Barray, tburl, tbindex, pl);
}

function locationMap(serid,layid,yw_guid){
   parent.center.queryAndLocation(serid,layid,"objectid="+yw_guid,7,true);
}
</script>
</html>
