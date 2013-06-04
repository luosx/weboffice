//GPS
var graphiclayer
// 用于当前被选择GPS图形
var selectgraphic
// 用于绘制图形的GPS设备的图层
var graphiclayerDraw
/*
 * 用于记录最后一个点
 */
var lastPoint;
/*
 * 跟踪的车辆ID
 */
var selectId;
/*
 * 记录数组
 */
var arr
/*
 * 记录数组下标
 */
var flag = 0;
var mileage=0;
var showInfoFlag=1;
var map = parent.center.map;
var historywin;// 历史回放窗口
var historyform;// 历史回放表单
var MileageStatisticsWin;// 里程统计窗口
var MileageStatisticsForm;// 里程统计表单
var gpsid;// 设备编号
var types;// 设备类型
var grp;// 图层车变量
var flag = 0;// 标量用于定时
var array;// 接受返回的数据（二维数组）
var time;// 用于定时的间隔
var timer;// 定时器对象
var t
var date;
/**
 * 根据用户选择指定GPS设备定位
 */
//#wangf# 转移到对应jsp中
function selectSingle(id) {
	parent.center.clearHighlight();
	clearDraw();
	clearDelayTime();
	try
		{
		parent.center.putClientCommond("gpsPosition", "getSimpleGpsInfo");
		parent.center.putRestParameter("gpsId", id);
		parent.center.putRestParameter("statusFlag", "true");
		var myData = parent.center.restRequest();
		if(myData[0][0].GPSX==0.0){
			alert("正在加载GPS数据...");
		}else{
			if (graphiclayer == null) {
				graphiclayer = parent.center.getGraphicLayer(588);
				parent.center.addLayer(graphiclayer);
				makeStyle();
			} 
		  	graphiclayer.clear();
	  	    date=myData[0][0].DATE;
	  	    addSingleGraphic(myData[0][0].GPSId, myData[0][0].GPSName ,myData[0][0].GPSX,myData[0][0].GPSY,myData[0][0].direction,myData[0][0].speed);
		    showInfoWindow(selectgraphic);
		    parent.center.setMapCenterAdnZoom(parent.center.getPoint(myData[0][0].GPSX, myData[0][0].GPSY), 12);
		}
	}
	catch (e)
	    {
		  alert('GPS接收设备未开启！');
		}

}

/**
 * 调用 清除延迟效果 同时回到最新点
 */
//#wangf# 同469行，一同处理
function clearDelayTime() {
	parent.center.putClientCommond("gpsPosition", "checkStatusFalse");
	var myData = parent.center.restRequest();
	if (t!= null) {
		clearTimeout(t);
	}
	
}

function clearCar(){
   closeInfo();
   clearDraw();
   clearDelayTime();
   showInfoFlag=0;
   if(graphiclayer){
   	graphiclayer.clear();
   }
   document.getElementById("showInfo").disabled=true;
}

/**
 * 清楚画图效果
 */
function clearDraw() {
	if (graphiclayerDraw != null) {
		graphiclayerDraw.clear();
	}
}

/**
 * 在地图展现对应图形信息框
 */
function showInfoWindow(graphic) {
	map.infoWindow.setTitle(graphic.getTitle());
	map.infoWindow.setContent(graphic.getContent());
	map.infoWindow.show(parent.center.getPoint(graphic.attributes.x, graphic.attributes.y));
}

/**
 * 添加新的GPS设备图形
 */
