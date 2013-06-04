<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="<%=basePath%>/base/include/ajax.js"></script> 
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/timer.js"></script>  
<title>百度地图</title>
<style type="text/css">
	html{height:100%}
	body{height:100%;margin:0px;padding:0px}
	#container{height:100%}
	a{
			color:green; 
			text-decoration:none;
			margin-left:10px;
			font-size:15px;
	 }
	a:hover{
			color:#DD6F00;
	}
</style>
</head>

<body>
<div id="container"></div>
<script type="text/javascript">
//------------------------ 地图初始化 -------------------------- 
	var map = new BMap.Map("container");            
	var point = new BMap.Point(120.160129,30.271473);  // 创建点坐标	
	map.centerAndZoom(point, 13);                 
 	map.enableScrollWheelZoom();  
  	map.enableKeyboard();         
  	map.enableContinuousZoom();   
  	map.enableInertialDragging(); 
  	var opts = {type: BMAP_NAVIGATION_CONTROL_LARGE }		
	map.addControl(new BMap.NavigationControl(opts));		
	map.addControl(new BMap.ScaleControl());				
	map.addControl(new BMap.OverviewMapControl()); 
	//map.addControl(new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1})); //默认开启			
	map.addControl(new BMap.MapTypeControl()); 				
 	map.setCurrentCity("浙江"); 			
//------------------------ 地图初始化 --------------------------   
	
	
var flag = true;
var isPointInRectJudge = true;    
var start_x = ''; 
var start_y = '';
var x_;
var y_; 
var mark;
var id;  
var showSimpleTimer;
var start=null;
var sflag=0;

//重置地图
function reSetMap(){
	map.centerAndZoom(point, 12);
	map.setCurrentCity("扬州"); 
}

//在地图上进行标注  
function marker(x,y,isAutoCenter,hasInfoWindow,id,imgName,myIcon){   
	var point = new BMap.Point(x,y); 
	var myIcon = new BMap.Icon('../images/'+myIcon, new BMap.Size(66, 32), {   
		anchor: new BMap.Size(10, 20)  
	});
	var marker = new BMap.Marker(point, {icon: myIcon });  
	//map.setZoom(16);        
	map.addOverlay(marker); 
	if(isAutoCenter){ 
		map.setCenter(point);                     	
	}
	if(hasInfoWindow){ 
		infoWindowIsAutoOpen(marker,point,id,imgName,false);      
	}
}

function clearSimpleOverlay(){
   var arrays=map.getOverlays();
   for(var i=0;i<arrays.length;i++){
   try{
     if(arrays[i].getIcon()=='Icon'){
        map.removeOverlay(arrays[i]);
     }
    }catch(e){
        continue;
    }
   }
}

//在地图上显示自定义标注,取消地图默认的标注图标  
function markerByDefine(y,x,isAutoCenter,id,hasInfoWindow,imgName){
	var point =  new BMap.Point(x,y); 
	var icon = new BMap.Icon('../images/car.png', new BMap.Size(66, 32), {   
		anchor: new BMap.Size(10, 20)  
	});
	var marker = new BMap.Marker(new BMap.Point(x,y), {icon: icon });     
	if(flag){
		map.setZoom(16); 
		flag = false; 
	}else{ 
		map.addEventListener("zoomend", function(){
	  		map.setZoom(this.getZoom());  
		});	
	}
	map.addOverlay(marker); 
	if(isAutoCenter){ 
		map.setCenter(point);                      	
	}
	if(hasInfoWindow){  
		infoWindowIsAutoOpen(marker,point,id,imgName,false);          
	} 
}

//根据坐标划线显示 
function drawLine(start_x,start_y,end_x,end_y){
	//alert("drawLine: "+start_x+"   "+start_y+"   "+end_x+"   "+end_y); 	
	color = 'red';  
	weight = 4;
	opacity = 1; 	
	if(flag){
		map.setZoom(16); 
		flag = false; 
	}else{ 
		map.addEventListener("zoomend", function(){
	  		map.setZoom(this.getZoom());  
		});	
	}
	
	var distance = map.getDistance(new BMap.Point(start_x,start_y),new BMap.Point(end_x,end_y)); 
	if(distance > 500){ 
		color = 'white';  
		weight = 1;
		opacity = 0.1; 
	}
	var result = BMapLib.GeoUtils.isPointInRect(new BMap.Point(end_y,end_x), map.getBounds());  
	if(!result){  
		map.setCenter(new BMap.Point(end_y,end_x));    
	} 
	
	var polyline = new BMap.Polyline([
		new BMap.Point(start_y,start_x),new BMap.Point(end_y,end_x)],
		{strokeColor:color, strokeWeight:weight, strokeOpacity:opacity});
	map.addOverlay(polyline); 
}

