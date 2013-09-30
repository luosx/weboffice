﻿<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   
    String name = ProjectInfo.getInstance().getProjectName();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>执法监察系统</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <LINK href="css/index.css" type=text/css rel=stylesheet>
		<SCRIPT src="js/jquery.js" type=text/javascript></SCRIPT>
		<script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/menu.js"></script>
<style type="text/css">
body{
 margin:0px;
 padding:0px;
}
body,td,div,span,li{
 font-size:12px;
  color:#333;

}
.map_nav{ width:150px; height:29px; line-height:20px;background:url(images/nav_m.png) no-repeat;  position:absolute; top:50px; right:70px; z-index:1000;}
.map_nav ul {margin-left:6px;margin-top:1px;}
.map_nav li img{ cursor: pointer; margin-left:1px;}
.map_nav li{ float:left; width:40px;}
.map_nav span{ padding:0px 7px; cursor:pointer; display:block; color: #666; }
.map_nav2{ width:74px; height:29px; line-height:20px; position:absolute;top:0px; right:10px;background:url(images/tc_bg.png);z-index:1000}
.map_nav2 ul {width:67px;margin-top:1px;}
.map_nav2 li{margin:0 -1px 0 5px; float:left; /* border-left:1px solid #ddd; */}
#map_layer_control{ padding:0px 4px 0px 7px; cursor:pointer; display:block; color: #666; }
/* .map_nav2 li a{ color:#666;  padding:0px 7px;}
.map_nav2 li a:hover{ color:#fff; background:url(images/icon_38.gif) repeat-x; display:block; padding:0px 7px; text-decoration:none;} */
#layerDiv { border: 1px solid #A0A199;width: 100px;height: auto;z-index: 10000;background-color: #ffffff;position: absolute;left: 4px;top: 22px;display: none}
#layerDiv div:hover { background-color: #EBEBEB; }
#layerDiv span, #layerDiv label { font-family: "宋体",arial,sans-serif;font-size: 13px;cursor: pointer; }
.layer-checkbox { display: inline;float: left;font-size: 0;height: 11px;line-height: 8px;margin-left: 6px;margin-right: 5px;margin-top: 7px;width: 13px; }
.layer-word { line-height: 26px;overflow: hidden;background-color: #EBEBEB;white-space: nowrap; }
</style>
<SCRIPT type=text/javascript>
  function clearLayer(){
    frames["lower"].swfobject.getObjectById("FxGIS").clear();
  }
  
  function showRoute(){
    var bg=document.getElementById('route').style.background;
    if(bg=='#ffffff'){
      frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('ROUTE',true);
      document.getElementById('route').style.background='#CDC5BF';
    }else{
      frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('ROUTE',false);
      document.getElementById('route').style.background='#FFFFFF';
    }
  }

  function changeMap(type){
    if(type=="vector"){
     document.getElementById(type).innerHTML="<div style='background-color:#217EC8;width:32px;padding-left:3px'><font color='#FAF9F9'>地图</font></div>";
     document.getElementById("image").innerHTML="影像";
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('VECTOR',true);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('V_ANNO',true);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('IMAGE',false);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('I_ANNO',false);
     }
     if(type=="image"){
     document.getElementById(type).innerHTML="<div style='background-color:#217EC8;width:32px;padding-left:5px'><font color='#FAF9F9'>影像</font></div>";
     document.getElementById("vector").innerHTML="地图";
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('VECTOR',false);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('V_ANNO',false);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('IMAGE',true);
     frames["lower"].swfobject.getObjectById("FxGIS").setLayerVisiableById('I_ANNO',true);
     }
  }
  
  function changeScreen(){
     if(parent.content.cols=="0,9,*"){
       parent.content.cols="261,7,*";
       parent.parent.index.rows="53,28,*"
     }else{
       parent.content.cols="0,9,*";
       parent.parent.index.rows="0,0,*";
     }
  }
  
  function locator(){
    var v=document.getElementById('c').value;
    var x=0;
    var y=0;
    var l=11;
    if(v=='all'){
      x=114.88525629043579;y=36.914695664722224;l=10;
    }else if(v=='jzz'){
      x=114.87846594303846;y=36.909628023342925;
    }else if(v=='xzz'){
      x=114.89895399659872;y=36.84818801502515;
    }else if(v=='stz'){
      x=114.8037701100111;y=36.80846812280434;
    }else if(v=='ftdx'){
      x=114.78028200566769;y=36.884189029832505;
    }else if(v=='wgyx'){
      x=114.92770291864872;y=36.921927943980286;
    }else if(v=='fzx'){
      x=114.86494794487953;y=36.87426794609517;
    }else if(v=='czz'){
      x= 114.88146800547838;y=36.76259095138669;
    }
    frames["lower"].swfobject.getObjectById("FxGIS").setCenterAtAndZoom(x,y,l,false);
  }
</SCRIPT>
</head>
    <body >

<table background="images/menu_bk.PNG" height=38 width=100%>
<tr>
<td width=99 height=38 style="cursor: hand;" onClick="openMap()">
<img id='mapImg' name='mapImg' style="position:absolute;left:-5;top:6;"  src="images/tab_1.png" width="99" height="26" />
</td>
<td width=99 height=38 style="cursor: hand;" onClick="openURL('<%=basePath%>web/jizeWW/padResult/padDatalist.jsp',0)">
<img id='urlImg' name='urlImg' style="position:absolute;left:94;top:6;"  src="images/tab_2.png" width="99" height="26" />
</td>
<td width='100%'></td>
<!-- 
<td   id='type' align="center" valign="top"  style="cursor: hand;"><input type='text' style="vertical-align: middle;border:0;height:24px;margin-top:2px;line-height:24px;margin-right:2px;color:white;font-weight:blod;background-color:#6fcbf8;"/></td>
<td   id='map_selec'   align="center" valign="top"  style="cursor: hand;"><img src="images/search.png" title="搜索" width="27" height="27" /></td>
-->
<td  id='zoomin' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='zoomIn()'><img src="images/zoom-in.png" title="放大" width="27" height="27" /></td>
<td  id='zoomout' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='zoomOut()'><img src="images/zoom-out.png" title="缩小" width="27" height="27" /></td>
<td  id='zoomToFullExtent'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='zoomToFullExtent()'><img src="images/Full_Extent.png" title="初始视图" width="27" height="27" /></td>
<td  id='pan' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='pan()'><img src="images/pan.png" width="27" title="漫游" title="直线长度量算" height="27" /></td>
<td  id='rule'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='measureLengths()'><img src="images/rule.png" width="27" height="27" /></td>
<td  id='clear' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='clearLayer()'><img src="images/clear.png" title="清除" width="27" height="27" /></td>
<td  id='legend'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='legend()'><img src="images/legend.png" title="图例" width="27" height="27" /></td>
<td  id='print' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='showInfo()'><img src="images/print.png" title="打印" width="27" height="27" /></td>

<td width=100 >
    <SELECT id="c"  name="c" onChange="locator()" style="vertical-align: middle;padding:0;margin:0;margin-bottom:10px;">
      <OPTION value='all' selected>鸡泽县</OPTION>
		<option value='jzz'>鸡泽镇</option>
		<option value='xzz'>小寨镇</option>
		<option value='stz'>双塔镇</option>
		<option value='ftdx'>浮图店乡</option>
		<option value='wgyx'>吴官营乡</option>
		<option value='fzx'>风正乡</option>
		<option value='czz'>曹庄镇</option>
    </SELECT>
</td>
</tr>
</table>

<div onClick='legend()' style="width:280px;height:404px;position:absolute; right:0px; top:132px;display:none; " id='legend1'>
<img src="images/legendInfo.png" width="280" height="404" />
</div>
<div onClick='closeInfo()' style="width:375px;height:171px;position:absolute; left:100px; top:100px;display:none; " id='info'>
<img src="images/info.png" width="375" height="171" />
</div>
<%--!add by zhaow 操作图层的几个按钮--%>
<div id="map_nav" class="map_nav">
<ul id="mapchose">
    <li><img id="full_screen" width="36" height="19" border="0" onClick="changeScreen()" src="images/fullScreen.png" title="显示全屏" /></li>
	<li><span id="vector" onClick='changeMap("vector")'><div style='background-color:#217EC8;width:32px;padding-left:3px'><font color='#FAF9F9'>地图</font></div></span></li>
	<li><span id="image" onClick='changeMap("image")'>影像</span></li>
</ul>
</div>
<!--<div id="map_nav2" class="map_nav2" style="z-index: 10000;top:50px;" onMouseOver="document.getElementById('layerDiv').style.display='inline'" onMouseOut="document.getElementById('layerDiv').style.display='none'">
				<div><ul>
					<li id="layer"><span id="map_layer_control"><img src="images/tuc_s.png" width="11" height="9" style="display:inline; margin-left:3px; margin-top:4px; margin-right:3px;"/>图层<img src="images/tuc_j.png" width="9" height="7" style="display:inline; margin-left:2px;" /></span></li>
				</ul>
				</div>
				<div id="layerDiv">
					<div id="cnItem" class="layer-item" title="显示巡查路线">
						<div id="cnCheckbox" class="layer-checkbox"></div>
						<div class="layer-word" id='route' style="background: #FFFFFF" onClick="showRoute()"><span>巡查路线</span></div>
						<input type="hidden" id="cnLayer" />
					</div>
					<%--!
					<div id="cnItem" class="layer-item" title="显示路况">
						<div id="cnCheckbox" class="layer-checkbox"></div>
						<div class="layer-word"><span>路况</span></div>
						<input type="hidden" id="cnLayer" />
					</div>--%>
				</div>
			</div>
-->

<iframe frameborder="0" id="lower"  name="lower"  style="width: 100%;height:100%; overflow: auto;" src="fxgis/FxGIS.html?debug=true"></iframe>
<iframe frameborder="0" id="operation"  style="display:none;" name="operation"  style="width: 100%;height:100%; overflow: auto;" src="<%=basePath%>web/jizeWW/padResult/PADDataList.jsp"></iframe>
    </body>
</html>
 <script>
 var openFlag="map";
 var url=document.getElementById("operation").src;
 function legend(){
	 var legend=document.getElementById('legend1');
	 if(legend.style.display==""){
		 legend.style.display="none";
	 }else{
		 legend.style.display="";
	 }
 }
   function closeInfo(){
    document.getElementById("info").style.display='none';
    openURL("<%=basePath%>web/<%=name%>/padResult/padDatalist.jsp",1);  
  }
  function showInfo(){
    document.getElementById("info").style.display='block';
  }
function openMap(){
	 if(openFlag!="map"){
	 openFlag="map";
	  document.getElementById('mapImg').src='images/tab_1.png';
	 document.getElementById('urlImg').src='images/tab_2.png';
	 document.getElementById('operation').style.display="none";
	 document.getElementById('lower').style.display="";
	 }
	 
	  var div_obj =document.getElementById("type");
		div_obj.style.display="block";
		var div_obj =document.getElementById("map_selec");
		div_obj.style.display="block";
	 var div_obj =document.getElementById("map_nav2");
		div_obj.style.display="block";
		var div_obj =document.getElementById("map_nav");
		div_obj.style.display="block";
		 var div_obj =document.getElementById("c");
		div_obj.style.display="block";
		var div_obj =document.getElementById("zoomin");
		div_obj.style.display="block";
		var div_obj =document.getElementById("zoomout");
        div_obj.style.display="block";
		var div_obj =document.getElementById("zoomToFullExtent");
		div_obj.style.display="block";
		var div_obj =document.getElementById("pan");
        div_obj.style.display="block";
		var div_obj =document.getElementById("rule");
		div_obj.style.display="block";
		var div_obj =document.getElementById("clear");
        div_obj.style.display="block";
		var div_obj =document.getElementById("legend");
		div_obj.style.display="block";
		var div_obj =document.getElementById("print");
		div_obj.style.display="block";
 }
 function openURL(url,flag){
  	 if(openFlag!="url"||flag==1){
 	 openFlag="url";
	 document.getElementById('mapImg').src='images/tab_3.png';
     document.getElementById('urlImg').src='images/tab_4.png';
	 document.getElementById('operation').style.display="";
	 document.getElementById('lower').style.display="none";
	 document.getElementById('operation').src=url;
	 }
	 var div_obj =document.getElementById("type");
		div_obj.style.display="none";
		var div_obj =document.getElementById("map_selec");
		div_obj.style.display="none";
		
	 	var div_obj =document.getElementById("map_nav");
		div_obj.style.display="none";
		var div_obj =document.getElementById("map_nav2");
		div_obj.style.display="none";
		 var div_obj =document.getElementById("c");
		div_obj.style.display="none";
		var div_obj =document.getElementById("zoomin");
		div_obj.style.display="none";
		var div_obj =document.getElementById("zoomout");
        div_obj.style.display="none";
		var div_obj =document.getElementById("zoomToFullExtent");
		div_obj.style.display="none";
		var div_obj =document.getElementById("pan");
        div_obj.style.display="none";
		var div_obj =document.getElementById("rule");
		div_obj.style.display="none";
		var div_obj =document.getElementById("clear");
        div_obj.style.display="none";
		var div_obj =document.getElementById("legend");
		div_obj.style.display="none";
		var div_obj =document.getElementById("print");
		div_obj.style.display="none";
 }
 </script>