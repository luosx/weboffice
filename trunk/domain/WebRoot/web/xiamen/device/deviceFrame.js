Ext.onReady(function() {
	var width = document.body.clientWidth;
	var height = document.body.clientHeight;
	new Ext.Viewport({
		layout : "border",
		items : [{
			region : 'center',
			items : [{
				renderTo : Ext.getBody(),
				height : 30,
				margins : '0 0 0 0',
				tbar : [{
					xtype : 'tbbutton',
					text : ' 放大',
					cls : 'x-btn-text-icon',
					icon : basePath + 'base/fxgis/framework/images/zoom-in.png',
					tooltip : '放大',
					handler : zoomIn
				}, {
					xtype : 'tbbutton',
					text : '缩小',
					cls : 'x-btn-text-icon',
					icon : basePath
							+ 'base/fxgis/framework/images/zoom-out.png',
					tooltip : '缩小',
					handler : zoomOut
				}, {
					xtype : 'tbbutton',
					text : '  漫游',
					cls : 'x-btn-text-icon',
					icon : basePath + 'base/fxgis/framework/images/hand.png',
					tooltip : '漫游',
					handler : pan
				}, {
					xtype : 'tbbutton',
					text : '  全图',
					cls : 'x-btn-text-icon',
					icon : basePath
							+ 'base/fxgis/framework/images/Full_Extent.png',
					tooltip : '全图',
					handler : zoomToFullExtent
				}, {
					xtype : 'tbbutton',
					text : '前图',
					cls : 'x-btn-text-icon',
					icon : basePath
							+ 'base/fxgis/framework/images/Zoom_Back.png',
					tooltip : '前图',
					handler : zoomToPrevExtent
				}, {
					xtype : 'tbbutton',
					text : '后图',
					cls : 'x-btn-text-icon',
					icon : basePath
							+ 'base/fxgis/framework/images/Zoom_Forward.png',
					tooltip : '后图',
					handler : zoomToNextExtent
				}, {
					xtype : 'splitbutton',
					text : '量算',
					handler : function() {
						this.showMenu();
						frames["lower"].swfobject.getObjectById("FxGIS")
								.panmap();
					},
					icon : basePath + 'base/fxgis/framework/images/rule.png',
					menu : [{
						text : '直线量算',
						cls : 'x-btn-text-icon',
						icon : basePath
								+ 'base/fxgis/framework/images/line.png',
						tooltip : '直线量算',
						handler : measureLengths
					}, {
						text : '面积量算',
						cls : 'x-btn-text-icon',
						icon : basePath
								+ 'base/fxgis/framework/images/showVertices.png',
						tooltip : '面积量算',
						handler : measureAreas
					}]
				}, {
					xtype : 'tbbutton',
					text : '清除',
					cls : 'x-btn-text-icon',
					icon : basePath + 'base/fxgis/framework/images/Clear.png',
					tooltip : '清除',
					handler : clear
				}, {
					text : '全屏',
					id : 'full_screen',
					cls : 'x-btn-text-icon',
					icon : basePath
							+ 'base/fxgis/framework/images/computer_16x16.png',
					tooltip : '全屏',
					handler : fullScreen
				}, {
					text : '退出全屏',
					id : 'quit_full_screen',
					hidden : true,
					cls : 'x-btn-text-icon',
					icon : basePath
							+ 'base/fxgis/framework/images/nofullscreen.png',
					tooltip : '退出全屏',
					handler : quitFullScreen
				}]

			}, {
				height : height,
				width : width,
				html : '<iframe name="center" id="map" frameborder="0" style="width: 100%; height: 100%; overflow: auto;" src="'
						+ basePath
						+ 'base/fxgis/fx/FxGIS.html?i=false&initFunction=[{$name$:$setMapExtent$,$parameters$:$45044.3121547718,5049.116018257262,72646.91380705396,14896.972418257263$}]"></iframe>'
			}],
			collapsible : false,
			margins : '0 0 0 0'
		}, {
			region : 'west',
			split : true,
			width : 260,
			minSize : 0,
			collapsible : true,
			id : 'treePanel',
			title : '设备列表--<font color=red>定位</font>',
			tbar : [{
						xtype : 'tbbutton',
						enableToggle : true,
						pressed : true,
						text : '  定位',
						id : 'locate',
						cls : 'x-btn-text-icon',
						icon : 'locate.png',
						handler : function() {
							Ext.getCmp("monitor").doToggle();
							changeMethod();
						}
					}, {
						xtype : 'tbbutton',
						enableToggle : true,
						id : 'monitor',
						text : '  监控',
						cls : 'x-btn-text-icon',
						icon : 'monitor.png',
						handler : function() {
							Ext.getCmp("locate").doToggle();
							changeMethod();
						}
					}],
			items : [tree, {
				id : 'timeSelector',
				hidden : true,
				preventBodyReset : true,
				labelWidth : 60,
				width : 259,
				layout : 'form',
				frame : true,
				defaults : {
					xtype : "datetimefield",
					anchor : '90%'
				},
				items : [{
							fieldLabel : '开始时间',
							id : 'startTime',
							value : new Date().add(Date.HOUR, -2),
							format : 'H:i'
						}, {
							fieldLabel : '结束时间',
							id : 'endTime',
							format : 'H:i',
							value : new Date()
						}],
				buttons : [{
					id : 'showTrack',
					text : '显示轨迹',
					handler : function() {
						var start = Ext.getCmp("startTime").getValue()
								.toString();
						var end = Ext.getCmp("endTime").getValue().toString();
						start = Ext.util.Format.date(start, 'Y-m-d H:i');
						end = Ext.util.Format.date(end, 'Y-m-d H:i');
						if (start == "" || end == "" || trackNode.length < 1) {
							Ext.MessageBox.alert("提示",
									"请检查[开始时间][结束时间][设备]是否为空!");
							return;
						}
						var deviceIds = "";
						for (var i = 0; i < trackNode.length; i++) {
							deviceIds += trackNode[i].attributes.GPS_ID + ","
						}
						deviceIds = deviceIds.substr(0, deviceIds.length - 1);
						frames["center"].swfobject.getObjectById("FxGIS")
								.showTrack(deviceIds, start, end);
					}
				}, {
					id : 'playBack',
					text : '回放轨迹',
					handler : function() {
						var start = Ext.getCmp("startTime").getValue();
						var end = Ext.getCmp("endTime").getValue();
						start = Ext.util.Format.date(start, 'Y-m-d H:i');
						end = Ext.util.Format.date(end, 'Y-m-d H:i');
						if (start == "" || end == "" || trackNode.length != 1) {
							Ext.MessageBox.alert("提示",
									"请检查[开始时间][结束时间][设备]是否为空!");
							return;
						}
						frames["center"].swfobject.getObjectById("FxGIS")
								.playBack(trackNode[0].attributes.GPS_ID,
										start, end);
					}
				}]
			}]
		}]
	});
	// init
	tree.setHeight(435);
	if (type == "showTrack") {
		Ext.getCmp("treePanel").topToolbar.hide();
		Ext.getCmp("timeSelector").show();
		Ext.getCmp("treePanel").setTitle("设备列表");
		tree.setHeight(335);
		method = "TRACK";
	}
});
var trackNode = new Array();
var method = "LOCATE";
function changeMethod() {
	var flag = Ext.getCmp("locate").pressed;
	if (flag) {
		method = "LOCATE";
		Ext.getCmp("treePanel").setTitle("设备列表--<font color=red>定位</font>");
		frames["center"].swfobject.getObjectById("FxGIS").clear();
		locate(null, null);
	} else {
		method = "MONITOR";
		Ext.getCmp("treePanel").setTitle("设备列表--<font color=green>监控</font>");
		frames["center"].swfobject.getObjectById("FxGIS").clear();
		monitor("");
		monitorFlag = true;
	}
}

