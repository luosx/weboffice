﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿/**
 * 设定地图是否可见。
 * 
 * @param {Object}
 *            serviceid
 * @param {Object}
 *            visiable
 */
function _$setMapVisiable(serviceid, visiable) {
	var layer;
	try {// 系统服务首次访问时map未初始化
		layer = map.getLayer(serviceid);
	} catch (ex) {
	}

	if (visiable == null || visiable == "") {
		try {
			layer.hide();
		} catch (ex) {
		}
	} else {
		try {
			layer.show();
			layer.setVisibleLayers(visiable);
		} catch (ex) {
            //throw ex;
		}
		for (var i = 0; i < mapServices.length; i++) {
			if (mapServices[i].id == serviceid) {
				mapServices[i].visiable = visiable;
				break;
			}
		}
	}
}

/**
 * 根据点坐标定位地图
 * 
 * @param {Object}
 *            who
 * @param {Object}
 *            xpoint
 * @param {Object}
 *            ypoint
 */
function _$doLocationItWithPoint(who, xpoint, ypoint,isCenterAt,isClear) {
if(isClear){
	clearHighlight();
}
	var locationpoint = getPoint(xpoint, ypoint);
	var highlightGraphic = new esri.Graphic(locationpoint, mark);
	map.graphics.add(highlightGraphic);
if(isCenterAt){
         map.centerAt(locationpoint);
}
	return highlightGraphic;
}
/**
*查询并定位 add by guorp 2011-8-1
*@param serviceId:地图服务id
*@param layerId:图层id
@param queryWhere:查询条件，如"objectid = 1"、"XMMC='xxx'"、"objectid = 1 and XMMC='xxx'".除objectid外，其余参数请带单引号
*@param expandLevel:缩放级别，不写此参数默认为7，0表示不缩放
*@isClear 定位前是否清除临时地图。false：不清理；true：清理
*/
function _$queryAndLocation(serviceId,layerId,queryWhere,expandLevel,isClear){
	if(isClear){
	   clearHighlight();
	}
	var query = new esri.tasks.Query();
    query.outFields = ["objectid"];
    query.returnGeometry = true;
    query.where = queryWhere;
    //query.outSpatialReference = getMapSpatialReference();
	var queryTask;
	for (var i = 0; i < mapServices.length; i++) {
		if (mapServices[i].id == serviceId) {
			queryTask=new esri.tasks.QueryTask(mapServices[i].url+"/"+layerId);
			break;
		}
	}
	dojo.connect(queryTask, "onError", function(error) {
		//alert(error);
	});
	dojo.connect(queryTask, "onComplete", function(featureSet) {

	    //多个图斑时，联合extent
	    var extent;
	    for(var i=0;i<featureSet.features.length;i++){
	        var graphic = featureSet.features[i];
	        if(i==0){
	            extent=featureSet.features[i].geometry.getExtent();
	        }else{
		        extent = extent.union(featureSet.features[i].geometry.getExtent());
		    }
		    var highlightGraphic=null;
		    if(graphic.geometry.type=='point'){
		        highlightGraphic = new esri.Graphic(graphic.geometry,commonmarkR);
		    }else{
		        highlightGraphic = new esri.Graphic(graphic.geometry,commonbluelight);
		    }
		    addHighlight(highlightGraphic);
		}
		if(expandLevel==null || expandLevel=='null'){  
		    if(graphic.geometry.type=='point'){
			    var locationpoint = getPoint(graphic.geometry.x, graphic.geometry.y);
			    setMapCenterAdnZoom(locationpoint, 1);
			}else{
				point=extent.getCenter();
			    setMapExtent(extent.expand(7));
			}
		}else if(expandLevel!=0){
		    if(graphic.geometry.type=='point'){
		        var locationpoint = getPoint(graphic.geometry.x, graphic.geometry.y);
		        setMapCenterAdnZoom(locationpoint, 1);
		       if(parent.window.dialogArguments!=null&&parent.window.dialogArguments.yw_guid!=null){		      
		        	markShow(graphic.geometry,true);
			    }
		    }else{
		    	point=extent.getCenter();
		        setMapExtent(extent.expand(expandLevel));
		   }
	    }
	});
	//alert(x+" "+y);
    queryTask.execute(query);
}

