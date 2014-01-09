var tree = new Ext.tree.TreePanel({
			useArrows : true,
			width : 195,
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
						expanded : true
					}),
			listeners : {
				'checkchange' : function(node, checked) {
					var swf = frames["center"].swfobject.getObjectById("FxGIS");
					var id = node.attributes.GPS_ID;
					if (!checked) {
						swf.carMonitor("remove", id);
						return;
					}
					var deviceCoors = getDeviceCoor();
					var target = deviceCoors[id];
					if (target == null) {
						parent.Ext.MessageBox.alert("提示", "没有该设备的坐标信息!");
						node.unselect();
						return;
					}
					swf.carMonitor("locate", id, deviceCoors[id].GPS_X,
							deviceCoors[id].GPS_Y, deviceCoors[id].online,0,0,node.attributes.GPS_UNIT+node.attributes.GPS_NAME)
				}
			}
		});

tree.getRootNode().expand(true);

function getTreeContent() {
	putClientCommond("deviceTree", "getDeviceMonitorTree");
	return (restRequest());
}
function getDeviceCoor() {
	putClientCommond("deviceMonitor", "getDeviceCoordinate");
	return (restRequest());
}
function locate() {
	var deviceCoors = getDeviceCoor();
	for (var i = 0; i < deviceIds.length; i++) {
		var deviceId = deviceIds[i];
		swf.carMonitor("locate", deviceId, deviceCoors[deviceId].GPS_X,
				deviceCoors[deviceId].GPS_Y, 1);
	}
}
function monitor() {
}