function addSingleGraphic(id, name, xpoint, ypoint, direction, speed) {
	var symbol = selectSymbol("1");
	var point = parent.center.getPoint(xpoint, ypoint);
	var attr = {
		"id" : id,
		"name" : name,
		"x" : xpoint,
		"y" : ypoint
	};
	var infoTemplate = parent.center.getInfoTemplate(
			name,
			"<div><font size=1>X:"
					+ xpoint
					+ "<br><font  size=1>Y:"
					+ ypoint
					+ "<br><font  size=1>时间:"
					+ date
					+ "<br><font  size=1>方向:"
					+ direction
					+ "<br><font  size=1>速度:"
					+ speed
					+ "</font><br><br><button style='border:1px #ccc solid;background-color:#C4E1FF;'"
					+ "type='button' onclick='parent.east.getData("
					+ id +")'>跟踪</button>&nbsp&nbsp&nbsp&nbsp<button type='button'"
					+ " style='border:1px #ccc solid;background-color:#C4E1FF' onclick='parent.east.clearDelayTime()'>停止</button><br><button type='button'"
					+ " style='border:1px #ccc solid;background-color:#C4E1FF' onclick='parent.east.playHistory("
					+ id
					+ ",1"
					+ ")'>回放</button>&nbsp&nbsp&nbsp&nbsp<button type='button' style='border:1px #ccc solid;background-color:#C4E1FF;'"
					+ "onclick='parent.east.closeInfo()'>关闭</button></div>");
	var graphic = parent.center.getGraphic(point, symbol, attr, infoTemplate);
	graphiclayer.add(graphic);
	selectgraphic = graphic;
}

/**
 * 控制显示防止越界遮盖信息
 */
//#wangf# 转移到对应jsp中
function checkGPSLocation(graphic) {
	var extent = parent.center.map.extent;
	var x = graphic.attributes.x;
	var y = graphic.attributes.y;
	var numX = (extent.xmax - extent.xmin) / 4;
	var numY = (extent.ymax - extent.ymin) / 3;
	if (x <= extent.xmin + numX || x >= extent.xmax || y <= extent.ymin + numY
			|| y > extent.ymax) {
		parent.center.setMapCenterAdnZoom(getPoint(x, y), 17);
	}
}

/**
 * 改变信息框大小位置，绑定图层事件
 */
function makeStyle() {
	dojo.connect(graphiclayer, "onClick", function(e) {
		var g = e.graphic;
		selectgraphic = g;
		var point = parent.center.getPoint(g.attributes.x, g.attributes.y);
		parent.center.setMapCenterAdnZoom(point, 17);
		//showInfoWindow(selectgraphic);
		//clearDraw();
		//clearDelayTime(t);
	})
dojo.connect(graphiclayer, "onMouseOver", function(e) {
		map.setMapCursor("pointer");
	})
dojo.connect(graphiclayer, "onMouseOut", function(e) {
		map.setMapCursor("default");
	})
map.infoWindow.resize(145, 170);
map.infoWindow.setFixedAnchor(esri.dijit.InfoWindow.ANCHOR_LOWERLEFT);

}

/**
 * 清除除了指定GPS设备外的路线
 * @param {}
 * id
 */
//#wangf# 可否抽取成公用方法？如不能转移到对应jsp中  与378行方法有什么区别？
function clearOtherDraw(id) {
	if (graphiclayerDraw != null) {
		for (var z = 0; z < graphiclayerDraw.graphics.length; z++) {
			if (graphiclayerDraw.graphics[z].attributes.id != id) {
				graphiclayerDraw.remove(graphiclayerDraw.graphics[z]);
			}
		}
	}
}

/**
 * 根据指定的点移动
 */
//#wangf# 提取到对应jsp中
function selectSingleDraw(id, name, status, time, xpoint, ypoint, speed,
		direction, type) {
	clearOtherDraw(id);
	for (var i = 0; i < graphiclayer.graphics.length; i++) {
		if (graphiclayer.graphics[i].attributes.id == id) {
			graphiclayer.remove(graphiclayer.graphics[i]);
			addSingleGraphic(id, name, status, time, xpoint, ypoint, speed,
					direction, type);
			showInfoWindow(selectgraphic);
			checkGPSLocation(selectgraphic);
		}
	}
}

/**
 * 控制显示防止越界遮盖信息
 */
//#wangf# 转移到对应jsp中
function checkGPSLocation(graphic) {
	var extent = map.extent;
	var x = graphic.attributes.x;
	var y = graphic.attributes.y;
	var numX = (extent.xmax - extent.xmin) / 4;
	var numY = (extent.ymax - extent.ymin) / 3;
	if (x <= extent.xmin + numX || x >= extent.xmax || y <= extent.ymin + numY
			|| y > extent.ymax) {
		parent.center.setMapCenterAdnZoom(parent.center.getPoint(x, y), 17);
	}
}

/**
 * 指定时间间隔请求最新数据用于定位指定的GPS
 */
