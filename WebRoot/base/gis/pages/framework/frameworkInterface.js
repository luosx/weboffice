﻿﻿﻿/**
 * 设定地图是否可见。
 * 
 * @param {Object} serviceid
 * @param {Object} visiable
 */
function setMapVisiable(serviceid, visiable) {
	_$setMapVisiable(serviceid, visiable);
}

/**
 * 根据点坐标定位地图
 * 
 * @param {Object} who
 * @param {Object} xpoint
 * @param {Object} ypoint
 *@param expandLevel:缩放级别，不写此参数默认为7，0表示不缩放
*@isClear 定位前是否清除临时地图。false：不清理；true：清理
 */
function doLocationItWithPoint(who, xpoint, ypoint,isCenterAt,isClear) {
	return _$doLocationItWithPoint(who, xpoint, ypoint,isCenterAt,isClear);
}
/**
*查询并定位 add by guorp 2011-8-1
*@param serviceId:地图服务id
*@param layerId:图层id
@param queryWhere:查询条件，如"objectid = 1"、"XMMC='xxx'"、"objectid = 1 and XMMC='xxx'".除objectid外，其余参数请带单引号
*@param expandLevel:缩放级别，不写此参数默认为7，0表示不缩放
*@isClear 定位前是否清除临时地图。false：不清理；true：清理
*/
function queryAndLocation(serviceId,layerId,queryWhere,expandLevel,isClear){
	return _$queryAndLocation(serviceId,layerId,queryWhere,expandLevel,isClear);
	
}
function queryTbAndLocation(Barray, tburl, tbindex, pl){
    _$queryTbAndLocation(Barray, tburl, tbindex, pl);
}

/**
 * 获取map的坐标参考
 */
function getMapSpatialReference() {
	return _$getMapSpatialReference();
}

/**
 * 绘制点线面
 */
 function drawGeometry(type,guid,drawType){
	 _$drawGeometry(type,guid,drawType);
 }
 

/**
 * 定位并缩放到原比例尺的倍数（小于1为放大，大于1为缩小）
 */
function setMapCenterAdnZoom(locationpoint, alpha) {
	_$setMapCenterAdnZoom(locationpoint, alpha);
}

/**
 * 设置地图的四至范围
 * 
 * @param {Object}
 *            extent
 */
function setMapExtent(extent) {
	_$setMapExtent(extent);
}

/**
 * 增加高亮图层显示
 * 
 * @param {Object} highlightGraphic
 */
function addHighlight(highlightGraphic) {
	_$addHighlight(highlightGraphic);
}

/**
 * 增加图层
 * 
 * @param {Object} highlightGraphic
 */
function addLayer(graphicLayer) {
	_$addLayer(graphicLayer);
}

/**
 * 获取GraphicLayer
 * @param {Object} highlightGraphic
 */
function getGraphicLayer(id){
   return _$getGraphicLayer(id);
}

/**
 * 获取intoTemplate
 * @param title context
 */
function getInfoTemplate(title,context){
   return _$getInfoTemplate(title,context);
}

/**
 * 获取Graphic
 * @param point, symbol, attr, infoTemplate
 */
function getGraphic(point, symbol, attr, infoTemplate){
  return _$getGraphic(point, symbol, attr, infoTemplate);
}


/**
 * 清除高亮图层显示
 */
function clearHighlight() {
	_$clearHighlight();
}

/**
 * 生成坐标点对象
 * 
 * @param {Object} xpoint
 * @param {Object} ypoint
 */
function getPoint(xpoint, ypoint) {
	return _$getPoint(xpoint, ypoint);
}
/**
 * 生成线对象 add by 郭润沛 2011-5-17
 * 
 * @param {Object} esri.geometry.Point
 * @param {Object} esri.geometry.Point
 */
function getPolyline(startPoint, endPoint) {
	return _$getPolyline(startPoint, endPoint);
}

/**
 * 
 * @param map
 */
function printMap(map){
	_$printMap(map);
}