//清除图层 
function clearOverlays(){
	map.clearOverlays();	
}

//在地图上对所有选择的设备进行标注，有信息提示框,需可视化范围判断  
function clearMarkerExceptChecked(checkedNodes,hasInfoWindow){   
	map.clearOverlays();		
	showAllGpsByChecked(checkedNodes,hasInfoWindow,isPointInRectJudge);     
}

//全局监控时,自动刷新设备位置,不需可视范围判断 
function timerAutoMarker(checkedNodes,hasInfoWindow,isPointInRectJudge){  
	map.clearOverlays();	 
	showAllGpsByChecked(checkedNodes,hasInfoWindow,isPointInRectJudge);    
}

//在地图上循环展现所有选中的GPS设备 
function showAllGpsByChecked(checkedNodes,hasInfoWindow,isPointInRectJudge){ 
	for(var i=0;i<checkedNodes.length;i++){ 
		doMarkByLocation(checkedNodes[i].id,hasInfoWindow,isPointInRectJudge);    
	} 
}

//根据设备编号获取坐标并在地图上显示
function doMarkByLocation(id,hasInfoWindow,isPointInRectJudge){  
	//根据id获取手持机坐标，如果在线则获取当前坐标，不在线获取上次坐标
	var point = getGpsCurrentPosition(id); 	 	
	if(point.lng!="null"){  
	   //调用标注方法，此处需要传递和设备id关联的图片名称
	   marker(point.lng,point.lat,true,hasInfoWindow,id,'shouchiji.png','car.png');    
	   //是否要求所勾选的设备全部显示在可是范围内 
	    if(isPointInRectJudge){
   			var result = BMapLib.GeoUtils.isPointInRect(point, map.getBounds());   
   			while(!result){ 
       			map.setZoom(map.getZoom()-1);  
       			result = BMapLib.GeoUtils.isPointInRect(point, map.getBounds());   
   			} 
	    }
	}
}

function startSimpleGps(id){
   if(sflag==1){
      alert("正处于全局监控状态，请先停止监控！")
   }else{
     start=null;
     map.clearOverlays();
     showSimpleGps(id);
   }
}

function showSimpleGps(id){
   clearSimpleOverlay();
   var path = "<%=basePath%>";
   var actionName = "pdaStatusAC";
   var actionMethod = "getPositionById";
   var parmeter="gpsId="+id;
   var res = ajaxRequest(path,actionName,actionMethod,parmeter);
   var zbs=res.split("@");
   marker(zbs[0],zbs[1],true,true,id,'shouchiji.png','car.png');
   if(start!=null){
      drawLine(start[1],start[0],zbs[1],zbs[0]);
   }
   start=res.split("@"); 
   showSimpleTimer = setTimeout("showSimpleGps('"+id+"')",10000);
}


function clearSimpleGpsTimer(){
    clearTimeout(showSimpleTimer);
}

//全局监控时，获取所有勾选的设备 
function globalMonitor(checkedNodes){   
	map.clearOverlays();    
	for(var i=0;i<checkedNodes.length;i++){   
		globalMarkerMonitor(checkedNodes[i].id);      
	} 
}  

//全局监控,在地图上标注所勾选的设备，需进行可视化范围判断
function globalMarkerMonitor(id){ 
		var point = getGpsCurrentPosition(id); 	  	
		var gpsName = getGpsNameById(id);   
		var imgName = 'shouchiji.png';         
		//如果新的标注不在地图可视范围内，则将地图缩小一级,直到标注在可是区域内显示 
		//isPointInRectJudge:是否进行可视范围判断，添加此判断主要用于跟踪 
		if(isPointInRectJudge){  
			var result = BMapLib.GeoUtils.isPointInRect(point, map.getBounds()); 
	   		while(!result){  
	       		map.setZoom(map.getZoom()-1); 
	       		result = BMapLib.GeoUtils.isPointInRect(point, map.getBounds());    
	   		}
		}
		var marker = new BMap.Marker(point);   
		map.addOverlay(marker); 
		//对标注添加信息提示框,默认不自动弹出信息提示框 
		infoWindowIsAutoOpen(marker,point,id,imgName,false);
}	

//根据选择的设备回放历史轨迹 
function playbackById(start_x, start_y,end_x, end_y){ 
		var polyline = new BMap.Polyline([
	    new BMap.Point(start_y,start_x),
	    new BMap.Point(end_y,end_x)
	  ],
	  {strokeColor:"red", strokeWeight:2, strokeOpacity:0.8}
	);
	map.addOverlay(polyline); 
}
 
