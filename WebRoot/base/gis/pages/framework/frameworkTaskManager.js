function addit(mapservicelayer){
gmap.addOverlay(mapservicelayer);

}

dojo.declare("frameworkTaskManager", null, {
	findTask : [],
	findParams : [],
	identifyTask : null,
	identifyParams : null,
	resultStore : [],
	detailStore : null,
	symbols : [],
	currentlySelectedItem : null,
	currentlySelectedGraphic : null,
	currentlySelectedIdx : null,

	// #wangf# 空方法，检查是否可去除
	constructor : function() {
	},

	
	setupMapServices : function(map) {
		//暂时屏蔽google测试代码

		//var google=new esri.layers.ArcGISTiledMapServiceLayer('http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer');
		//map.addLayer(google);
		
		//*
		// * 先使用google代码测试
		for(var i=0;i<mapServices.length;i++){
			console.log("Creating Layer:" + mapServices[i].id);
			
			if (mapServices[i].type == "dynamic") {
				_$layers[mapServices[i].id] = new esri.layers.ArcGISDynamicMapServiceLayer(
						mapServices[i].url, {
							id : mapServices[i].id,opacity:mapServices[i].opacity
						});
			} else if(mapServices[i].type == "tiled"){
				_$layers[mapServices[i].id] = new esri.layers.ArcGISTiledMapServiceLayer(
						mapServices[i].url, {
							id : mapServices[i].id
						});
			} else if(mapServices[i].type == "wmts"){
				switch(mapServices[i].id){
				      case "XZQ" : _$layers[mapServices[i].id] = new my.XZQ(96, 39346916.7230172,4256481.47820994); break;
				      case "DT2010" : _$layers[mapServices[i].id] = new my.DT2010(96, 39346916.7230172,4256481.47820994); break;				    
				      case "DC2009" : _$layers[mapServices[i].id] = new my.DC2009(96, 39346916.7230172,4256481.47820994); break;
				      case "NT2009" : _$layers[mapServices[i].id] = new my.NT2009(96, 39346916.7230172,4256481.47820994); break;				    
				      case "CG2010G" : _$layers[mapServices[i].id] = new my.CG2010G(96, 39346916.7230172,4256481.47820994); break;
				      case "NT2010" : _$layers[mapServices[i].id] = new my.NT2010(96, 39346916.7230172,4256481.47820994); break;				    
				      case "DC2010" : _$layers[mapServices[i].id] = new my.DC2010(96, 39346916.7230172,4256481.47820994); break;
				      case "RAS2009G" : _$layers[mapServices[i].id] = new my.RAS2009G(96, 39346916.7230172,4256481.47820994); break;
				      case "RAS2010G" : _$layers[mapServices[i].id] = new my.RAS2010G(96, 39346916.7230172,4256481.47820994); break;
				      case "RAS2011G" : _$layers[mapServices[i].id] = new my.RAS2011G(96, 39346916.7230172,4256481.47820994); break;
				}
			}
			
			if (mapServices[i].defaultOn == true) {
				map.addLayer(_$layers[mapServices[i].id]);
			}
		}
		
		//*/
	},

	setupSymbol : function() {
		commoncar = new esri.symbol.PictureMarkerSymbol(basePath + 'base/gis/images/carStatus.png', 32, 32);
		commoncom = new esri.symbol.PictureMarkerSymbol(basePath + 'base/gis/images/comp.png', 14, 19);
		commonpms = new esri.symbol.PictureMarkerSymbol(basePath + 'base/gis/images/pda.png', 19, 25);
		mark = new esri.symbol.PictureMarkerSymbol(basePath + 'base/gis/images/mark.png', 36, 72);
		commonsls = new esri.symbol.SimpleLineSymbol( esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0, 0, 255]), 3);
		commonslsR = new esri.symbol.SimpleLineSymbol( esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255, 0, 0]), 3);
		commonsfs = new esri.symbol.SimpleFillSymbol( esri.symbol.SimpleFillSymbol.STYLE_SOLID, commonsls, new dojo.Color([125, 125, 125, 0.35]));
		commonsms = new esri.symbol.SimpleMarkerSymbol( esri.symbol.SimpleMarkerSymbol.STYLE_X, 20, commonsls, new dojo.Color("#000000"));
		commonbluelight = new esri.symbol.SimpleFillSymbol( esri.symbol.SimpleFillSymbol.STYLE_NULL, new esri.symbol.SimpleLineSymbol( esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0, 255, 255]), 2), new dojo.Color([255, 255, 0, 2]));
		commonpoint = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 20,new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,new dojo.Color([0, 255, 255]), 2), new dojo.Color([0,255, 255, 0.25]));
	    //标注样式
		commonmarkR = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 20,new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,new dojo.Color([255, 0, 0]), 3), new dojo.Color([255,0, 0, 0.25]));
		commonmarkB = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 20,new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,new dojo.Color([0,197,205]), 3), new dojo.Color([0,197,205, 0.25]));
	},

	getTextSymbol : function(text) {
		var textsymbol;
		var font = new esri.symbol.Font("15px", esri.symbol.Font.STYLE_NORMAL,esri.symbol.Font.VARIANT_NORMAL, esri.symbol.Font.WEIGHT_BOLDER);
		textsymbol = new esri.symbol.TextSymbol(text, font,new dojo.Color("#FF0000"));
		return textsymbol;
	},
	setupStatus : function(map) {
		dojo.connect(map, "onMouseMove", showCoordinates);
		dojo.connect(map, "onMouseDrag", showCoordinates);
		// 添加【属性查询】的鼠标单击监听
		dojo.connect(map, "onClick", executeQueryTask);
		// 添加地图四至改变的监听
		dojo.connect(map, "onExtentChange", changeExtent);
	},

	setupScalebar : function(map) {
		var scalebar = new esri.dijit.Scalebar({map : map,scalebarUnit : 'metric'});
	},

	setupOverview : function(map) {
		dojo.connect(map, 'onLoad', function(theMap) {
			dojo.connect(dijit.byId('map'), 'resize', function() { // resize
				clearTimeout(resizeTimer);
				resizeTimer = setTimeout(function() {
			        map.resize();
					map.reposition();
				}, 500);
			});
		// add the overview map
		var overviewMapDijit = new esri.dijit.OverviewMap({map : map,visible : false});
		    overviewMapDijit.startup();
		});
	},

	setupToolbar : function(map) {
		navigationToolbar = new esri.toolbars.Navigation(map);
		drawToolbar = new esri.toolbars.Draw(map, {showTooltips : false});
		createLayout();
		dojo.connect(drawToolbar, "onDrawEnd", addToMap);
	}
});

console.log("taskManager parsed succesfully");
/**
 * 双窗口改变窗口四至 add by guorp 2011-8-7
 */
function changeExtent(extent) {
	if(isNaN(extent.ymin)){
		return;
	}
	var salt = 0.01;// 盐值
	if (parent.name == 'left') {
		var rightExtent = top.right.center.map.extent;
		if (Math.abs(rightExtent.xmin - extent.xmin) > salt
				|| Math.abs(rightExtent.ymin - extent.ymin) > salt
				|| Math.abs(rightExtent.xmax - extent.xmax) > salt
				|| Math.abs(rightExtent.xmax - extent.xmax) > salt) {
			top.right.center.setMapExtent(extent);
		}
	}
	if (parent.name == 'right') {
		var leftExtent;
		try{
		leftExtent = top.left.center.map.extent;
		}catch(e){
		return;
		}
		if (Math.abs(leftExtent.xmin - extent.xmin) > salt
				|| Math.abs(leftExtent.ymin - extent.ymin) > salt
				|| Math.abs(leftExtent.xmax - extent.xmax) > salt
				|| Math.abs(leftExtent.xmax - extent.xmax) > salt) {
			top.left.center.setMapExtent(extent);
		}
	}
}
function showCoordinates(evt) {
	var mp = evt.mapPoint;
	window.status = "X:" + mp.x + ", Y:" + mp.y;
}

function setOPStatus() {
	isPropertiesQueryClickEventEnabled = false;
	isProjectQueryClickEventEnabled = false;
	isSpProjectQueryClickEventEnabled = false;
	isShprojectQueryClickEventEnabled = false;
	isShpExportQueryClickEventEnabled=false;
	//框选
	isSelectedQueryClickEventEnabled =false;	
	//WFS查询
	isWFSQueryClickEventEnabled=false;
	isSGQueryClickEventEnabled = false;   
}
/* 地图放大 */
function zoomIn() {
	drawToolbar.deactivate();
	setOPStatus();
	navigationToolbar.activate(esri.toolbars.Navigation.ZOOM_IN);
}
/* 地图缩小 */
function zoomOut() {
	drawToolbar.deactivate();
	setOPStatus();
	navigationToolbar.activate(esri.toolbars.Navigation.ZOOM_OUT);
}
/* 地图漫游 */
function pan() {
	drawToolbar.deactivate();
	setOPStatus();
	navigationToolbar.activate(esri.toolbars.Navigation.PAN);
}
/* 地图全图 */
function zoomToFullExtent() {
	drawToolbar.deactivate();
	setOPStatus();
	navigationToolbar.zoomToFullExtent();
}
/* 前一视图 */
function zoomToPrevExtent() {
	drawToolbar.deactivate();
	setOPStatus();
	navigationToolbar.zoomToPrevExtent();
}
/* 后一视图 */
function zoomToNextExtent() {
	drawToolbar.deactivate();
	setOPStatus();
	navigationToolbar.zoomToNextExtent();
}
/* 清除 */
function clear() {
	drawToolbar.deactivate();
	map.graphics.clear();
}