//#wangf# 哪里调用了这个方法？ 没有调用就去掉
function getData(id) {
	selectId = id;
	follow();
}
//#wangf# 转移到对应jsp中
function follow() {
	graphiclayer.clear();
	parent.center.putClientCommond("gpsPosition", "getSimpleGpsInfo");
	parent.center.putRestParameter("gpsId", selectId);
	var myData = parent.center.restRequest();
	if (lastPoint == null) {
		addSingleGraphic(myData[0][0].GPSId, myData[0][0].GPSName,myData[0][0].GPSX,myData[0][0].GPSY,myData[0][0].direction,myData[0][0].speed);
		showInfoWindow(selectgraphic);
		parent.center.setMapCenterAdnZoom(parent.center.getPoint(myData[0][0].GPSX, myData[0][0].GPSY), 17);
		//alert(
		//lastpoint = parent.center.getPoint(myData[0][0].GPSX, myData[0][0].GPSY);
		lastPoint = myData[0][0].GPSX+","+myData[0][0].GPSY;
		//alert(lastPoint);
	} else {
		if (graphiclayerDraw == null) {
 		 graphiclayerDraw = parent.center.getGraphicLayer(688);
 		 parent.center.addLayer(graphiclayerDraw);
		}
		var fistPoint = lastPoint;
		lastPoint = myData[0][0].GPSX+","+myData[0][0].GPSY
		//alert(lastPoint.x+","+lastPoint.y+"!"+firstPoint.x+","+firstPoint.y)
		drawTrackFollow(fistPoint, lastPoint, '1');
		addSingleGraphic(myData[0][0].GPSId, myData[0][0].GPSName,myData[0][0].GPSX,myData[0][0].GPSY,myData[0][0].direction,myData[0][0].speed);
		 if(showInfoFlag==1){
		    showInfoWindow(selectgraphic);
		 }
		parent.center.setMapCenterAdnZoom(parent.center.getPoint(myData[0][0].GPSX, myData[0][0].GPSY), 17);
	}
	t = setTimeout("follow()", 3000);
}

/**
 * 跟踪功能测试
 */
//#wangf# 去掉无用功能 从当前行 到 512行
//function clgz(gpsid) {
//	var array = [["40445485", "3590780", "正东"], ["40446523", "3590834", "正东"],
//			["40447635", "3590945", "正东"], ["40448760", "3590656", "东南"],
//			["40445467", "3590730", "正西"], ["40446589", "3590845", "正东"],
//			["40447515", "3590912", "正东"], ["40448740", "3590645", "东南"],
//			["40448645", "3590744", "西北"]];
//	if (graphiclayerDraw == null) {
//		graphiclayerDraw = parent.center.getGraphicLayer(688)
//		parent.center.addLayer(graphiclayerDraw);
//	} else {
//		clearDraw();
//	}
//	arr = array;
//	test();
//}

/*
 * 延时器对象
 */

//function test() {
//	flag++;
//	if (flag < arr.length) {
//		var fistPoint = parent.center.getPoint(arr[flag - 1][0], arr[flag - 1][1]);
//		lastpoint = parent.center.getPoint(arr[flag][0], arr[flag][1])
//		drawTrackFollow(fistPoint, lastpoint, 1);
//		selectSingleDraw(1, "苏E00001", "停止", "05:15:18 05/20", arr[flag][0],
//				arr[flag][1], "50km/h", arr[flag][2], 1);
//		t = setTimeout("test()", 3000);
//	} else {
//		flag = 0;
//	}
//}

/**
 * 进行线相关graphic操作
 */
//#wangf# 提取到对应jsp中
function drawTrackFollow(first, last, id) {
 //   var startPoint = first;
   // var endPoint = last;

	var startPoint = first.split(",");

	var endPoint = last.split(",");
    
	//startPoint="4.057038891631666E7,3461473.088822161".split(",");
	//endPoint="4.05704042219436666E7,3461406.088822161".split(",");
	var polyline = parent.center.getPolyline(parent.center.getPoint(startPoint[0],startPoint[1]),parent.center.getPoint(endPoint[0],endPoint[1]));
	var symbole = parent.center.commoncar;
	var attr = {
		"id" : id
	};
	var highlightGraphic = parent.center.getGraphic(polyline,symbole,attr)
	graphiclayerDraw.add(highlightGraphic);
	if(graphiclayerDraw.graphics.length>30){
	graphiclayerDraw.remove(graphiclayerDraw.graphics[0]);
	}
//	graphiclayerDraw.add(parent.center.getGraphic(parent.center.getPolyline(parent.center.getPoint(startPoint[0],startPoint[1]),parent.center.getPoint(endPoint[0],endPoint[1])), new esri.symbol.SimpleLineSymbol(
//			esri.symbol.SimpleLineSymbol.STYLE_SOLID,
//			new dojo.Color([255,0,0]),10), {"id" : id}));
	//map.graphics.add(highlightGraphic);
			
}


