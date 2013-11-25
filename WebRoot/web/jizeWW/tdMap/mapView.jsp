<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   
    String name = ProjectInfo.getInstance().getProjectName();
    String flag = request.getParameter("flag");
    //String flag = "wss";
	//获取当前登录用户
	Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	User userBean = (User) user;   
	String userid = userBean.getUserID(); 
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
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
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

#childDiv
{
	position: relative;
	left: 300px;
	top: -3px;
}
.menuicon
{	
	width:17px;
	height:17px;
	vertical-align: middle;	

}
.childmenu
{
	list-style-type:none; 
	margin:0;
	width:100%;
}

.childmenu li
{
	 width:120px; 
	 float:left;	
	 cursor: hand;
}

.childmenutitle
{	
	font-family:"宋体";
	font-size: 10pt;
	color: white;
	vertical-align: middle;	
}
</style>
<SCRIPT type=text/javascript>
 function showChildMenu(menuId){
    putClientCommond("menuManager","getChildMenu");
	putRestParameter("userid",'<%=userid%>');
	putRestParameter("parentMenuId",menuId);
	var result = restRequest();	
    document.getElementById('childmenu').innerHTML = result;
 }
 
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
     if(parent.parent.index.rows=="53,28,*"){
        parent.parent.index.rows="0,28,*";
        document.getElementById('full_screen').title="退出全屏";
     }else{
		parent.parent.index.rows="53,28,*"
		document.getElementById('full_screen').title="显示全屏";   
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
<%if("map".equals(flag)){ %>
<td width=99 height=38 style="cursor: hand;" onClick="openMap()">
<img id='mapImg' name='mapImg' style="position:absolute;left:-5;top:6;"  src="images/tab_1.png" width="99" height="26" />
</td>
<%}else{ %>
<td width=99 height=38 style="cursor: hand;" onClick="">
<img id='urlImg' name='urlImg' style="position:absolute;left:-5;top:6;"  src="images/tab_4.png" width="99" height="26" />
</td>
<%} %>
<td width='100%'><div id="childDiv">
			<ul class="childmenu" id="childmenu">
			   
	        </ul>
		</div></td>
<!-- 
<td   id='type' align="center" valign="top"  style="cursor: hand;"><input type='text' style="vertical-align: middle;border:0;height:24px;margin-top:2px;line-height:24px;margin-right:2px;color:white;font-weight:blod;background-color:#6fcbf8;"/></td>
<td   id='map_selec'   align="center" valign="top"  style="cursor: hand;"><img src="images/search.png" title="搜索" width="27" height="27" /></td>
-->

<td  id='zoomin' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='zoomIn()'><img src="images/zoom-in.png" title="放大" width="27" height="27" /></td>
<td  id='zoomout' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='zoomOut()'><img src="images/zoom-out.png" title="缩小" width="27" height="27" /></td>
<td  id='zoomToFullExtent'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='zoomToFullExtent()'><img src="images/Full_Extent.png" title="初始视图" width="27" height="27" /></td>
<td  id='pan'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='pan()'><img src="images/pan.png" title="漫游" width="27" height="27" /></td>
<td  id='rule'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='measureLengths()'><img src="images/rule.png" title="长度量算" width="27" height="27" /></td>
<td  id='clear' nowrap  align="center" valign="top"  style="cursor: hand;" onClick='clearLayer()'><img src="images/clear.png" title="清除" width="27" height="27" /></td>
<td  id='legend'  nowrap  align="center" valign="top"  style="cursor: hand;" onClick='legend()'><img src="images/legend.png" title="图例" width="27" height="27" /></td>
<!-- <td  id='print' nowrap  align="center" valign="top"  style="cursor: hand;" onClick=''><img src="images/print.png" title="打印" width="27" height="27" /></td> -->

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
<div id="showCar" style="width:150px;height:80px; position:absolute; left:101px; top:61px; background:#E2EAF3; filter:alpha(opacity=80); display:none;">
	
</div>
<div id="showHistory" style="width:150px; height:200px; position:absolute; left:110px; top:80px; background:#E2EAF3; filter:alpha(opacity=80); display:none;">
	<table id="tables">
	</table>
	<div id="times" style="margin-Left: 0px; margin-Right: -14px; margin-bottom:0px; margin-top:50px;"></div>
</div>
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

<iframe frameborder="0" id="lower"  name="lower"  style="width: 100%;height:100%; overflow: auto;" src="<%=basePath%>base/fxgis/fx/FxGIS.html?debug=true&i=false"></iframe>

<iframe frameborder="0" id="operation"  style="display:none;" name="operation"  style="width: 100%;height:92%; overflow: auto;" ></iframe>
<!-- 
<iframe frameborder="0" id="operation"  style="display:none;" name="operation"  style="width: 100%;height:92%; overflow: auto;" ></iframe>
-->
    </body>
</html>
 <script>
 var carList;
 var openFlag="map";
 //var url=document.getElementById("operation").src;
 url = "";
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
    //openURL("<%=basePath%>web/<%=name%>/padResult/padDatalist.jsp",1);  
  }
  function showInfo(){
    document.getElementById("info").style.display='block';
  }
  //显示所有车辆列表

  function showCarList(result){
  			hiddlenListAndHistory();
  			carList = result;
  			var showModel = document.getElementById("showCar");
  			var showTable = "<table style='border:none'>"
			for(var i = 0; i < result.length; i++){
				if(result[i].carstatus == "going"){
					if(result[i].carlx!="0"){
						showTable += "<tr><td width=\"30px\"><input type=\"checkbox\" value = '"+ i +"' name='"+ result[i].carname +"' onclick=\"choseCar(this)\" ></td><td style=\"color: #FFFF33\"><label><font color=green>"+result[i].carname+"(行驶)</font><img onclick=\"showVideo("+result[i].carlx+")\" src=\"<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png\" width=\"16\" height=\"16\" /></label></td></tr>";
					}else{
						showTable += "<tr><td width=\"30px\"><input type=\"checkbox\" value = '"+ i +"' name='"+ result[i].carname +"' onclick=\"choseCar(this)\" ></td><td style=\"color: #FFFF33\"><label><font color=green>"+result[i].carname+"(行驶)</font></label></td></tr>";
					}
				}else{
					if(result[i].carlx!="0"){
						showTable += "<tr><td width=\"30px\"><input type=\"checkbox\" value = '"+ i +"' name='"+ result[i].carname +"' onclick=\"choseCar(this)\" ></td><td style=\"color: #FFFF33\"><label><font color=red>"+result[i].carname+"(停止)</font><img onclick=\"showVideo("+result[i].carlx+")\" src=\"<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png\" width=\"16\" height=\"16\" /></label></td></tr>";
					}else{
						showTable += "<tr><td width=\"30px\"><input type=\"checkbox\" value = '"+ i +"' name='"+ result[i].carname +"' onclick=\"choseCar(this)\" ></td><td style=\"color: #FFFF33\"><label><font color=red>"+result[i].carname+"(停止)</font></label></td></tr>";
					}
				}
			
			}
			showTable += "</table>";
			showModel.innerHTML = showTable;
			showModel.style.display = "";
  }
  //对所选的车辆进行定位
  function choseCar(check){
  	if(check.checked){
  		if(carList[check.value].carstatus == "going"){	
  			parent.parent.menu.doLocation(carList[check.value].carid, carList[check.value].carname, "1");
  		}else{
  			parent.parent.menu.doLocation(carList[check.value].carid, carList[check.value].carname, "0");
  		}
  	}else{
  		parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('remove',check.name);
  	}
  }
  
  //隐藏车辆定位和轨迹回放选择层
  function hiddlenListAndHistory(){
  	document.getElementById("showCar").style.display = "none";
  	document.getElementById("showHistory").style.display = "none";
  }
  
  //显示轨迹回放对话框
  var panel;
  function showCarHistory(result){
  		carList = result;
  		hiddlenListAndHistory();
  		document.getElementById("showHistory").style.display = "";
  		var carList = document.getElementById("tables");
  		var showTable = "";
  		var rows;
  		var cells;
  		carList.innerText = "";
  		for(var i = 0; i < result.length; i++){
  			rows = carList.insertRow(i);
  			cells = rows.insertCell(0);
  			cells.style.width = "30px";
  			cells.innerHTML = "<input type=\"checkbox\" id='" + result[i].carname +"'  >";
  			cells = rows.insertCell(1);
  			cells.style.color = "#FF3300";
  			cells.innerHTML = "<label>"+result[i].carname+"</label>";
			//showTable += "<tr><td width=\"30px\"><input type=\"checkbox\" value = '"+ i +"' onclick=\"choseCar(this)\" ></td><td style=\"color: #FFFF33\"><label>"+result[i].carname+"</label></td></tr>";
		}
  		document.getElementById("times").innerHTML = "";
   		var panel=new Ext.Panel({
			preventBodyReset: true,
		 	labelWidth:60,	
		 	width:259,
		 	layout:'form',
			frame:true,
			defaults:{xtype:"datetimefield",anchor:'90%'},   
	    	items: [ {  
		    		fieldLabel:'开始时间', 
            		id:'sater_time',   
            		format:'H:i'  
            	},{  
            		fieldLabel:'结束时间',  
            		id:'over_time',   
            		format:'H:i'  
            	}
			],
        	buttons: [{
            	id:'showTrajectory',
            	disabled:false,
         		text:'显示轨迹',
         		handler: showTrajectory 
          	},{
            	id:'playback',
            	disabled:false,
         		text:'回放轨迹',
         		handler: playback
          	}],
  			renderTo:'times'
  		});
  }
  
  //显示轨迹
  function showTrajectory(){
  	var para = gjhf();	
  	if(para!=null){
		var arrs=para.split("@");
		var carids=arrs[0].split(",");
		frames["lower"].swfobject.getObjectById("FxGIS").showTrack(escape(arrs[0]),arrs[1],arrs[2]);
		     // alert("车辆编号"+carids[i]+arrs[1]+arrs[2]);
	}
  }
  //回放轨迹
  function playback(){
  	var para = gjhf();
   if(para!=null){
	   var arrs=para.split("@");
	   var carids=arrs[0].split(",");
	  frames["lower"].swfobject.getObjectById("FxGIS").playBack(escape(carids[0]),arrs[1],arrs[2]);
   }
  }
  
  function gjhf(){
    var  sater_time=Ext.getCmp("sater_time").getValue();
    var  startdate = Ext.util.Format.date(sater_time, 'Y-m-d H:i');
    var  over_time=Ext.getCmp("over_time").getValue();
    var  overdate = Ext.util.Format.date(over_time, 'Y-m-d H:i');
    var result;
   if(sater_time!=''&over_time!=''){
	  var carnumber='';
	  //获取已选择的车牌号
	  ajaxRequest("<%=basePath%>","hander","flushGps","");
	  var result = ajaxRequest("<%=basePath%>","hander","getAllCarInf","");
	  result=eval(result);
      for(var i = 0; i < result.length; i++){
      		if(document.getElementById(result[i].carname).checked){
      			carnumber += result[i].carid + ","
      		}
	  }
       
      if(carnumber!=''){
        result=carnumber+"@"+startdate+"@"+overdate;
       }else{alert("请选择车辆")}

   }else{alert("请填写时间")}
      return result;
	}
  