/* 绘制点 */
function drawLocationPoint() {
	
	shflag = 'drawPoint';
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.POINT);
	isShprojectQueryClickEventEnabled = true;
	doMonitor();
}

/* 绘制线 */
function drawLocationPolyline() {
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.POLYLINE);
	shflag = 'drawLine';
	doMonitor();
}

/* 绘制面 */
function drawLocationPolygon() {
	shflag = 'drawPolygon';
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.POLYGON);
	doMonitor();
}

/* 规则面积量算 */
function drawPolygon() {
	shflag = null;
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.POLYGON);
}
/* 任意面积量算 */
function DrawFreeHandPolygon() {
	shflag = null;
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.FREEHAND_POLYGON);
}
/* 直线长度量算 */
function drawLine() {
	shflag = null;
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.LINE);
}
/* 折线长度量算 */
function drawPolyline() {
	shflag = null;
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.POLYLINE);
}
/* 任意长度量算 */
function drawFreeHandPolyline() {
	shflag = null;
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.FREEHAND_POLYLINE);
}

/* 属性分析 */
function mapAnalyse() {
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isPropertiesQueryClickEventEnabled = true;
}


/*图斑框选*/
function selectedQuery() {
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isSelectedQueryClickEventEnabled= true;
	drawToolbar.activate(esri.toolbars.Draw.EXTENT);
}

/* 选择监测图斑 */
function selectJCTB() {
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isSelectJCTBClickEventEnabled = true;
	doMonitor();
}

/* 项目查询 */
function projectQuery() {
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isProjectQueryClickEventEnabled = true;
}

/* 寿光查询 */
function sgQuery() {
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isSGQueryClickEventEnabled = true;
}


/*WFS查询*/
function WFSQuery(){
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isWFSQueryClickEventEnabled=true;
}

/* shp导出 */
function exportShape(){
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	isShpExportQueryClickEventEnabled = true;	
}

function exportShp(featureSet){
	exportShpeFile(featureSet);
}

/* 地图打印 */
function printMapHandler() {
	navigationToolbar.deactivate();
	drawToolbar.deactivate();
	setOPStatus();
	printMap(map);
}
/* 地图全屏 */
function fullScreen() {
	parent.parent.parent.index.rows="0,0,*"
	parent.parent.content.cols="0,0,*";
	
}
function enterAndEsc() 
{ 
   var esc=window.event.keyCode; 
   if(esc==27) //判断是不是按的Esc键,27表示Esc键的keyCode.按下退出全屏.
   {   
   		parent.parent.parent.index.rows="106,32,*"
		parent.parent.content.cols="220,0,*";
    }
}
document.onkeydown = enterAndEsc; 	
/* 地图图例 */
function legend(){
	parent.Ext.getCmp('east-panel').expand();
	parent.Ext.getCmp('east-panel').setTitle('地图图例');
	parent.document.getElementById("east").src="model/giscomponents/legend/legendTab.jsp";
}
/* 定位 */
function doLocation(){
	parent.Ext.getCmp('east-panel').expand();
	parent.Ext.getCmp('east-panel').setTitle('定位');
	parent.document.getElementById("east").src="model/giscomponents/location/location.jsp";
}
/*巡查核查列表展现*/
function MarkList(){
    parent.Ext.getCmp('west-panel').collapse();
	parent.Ext.getCmp('east-panel').expand();
	parent.Ext.getCmp('east-panel').setTitle('巡查核查成果列表');
	parent.document.getElementById("east").src="model/dc/pages/MarkList.jsp";
}
/* 实时跟踪 */
function doMonitor(){
	parent.Ext.getCmp('west-panel').collapse();
	parent.Ext.getCmp('east-panel').expand();
	parent.Ext.getCmp('east-panel').setTitle('实时跟踪');
	parent.document.getElementById("east").src="model/giscomponents/carMonitor/index.jsp";
}
/* shp导入 */
function shpimport(){
	parent.Ext.getCmp('east-panel').expand();
	parent.Ext.getCmp('east-panel').setTitle('图斑导入');
	parent.document.getElementById("east").src="model/giscomponents/importShapefile/importShapefile.jsp";
}
/* 图斑查询 */
function tbQuery(){
	parent.Ext.getCmp('east-panel').expand();
	parent.Ext.getCmp('east-panel').setTitle('图斑查询');
	parent.document.getElementById("east").src="model/giscomponents/infoQuery/infoQuery.jsp";
}

//标记分析
function markAnalysis(){
	shflag = 'mark';
	navigationToolbar.deactivate();
	setOPStatus();
	drawToolbar.activate(esri.toolbars.Draw.POINT);	
}
//splitbutton显示菜单 add by guorp 2012-4-3
function showMenu(){
	this.showMenu();
}
/* 创建通用按钮 */
function createLayout() {
	new Ext.Viewport({
		layout : "border",
		items : [{
					region : "north",
					contentEl : 'toolbar',
					height:40,
					margins : '0 0 -12 0',
					tbar : [

					{
								xtype : 'tbbutton',
								text : '  放大',
								cls : 'x-btn-text-icon',
								icon : '../images/zoom-in.png',
								tooltip : '放大',
								handler : zoomIn
							}, {
								xtype : 'tbbutton',
								text : '  缩小',
								cls : 'x-btn-text-icon',
								icon : '../images/zoom-out.png',
								tooltip : '缩小',
								handler : zoomOut
							}, {
								xtype : 'tbbutton',
								text : '  漫游',
								cls : 'x-btn-text-icon',
								icon : '../images/hand.png',
								tooltip : '漫游',
								handler : pan
							}, {
								xtype : 'tbbutton',
								text : '  全图',
								cls : 'x-btn-text-icon',
								icon : '../images/Full_Extent.png',
								tooltip : '全图',
								handler : zoomToFullExtent
							}, {
								xtype : 'tbbutton',
								text : '前图',
								cls : 'x-btn-text-icon',
								icon : '../images/Zoom_Back.png',
								tooltip : '前图',
								handler : zoomToPrevExtent
							}, {
								xtype : 'tbbutton',
								text : '后图',
								cls : 'x-btn-text-icon',
								icon : '../images/Zoom_Forward.png',
								tooltip : '后图',
								handler : zoomToNextExtent
							}, {
								xtype : 'splitbutton',
								text : '量算',
								handler:showMenu,
								icon : '../images/sjpz.png',
								menu : [ {
											text : '规则面积量算',
											cls : 'x-btn-text-icon',
											icon : '../images/showVertices.png',
											tooltip : '面积量算',
											handler : drawPolygon
										}, {
											text : '任意面积量算',
											cls : 'x-btn-text-icon',
											icon : '../images/showVertices1.png',
											tooltip : '面积量算',
											handler : DrawFreeHandPolygon
										}, {
											text : '直线长度量算',
											cls : 'x-btn-text-icon',
											icon : '../images/line.png',
											tooltip : '长度量算',
											handler : drawLine
										}, {
											text : '折线长度量算',
											cls : 'x-btn-text-icon',
											icon : '../images/line2.png',
											tooltip : '长度量算',
											handler : drawPolyline
										}, {
											text : '任意长度量算',
											cls : 'x-btn-text-icon',
											icon : '../images/line3.png',
											tooltip : '长度量算',
											handler : drawFreeHandPolyline
										}]
							},'-', {
								xtype : 'tbbutton',
								text : '清除',
								cls : 'x-btn-text-icon',
								icon : '../images/Clear.png',
								tooltip : '清除',
								handler : clear
							},'-', {
											text : '标注查看',
											cls : 'x-btn-text-icon',
											icon : '../images/sjpz.png',
											tooltip : '标注查看',
											handler : markAnalysis
										},{
								xtype : 'splitbutton',
								text : '分析',
								handler : showMenu,
								icon : '../images/ygfx.png',
								menu : [{
											text : '属性分析',
											cls : 'x-btn-text-icon',
											icon : '../images/ygfx.png',
											tooltip : '属性分析',
											handler : mapAnalyse
										}, {
											text : '项目查询',
											cls : 'x-btn-text-icon',
											icon : '../images/wptb.png',
											tooltip : '项目查询',
											handler : projectQuery
										}]
							}, '-', 
							{
								xtype : 'splitbutton',
								text : '工具箱',
								handler : showMenu,
								icon : '../images/box.png',
								menu : [{
											text : '坐标定位',
											cls : 'x-btn-text-icon',
											icon : '../images/marker.png',
											tooltip : '坐标定位',
											handler : doLocation
										},
										{
											text : '实时跟踪',
											cls : 'x-btn-text-icon',
											icon : '../images/location.png',
											tooltip : '实时跟踪',
											handler : doMonitor
										}, 
										{
											text : '地图图例',
											cls : 'x-btn-text-icon',
											icon : '../images/legend.png',
											tooltip : '地图图例',
											handler : legend
										},{
											text : '图斑查询',
											cls : 'x-btn-text-icon',
											icon : '../images/ss.gif',
											tooltip : '图斑查询',
											handler : tbQuery
										},{
											text : '打印',
											cls : 'x-btn-text-icon',
											icon : '../images/printer.png',
											tooltip : '打印',
											handler : printMapHandler
										},{
									    	text : '全屏',
											id:'full_screen',
											cls : 'x-btn-text-icon',
											icon : '../images/Full_Extent.png',
											tooltip : '全屏',
											handler : fullScreen
										}]
							     },
							     	{
								xtype : 'splitbutton',
								text : '标注',
								handler:showMenu,
								icon : '../images/sjpz.png',
								menu : [{
											text : '点',
											cls : 'x-btn-text-icon',
											icon : '../images/point1.png',
											tooltip : '点',
											handler : drawLocationPoint
										}, {
											text : '面',
											cls : 'x-btn-text-icon',
											icon : '../images/showVertices.png',
											tooltip : '面',
											handler : drawLocationPolygon
										},{
											text : '选择监测图班',
											cls : 'x-btn-text-icon',
											icon : '../images/select.png',
											tooltip : '选择监测图班',
											handler : selectJCTB
										},{
											text : '图斑导入',
											cls : 'x-btn-text-icon',
											icon : '../images/importshp.png',
											tooltip : '图斑导入',
											handler : shpimport
										}]
							}]
				}, {
					region : "center",
					margins : '0 0 0 0',
					contentEl : 'mapDiv'
				}]
	});
}