function _$queryTbAndLocation(){
	var query = new esri.tasks.Query();	
    query.outFields = ["objectid"];
    query.returnGeometry = true;
    query.where = 'objectid='+Barray[tbindex];
	var queryTask=new esri.tasks.QueryTask(tburl);
	dojo.connect(queryTask, "onComplete", function(featureSet) {
	    var extent;
	    for(var i=0;i<featureSet.features.length;i++){
	       var graphic = featureSet.features[i];
		   var highlightGraphic=null;
		   var point=new esri.geometry.Point(graphic.geometry.getExtent().getCenter());
   	       if(tbindex%10==0){
   	       		 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/a.png', 19, 25));   	       	
		    }
		    if(tbindex%10==1){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/b.png', 19, 25));
		    }
		    if(tbindex%10==2){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
					+ 'gisapp/images/c.png', 19, 25));
		    }
		    if(tbindex%10==3){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/d.png', 19, 25));
		    }
		    if(tbindex%10==4){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
					+ 'gisapp/images/e.png',19, 25));
		    }		    
		    if(tbindex%10==5){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
					+ 'gisapp/images/f.png', 19, 25));
		    }
		    if(tbindex%10==6){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/g.png', 19, 25));
		    }
		    if(tbindex%10==7){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/h.png', 19, 25));
		    }
		    if(tbindex%10==8){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/i.png', 19, 25));
		    }
		    if(tbindex%10==9){
		    	 highlightGraphic = new esri.Graphic(point,new esri.symbol.PictureMarkerSymbol(basePath
						+ 'gisapp/images/j.png', 19, 25));
		    }	
		    addHighlight(highlightGraphic);		
			}		   
			if(tbindex<Barray.length-1){
			 tbindex++;
			_$queryTbAndLocation();
			}else{
			//_$allLayoutTB();
			
			}
	});
    queryTask.execute(query);
}

function  _$allLayoutTB(){
var mpoints =new esri.geometry.Multipoint(getMapSpatialReference());
for(var f=0;f<pl.length/2;f++){
  mpoints.addPoint(new esri.geometry.Point(pl[f*2],pl[f*2+1],getMapSpatialReference()));
}
setMapExtent(mpoints.getExtent().expand(3));
}

/**
 * 获取map的坐标参考
 */
function _$getMapSpatialReference() {
	return map.spatialReference;
}

/**
 * 绘制点线面
 */
 function _$drawGeometry(drawType){
    if(drawType=='point') drawLocationPoint();
    if(drawType=='polyline') drawLocationPolyline();
    if(drawType=='polygon') drawLocationPolygon();
 }
 

/**
 * 定位并缩放到原比例尺的倍数（小于1为放大，大于1为缩小）
 */
function _$setMapCenterAdnZoom(locationpoint, alpha) {
	map.centerAndZoom(locationpoint, alpha);
}

/**
 * 设置地图的四至范围
 * @param {Object} extent
 */
function _$setMapExtent(extent) {
	map.setExtent(extent);
}

/**
 * 增加高亮图层显示
 * @param {Object} highlightGraphic
 */
function _$addHighlight(highlightGraphic) {
	map.graphics.add(highlightGraphic);
}

/**
 * 获取GraphicLayer
 * @param id
 */
function _$getGraphicLayer(layerId) {
	return new esri.layers.GraphicsLayer({id : layerId});
}

/**
 * 获取GraphicLayer
 * @param title,context
 */
function _$getInfoTemplate(title,context){
    return new esri.InfoTemplate(title,context);
}

/**
 * 获取Graphic
 * @param point, symbol, attr, infoTemplate
 */
function _$getGraphic(point, symbol, attr, infoTemplate){
   return new esri.Graphic(point, symbol, attr, infoTemplate);
}

/**
 * 增加图层
 * @param {Object} highlightGraphic
 */
function _$addLayer(graphicLayer) {
	map.addLayer(graphicLayer);
}

/**
 * 清除高亮图层显示
 */
function _$clearHighlight() {
	map.graphics.clear();
}

/**
 * 生成坐标点对象
 * @param {Object} xpoint
 * @param {Object} ypoint
 */
function _$getPoint(xpoint, ypoint) {
	xpoint = parseFloat(xpoint);
	ypoint = parseFloat(ypoint);
	return new esri.geometry.Point(xpoint, ypoint, map.spatialReference);
}
/**
 * 生成线对象 add by 郭润沛 2011-5-17
 * @param {Object} esri.geometry.Point
 * @param {Object} esri.geometry.Point
 */
function _$getPolyline(startPoint, endPoint) {
	var polylineJson = {
		"paths" : [[[startPoint.x, startPoint.y], [endPoint.x, endPoint.y]]],
		"spatialReference" : map.spatialReference
	};
	return new esri.geometry.Polyline(polylineJson);
}

function _$printMap(map){
    var w=document.body.clientWidth;
    var h=document.body.clientHeight;
window.open(basePath+"gisapp/pages/print.jsp","print",'width='+w+',height='+(h+120)+',top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');	
}

