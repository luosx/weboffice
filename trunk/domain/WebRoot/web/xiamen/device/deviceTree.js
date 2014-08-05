var tree = new Ext.tree.TreePanel({
	useArrows : true,
	width : 258,
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
			// TRACK
			if (method == "TRACK") {
				// delete
				if (!checked) {
					for (var i = 0; i < trackNode.length; i++) {
						if (node.id == trackNode[i].id) {
							trackNode.splice(i,1);
						}
					}
					if (trackNode.length == 1) {
						Ext.getCmp("playBack").setDisabled(false);
						Ext.getCmp("showWindow").setDisabled(false);
					}
					return;
				}
				// add
				trackNode.push(node);
				if (trackNode.length > 1) {
					Ext.getCmp("playBack").setDisabled(true);
					Ext.getCmp("showWindow").setDisabled(true);
				}
				return;
			}
			// MONITOR AND LOCATE
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
		monitor(swf);
	}
}
// //////////////////////////////////////////////
var monitorFlag = true;
function monitor(swf) {
	if (swf == null || swf == "") {
		swf = frames["center"].swfobject.getObjectById("FxGIS");
	}
	if (method != "MONITOR") {
		return;
	}
	var nodes = new Array();
	// iterator nodes
	iteratorNodes(tree.getRootNode());
	function iteratorNodes(rootnode) {
		var childNodes = rootnode.childNodes;
		for (var i = 0; i < childNodes.length; i++) {
			var childNode = childNodes[i];
			if (childNode.leaf == true && childNode.attributes.checked == true) {
				nodes.push(childNode);
			}
			if (childNode.hasChildNodes()) {
				iteratorNodes(childNode);
			}
		}
	}
	if (nodes.length < 1) {
		return;
	}
	var deviceCoors = getDeviceCoor();
	// monitor
	for (var i = 0; i < nodes.length; i++) {
		var id = nodes[i].attributes.GPS_ID;
		var target = deviceCoors[id];
		if (target == null) {
			continue;
		}
		try {
			swf
					.carMonitor("monitor", id, deviceCoors[id].GPS_X,
							deviceCoors[id].GPS_Y, nodes[i].attributes.online,
							0, 0, nodes[i].attributes.GPS_UNIT
									+ nodes[i].attributes.GPS_NAME);
			if (monitorFlag) {
				swf.expandExtentByMapPoint(deviceCoors[id].GPS_X,
						deviceCoors[id].GPS_Y, 0.2);
				monitorFlag = false;
			}
		} catch (e) {
		}
	}
	setTimeout(function() {
				monitor(swf)
			}, 10000);
}
// ////////////////////////////////////////////////////////////////
function locate(node, swf) {
	// ///////////////////////////// multiple nodes
	if (node == null && swf == null) {
		multiLocate();
		return;
	}
	// ///////////////////////////// single node
	var id = node.attributes.GPS_ID;
	var deviceCoors = getDeviceCoor();
	var target = deviceCoors[id];
	if (target == null) {
		Ext.MessageBox.alert("提示", "没有该设备的坐标信息!");
		return;
	}
	try {
		swf.carMonitor("locate", id, deviceCoors[id].GPS_X,
				deviceCoors[id].GPS_Y, node.attributes.online, 0, 0,
				node.attributes.GPS_UNIT + node.attributes.GPS_NAME);

		swf.expandExtentByMapPoint(deviceCoors[id].GPS_X,
				deviceCoors[id].GPS_Y, 0.2);
	} catch (e) {
		Ext.MessageBox.alert("提示", "地图尚未加载完毕，请稍后重试!");
	}
}
function multiLocate() {
	var swf = frames["center"].swfobject.getObjectById("FxGIS");
	var nodes = new Array();
	// iterator nodes
	iteratorNodes(tree.getRootNode());
	function iteratorNodes(rootnode) {
		var childNodes = rootnode.childNodes;
		for (var i = 0; i < childNodes.length; i++) {
			var childNode = childNodes[i];
			if (childNode.leaf == true && childNode.attributes.checked == true) {
				nodes.push(childNode);
			}
			if (childNode.hasChildNodes()) {
				iteratorNodes(childNode);
			}
		}
	}
	if (nodes.length < 1) {
		return;
	}
	var deviceCoors = getDeviceCoor();
	for (var i = 0; i < nodes.length; i++) {
		var id = nodes[i].attributes.GPS_ID;
		var target = deviceCoors[id];
		if (target == null) {
			continue;
		}
		try {
			swf
					.carMonitor("locate", id, deviceCoors[id].GPS_X,
							deviceCoors[id].GPS_Y, nodes[i].attributes.online,
							0, 0, nodes[i].attributes.GPS_UNIT
									+ nodes[i].attributes.GPS_NAME);
			swf.expandExtentByMapPoint(deviceCoors[id].GPS_X,
					deviceCoors[id].GPS_Y, 0.2);
		} catch (e) {
		}
	}
}

// ///Get Data
function getTreeContent() {
	var tree;
	if (type == "showTrack") {
		tree = getTrackTreeContent();
		// Ext.getCmp("treePanel").topToolBar.removeall();
	} else {
		tree = getMonitorTreeContent();
	}
	return tree;
}
function getMonitorTreeContent() {
	putClientCommond("deviceTree", "getDeviceMonitorTree");
	return (restRequest());
}
function getTrackTreeContent() {
	putClientCommond("deviceTree", "getDeviceTrackTree");
	return (restRequest());
}
function getDeviceCoor() {
	putClientCommond("deviceMonitor", "getDeviceCoordinate");
	return (restRequest());
}