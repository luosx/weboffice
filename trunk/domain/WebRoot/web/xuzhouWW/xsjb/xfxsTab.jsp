<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xuzhouWW.Xsjb12336"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String jdbcname=request.getParameter("jdbcname");
	String yw_guid=request.getParameter("yw_guid");
	String style=request.getParameter("style");
	String x="123";
	String y="345";
	if(style.equals("1")){
	String point=new Xsjb12336().getPoint(yw_guid);
	if(point.length()>3){
	  String [] xy=point.split(",");
	  x=xy[0];
	  y=xy[1];
	 }
	}
	String parmarts="jdbcname="+jdbcname+"&yw_guid="+yw_guid;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>信访事项—已立案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf" %>
   <style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }
    .map_nav{ width:150px; height:29px; line-height:20px;background:url(images/nav_m.png) no-repeat;  position:absolute; top:52px; right:70px; z-index:1000;}
.map_nav ul {margin-left:6px;margin-top:4px;}
.map_nav li img{ cursor: pointer; margin-left:1px;}
.map_nav li{ float:left; width:40px;}
.map_nav span{ padding:0px 7px; cursor:pointer; display:block; color: #666; }
   </style>
   <script>
   Ext.onReady(function(){
   	Ext.QuickTips.init();
    var w=document.body.clientWidth;
	var h=document.body.clientHeight - 30; 
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,  
        frame:true,
        items:[
        	{
                title: '信访登记',
                html: "<iframe id='xfdj' width='"+w+"' height='"+h+"' src='wfxsdjb.jsp?<%=parmarts%>'/>" ,
                 listeners :{
		                    activate: {
                            fn: hide
		                    }
		                }     
            },{
                title: '地图标注',
                html: "<div><iframe id='map' name='map' width='"+w+"' height='"+h+"' src='<%=basePath%>web/xuzhouWW/tdmap/fxgis/FxGIS.html?debug=true&dolocation=true&p={\"rings\":[[[117.18292351612803,34.30403479680317],[117.18652840511129,34.3035199126627],[117.18626909059827,34.3014262745128],[117.18355469502457, 34.30170522425556],[117.18292351612803,34.30403479680317]]],\"spatialReference\":{\"wkid\":2364}}&initFunction=[{\"name\":\"setCenterAt\",\"parameters\":\"117.18473531014112,34.30273489468256\"}]'/>" ,
                listeners :{
		                    activate: {
                            fn: view
		                    }
		                }         
            }
        ]
        
    })
  });
   function view(){
	 var tab=document.getElementById('tab');
	 if(tab.style.display=="block"){
		 tab.style.display="none";
	 }else{
		 tab.style.display="block";
		 // location();
		 // setTimeout('location()',2000);
	 }
	 
 }
  function hide(){
	 var tab=document.getElementById('tab');
	 if(tab.style.display=="none"){
		 tab.style.display="block";
	 }else{
		 tab.style.display="none";
	 }
 }
 
 function setPoint(){
   frames["map"].swfobject.getObjectById("FxGIS").drawPoint('');
 // document.getElementById('map').contentWindow.getObjectById("FxGIS").drawPoint("");
 }
 function drawLine(){
  frames["map"].swfobject.getObjectById("FxGIS").drawPolygon();
 }
  function location(){
   var loct='{"rings":[[[117.18292351612803,34.30403479680317],[117.18652840511129,34.3035199126627],[117.18626909059827,34.3014262745128],[117.18355469502457, 34.30170522425556],[117.18292351612803,34.30403479680317]]],"spatialReference":{"wkid":2364}}';
  frames["map"].swfobject.getObjectById("FxGIS").doLocation(loct);
  var x=<%=x%>;
  var y=<%=y%>;
  //静态数据

  x='117.18473531014112';
  y='34.30273489468256';
  var point ="[{\"y\":\""+y+"\",\"x\":\""+x+"\"}]";
  frames["map"].swfobject.getObjectById("FxGIS").setCenterAt(x,y);
 }
 function save(){
 alert("保存成功！");
 }
 
 function search(){
   var value=document.getElementById('searchContent').value;
   if(value=='国土局'){
     frames["map"].swfobject.getObjectById("FxGIS").setCenterAtAndZoom(117.16982464311357,34.26089736587228,16);
   }else if(value=='江庄镇'||value=='江庄'){
     frames["map"].swfobject.getObjectById("FxGIS").setCenterAtAndZoom(117.4348942015171,34.48902887727345,16);
   }else{
     var temp="搜索不到'"+value+"'";
     setTimeout(alert(temp),2000);
   }
 }
 
 function changeMap(type){
    if(type=="vector"){
     document.getElementById(type).innerHTML="<div style='background-color:#99D9EA;width:33px;padding-left:6px;padding-top: 2px'>地图</div>";
     document.getElementById("image").innerHTML="<div style='padding-top: 2px'>影像<div>";
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('VECTOR',true);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('V_ANNO',true);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('IMAGE',false);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('I_ANNO',false);
     }
     if(type=="image"){
     document.getElementById(type).innerHTML="<div style='background-color:#99D9EA;width:32px;padding-left:5px; padding-top: 2px'>影像</div>";
     document.getElementById("vector").innerHTML="<div style='padding-top: 2px'>地图</div>";
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('VECTOR',false);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('V_ANNO',false);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('IMAGE',true);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('I_ANNO',true);
     }
  }
   </script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="statusTab" style="width:100%"></div>
		<div id="tab" class="map_nav" style="width:600px;height:150px;position:absolute;margin-right:10px; top:30px;display:block; ">
		<ul>
		  <li><input id="searchContent" type="text"></li>
		  <li><span id="save" style="margin-top: 2px" onClick='search()'>搜索</span></li>
		  <li><span id="point" onClick='setPoint()'><div style='width:45px;padding-left:5px;padding-top: 2px'>点标注</div></span></li>
		  <li><span id="areas" onClick='drawLine()' ><div style='width:45px;padding-left:5px;padding-top: 2px'>面标注</div></span></li>
	     <li><span id="vector" onClick='changeMap("vector")'><div style='background-color:#99D9EA;width:33px;padding-left:5px;padding-top: 2px'>地图</div></span></li>
	     <li><span id="image"  style="margin-top:1px " onClick='changeMap("image")'>影像</span></li>
	     <li><span id="save" style="margin-top:2px "  onClick='save()'>保存</span></li>
           </ul>
   </div>
	</body>
</html>
