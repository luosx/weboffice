function getInitMapLayerVisiable() {
	putClientCommond("mapconfig", "getInitMapService");
	putRestParameter("enterFlag", "map_monitor");
	var result = restRequest();
	var jsonData = new Dictionary();
	var flag;
	for (var i = 0; i < result.length; i++) {
		if (result[i].FLAG == 'true') {
			flag = true;
		} else {
			flag = false;
		}
		jsonData.put(result[i].SERVERID, result[i].LAYERID, result[i].TYPE,
				flag);
	}
	return jsonData.toStr();
}

// 属性查询 回调方法
function identifyCallback(s) {
	tempValue = eval('(' + s + ')');
	var attributes = tempValue.attributes;
	layername = tempValue.layername;
	if (layername == "外业巡查核查图层") {
		var_YW_GUID = attributes.YW_GUID;
	}
	var attr_fields = fields_to_chinese(layername);
	var attritable = '<table border="1" cellpadding="0" cellspacing="0" width="330"  style="text-align:center; vertical-align:middle;font-family: 宋体, Arial; font-size: 12px;border-collapse:collapse;border:1px #000 solid;" >';
	for (var attr in attr_fields) {
		attritable += '<tr><td>' + attr_fields[attr] + '</td><td>' + attributes[attr]
				+ '</td></tr>';
	}
	attritable += '</table>';
	document.getElementById('properties').innerHTML = attritable;
	showWindow_identify('fault');

}
var win_identify;
function showWindow_identify(mes) {
	var tabs = new Ext.TabPanel({
				id : 'pan',
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
	if (mes == 'fault') {
		tabs.remove('xz_tab');
		tabs.remove('gh_tab');
	}
	if (!win_identify) {
		win_identify = new Ext.Window({
					layout : 'fit',
					width : 350,
					height : 400,
					plain : true,
					closeAction : 'hide',
					items : tabs,
					buttons : [{
								id : 'show_data',
								text : '查看详细',
								hidden : true,
								handler : function() {
									showDetail();
									win_identify.hide();
								}
							}, {
								text : '关闭',
								handler : function() {
									win_identify.hide();
								}
							}]
				});
	} else {
		win_identify.items.removeAt(0);
		win_identify.items.add("pan", tabs);
		win_identify.doLayout();
	}

	if (layername == "外业巡查核查图层") {
		Ext.getCmp("show_data").show();
	} else {
		Ext.getCmp("show_data").hide();
	}

	win_identify.show();
}

function showDetail(){
	var url = "";
	if(var_YW_GUID.substring(0,4) == "PHJG"){
		url = "/domain/web/xiamen/xchc/cglb/xjclyjframe.jsp?zfjcType=12&yw_guid="+var_YW_GUID;
	}else{
		url = "/domain/web/xiamen/xchc/cglb/xjclyjframe.jsp?zfjcType=11&yw_guid="+var_YW_GUID;
	}
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	window.open(url,"","width="+width+",height="+height);
}