/* draw map add by guorp 2010-12-27 */
function addToMap(geometry) {
	var graphic;
	//是框选的话调用对应方法
    if(isSelectedQueryClickEventEnabled){
     searchSelectedName(geometry);
    return;
    }
	switch (geometry.type) {
		case "polyline" :
			graphic = new esri.Graphic(geometry, commonsls);
			break;
		case "polygon" :
			graphic = new esri.Graphic(geometry, commonsfs);
			break;
	}
	if(shflag=="mark"){
			markShow(geometry,false);
			return;
	}
	if (shflag == 'drawPoint') {
		drawToolbar.deactivate();
		graphic = new esri.Graphic(geometry, commonmarkR);
		map.graphics.clear();
	}
	if (shflag == 'drawLine' || shflag == 'drawPolygon') {
		graphic = new esri.Graphic(geometry, commonbluelight);
		map.graphics.clear();		
	}
	top.graphic=graphic;
	map.graphics.add(graphic);
    if(shflag!=null){
       saveMark(geometry);
    }
	shflag = null;
	var spatialReference2 = new esri.SpatialReference({"wkid":"2364"});
	//alert(spatialReference2);
	//鉴于 转换后坐标发生改变无法定位
	geometries2=geometry;
	/* 坐标参考转换 */
	geometryService.project([geometry], spatialReference2, projectComplete, projectException);
}
function json2str(o) {
    var arr = [];
    var fmt = function(s) {
    if (typeof s == 'object' && s != null) return json2str(s);
        return /^(string|number)$/.test(typeof s) ? "'" + s + "'" : s;
    }
    for (var i in o) arr.push("'" + i + "':" + fmt(o[i]));
        return '{' + arr.join(',') + '}';
}
   
function saveMark(geometry){
	        var wkt="";
		    var actionName = "mapFunctionAC";
		    var actionMethod = "markBeiAnJudge";
		    if(geometry.type=='point'){     
		    	wkt=geometry.x+","+geometry.y;
		    }else{
		    	r = geometry.rings;
		        var ringstr = "";
			    for (var i = 0; i < r[0].length; i++) {
					if (i == r[0].length - 1)
						ringstr = ringstr + r[0][i][0] + "," + r[0][i][1];
					else {
						ringstr = ringstr + r[0][i][0] + "," + r[0][i][1] + ",";
					}
			    }
			    wkt=ringstr;
		    }
			var parameter="wkt="+wkt+"&shType="+geometry.type;
		    var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
		    var arr=result.split("@");
		    var res;
		    //alert(arr[arr.length-1]);
		     //弹出条件
		     if(arr[1]=="1"){
		     res=window.showModalDialog(
						"/model/dc/pages/1/dc_ydqkdcb.jsp?jdbcname=ywJdbcTemplate&yw_guid="+arr[0], "",
						"dialogWidth=800px;dialogHeight=600px;status=no;scroll=no");
				
		     }else{
		     res=window.showModalDialog(
						"/model/dc/pages/2/dc_ydqkdcb.jsp?jdbcname=ywJdbcTemplate&yw_guid="+arr[0], "",
						"dialogWidth=800px;dialogHeight=600px;status=no;scroll=no");
		     }
		     if(!res){
				  parent.east.document.location.reload();
			 }
}
//提取标注方法
function markShow(geo,isReload){
       if(map.graphics!=null){
  		 for(var n=0;n<map.graphics.graphics.length;n++){
		  if(map.graphics.graphics[n].geometry.type=='point'){
		   map.graphics.remove(map.graphics.graphics[n]);
		   n--;
		  }
		}       
       }
		//map.graphics.clear();

		//shflag = null;	
		//parent.center.putClientCommond("analysisGH", "doit");
		//parent.center.putRestParameter("_$sid", "aaa");
		//parent.center.putRestParameter("geometry", Ext.encode(geometry));
		//var result = parent.center.restRequest();
		//异步请求
		
		
		
		//alert(parent.window.dialogArguments.id);
		//查询方式
		var actionName = "mapFunctionAC";
	     var actionMethod = "markAnalysis";
	     //+"&yw_guid="+parent.window.dialogArguments.zch
		var parameter="geometry="+ Ext.encode(geo);
		if(parent.window.dialogArguments) { 
			parameter+="&yw_guid="+parent.window.dialogArguments.yw_guid;
		}
		var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
		if(result!=null){
			if(result.indexOf('未审批')>=0){
		       graphic = new esri.Graphic(geo, commonmarkR);
			}else{
			   graphic = new esri.Graphic(geo, commonmarkB);
			}
		    map.graphics.add(graphic);	
		  // Ext.Msg.alert('相关信息',result);
		  // var result="未审批<br>未供地<br>符合规划<br>未占用基本农田<br>年度卫片执法检查未发现";
		  //result=result+"年度卫片执法检查未发现";
		  var p=map.toScreen(geo);
		  var em;
		  if(parent.window.dialogArguments){
		   em=Ext.Msg.show({
      	   title:"相关信息",
       	   width:300,
      	   buttons:{
      	       ok:'保存返回'
      	   },
      	   fn:  function() { 
      	   				// 
					    window.returnValue=result+'zuobiao:'+geo.x+","+geo.y;
						window.close();
						},
           msg:result,
           modal:false
           });
		  }else{
		  		   em=Ext.Msg.show({
      	   title:"相关信息",
       	   width:300,
      	   buttons:{
      	       ok:'关闭'
      	   },
           msg:result,
           modal:false
           });
		  }
         if(!isReload){
           em.getDialog().setPosition(p.x+10,p.y+40); 
		 }else{
		   //em.getDialog().setPosition(map.width,map.height); 
		 }
		}
}

function projectException(e) {
	Ext.Msg.alert('提示','地图服务异常！');
}
function projectComplete(geometries) {
	// 如果为线类型就进行lengths距离测算
	//alert(geometries[0].type);
	if (geometries[0].type == "polyline") {
		// alert(geometries[0].type)
		dojo.connect(geometryService, "onLengthsComplete", outputAreaAndLength);
		//geometries2 = geometries;
		var lengthParams = new esri.tasks.LengthsParameters();
		lengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_FOOT;
		// 如果为经纬大地理，geodesic = true add by guorp 2010-12-28
		//lengthParams.geodesic = true;
		lengthParams.polylines = geometries;
		geometryService.lengths(lengthParams);
	}
	// 如果为面类型需要先进行simplify操作在进行面积测算
	else if (geometries[0].type == "polygon") {
		dojo.connect(geometryService, "onSimplifyComplete", simplifyComplete);
		geometryService.simplify(geometries);
	}
}

/* 面积和长度计算 */
function simplifyComplete(geometries) {
	//geometries2 = geometries;
	dojo.connect(geometryService, "onAreasAndLengthsComplete",
			outputAreaAndLength);
	var areasAndLengthParams = new esri.tasks.AreasAndLengthsParameters();
	areasAndLengthParams.areaUnit = esri.tasks.GeometryService.UNIT_ACRES;
	areasAndLengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_FOOT;
	areasAndLengthParams.polygons = geometries;
	geometryService.areasAndLengths(areasAndLengthParams);
}

// 显示测量结果
function outputAreaAndLength(result) {
	drawToolbar.deactivate();
	var text;
	var labelPoint = geometries2.getExtent().getCenter();
	if ('polyline' == geometries2.type) {
		if (result.lengths[0] > 1000) {
			text = (parseFloat(result.lengths[0]) / 1000).toFixed(2) + "千米"
		} else {
			text = (parseFloat(result.lengths[0]).toFixed(2)) + "米"
		}
	} else if ('polygon' == geometries2.type) {
			text = "面积：" + parseFloat(result.areas[0]).toFixed(2)*0.0015 + "亩\n"
					+ " 周长：" + (parseFloat(result.lengths[0]).toFixed(2)) + "米";

	}
	var textSymbol = application.getTextSymbol(text);
	var labelPointGraphic = new esri.Graphic(labelPoint, textSymbol);
	map.graphics.add(labelPointGraphic);
	if (shgeometry != null) {
		var r = "";
		if (shgeometry.type == 'polygon') {
			r = shgeometry.rings;
		}
		if (shgeometry.type == 'polyline') {
			r = shgeometry.paths;
		}
		var ringstr = "";
		for (var i = 0; i < r[0].length; i++) {
			if (i == r[0].length - 1)
				ringstr = ringstr + r[0][i][0] + "," + r[0][i][1];
			else {
				ringstr = ringstr + r[0][i][0] + "," + r[0][i][1] + ",";
			}
		}
		if (showflag == null)
			showShProperties();
		formSh.getForm().findField('type').setValue(shgeometry.type);
		formSh.getForm().findField('rings').setValue(ringstr);
		shgeometry =null;
	}
}