//复杂信息提示框
function infoWindowIsAutoOpen(marker,point,id,imgName,isAutoOpenWindow){
	var gpsName = getGpsNameById(id);  
	var sContent ="<div><h5 style='margin:0 0 5px 0;padding:0.1em 0'>扬州市国土资源局</h5>" + 
				  "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>"+gpsName+"_巡查</p>" +   
				  "<p><a href=\"javascript:startSimpleGps('"+id+"')\">开始跟踪</a>&nbsp&nbsp&nbsp<a href='javascript:clearSimpleGpsTimer()'>取消跟踪</a></p>" +      
	    		  "</div>";
	var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象 
	//通过单击事件弹出提示框 
	marker.addEventListener("click", function(){            
	   marker.openInfoWindow(infoWindow);  
	});
	if(isAutoOpenWindow){  
		//不调用默认的单击事件，直接弹出复杂信息提示框   
		marker.openInfoWindow(infoWindow);  	
	}
	
}

//根据设备ID获取设备名称 
function getGpsNameById(id){
	var actionName = "pdaStatusAC";
	var actionMethod = "getGpsNameById";
	var parameter="id="+id; 
	var result = ajaxRequest('<%=basePath%>',actionName,actionMethod,parameter);
	return result;  
}

//根据设备ID获取设备坐标
function getGpsCurrentPosition(id){
	var actionName = "pdaStatusAC";
	var actionMethod = "getCurrentPositon"; 
	var parameter="id="+id; 
	var result = ajaxRequest('<%=basePath%>',actionName,actionMethod,parameter);
	if(result != ""){ 
		var x_  = result.split(',')[0];  
		var y_  = result.split(',')[1];  
		var point = new BMap.Point(x_,y_); 	
	}  
	return point; 
}

//静态显示划线
function staticDrawLine(json,color,weight,opactiy){
	var arrpointNormal = [];
	var arrpointUnNormal = [];
	var j = 0; 
	for(var i=0;i<json[0].length;i++){
		if(i != json[0].length-1){
			//对跳点进行处理 
			var distance = map.getDistance(new BMap.Point(json[0][i].x,json[0][i].y),new BMap.Point(json[0][i+1].x,json[0][i+1].y)); 
			if(distance > 500){
				//查询到跳点时，先将正常点在地图上划线   
				var polyline2 = new BMap.Polyline( 
		 			arrpointNormal, 
					{strokeColor:'red', strokeWeight:2, strokeOpacity:1}       
				);			
				map.addOverlay(polyline2);
				arrpointNormal = [];				
				//将非正常点上图；alert(i+" 和 "+(i+1)+" 两点的距离是："+distance+"     "+(i+1)+" 是不正常坐标"); //非正常点之间的连线特殊处理    
				arrpointUnNormal[0] = new BMap.Point(json[0][i].x,json[0][i].y);
				arrpointUnNormal[1] = new BMap.Point(json[0][i+1].x,json[0][i+1].y);  
				j = i;  
			 	var polyline = new BMap.Polyline( 
				 	arrpointUnNormal,
					{strokeColor:'white', strokeWeight:1, strokeOpacity:0.1}     
				);
				map.addOverlay(polyline); 
				map.setCenter(new BMap.Point(json[0][i+1].x,json[0][i+1].y)); 	
			}else{ 
				//正常点
				arrpointNormal[i-j] =	new BMap.Point(json[0][i].x,json[0][i].y);
			}
		}else{
			var polyline3 = new BMap.Polyline( 
	 			arrpointNormal, 
				{strokeColor:'red', strokeWeight:4, strokeOpacity:1}       
			);			
			map.addOverlay(polyline3);
			map.centerAndZoom(new BMap.Point(json[0][json[0].length-1].x,json[0][json[0].length-1].y),16);
		}
	}
}

//轨迹回放后，需要将设备采集的成果标注在地图上
function getGpsResult2DrawPolygon(ids,startTime,endTime){
	var actionName = "pdaStatusAC"; 
	var actionMethod = "getGpsResultById";    
	var parameter="id="+ids+"&startTime="+startTime+"&endTime="+endTime;   
	var result = ajaxRequest('<%=basePath%>',actionName,actionMethod,parameter);  
	parseStringToArray(result);   
}