/**
 * 隐藏信息窗口
 */
function closeInfo() {
	showInfoFlag=0;
	map.infoWindow.hide();
}

function checkInfo(){
   showInfoFlag=1;
   showInfoWindow(selectgraphic);
}
/**
 * 清楚画图效果
 */
function clearDraw() {
	if (graphiclayerDraw != null) {
		graphiclayerDraw.clear();
	}
}

/**
 * 选取对应图标
 * @param 类型编号
 * @return {}
 */
//#wangf# 魔法数调整
function selectSymbol(type) {
	if (type == 1) {
		return parent.center.commoncar;
	}
	if (type == 2) {
		return parent.center.commonpms;
	}
	if (type == 3) {
		return parent.center.commoncom;
	}
}

/**
 * 历史回放
 */
function playHistory(id, type) {
	gpsid = id;
	types = type;
	if (historyform == null) {
		historyform = new parent.center.Ext.form.FormPanel({
					applyTo : 'form',
					id : 'myForm',
					baseCls : 'x-plain',
					autoHeight : true,
					frame : true,
					labelWidth : 60,
					buttonAlign : 'center',
					bodyStyle : 'padding:0px 0px 0',
					width : 360,
					items : [{
								xtype : 'datetimefield',
								id : 'starttime',
								anchor : '100%',
								format : 'Y-m-d H:i:s',
								allowBlank : false,
								blankText : '开始时间不能为空',
								editable : false,
								emptyText : "请选择",
								fieldLabel : '开始时间'
							}, {
								xtype : 'datetimefield',
								id : 'endtime',
								anchor : '100%',
								format : 'Y-m-d H:i:s',
								allowBlank : false,
								blankText : '结束时间不能为空',
								editable : false,
								emptyText : "请选择",
								fieldLabel : '结束时间'
							}, {
								xtype : 'radiogroup',
								fieldLabel : '播放速度',
								items : [{
											boxLabel : '快',
											checked : false,
											inputValue : 1,
											id : 'fast',
											name : 'speed'
										}, {
											boxLabel : '慢',
											checked : true,
											inputValue : 2,
											id : 'slow',
											name : 'speed'
										}]
							}],
					buttons : [{
								text : '播放',
								id : 'play',
								handler : function(){
									var url = basePath + "playManageAC.do?method=playback&gpsid=" + gpsid;
	if (historyform.getForm().isValid()) {
		if (parent.center.Ext.getCmp('starttime').getValue() < parent.center.Ext.getCmp('endtime').getValue()) {
			historywin.hide();
			closeInfo();
			historyform.form.submit({
						url : url,
						waitMsg : '正在加载数据,请稍候... ',
						success : function(form, action) {
							var msg = parent.center.Ext.decode(action.result.msg);
							transfer(msg, parent.center.Ext.getCmp('fast').getValue());
						},
						failure : function() {
							parent.center.Ext.Msg.alert('提示', '请稍后重试或联系管理员。');
						}
					});
		} else {
			parent.center.Ext.Msg.alert('提示', '开始时间必须小于结束时间！');
		}
	}
								}
							}, {
								text : '重置',
								handler : function() {
									historyform.getForm().reset();
								}
							}]
				});
	}
	if (historywin == null) {
		historywin = new parent.center.Ext.Window({
					applyTo : 'win',
					width : 400,
					autoHeight : true,
					title : '历史回放',
					closeAction : 'hide',
					collapsible : true,
					items : historyform
				});
	}
	historywin.show();
}