// ////////////////////////////////////////////////////////////////////////////////////
// 放大
function zoomIn() {
	frames["center"].swfobject.getObjectById("FxGIS").zoomIn();
}
// 缩小
function zoomOut() {
	frames["center"].swfobject.getObjectById("FxGIS").zoomOut();
}
// 漫游
function pan() {
	frames["center"].swfobject.getObjectById("FxGIS").panmap();
}
// 全图
function zoomToFullExtent() {
	frames["center"].swfobject.getObjectById("FxGIS").setMapExtent(
			45044.3121547718, 5049.116018257262, 72646.91380705396,
			14896.972418257263);
	// frames["center"].swfobject.getObjectById("FxGIS").zoomToFullExtent();
}
// 前一视图
function zoomToPrevExtent() {
	frames["center"].swfobject.getObjectById("FxGIS").zoomToPrevExtent();
}
// 后一视图
function zoomToNextExtent() {
	frames["center"].swfobject.getObjectById("FxGIS").zoomToNextExtent();
}
// 清除
function clear() {
	frames["center"].swfobject.getObjectById("FxGIS").clear();
}
// 直线长度量算
function measureLengths() {
	frames["center"].swfobject.getObjectById("FxGIS").measureLengths();
}
// 面积量算
function measureAreas() {
	frames["center"].swfobject.getObjectById("FxGIS").clear();
	frames["center"].swfobject.getObjectById("FxGIS").measureAreas();
}
/* 地图全屏 */
function fullScreen() {
	Ext.getCmp('full_screen').setVisible(false);
	Ext.getCmp('quit_full_screen').setVisible(true);
	parent.parent.parent.index.rows = "0,0,*"
	parent.parent.content.cols = "0,0,*";
}

/* 退出全屏 */
function quitFullScreen() {
	Ext.getCmp('full_screen').setVisible(true);
	Ext.getCmp('quit_full_screen').setVisible(false);
	parent.parent.parent.index.rows = "106,32,*"
	parent.parent.content.cols = "0,9,*";
}