var _$queryEvt;
var _$queryMapServiceIndex;
var _$queryLayerIndex;
var _$layerID;
var _$result;
var queryinfo;
var resultindex;

/**
 * 属性查询方法
 */
function propertiesQuery(evt){
		if(win){
		 win.hide();
		}
		// 初始化全局变量
		_$queryEvt = evt;
		_$queryMapServiceIndex = -1;
		_$queryLayerIndex = -1;
		_$layerID = null;// 置空
	    var actionName = "mapFunctionAC";
	    var actionMethod = "sxcxFunction";
		//var parameter="f="+treeid+"&keyWord="+escape(escape(keyWord));
		var parameter="function=1";
		var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
		if(result!=null){
		_$result=Ext.util.JSON.decode(result);
		queryTask(evt, _$queryMapServiceIndex, _$queryLayerIndex);
		}
}


function checkJCTB(evt){
   var actionName = "shtcDataOperationAC";
   var actionMethod = "getMapservicesByName";
   var parameter="servicesName=DC_YW";
   var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
   //alert(result);
   var query = new esri.tasks.Query();
   var queryTask = new esri.tasks.QueryTask(result + "/5");
   var spatialReference=getMapSpatialReference();
   query.outSpatialReference = spatialReference;
   query.geometry = new esri.geometry.Point(evt.mapPoint.x, evt.mapPoint.y, spatialReference);
   query.geometry.setSpatialReference(spatialReference);
   query.outFields = ['TBBH'];
   queryTask.execute(query, showJCTB);
}


function showJCTB(featureSet){
   var graphic = featureSet.features[0];
   	if (tblayer == null) {
		tblayer = new esri.layers.GraphicsLayer();
		map.addLayer(tblayer);
	}
   	var sfs = new esri.symbol.SimpleFillSymbol(
			esri.symbol.SimpleFillSymbol.STYLE_NULL,
			new esri.symbol.SimpleLineSymbol(
					esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([
							0, 255, 255]), 2), new dojo.Color([255, 255, 0, 1]));
	sfs.setColor(new dojo.Color([255, 0, 0]));
    graphic.setSymbol(sfs);
    tblayer.add(graphic);
   //获取id
   //高亮定位 
    //分析
    var actionName = "mapFunctionAC";
    var actionMethod = "markBeiAnJudge";
	var parameter="TBBH="+graphic.attributes.TBBH;
    var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
    var res;
    var arr=result.split("@");
    var resultArray = arr[arr.length-1].split(","); 
		   	var array = new Array(); 
		   	for(var i=0;i<resultArray.length;i++){	
		   	   array[i]=new Array(); 
		   	   var zb=resultArray[i].split(" ");
			   array[i][0]=Number(zb[0]); 
			   array[i][1]=Number(zb[1]); 
		   	 }
	          var polygon=new esri.geometry.Polygon(map.spatialReference);
	          polygon.addRing(array);  	          
		      var geometries=geometryService.simplify([polygon]);
		      var graphic = new esri.Graphic(polygon,commonbluelight);
		      map.graphics.add(graphic);
     //弹出条件
     if(arr[1]=="1"){
     res=window.showModalDialog(
				"/model/dc/pages/1/dc_ydqkdcb.jsp?jdbcname=ywJdbcTemplate&yw_guid="+arr[0], "",
				"dialogWidth=800px;dialogHeight=600px;status=no;scroll=no");
     }else{
      res=window.showModalDialog(
				"/model/dc/pages/2/dc_ydqkdcb.jsp?jdbcname=ywJdbcTemplate&yw_guid="+arr[0], "",
				"dialogWidth=800px;dialogHeight=600px;status=no;scroll=no");
     }
     if(!res){parent.east.document.location.reload();}
}

function showBuffer(geometries){				
        var extent=geometries[0].getExtent();
		var xmin=extent.xmin;
		var xmax=extent.xmax;
		var ymin=extent.ymin;
		var ymax=extent.ymax;
		var ms=xmin+','+ymin+','+xmax+','+ymax;
		var mapServicesUrl;
		var result;
		var message;
		var infoStr="";
		for(var i=0;i<mapServices.length;i++){//////wfs
			//if(mapServices[i].type=='wfs'){		
			mapServicesUrl=mapServices[i].url;	
			//wfsServicesUrl=mapServices[i].url;		
			wfsServicesUrl=mapServicesUrl.substring(0,mapServicesUrl.length-9)+"WFSServer";
			pjsonServicesUrl=wfsServicesUrl.replace('arcgis/','arcgis/rest/');
			pjsonServicesUrl=pjsonServicesUrl+"?f=pjson";
			pjsonResult=pjsonAjax(pjsonServicesUrl);
			var layerJson=eval('('+pjsonResult+')');				
			for(var j=0;j<layerJson.layers.length;j++){
			var layerName=layerJson.layers[j].name;	
			if(layerName.indexOf('GISER')>-1){
				layerName=layerName.substring(layerName.indexOf('GISER')+6,layerName.length);
			}				    
    	        result = wfsAjax(wfsServicesUrl,escape(escape(layerName)),ms);//http://win-fbya1dojc3y:8399/arcgis/services/WFS_TEST/bbb/MapServer/WFSServer YZ_JSYDSP
    	       	if(result.indexOf('fid')>-1){///有查询结果 
    	           message=toXML(result);
    	           //alert(message.getElementsByTagName("gml:featureMember")[0].childNodes[0].firstChild.firstChild.nodeValue);//.firstChild.
    	           //showInfo();
    	           var childNodes=message.getElementsByTagName("gml:featureMember")[0].childNodes[0].childNodes;    	           
    	           for(var k=0;k<childNodes.length;k++){   	           		
    	           		if(!childNodes[k].firstChild.nodeValue){
    	           			continue;
    	           		}   	           
    	           		if(k==childNodes.length-1){
    	           			infoStr+=childNodes[k].firstChild.nodeValue;   	           			
    	           		}
    	           		infoStr+=childNodes[k].firstChild.nodeValue+"<br>";
    	           }
    	        }
    	   }		      								
	//}
	if(infoStr){
	showInfo(infoStr);
	}else{
	Ext.Msg.alert("提示","未找到相关属性信息！");
	}
  }
}

function toXML(strxml){ 
try{ 
xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); 
xmlDoc.loadXML(strxml); 
} 
catch(e){ 
var oParser=new DOMParser(); 
xmlDoc=oParser.parseFromString(strxml,"text/xml"); 
} 
return xmlDoc; 
} 

var wfsWin;
function showInfo(mes){
if(!wfsWin){
	wfsWin = new Ext.Window({
			applyTo : 'wfsWin',
			title : 'WFS查询结果',
			width : 250,
			height : 200,
			closeAction : 'hide',
			html:mes
			});	
		}
	  wfsWin.body.update(mes);	
	  wfsWin.show();	 	
}