function MileageStatistics(id) {
	gpsid = id;
	if (MileageStatisticsForm == null) {
		MileageStatisticsForm = new parent.center.Ext.form.FormPanel({
					applyTo : 'MileageStatisticsForm',
					baseCls : 'x-plain',
					autoHeight : true,
					frame : true,
					labelWidth : 60,
					buttonAlign : 'center',
					bodyStyle : 'padding:0px 0px 0',
					width : 360,
				    items : [{
				                xtype: 'combo',
				                id: 'carNumber',
				                value:'',
				                mode:  'local',
				                triggerAction: 'all',
				                forceSelection:true,
				                editable:false,
				                anchor: '50%',
				                fieldLabel: '编号',
				                displayField: 'text',
				                valueField: 'value',
			                    store: new Ext.data.JsonStore({
			                    fields : ['text', 'value'],
			                    data   : [
			                        {text:'平板电脑1',value:'3'}
			                       ]
			                   })
			                }, {
								xtype : 'datetimefield',
								id : 'starttime1',
								anchor : '100%',
								format : 'Y-m-d H:i:s',
								allowBlank : false,
								blankText : '开始时间不能为空',
								editable : false,
								emptyText : "请选择",
								fieldLabel : '开始时间'
							}, {
								xtype : 'datetimefield',
								id : 'endtime1',
								anchor : '100%',
								format : 'Y-m-d H:i:s',
								allowBlank : false,
								blankText : '结束时间不能为空',
								editable : false,
								emptyText : "请选择",
								fieldLabel : '结束时间'
							},{
						        xtype:'textarea',
						        name: 'describe',
						        anchor : '100%',
						        labelStyle : 'color:blue',
						        readOnly:true,
						        style:'color:red;',
						        fieldLabel: '统计结果'
						    }],
					buttons : [{
								text : '统计',
								handler : function(){
									var gpsid=MileageStatisticsForm.getForm().findField('carNumber').getValue();
									var url = basePath + "playManageAC.do?method=mileageStatistics&gpsid=" + gpsid;
	if (MileageStatisticsForm.getForm().isValid()) {
		if (parent.center.Ext.getCmp('starttime1').getValue() < parent.center.Ext.getCmp('endtime1').getValue()) {
			MileageStatisticsForm.form.submit({
						url : url,
						waitMsg : '正在加载数据,请稍候... ',
						success : function(form, action) {
							var msg = parent.center.Ext.decode(action.result.msg);
							var mileag=0;
							if (msg != null && msg.length > 1) {
							   for(var i=0;i<msg.length-1;i++){
                                       mileag=mileag+Math.abs(Math.sqrt((msg[i+1][0]-msg[i][0])*(msg[i+1][0]-msg[i][0])+(msg[i+1][1]-msg[i][1])*(msg[i+1][1]-msg[i][1])))/1000
							       }
							   }	
							MileageStatisticsForm.getForm().findField('describe').setValue(mileag.toFixed(4)+"公里");
						},
						failure : function() {
							parent.center.Ext.Msg.alert('提示', '请稍后重试或联系管理员。');
						}
					});
		} else {
			parent.center.Ext.Msg.alert('提示', '开始时间必须小于结束时间！');
		}
	}
								}
							}]
				});
	}
	if (MileageStatisticsWin == null) {
		MileageStatisticsWin = new parent.center.Ext.Window({
					applyTo : 'MileageStatisticsWin',
					width : 400,
					autoHeight : true,
					title : '里程统计',
					closeAction : 'hide',
					collapsible : true,
					items : MileageStatisticsForm
				});
	}
	MileageStatisticsWin.show();
}



/**
 * 从前台传递数据
 * 
 * @param {}
 *            msg 坐标点的集合（二维数组）
 * @param {}
 *            checked 播放速度：快是否选中
 */
function transfer(msg, checked) {
	if (msg != null && msg.length > 0) {
		graphiclayer.clear();
		parent.center.clearHighlight();
		check = checked;
		if (check) {
			time = 83.4;
		} else {
			time = 166.6;
		}
		array = msg;
	    parent.center.setMapCenterAdnZoom(parent.center.getPoint(array[0][0], array[0][1]), 12);
		dispose();
	} else {
		parent.center.Ext.Msg.alert('提示', '当前时间段内无轨迹！');
	}
}

