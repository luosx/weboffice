Ext.onReady(function() {
	var simple = new Ext.FormPanel({
				labelWidth : 75,
				url : 'save-form.php',
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
							xtype : 'combo',
							store : ['信访', '立案', '文件审批'],
							itemCls : 'x-form-required',
							emptyText : '信访',
							resizable : true
						}, {
							title : '时限配置',
							xtype : 'fieldset',
							width : 450,
							labelWidth : 125,
							items : [{
										xtype : 'compositefield',
										fieldLabel : '绿色提醒(大于)',
										combineErrors : false,
										id : 'g',
										items : [{
													name : 'hours',
													xtype : 'numberfield',
													width : 48,
													allowBlank : false
												}, {
													xtype : 'displayfield',
													value : '天'
												}, getHoursComoBox(), {
													xtype : 'displayfield',
													value : '时'
												}, getMinComoBox(), {
													xtype : 'displayfield',
													value : '分'
												}]
									}, {
										xtype : 'compositefield',
										fieldLabel : '黄色提醒(小于)',
										combineErrors : false,
										id : 'y',
										items : [{
													name : 'hours',
													xtype : 'numberfield',
													width : 48,
													allowBlank : false
												}, {
													xtype : 'displayfield',
													value : '天'
												}, getHoursComoBox(), {
													xtype : 'displayfield',
													value : '时'
												}, getMinComoBox(), {
													xtype : 'displayfield',
													value : '分'
												}]
									}]
						}],

				buttons : [{
							text : '保存',
							handler : function() {
								alert(Ext.getCmp("g").items.items[2].getValue());
							}
						}]
			});
	simple.render(document.body);
	getConfig('信访');
})
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
// 获取数据
function getConfig(type) {
	putClientCommond("noticeSet", "getConfigByType");
	putRestParameter("type", escape(escape(type)));
	var result=restRequest();
	alert(result[0].limit);
}