// #wangf# 此为什么功能？代码有写死的情况
function executeQueryTask(evt) {
	if(isSGQueryClickEventEnabled){
		
	}
	if(isSelectJCTBClickEventEnabled){
	    checkJCTB(evt);
	}
	if(isWFSQueryClickEventEnabled){
	  	var params = new esri.tasks.BufferParameters(); 
      	params.geometries = [ evt.mapPoint ]; 
	  	params.distances = [0.01]; 
      	params.unit = esri.tasks.GeometryService.UNIT_METER; 
      	params.outSpatialReference = map.spatialReference; 
	  	geometryService.buffer(params, showBuffer); 	  				
	}
	if(isShpExportQueryClickEventEnabled){
		 propertiesQuery(evt);    
	}
	if (isPropertiesQueryClickEventEnabled) {
            propertiesQuery(evt);
	} else if (isProjectQueryClickEventEnabled) {
		var visible = "";
		for (var i = 0; i < mapServices.length; i++) {
			if (mapServices[i].id == 'ZFJ_GDGZ'
					|| mapServices[i].id == 'ZFJ_JSYDSP'
					|| mapServices[i].id == 'ZFJ_WPZFJC') {
				if (mapServices[i].visiable[0] == "0") {
					visible += mapServices[i].url + "/0,";
				}
			}
		}
        if(visible==""){
         Ext.Msg.alert('提示', '未查询到相关项目！');
         return false;
        }
		if (visible.indexOf("ZFJ_GDGZ") > -1) {
			var url = "";
			for (var t = 0; t < visible.split(",").length; t++) {
				if (visible.split(",")[t].indexOf("ZFJ_GDGZ") > -1) {
					url = visible.split(",")[t];
				}
			}
			var queryTaskXm = new esri.tasks.QueryTask(url);
			var query = new esri.tasks.Query();
			query.returnGeometry = true;
			query.outFields = ["GD_GUID"];
			query.outSpatialReference = getMapSpatialReference();
			query.geometry = evt.mapPoint;
			dojo.connect(queryTaskXm, "onComplete", function(featureSet) {
						var graph = featureSet.features[0];
						if (graph == null) {
							showXm(visible, "ZFJ_JSYDSP", "YW_GUID", evt);
						} else {
							var GD_GUID = graph.attributes.GD_GUID;
							window.open("/model/giscomponents/resourcetree/resourceTree.jsp?jdbcname=spJdbcTemplate&zfjcType=43&yw_guid=GD_GUID$"+GD_GUID);
						}

					});
			queryTaskXm.execute(query);
		} else {
			showXm(visible, "ZFJ_JSYDSP", "YW_GUID", evt);
		}
		// if(visible.indexOf("YZ_GD")>-1){
		// YZ_WPZFJC YZ_JSYDSP
		// }

		/*
		 * 版本1 var visible=""; for(var i=0;i<mapServices.length;i++){
		 * if(mapServices[i].id=='YZ_GD'||mapServices[i].id=='YZ_JSYDSP'||mapServices[i].id=='20_YZ_WPZFJC'){
		 * visible+=mapServices[i].id+","; } } if(visible!=null){ //获取显示状态 及事件点
		 * parent.center.putClientCommond("xmcx", "deal");
		 * parent.center.putRestParameter("x",evt.mapPoint.x);
		 * parent.center.putRestParameter("y",evt.mapPoint.y);
		 * parent.center.putRestParameter("visible",visible); var mes=
		 * parent.center.restRequest(); if(mes[0].YZ_GD!=null){ //供地 }else
		 * if(mes[0].yz_jsydsp!=null){ //建设用地结果 var
		 * showUrl="/zfjc//common/pages/resourcetree/resourceTree.jsp?zfjcType=4&yw_guid="+mes[0].yz_jsydsp;
		 * 
		 * window.open(showUrl);
		 * 
		 * }else if(mes[0].YZ_WPZFJC!=null){ //卫片结果
		 * window.showModalDialog("/zfjc/supervisory/wpzfjc/pages/bhtb/bhtbInfo.jsp?yw_guid="+mes[0].YZ_WPZFJC,"","dialogWidth=600px;dialogHeight=550px;status=no;scroll=no");
		 * }else{ Ext.Msg.alert('提示','未查询到相关项目！'); } }else{
		 * Ext.Msg.alert('提示','未查询到相关项目！'); }
		 */
		// window
		// .showModalDialog(
		// "/zfjc/supervisory/wpzfjc/pages/bhtb/bhtbInfo.jsp?yw_guid=8F5BC34633EE44069716BD9558CCB621",
		// "",
		// "dialogWidth=600px;dialogHeight=550px;status=no;scroll=no");
	} else if (isSpProjectQueryClickEventEnabled) {
		window.showModalDialog(
				"/hotline/gisapp/pages/components/pdaStatus/sp.jsp", "",
				"dialogWidth=550px;dialogHeight=363px;status=no;scroll=no");
	} else if (isShprojectQueryClickEventEnabled) {

		//if (showflag == null)
		//	showShProperties();
		//isShprojectQueryClickEventEnabled = false;
		
	} else {
		return false;
	}
}

function showXm(visible, name, field, evt) {
	if (visible.indexOf(name) > -1) {
		var url = "";
		for (var t = 0; t < visible.split(",").length; t++) {
			if (visible.split(",")[t].indexOf(name) > -1) {
				url = visible.split(",")[t];
			}
		}
		var queryTaskXm = new esri.tasks.QueryTask(url);
		var query = new esri.tasks.Query();
		dojo.connect(queryTaskXm, "onComplete", function(featureSet) {
			var graph = featureSet.features[0];
			if (graph == null && name.indexOf("ZFJ_WPZFJC") == 0) {
				Ext.Msg.alert('提示', '未查询到相关项目！');
			} else if (graph != null) {
				if (name.indexOf("ZFJ_WPZFJC") == 0) {
					var jcbh = graph.attributes.JCBH;
					window
							.open(
									"/base/gis/pages/deal.jsp?jcbh=" + jcbh,
									'',
									'height=620,width=600,top=100,left=100，toobar=no,menubar=no,scrollbar=no,resizable=no,status=no,location=no');
				} else if (name.indexOf("ZFJ_JSYDSP") == 0) {
					var yw_guid = graph.attributes.YW_GUID;
					if (yw_guid == undefined) {
						showXm(visible, "ZFJ_WPZFJC", "JCBH", evt);
					} else {
						window
								.open("/model/giscomponents/resourcetree/resourceTree.jsp?zfjcType=4&yw_guid="
										+ yw_guid);
					}
				}
			} else {
				if (name.indexOf("ZFJ_JSYDSP") == 0) {
					showXm(visible, "ZFJ_WPZFJC", "JCBH", evt);
				}
			}
		})
		query.returnGeometry = true;
		query.outFields = [field];
		query.outSpatialReference = getMapSpatialReference();
		query.geometry = evt.mapPoint;
		queryTaskXm.execute(query);
	} else {
		if (name.indexOf("ZFJ_JSYDSP") == 0) {
			showXm(visible, "ZFJ_WPZFJC", "JCBH", evt);
		}else{
		 Ext.Msg.alert('提示', '未查询到相关项目！');
		}
	}
}


function showXmLast(visible,name,field, evt){
if (visible.indexOf(name) > -1) {
		var url = "";
		for (var t = 0; t < visible.split(",").length; t++) {
			if (visible.split(",")[t].indexOf(name) > -1) {
				url = visible.split(",")[t];
			}
		}
		var queryTaskXm = new esri.tasks.QueryTask(url);
		var query = new esri.tasks.Query();
		dojo.connect(queryTaskXm, "onComplete", function(featureSet) {
			var graph = featureSet.features[0];
			if (graph == null){
			Ext.Msg.alert('提示', '未查询到相关项目！');
			}else{
			  var yw_guid = graph.attributes.查询字段;
			  window.open("...................."+yw_guid);
			}
		});
		query.returnGeometry = true;
		query.outFields = [field];
		query.outSpatialReference = getMapSpatialReference();
		query.geometry = evt.mapPoint;
		queryTaskXm.execute(query);
}else{
 Ext.Msg.alert('提示', '未查询到相关项目！');
}  

}

/**
 * 图斑属性查询方法，通过循环递归调用实现。add by guorunpei 2011-2-22
 * 
 * @param {}
 *            evt:鼠标的单击事件
 * @param {}
 *            queryMapServiceIndex：上次查询的地图服务顺序
 * @param {}
 *            queryLayerIndex：上次查询的图层顺序
 */
function queryTask(evt, queryMapServiceIndex, queryLayerIndex) {
	// alert(queryMapServiceIndex+' '+queryLayerIndex)
	var mapServices_size = mapServices.length;
	// alert("地图服务序号 "+_$queryMapServiceIndex+" "+queryLayerIndex );
	if (_$queryMapServiceIndex >= mapServices_size) {
		// alert("未查询到结果");
		Ext.Msg.alert('提示', '未查询到结果！');
		return false;
	}
	if (queryMapServiceIndex != -1) {
		if (queryLayerIndex == -1) {// 首次查询这个mapservice下的图层
			// alert(_$queryMapServiceIndex)
			var type = mapServices[_$queryMapServiceIndex].type;
			if (type != "dynamic") {// 跳过非dynamic
				_$queryMapServiceIndex += 1;
				queryTask(evt, _$queryMapServiceIndex, -1);
				return false;
			} else {
				_$queryLayerIndex = queryLayerIndex + 1;
			}
		}

	} else if (queryMapServiceIndex == -1) {
		_$queryMapServiceIndex = 0;
		_$queryLayerIndex = 0;
		var type = mapServices[_$queryMapServiceIndex].format;
		if (type != "dynamic") {// 跳过影像服务的查询
			// alert("raster")
			_$queryMapServiceIndex += 1;
			// alert(_$queryMapServiceIndex)
			// alert(evt)
			queryTask(evt, _$queryMapServiceIndex, -1);
			return false;
		}
	}
//	// 判断是否是不存在query字段内容
//	if (mapServices[_$queryMapServiceIndex].query.length == 0) {
//		_$queryMapServiceIndex += 1;
//		queryTask(evt, _$queryMapServiceIndex, -1);
//		return false;
//	}
	// 定义queryTask 和 query
	if (mapServices[_$queryMapServiceIndex].visiable[_$queryLayerIndex] == null
			|| mapServices[_$queryMapServiceIndex].visiable[_$queryLayerIndex] == "null") {
		judge(evt, _$queryMapServiceIndex, _$queryLayerIndex)
		return false;
	}
	var mapServiceURL = mapServices[_$queryMapServiceIndex].url;
	// alert("可视的"+_$queryLayerIndex);
	_$layerID = mapServices[_$queryMapServiceIndex].visiable[_$queryLayerIndex];
	// alert(mapServices[_$queryMapServiceIndex].url+" "+_$layerID);
	// 判断可视图层
	if (_$layerID == null || _$layerID == "null") {
		judge(evt, _$queryMapServiceIndex, _$queryLayerIndex);
		return false;
	}
	var queryTask1 = new esri.tasks.QueryTask(mapServiceURL + "/" + _$layerID);
	var query = new esri.tasks.Query();
	var outFields;
	queryinfo=null;
	resultindex=-1;
	for (var i = 0; i <_$result.length;i++) {
		if (_$result[i].LAYERURL==mapServiceURL + "/" + _$layerID) {
			outFields =_$result[i].QUERYFIELDS;
			queryinfo =_$result[i].QUERYFIELDSINFO;		
			resultindex=i;
			break;
		}
	}
	if(resultindex==-1){
	   judge(evt, _$queryMapServiceIndex, _$queryLayerIndex);
	 return;
	}
	query.returnGeometry = true;
	query.outFields = [outFields];
	//var spatialReference2 = new esri.SpatialReference({"wkid":"9999"});
	query.outSpatialReference = getMapSpatialReference();
	query.geometry = new esri.geometry.Point(evt.mapPoint.x, evt.mapPoint.y, getMapSpatialReference());
	query.geometry.setSpatialReference(getMapSpatialReference());
	queryTask1.execute(query, showResults, errback);

}
function errback(e) {
	// alert('errorback');
	_$queryMapServiceIndex += 1;
	queryTask(_$queryEvt, _$queryMapServiceIndex, -1);
}