function openMap(){
	 if(openFlag!="map"){
	 openFlag="map";
	  document.getElementById('mapImg').src='images/tab_1.png';
	 //document.getElementById('urlImg').src='images/tab_2.png';
	 document.getElementById('operation').style.display="none";
	 document.getElementById('lower').style.display="";
	 }
	 
	  //var div_obj =document.getElementById("type");
		//div_obj.style.display="block";
		//var div_obj =document.getElementById("map_selec");
		//div_obj.style.display="block";
	// var div_obj =document.getElementById("map_nav2");
	//	div_obj.style.display="block";
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
 	 if(url.indexOf('flag=map')!=-1){
 	    document.getElementById('mapImg').src='images/tab_1.png';
 	 }else{
	 	document.getElementById('mapImg').src='images/tab_4.png';
	 }
	 document.getElementById('operation').style.display="";
	 document.getElementById('lower').style.display="none";
	 if(url.indexOf(".jsp?") > 0){
	 	document.getElementById('operation').src=url + "&r=" + Math.random();
	 }else{
	 	document.getElementById('operation').src=url + "?r=" + Math.random();
	 }
	 }
	 	var div_obj =document.getElementById("map_nav");
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
 
function openPage(url){
	 document.getElementById("showCar").style.display="none";
	 document.getElementById("showHistory").style.display="none";
	 var_flag = url.split("/")[url.split("/").length - 1];//得到jsp页面名称
	 if(var_flag == "PersonInfo.jsp"){
	 	openURL("<%=basePath%>" + url,1);
	 }else{
	 	openURL("<%=basePath%>web/<%=name%>/" + url,1);
	 }
}

function showVideo(puid){
window.showModalDialog("<%=basePath%>web/<%=name%>/videoMonitor/pop.jsp?puid="+puid,window,"dialogWidth=704px;dialogHeight=288px;status=no;scroll=no");
  }
 </script>