﻿﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
.anchorBL{  display:none;}
 
#legend1 {border:0;background-color:#15161B;opacity:0.3;width:280px;height:404px;position:absolute; left:1086px; top:132px;border-radius:10px 10px 5px 5px}
#menu {opacity:0.8;width:280px;height:404px;position:absolute;left:1086px;top:132px;display:block;}
#tit {cursor:move;width:100%;height:20px;background-color:#15161B;opacity:0.5;border-radius:10px 10px 0 0}
#menuFrame {border:0;width:100%;height:100%}
#d_iframe {width:100%;height:384px}
</style>
<script src="../framework/js/jquery-1.8.1.js" type="text/javascript"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=q3i2iXOKCWLVGY4hddgk92I9"></script>

<title>南京智能公交监察系统</title>
</head>
<body>
	<div id="allmap"></div>

	<div id="menu_back"><iframe  id='legend1'></iframe></div>
	<div id="menu">
		
		<div id="tit"></div>
		<div id="d_iframe">
			<iframe id='menuFrame' src="../carMonitor/monitor.jsp" ></iframe>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">

//菜单显示与否功能
var isShow = false;
function showMenu(){
	if(isShow==false){
		$("#menu").css('display','block');
		$("#menu_back").css('display','block');
		isShow = true;
	}else{
		$("#menu").css('display','none');
		$("#menu_back").css('display','none');
		isShow = false;
	}
}

//菜单窗口的拖拽
//$(function(){
  var x,y;
  var i=0;
  $("#tit").mousedown(function(e){
   
   i=1;
   x = e.pageX-parseInt($("#menu").css("left"));
   y = e.pageY-parseInt($("#menu").css("top"));
   //$(".menu").fadeTo(200, 0.5);
   
  //})
  $(document).mousemove(function(e){
	
   if(i == 1){
    x2 = e.pageX - x;
    y2 = e.pageY - y;
    if(x2 < 0){x2 = 0;}
    if(x2 > 1186){x2 = 1186;}
    if(y2 < 0){y2 = 0;}
    if(y2 > 758){y2 = 758;}
    $("#menu").css({top:y2,left:x2});
   }
   	$("#legend1").css({top:y2,left:x2});
  }).mouseup(function(){ 
    i=0; 
    
    //$(".menu").fadeTo(200, 1);
   })
 })


//跳转到线路查询页面的方法
function showSearchPage(){
	$("#menuFrame").attr("src","../carMonitor/searchPage.jsp");
}
//从查询页面跳转回来
function showMain(){
	$("#menuFrame").attr("src","../carMonitor/monitor.jsp");
}




//百度地图API功能
var map = new BMap.Map("allmap",{minZoom:11,maxZoom:18});                        // 创建Map实例
map.centerAndZoom(new BMap.Point(118.784398,32.062132), 11);     // 初始化地图,设置中心点坐标和地图级别
map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
map.enableScrollWheelZoom();                            //启用滚轮放大缩小
map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
map.setCurrentCity("南京"); // 设置地图显示的城市 此项是必须设置的



//公交查询系列功能

var searchResult = null;
var busline = new BMap.BusLineSearch(map,{
    renderOptions:{map:map},
        onGetBusListComplete: function(result){
           if(result) {
        	   
        	   $("#menuFrame")[0].contentWindow.showResult(result);
            // var fstLine = result.getBusListItem(0);//获取第一个公交列表显示到map上
            // busline.getBusLine(fstLine);
             //alert(result);
           }
        }
});

var busline1 = new BMap.BusLineSearch(map,{
    renderOptions:{map:map},
        onGetBusListComplete: function(result){
           if(result) {
        	   searchResult = result;
        	   
             var fstLine = result.getBusListItem(0);//获取第一个公交列表显示到map上
            // alert(fstLine);
             busline1.getBusLine(fstLine);
             //alert(result);
           }
        }
});

function busSearch(name){
    var busName = name;
    busline.getBusList(busName);
}

function busSearch1(name){
    var busName = name;
    busline1.getBusList(busName);
}
//展现该路公交，由searchPage.jsp调用
//function showThisLine(lineNum){
//	busline.
//}





//地图上展现被点选的车辆的公交路线
function displayBusLineOnMap(line){
	busSearch1(line);
	//var firstLine = searchResult.getBusListItem(0);
	//busLine1.getBusLine(firstLine);
}
//地图上展现被点选的车辆
function displayBusOnMap(x,y,towards,isRunning){
	var url = "images/";
	if(isRunning){
		url = url + "g_";
	}else{
		url = url + "r_";
	}
	url = url + towards + ".png";
	
	var pt = new BMap.Point(x,y);
	var myIcon = new BMap.Icon(url, new BMap.Size(40,40));
	var marker2 = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
	map.addOverlay(marker2);              // 将标注添加到地图中
}

</script>