var tblayer;
function showResults(featureSet) {
	// alert("到showResults");
	// var content =
	// mapServices[_$queryMapServiceIndex].query._$layerID.queryFieldsInfo;
	var infoTemplate;
	if (queryinfo != null && queryinfo != "null") {
		// alert("content: "+content)
		infoTemplate = new esri.InfoTemplate("", queryinfo);
	} else {
		infoTemplate = new esri.InfoTemplate("");
	}
	var graphic = featureSet.features[0];
	if (featureSet.features.length == 0) {
		judge(_$queryEvt, _$queryMapServiceIndex, _$queryLayerIndex);
		return false;
	} else {
		graphic.setInfoTemplate(infoTemplate);
	}

	if (tblayer == null) {
		tblayer = new esri.layers.GraphicsLayer();
		map.addLayer(tblayer);
	}
	tblayer.disableMouseEvents();
	tblayer.clear();
	var sfs = new esri.symbol.SimpleFillSymbol(
			esri.symbol.SimpleFillSymbol.STYLE_NULL,
			new esri.symbol.SimpleLineSymbol(
					esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([
							0, 255, 255]), 2), new dojo.Color([255, 255, 0, 1]));
	sfs.setColor(new dojo.Color([255, 0, 0]));
	graphic.setSymbol(sfs);
	tblayer.add(graphic);
	
	//shp导出
	if(isShpExportQueryClickEventEnabled){
	  exportShp(featureSet);
	  return;
	}
	
	var str;
	if (graphic.getContent().indexOf('变更日期') > 0) {
		var bgrq = graphic.getContent().substr(
				graphic.getContent().indexOf('变更日期') + 5,
				graphic.getContent().length
						- graphic.getContent().indexOf('变更日期') - 10);
		var bgyear = bgrq.substr(bgrq.length - 5, bgrq.length - 1);
		var bgmonth;
		if (bgrq.substr(4, 3) == 'Jan') {
			bgmonth = "01";
		}
		if (bgrq.substr(4, 3) == 'Feb') {
			bgmonth = "02";
		}
		if (bgrq.substr(4, 3) == 'Mar') {
			bgmonth = "03";
		}
		if (bgrq.substr(4, 3) == 'Apr') {
			bgmonth = "02";
		}
		if (bgrq.substr(4, 3) == 'May') {
			bgmonth = "03";
		}
		if (bgrq.substr(4, 3) == 'Jun') {
			bgmonth = "06";
		}
		if (bgrq.substr(4, 3) == 'Jul') {
			bgmonth = "07";
		}
		if (bgrq.substr(4, 3) == 'Aug') {
			bgmonth = "08";
		}
		if (bgrq.substr(4, 3) == 'Sep') {
			bgmonth = "09";
		}
		if (bgrq.substr(4, 3) == 'Oct') {
			bgmonth = "10";
		}
		if (bgrq.substr(4, 3) == 'Nov') {
			bgmonth = "11";
		}
		if (bgrq.substr(4, 3) == 'Nov') {
			bgmonth = "11";
		}
		if (bgrq.substr(4, 3) == 'Dec') {
			bgmonth = "12";
		}
		if (bgrq.substr(4, 3) == 'Nov') {
			bgmonth = "11";
		}
		var bgdate = bgrq.substr(8, 2);
		var datetime = bgrq.substr(11, 8);
		var bgrq2 = bgyear + "-" + bgmonth + "-" + bgdate + " " + datetime;
		str = graphic.getContent().replace(bgrq, bgrq2);
	}
	// 显示属性分析、现状压盖分析、规划压盖分析
	if (str) {
		document.getElementById('properties').innerHTML = str;
	} else {
		document.getElementById('properties').innerHTML = graphic.getContent();
	}
	if (_$result[resultindex].MAPFUNCTION.indexOf('1')<0) {
		showPropertiesAndAnalyseResult(graphic.geometry, '1,2,3');
		return false;
	} else {// 只显示属性分析

		showPropertiesAndAnalyseResult(graphic.geometry, '1');
		return false;
	}
}

/**
 * 提取重复方法 指定下一个判断图层
 * 
 * @return {Boolean}
 */
function judge(evt, queryMapServiceIndex, queryLayerIndex) {
	if (queryLayerIndex < (mapServices[queryMapServiceIndex].visiable.length - 1)) {// 当前地图服务下的图层未查询完毕
		_$queryLayerIndex = queryLayerIndex + 1;
	} else if (queryLayerIndex >= (mapServices[queryMapServiceIndex].visiable.length - 1)) {// 当前地图服务下的图层查询完毕，或当前地图服务下无可见图层
		_$queryLayerIndex = -1;
		if (queryMapServiceIndex < (mapServices.length - 1)) {// 不是最后一个地图服务
			_$queryMapServiceIndex = queryMapServiceIndex + 1;
			var type = mapServices[_$queryMapServiceIndex].type;
			if (type != "dynamic") {// 跳过影像服务的查询
				// alert("raster");
				_$queryMapServiceIndex += 1;
				queryTask(evt, _$queryMapServiceIndex, -1);
				return false;
			}
		} else if (_$queryMapServiceIndex >= (mapServices.length - 1)) {// 最后一个地图服务
			// alert("未查询到结果");
			Ext.Msg.alert('提示', '未查询到结果！');
			return false;
		}
	}
	queryTask(evt, _$queryMapServiceIndex, _$queryLayerIndex);
}

// 单位转换
function reviseData(number) {
	var data;
	if (number.toString().indexOf('.') >= 0) {
		data = number.toString().substring(0,
				number.toString().indexOf('.') + 5);
	} else {
		data = number.toString();
	}
	return data;
}
/**
 * 图斑属性、现状规划压盖分析
 * 
 * @param {}
 *            graphic
 * @param {}
 *            flag：1属性页面；2现状压盖页面；3规划页面。
 *            多个页面用逗号隔开，如：'2,3'表示显示规划和现状压盖页面，'1':仅显示属性页面；'1,2,3':显示属性页面、现状压盖页面、规划压盖页面
 */
