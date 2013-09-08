Ext.onReady(function() {
			var simple = new Ext.FormPanel({
						labelWidth : 75,
						frame : true,
						title : '督办时间时限配置',
						bodyStyle : 'padding:5px 5px 0',
						width : 450,
						defaults : {
							width : 230
						},
						defaultType : 'textfield',

						items : [{
									fieldLabel : '案件类型',
									id : 't',
									xtype : 'combo',
									store : ['信访', '立案', '文件审批'],
									itemCls : 'x-form-required',
									emptyText : '信访',
									listeners : {
										'select' : function() {
											getConfig(Ext.getCmp("t")
													.getValue());
										}
									},
									resizable : true
								}, {
									title : '时限配置',
									xtype : 'fieldset',
									width : 350,
									items : [{
												xtype : 'compositefield',
												fieldLabel : '提醒时限',
												combineErrors : false,
												id : 'g',
												items : [{
															name : 'limit',
															xtype : 'numberfield',
															width : 100,
															allowBlank : false
														}, {
															xtype : 'displayfield',
															value : '天'
														}, {
															xtype : 'displayfield',
															hidden : true,
															id : 'hid',
															name : 'type',
															value : '天'
														}]
											}]
								}],

						buttons : [{
									text : '保存',
									id : 'button',
									handler : function() {
										save(Ext.getCmp('t').getValue());
									}
								}]
					});
			simple.render(document.body);
			getConfig('信访');
		})

// 获取数据
function getConfig(type) {
	putClientCommond("noticeSet", "getConfigByType");
	putRestParameter("type", escape(escape(type)));
	var result = restRequest();
	Ext.getCmp("g").items.items[0].setValue(result[0].LIMIT)
}
// save
function save(type) {
	putClientCommond("noticeSet", "setConfigByType");
	putRestParameter("type", escape(escape(type)));
	putRestParameter("limit", Ext.getCmp("g").items.items[0].getValue());
	var result = restRequest();
	if (result == true) {
		Ext.MessageBox.alert('提示', '保存成功');
	} else {
		Ext.MessageBox.alert('提示', '保存失败，请联系管理员！');
	}
}
// 生成小时的下拉框
function getHoursComoBox() {
	var array = new Array();
	for (var i = 0; i < 25; i++) {
		array.push(i);
	}
	var combo = new Ext.form.ComboBox({
				store : array,
				width : 60,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "0",
				selectOnFocus : true
			});
	return combo;
}
// 生成分的下拉框
function getMinComoBox() {
	var array = new Array();
	for (var i = 0; i < 61; i++) {
		array.push(i);
	}
	var combo = new Ext.form.ComboBox({
				store : array,
				width : 60,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "0",
				selectOnFocus : true
			});
	return combo;
}