/**
 * 处理数据的方法，定时器（历史回放）
 */
function dispose() {
	flag++;
	if (flag < array.length) {
		var startpoint = parent.center.getPoint(array[flag - 1][0], array[flag - 1][1]);
		var endpoint = parent.center.getPoint(array[flag][0], array[flag][1]);
		drawTrack(types, startpoint, endpoint);
		timer = setTimeout("dispose()", time);
	} else {
		flag = 0;
	}
}


/**
 * 回放调用
 */
function drawTrack(type, startPoint, endPoint) {
	var polyline = parent.center.getPolyline(startPoint, endPoint);
	var highlightGraphic = parent.center.getGraphic(polyline, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,new dojo.Color([255, 0, 0]), 3));
	map.graphics.add(highlightGraphic);	
	if (grp != null) {
		map.graphics.remove(grp);
	}
	doLocationItWithGPAPoint(type, endPoint.x, endPoint.y);
	var extent = map.extent;
	var x = endPoint.x;
	var y = endPoint.y;
	var numX = (extent.xmax - extent.xmin) / 4;
	var numY = (extent.ymax - extent.ymin) / 3;
	if (x <= extent.xmin + numX || x >= extent.xmax || y <= extent.ymin + numY
			|| y > extent.ymax) {
		parent.center.setMapCenterAdnZoom(parent.center.getPoint(x, y), 17);
	}
}

/**
 * 定位Gps设备
 */
function doLocationItWithGPAPoint(type, xpoint, ypoint) {
	var locationpoint = parent.center.getPoint(xpoint, ypoint);
	var highlightGraphic = parent.center.getGraphic(locationpoint, selectSymbol(type));
	parent.center.map.graphics.add(highlightGraphic);
	grp = highlightGraphic;
	
	//map.setExtent(map.extent.centerAt(locationpoint));
	
}

/**
 * 用于指定GPSID的视频监控
 * gpsid 车辆上视频设备的ID编号
 */
function monitor(gpsid) {
	var win = new parent.center.Ext.Window({
		title : '视频监控',
		id : gpsid,
		resizable : false,
		closeAction : 'close',
		frame : true,
		modal : true,
		width : 390,
		height : 350,
		html : "<iframe width='100%' height='100%' src ='crearo/index_car.jsp?gpsid="
				+ gpsid + "'></iframe>"
	})
	win.show();
}

 /**
 * 展现所有的GPS设备图形
 */
function showAllGps(array) {
//	closeInfo();
//	if (graphiclayer == null) {
//		graphiclayer = parent.center.getGraphicLayer(588);
//		parent.center.addLayer(graphiclayer);
//		makeStyle();
//	} else {
//		graphiclayer.clear();
//	}
//	for (var i = 0; i < array[0].length; i++) {
//		addSingleGraphic(array[0][i].GPSId, array[0][i].GPSName,
//				array[0][i].status, array[0][i].timeStamp, array[0][i].GPSX,
//				array[0][i].GPSY, array[0][i].speed, array[0][i].direction,
//				array[0][i].GPSType);
//	}
}

 /**
  * 设置全局监控四至范围
  * 
  * @param {Object}
  * extent
 */
  function setMapExpand(json) {
	var spatialReference = parent.center.getMapSpatialReference();
	var polygon = new esri.geometry.Polygon(spatialReference);
	var points = new Array();
	for (i = 0; i < json.length; i++) {
		for (j = 0; j < json[i].length; j++) {
			if (json[i][j].GPSX != 0 || json[i][j].GPSY != 0) {
				var point = new esri.geometry.Point(json[i][j].GPSX, json[i][j].GPSY, spatialReference);
				points[j] = point;
			}

		}
	}
	polygon.addRing(points);
	var extent = polygon.getExtent();
	if(extent){
	extent = new esri.geometry.Extent(extent.xmin, extent.ymin, extent.xmax,
			extent.ymax, spatialReference);
	extent = extent.expand(3);
	map.setExtent(extent);
  	}
  }

  //全局监控
  function overview(){
  	parent.center.putClientCommond("gpsPosition","getAllGpsInfo");
	var json = parent.center.restRequest();
	setMapExpand(json);
	showAllGps(json);

  }