function showPropertiesAndAnalyseResult(geometry, tabIndex) {
	// #wangf# 将魔法数字修改为可识别的标记样式
	if (tabIndex.indexOf(PropertiesPage) >= 0) {
	}
	if (tabIndex.indexOf(XZPage) >= 0) {
		// 现状压盖分析
		parent.center.putClientCommond("analysisXZ", "doit");
		parent.center.putRestParameter("_$sid", "aaa");
		parent.center.putRestParameter("geometry", Ext.encode(geometry));
		var xz = parent.center.restRequest();
		var header = '<table border="1" cellpadding="0" cellspacing="0" width="330" height="40" style="text-align:center; vertical-align:middle;font-family: 宋体, Arial; font-size: 12px;border-collapse:collapse;border:1px #000 solid;margin-top:-10px;" >'
				+ '<tr>'
				+ '<td style="border:1px #000 solid;">总面积</td>'
				+ '<td style="border:1px #000 solid;" colspan="2">农用地</td>'
				+ '<td style="border:1px #000 solid;">建设用地</td>'
				+ '<td style="border:1px #000 solid;">未利用地</td>'
				+ '</tr>'
				+ '<tr>'
				+ '<td id="zmj" style="border:1px #000 solid;" rowspan="2">&nbsp;</td>'
				+ '<td id="nyd" style="border:1px #000 solid;" rowspan="2" width="60">&nbsp;</td>'
				+ '<td style="border:1px #000 solid;">其中耕地</td>'
				+ '<td id="jsyd" style="border:1px #000 solid;" rowspan="2">&nbsp;</td>'
				+ '<td id="wlyd" style="border:1px #000 solid;" rowspan="2">&nbsp;</td>'
				+ '</tr>'
				+ '+<tr>'
				+ '<td id="gd" style="border:1px #000 solid;">&nbsp;</td>'
				+ '</tr>' + '</table>';
		header += "<table width='330' border=0 style='font-family: 宋体, Arial; font-size: 12px;'><tr style=' font: bold 12px , Verdana, Arial, Helvetica, sans-serif;'><td width='9%' align='left'>序号</td><td width='9%' align='left'>代码</td><td width='25%' align='left'>名称</td><td width='17%' align='left'>图斑编号</td><td width='20%' align='left'>权属单位</td><td width='20%' align='center'>面积</td></tr>"
		var area = 0;
		var ysydmj = 0;// 建设用地面积
		var nydmj = 0;// 农用地面积
		var gdmj = 0;// 其中耕地面积
		var wlydmj = 0;// 未利用地面积
		var ysydtb = "051,052,053,054,061,062,063,071,072,081,082,083,084,085,086,087,088,091,092,093,094,095,101,102,103,105,106,107,113,118,121,201,202,203,204,205";
		var nydtb = "011,012,013,021,022,023,031,032,033,041,042,043,104,114,117,123";
		var gdtb = "011,012,013";
		var wlydtb = "111,112,115,116,119,122,124,125,126,127";
		for (var i = 0; i < xz.length; i++) {
			header += '<tr><td align="left">&nbsp;'
					+ (i + 1)
					+ '</td><td align="left">'
					+ xz[i][1]
					+ '</td><td align="left">'
					+ xz[i][2]
					+ '</td><td align="left">'
					+ xz[i][3]
					+ '</td><td align="left">'					
					+ xz[i][4]
					+ '</td><td align="right">'
					+ reviseData(((Math.round(xz[i][5] * 10000) / 10000) * 0.0015))
					+ '亩</td></tr>'
			area = area + parseFloat(xz[i][5]);
			if (ysydtb.indexOf(xz[i][1]) >= 0) {
				ysydmj = ysydmj + parseFloat(xz[i][5] * 0.0015);
			}

			if (nydtb.indexOf(xz[i][1]) >= 0) {
				nydmj = nydmj + parseFloat(xz[i][5] * 0.0015);
			}

			if (gdtb.indexOf(xz[i][1]) >= 0) {
				gdmj = gdmj + parseFloat(xz[i][5] * 0.0015);
			}

			if (wlydtb.indexOf(xz[i][1]) >= 0) {
				wlydmj = wlydmj + parseFloat(xz[i][5] * 0.0015);
			}
		}
		 header += '</table>';
		 //header += '<br>面积合计：' + reviseData(((Math.round(area * 10000) /
		 //10000)*0.0015)) +
		// '亩<br>其中建设用地：'+reviseData(ysydmj)+'亩<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;农&nbsp;&nbsp;用&nbsp;&nbsp;地：'+reviseData(nydmj)+'亩<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;未利用地：'+reviseData(wlydmj)+'亩</table>'
		
		document.getElementById('xz').innerHTML = header;
		document.getElementById('zmj').innerHTML=reviseData(((Math.round(area * 10000)/10000)*0.0015))+"亩";
		document.getElementById('nyd').innerHTML=reviseData(nydmj)+"亩";
		document.getElementById('jsyd').innerHTML=reviseData(ysydmj)+"亩";
		document.getElementById('wlyd').innerHTML=reviseData(wlydmj)+"亩";
		document.getElementById('gd').innerHTML=reviseData(gdmj)+"亩";
	}
	if (tabIndex.indexOf(GHPage) >= 0) {
		// 规划压盖分析
		parent.center.putClientCommond("analysisGH", "doit");
		parent.center.putRestParameter("_$sid", "aaa");
		parent.center.putRestParameter("geometry", Ext.encode(geometry));
		var gh = parent.center.restRequest();

		//011:现状建设用地,012：新增建设用地,020:有条件建设区,030：限制建设区,040：禁止建设区
		//011和012为允许建设区，为符合规划，020、030、040为不符合规划的 		
		var fhghdm = "1";		//符合规划代码	
		var bfhghdm = "2,3,4";//不符合规划代码
		//var xyjsq = 0;		//允许建设区
		var fhmj = 0;		//符合规划面积
		var ytjjsq = 0;		//有条件建设区面积
		var xzjsq = 0;		//限制建设区
		var jzjsq = 0;		//禁止建设区
		var bfhmj = 0;		//不符合规划面积
		var mjhj = 0;		//面积合计

		for(var i = 0; i < gh.length; i++){
			if(fhghdm.indexOf(gh[i][1].trim())>=0){
				fhmj += parseFloat(gh[i][3]);	
			}else if(bfhghdm.indexOf(gh[i][1].trim())>=0){
				if(gh[i][1] == "2"){
					ytjjsq += parseFloat(gh[i][3]);
				}else if(gh[i][1] == "3"){
					xzjsq += parseFloat(gh[i][3]);
				}else if(gh[i][1] == "4"){ 
					jzjsq += parseFloat(gh[i][3]);
				}
				bfhmj += parseFloat(gh[i][3]);
			}
			mjhj += parseFloat(gh[i][3]); 
		}

	var header = '<table border="1" cellpadding="0" cellspacing="0" width="330" height="100" style="text-align:left; vertical-align:middle;font-family: 宋体, Arial; font-size: 12px;border-collapse:collapse;border:1px #000 solid;margin-top:5px;">' 
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" rowspan="2" width="80" align="center">符合规划</td>'
		 +'<td style="border:1px #000 solid;" colspan="2">&nbsp;允许建设区</td>'
		 +'<td style="border:1px #000 solid;" id="yxjsq" width="80" align="right">&nbsp;</td>' 
		 +'</tr>'
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" colspan="2" align="right">小计：</td>'
		 +'<td style="border:1px #000 solid;" width="80" id="fhmj" align="right">&nbsp;</td>'
		 +'</tr>'
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" rowspan="4" width="80" align="center">不符合规划</td>'
		 +'<td style="border:1px #000 solid;" colspan="2">&nbsp;有条件建设区</td>'
		 +'<td style="border:1px #000 solid;" width="80" id="ytjjsq" align="right">&nbsp;</td>'
		 +'</tr>'
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" colspan="2">&nbsp;限制建设区</td>'
		 +'<td style="border:1px #000 solid;" width="80" id="xzjsq" align="right">&nbsp;</td>'
		 +'</tr>'
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" colspan="2">&nbsp;禁止建设区</td>'
		 +'<td style="border:1px #000 solid;" width="80" id="jzjsq" align="right">&nbsp;</td>'
		 +'</tr>'
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" colspan="2" align="right">小计：</td>'
		 +'<td style="border:1px #000 solid;" width="80" id="bfhmj" align="right">&nbsp;</td>'
		 +'</tr>'
		 +'<tr>'
		 +'<td style="border:1px #000 solid;" colspan="3" align="right"><b>面积合计:</b></td>'
		 +'<td style="border:1px #000 solid;" width="80" id="mjhj" align="right">&nbsp;</td>'
		 +'</tr>'
		 +'</table>'		
	
		document.getElementById('gh').innerHTML = header;
		document.getElementById('yxjsq').innerHTML = (fhmj*0.0015).toFixed(4) + '亩';
		document.getElementById('fhmj').innerHTML = (fhmj*0.0015).toFixed(4) + '亩';
		document.getElementById('ytjjsq').innerHTML = (ytjjsq*0.0015).toFixed(4) + '亩';
		document.getElementById('xzjsq').innerHTML = (xzjsq*0.0015).toFixed(4) + '亩';
		document.getElementById('jzjsq').innerHTML = (jzjsq*0.0015).toFixed(4) + '亩';
		document.getElementById('bfhmj').innerHTML = (bfhmj*0.0015).toFixed(4) + '亩';
		document.getElementById('mjhj').innerHTML = (mjhj*0.0015).toFixed(4) + '亩';
		
	}
	showWindow(tabIndex);
	return false;
}

/**
 * 显示手绘图层保存窗口
 */
function showShProperties() {
	Ext.QuickTips.init();
	if (!formSh) {
		formSh = new Ext.form.FormPanel({
			applyTo : 'updateForm',
			baseCls : 'x-plain',
			labelWidth : 60,
			width : 240,
			url : basePath + "shtcDataOperationAC.do?method=saveShtc",
			defaults : {
				xtype : "textfield",
				anchor : '100%'
			},
			items : [{
						name : 'name',
						fieldLabel : '名称',
						maxLength : 30
					}, {
						xtype : 'textarea',
						name : 'describe',
						height : 90,
						fieldLabel : '描述',
						maxLength : 50
					}, {
						xtype : 'radiogroup',
						name : 'shareflag',
						fieldLabel : '可见程度',
						items : [{
									boxLabel : '所有人',
									name : 'flag',
									inputValue : 1,
									checked : true
								}, {
									boxLabel : '仅自己',
									name : 'flag',
									inputValue : 0
								}]
					}, {
						name : 'type',
						hidden : true
					}, {
						name : 'rings',
						hidden : true
					}, {
						name : 'yw_guid',
						hidden : true
					}, {
						name : 'zfjctype',
						hidden : true
					}, {
						name : 'username',
						hidden : true
					}],
			buttons : [{
				text : '保存',
				handler : function() {
					if (formSh.getForm().isValid()) {
						formSh.form.submit({
									waitMsg : '正在保存,请稍候... ',
									success : function() {
										Ext.MessageBox.alert('提示', '保存成功！');
										saveflag = 1;
										winSh.hide();
										if (yw_guid == 0)
											parent.parent.east.document.location
													.reload();
									},
									failure : function() {
										// #wangf# 将具体的错误返回到页面提示中
										Ext.Msg.alert('提示', '保存失败！');
									}
								});
					}
				}
			}]
		});
	}
	if (!winSh) {
		winSh = new Ext.Window({
					applyTo : 'graphwin',
					title : '新增标记',
					width : 280,
					height : 230,
					closeAction : 'hide',
					items : formSh,
					listeners : {
						"hide" : function() {
							if (saveflag == null)
								map.graphics.clear();
							showflag = null;
						}
					}

				});
	}
	winSh.show();
	showflag = 1;
	formSh.getForm().findField('name').setValue("");
	formSh.getForm().findField('describe').setValue("");
	formSh.getForm().findField('yw_guid').setValue(yw_guid);
	formSh.getForm().findField('zfjctype').setValue(zfjctype);
	formSh.getForm().findField('username').setValue(username);
	saveflag = null;
}
/**
 * 显示图斑属性和规划现状分析window窗口
 * 
 * @param {}
 *            result
 * @param {}
 *            flag
 */
