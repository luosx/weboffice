var plainCode = "sorry!数据库连接失败，请重新操作！";
var secretCode = "/com/klspta/base/util/impl/ExceptionCodeUtil";
var _window;
var _windowDel;

function showDetail() {
	viewDel();

}
function viewCompare(result) {
	var json = eval(result);
	if (result.length > 0) {
		var res = json[0].Exception;
		if ("error" == res) {
			plainCode = json[0].rough;
			secretCode = json[0].detailed;
			viewException();
			return "YS";
		} else {
			return "NO";
		}
	} else {
		return "NO";
	}

}
viewException = function() {
	_window = new Ext.Window({

				id : "_window",
				title : "消息",
				renderTo : Ext.getBody(),
				frame : true,
				plain : true,
				resizable : false,
				buttonAlign : "right",
				closeAction : "hide",
				maximizable : false,
				draggable : false,
				closable : true,
				bodyStyle : "padding:4px",
				width : 300,
				height : 200,
				layout : "form",
				lableWidth : 280,
				items : [{
							xtype : 'label',
							id : "meg1",
							text : plainCode
						}],
				buttons : [{
							id : "deta",
							text : "详细",
							handler : showDetail
						}, {
							id : "clos",
							text : "关闭",
							handler : function() {
								_window.hide();
							}
						}]

			});
	_window.show();

}
viewDel = function() {
	_windowDel = new Ext.Window({
				id : "_windowDel",
				title : "消息",
				renderTo : Ext.getBody(),
				frame : true,
				plain : true,
				draggable : false,
				resizable : false,
				buttonAlign : "right",
				closeAction : "hide",
				maximizable : false,
				closable : true,
				// bodyStyle : "padding:4px",
				width : 750,
				height : 550,
				lableWidth : 1,
				layout : "fit",
				items : [{
							xtype : 'textarea',
							width : 640,
							height : 540,

							// maxLength :50,
							value : secretCode,
							id : "meg2"
						}],
				buttons : [{
							id : "cop",
							text : "复制",
							handler : function() {
								try {
									window.clipboardData.setData("Text",
											secretCode);
								} catch (e) {
									alert("浏览器不支持此功能！");
								}
							}
						}, {
							id : "clos",
							text : "关闭",
							handler : function() {
								_windowDel.hide();
							}
						}]

			});
	_windowDel.show();
	Ext.getCmp("meg2").multiline = true; // 多行
	Ext.getCmp("meg2").wordWrap = true;
	Ext.getCmp("meg2").setPagePosition(5, 5);

}
