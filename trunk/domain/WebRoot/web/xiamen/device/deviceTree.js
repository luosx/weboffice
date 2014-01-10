var tree = new Ext.tree.TreePanel({
			useArrows : true,
			width : 198,
			autoScroll : true,
			frame : true, // 显示树形列表样式
			animate : true,
			renderTo : Ext.getBody(),
			autoScroll : true,
			border : false,
			containerScroll : true,
			rootVisible : false,
			checkModel : 'cascade',
			onlyLeafCheckable : true,
			loader : new Ext.tree.TreeLoader({
						baseAttrs : {
							uiProvider : Ext.ux.TreeCheckNodeUI
						}
					}),
			root : new Ext.tree.AsyncTreeNode({
						children : getTreeContent(),
						expanded : false
					}),
			listeners : {
				'checkchange' : function(node, checked) {
					var id = node.attributes.GPS_ID;
					var swf = frames["center"].swfobject.getObjectById("FxGIS");
					if (!checked) {
						swf.carMonitor("remove", id);
						return;
					}
					deviceMonitor(node, swf);
				}
			}
		});

function deviceMonitor(node, swf) {
	if (method == "LOCATE") {
		locate(node, swf);
	} else if (method == "MONITOR") {
		monitor(node, swf);
	}
}
function monitor(node, swf) {
}
function locate(node, swf) {
	var id = node.attributes.GPS_ID;
	var deviceCoors = getDeviceCoor();
	var target = deviceCoors[id];
	if (target == null) {
		parent.Ext.MessageBox.alert("提示", "没有该设备的坐标信息!");
		return;
	}
	try {
		swf.carMonitor("locate", id, deviceCoors[id].GPS_X,
				deviceCoors[id].GPS_Y, deviceCoors[id].online, 0, 0,
				node.attributes.GPS_UNIT + node.attributes.GPS_NAME);
	} catch (e) {
		parent.Ext.MessageBox.alert("提示", "地图尚未加载完毕，请稍后重试!");
	}
}
// ///Get Data
function getTreeContent() {
	putClientCommond("deviceTree", "getDeviceMonitorTree");
	return (restRequest());
}
function getDeviceCoor() {
	putClientCommond("deviceMonitor", "getDeviceCoordinate");
	return (restRequest());
}