function showWindow(tabIndex) {
	var tabs = new Ext.TabPanel({
		        id:'pan',
				autoTabs : true,
				activeTab : 0,
				height : 400,
				enableTabScroll : true,
				deferredRender : false,
				border : false,
				scrollDuration : 0.35,
				scrollIncrement : 100,
				animScroll : true,
				defaults : {
					autoScroll : true
				},
				items : [{
							contentEl : 'properties',
							title : '图斑属性',
							id : 'properties_tab',
							closable : false,
							autoScroll : true,
							autoDestroy : true
						}, {
							contentEl : 'xz',
							title : '现状分析',
							id : 'xz_tab',
							closable : false,
							autoScroll : true,
							autoDestroy : true
						}, {
							contentEl : 'gh',
							title : '规划分析',
							id : 'gh_tab',
							closable : false,
							autoScroll : true,
							autoDestroy : true
						}]
			});
	// #wangf# 魔法数字，你懂的
	if (tabIndex.indexOf(PropertiesPage) < 0) {
		tabs.remove('properties_tab');
	}
	if (tabIndex.indexOf(XZPage) < 0) {
		tabs.remove('xz_tab');
	}
	if (tabIndex.indexOf(GHPage) < 0) {
		tabs.remove('gh_tab');
	}
	if (!win) {
		win = new Ext.Window({
					layout : 'fit',
					width : 350,
					height : 400,
					plain : true,
					closeAction : 'hide',
					listeners : {
						"hide" : function() {
							if(tblayer!=null){
							tblayer.clear();
							}
						}
					},

					items : tabs,

					buttons : [{
								text : '关闭',
								handler : function() {
									win.hide();
								}
							}]
				});
	}else{	
	win.items.removeAt(0);
	win.items.add("pan",tabs);
	win.doLayout();
	} 
	win.show();
}

/* 初始化业务ID 和 类型 */
function initYw(type, guid) {
	yw_guid = guid;
	zfjctype = type;
}


var kxresult;
var kxextent;
var kxIndex;
/**
 * 查询框选图形名称
 */
function searchSelectedName(extent){
	    if(kxwin){
	    kxwin.hide();
	    }
		if (tblayer == null) {
		tblayer = new esri.layers.GraphicsLayer();
		map.addLayer(tblayer);
		}
		tblayer.disableMouseEvents();
	    tblayer.clear();
			// 初始化全局变量
	   document.getElementById('kx').innerHTML='';
	    kxextent=extent;
	    kxIndex=0;
	    htmlInner=null;
	    var actionName = "mapFunctionAC";
	    var actionMethod = "kxFunction";
		var parameter="function=5";
		var result = ajaxRequest(basePath,actionName,actionMethod,parameter);
		if(result!=null&&result!=''){
		  kxresult=Ext.util.JSON.decode(result);
		  selectFilter();
		}
}
/**
 * 过滤可见图层并查询
 */
function selectFilter(){
	 //判断是否最后一个
	 if(kxIndex==kxresult.length){
	  //展现
	 	showKx();
	  return;
	 }
	  var url=kxresult[kxIndex].LAYERURL;
	   for(var t=0;t<mapServices.length;t++){
	     	//找到对应的地图服务
	   	  if(url.indexOf(mapServices[t].url)==0){
	          var visible=mapServices[t].visiable;
	          //当此地图服务无可见图层跳至下个循环
	          if(visible==null||visible=='null'){
	          	kxIndex++;
	          	selectFilter();
	          	return;
	          }else{
	             for(var y=0;y<visible.length;y++){
	              if(url==mapServices[t].url + "/" +visible[y]){              	
	              var queryTaskKx = new esri.tasks.QueryTask(mapServices[t].url + "/" +visible[y]);
	               dojo.connect(queryTaskKx, "onComplete", function(featureSet) {
	             		var features  = featureSet.features;
	             		if(features !=null){	             			
	             	  	document.getElementById('kx').innerHTML+='<h3>'+kxresult[kxIndex].TREENAME+'</h3><br>';	
	             		    for(var w=0;w<features.length;w++)	{
	             		    	if(kxextent.contains(features[w].geometry.getExtent())){
	             		    		var graphic=features[w];
									var sfs = new esri.symbol.SimpleFillSymbol(
											esri.symbol.SimpleFillSymbol.STYLE_NULL,
											new esri.symbol.SimpleLineSymbol(
													esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([
															0, 255, 255]), 2), new dojo.Color([255, 255, 0, 1]));
									sfs.setColor(new dojo.Color([255, 0, 0]));
									graphic.setSymbol(sfs);
									var resultTemplate=new esri.InfoTemplate(kxresult[kxIndex].FIELDS,kxresult[kxIndex].INFOTEMPLATE);
									tblayer.add(graphic.setInfoTemplate(resultTemplate));
									document.getElementById('kx').innerHTML+=graphic.getContent();
	             		    	}
	             		    }             				             			
	             		}
	             		//查询到最后一个
	             		if(kxIndex==kxresult.length-1){
	             			 //展现
	             			showKx();
	             		}else{
	             			   kxIndex++;
	             			   selectFilter();          				
	             		} 
	               });
	               var queryKx = new esri.tasks.Query();
                   queryKx.outSpatialReference = getMapSpatialReference(); 
                   queryKx.returnGeometry =true;
                   queryKx.outFields = [kxresult[kxIndex].FIELDS];
                   queryKx.where='1=1';
                   queryTaskKx.execute(queryKx);
                   return;
	              }             
	         }
	       }
	        kxIndex++;
	        selectFilter(); 
	        return;
	     }
		}	
}
var  kxwin;
function  showKx(){
if(document.getElementById('kx').innerHTML.length==0){
		 Ext.Msg.alert('提示', '没有可框选项！');
		 return;
}
var inner=document.getElementById('kx').innerHTML;
var tabs = new Ext.TabPanel({
		        id:'pan',
				autoTabs : true,
				activeTab : 0,
				enableTabScroll : true,
				deferredRender : false,
				border : false,
				scrollIncrement : 15,
				animScroll : true,

				items : [{
                      title: '列表',
                      html:inner,
                      autoScroll : true,
                      autoDestroy : true
						}]
	});	
if(!kxwin){
		kxwin = new Ext.Window({
				    layout : 'fit',
					width : 300,
					height : 300,
					plain : true,
					closeAction : 'hide',
					listeners : {
						"hide" : function() {
							tblayer.clear();
						}
					},
					items : tabs,
					buttons : [{
								text : '关闭',
								handler : function() {
									kxwin.hide();
								}
							}]
				});
}else{
	kxwin.items.removeAt(0);
	kxwin.items.add("pan",tabs);
}
kxwin.doLayout();
kxwin.show();
}

function replaceAll(s1,s2,s3){
	var r = new RegExp(s2.replace(/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g,"\\$1"),"ig");
	return s1.replace(r,s3);
}

function showAddTask(){
	if(!addTaskForm){
      addTaskForm=new Ext.form.FormPanel({
	   applyTo:'addTaskForm',
	   baseCls: 'x-plain',
       labelWidth:40,	
       width:220, 
       buttonAlign:'center',
       items: [{
            xtype:'textarea',	
            name:'tbmc',
            id:'tbmc',
            height:220,
            allowBlank: false,
            anchor:'90%',
            fieldLabel:'编号'      			
        }],				
             buttons: [{
               text:'确认', handler: function() {  
                    var actionName = "sHManageAC";
					var actionMethod = "checkTBBH";
				    var parameter="ids="+replaceAll(addTaskForm.getForm().findField('tbmc').getValue(),"\r\n",",");
					var result = ajaxRequest(basePath,actionName,actionMethod,parameter); 
					if(result){
					 var arr=result.split("@");
					 if(arr[1]!='0'){
                     Ext.MessageBox.confirm("注意", "本次录入图斑总数："+arr[0]+"个<br>其中有效图斑："+arr[1]+"个<br>编号不匹配："+arr[2]+"<br>已在核查任务中："+arr[3]+"<br>已核查完成："+arr[4]+"<br>将"+arr[1]+"个有效图斑加入到核查任务，确定吗？",function(btn){
			         if(btn=='yes'){
			             var actionName = "sHManageAC";
					     var actionMethod = "saveTBBH";
				         var parameter="ids="+arr[arr.length-1];
					     var result = ajaxRequest(basePath,actionName,actionMethod,parameter); 
					     if(result){
					        Ext.Msg.alert('提示','保存成功！');
					        parent.east.document.location.reload();
					     }
			          }
                    });
					}else{
					   Ext.Msg.alert('提示','无有效图斑！');	 
					}
			      }
               }
            }]
    });  
   }
   if(!addTaskWin){
    addTaskWin = new Ext.Window({
       applyTo:'addTaskWin',
       title:'请输入核查图斑编号，输入多个按回车键',
       width:270,
       height:330,
       closeAction:'hide',
	   items:addTaskForm
    });
   }
   addTaskWin.show();
}