//在地图上显示平板采集的图斑成果  
function parseStringToArray(data){ 
	var arrpoint = [];
	var point = []; 
	var arr = JSON.parse(data); 
	var j = 0; 
	var xmmc;
	if(data != null && data.length>0){ 
		for(var o in arr){ 
			////alert(arr[o][0]+"  "+arr[o][1]+"  "+arr[o][2]+"  "+arr[o][3]+"  "+arr[o][4]+"  "+arr[o][5]+"  "+arr[o][6]+"  "+arr[o][7]+"  "+arr[o][8]+"  "+arr[o][09]+"  "+arr[o][10]+"  "+arr[o][11]+"  "+arr[o][12]);    
			xmmc = arr[o][3];
			if(xmmc == null ){
				xmmc = ""; 
			}
			arrpoint =  arr[o][12].split(",");  
			for(i=0;i<arrpoint.length/2 ;i++ ){
					 //point[i] = new BMap.Point (arrpoint[i*2],arrpoint[i*2+1]);   
					 point[i] = new BMap.Point (arrpoint[i*2+1],arrpoint[i*2]);    
			}  
		 	//创建经纬度数组、创建多边形并添加多边形到地图上  
			var secRingCenter = new BMap.Point(point[0].lng,point[0].lat);  
			var secRingPolygon = new BMap.Polygon(point, {strokeColor:"blue", strokeWeight:3, strokeOpacity:1}); 
			map.addOverlay(secRingPolygon); 
			//------------------------------ 复杂的自定义覆盖物 ------------------------------------------------------------------------- 
			function ComplexCustomOverlay(point, text, mouseoverText){ 
			      this._point = point;
			      this._text = text;
			      this._overText = mouseoverText;
			}
			ComplexCustomOverlay.prototype = new BMap.Overlay();
			ComplexCustomOverlay.prototype.initialize = function(map){
			      this._map = map;
			      var div = this._div = document.createElement("div");
			      div.style.position = "absolute";
			      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat); 
			      div.style.backgroundColor = "#EE5D5B";
			      div.style.border = "1px solid #BC3B3A";
			      div.style.color = "white";
			      div.style.height = "12px";
			      div.style.padding = "2px";
			      div.style.lineHeight = "12px";
			      div.style.whiteSpace = "nowrap";
			      div.style.MozUserSelect = "none";
			      div.style.fontSize = "11px"
			      var span = this._span = document.createElement("span");
			      div.appendChild(span); 
			      span.appendChild(document.createTextNode(this._text));        
			      var that = this;
			
			      var arrow = this._arrow = document.createElement("div");
			      arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
			      arrow.style.position = "absolute";
			      arrow.style.width = "12px";
			      arrow.style.height = "10px";
			      arrow.style.top = "15px";
			      arrow.style.left = "-1px";
			      arrow.style.overflow = "hidden";
			      div.appendChild(arrow);
			     
				div.onmouseover = function(){
				        this.style.backgroundColor = "#6BADCA"; 
				        this.style.borderColor = "#0000ff";
				        div.style.height = "70px"; 
				        div.style.zIndex = 999;   
				        this.getElementsByTagName("span")[0].innerHTML = that._overText;  
				        arrow.style.backgroundPosition = "0px 20px"; 
				}
			
				div.onmouseout = function(){
				        this.style.backgroundColor = "#EE5D5B";
				        this.style.borderColor = "#BC3B3A";
						arrow.style.position = "absolute";
						arrow.style.width = "11px";
						arrow.style.height = "10px";
						arrow.style.top = "15px";
						arrow.style.left = "-1px";
						arrow.style.overflow = "hidden";
						div.appendChild(arrow);
						div.style.height = "12px";
				        this.getElementsByTagName("span")[0].innerHTML = that._text;
				        this.style.zIndex = 100;  	//降低图层的高度，因为当图层有鼠标滑过时图层默认最高层显示 
				        arrow.style.backgroundPosition = "0px 0px";
				}
			      map.getPanes().labelPane.appendChild(div);
			      return div;
			}
			    
			ComplexCustomOverlay.prototype.draw = function(){
			      var map = this._map;
			      var pixel = map.pointToOverlayPixel(this._point);
			      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
			      this._div.style.top  = pixel.y - 30 + "px";
			}
			//循环图版再地图上进行标注 
	  		mouseoverTxt =  "项目名称："+xmmc+"<br/>任务类型："+arr[o][5]+"<br/>是否违法："+arr[o][8]+"<br/>巡查人&nbsp;&nbsp;&nbsp;&nbsp;："+"巡查人"+"<br/>巡查日期："+arr[o][11];      
	  		var myCompOverlay = new ComplexCustomOverlay(new BMap.Point(point[0].lng,point[0].lat), arr[o][3],mouseoverTxt); 
	  		//var myCompOverlay = new ComplexCustomOverlay(new BMap.Point(point[0].lng,point[0].lat),(parseInt(o)+parseInt(1)),mouseoverTxt);   
	  		map.addOverlay(myCompOverlay);
			//----------------------------------------------------------------------------------------------------------------------------
			map.setCenter(secRingCenter);    
			point = []; 
		}
	}
}


</script>
	</body>
</html>
                    