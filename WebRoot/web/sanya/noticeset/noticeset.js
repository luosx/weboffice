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
					resizable : true
				}, {
					title : '时限配置',
					xtype : 'fieldset',
					width : 350,
					labelWidth : 125,
					items : [{
								fieldLabel : '<div color="green">绿色提醒</div>(大于)',
								name : 'first',
								allowBlank : false
							}, {
								xtype : 'compositefield',
								fieldLabel : 'Time worked',
								combineErrors : false,
								items : [{
											name : 'hours',
											xtype : 'numberfield',
											width : 48,
											allowBlank : false
										}, {
											xtype : 'displayfield',
											value : 'hours'
										}, {
											name : 'minutes',
											xtype : 'numberfield',
											width : 48,
											allowBlank : false
										}, {
											xtype : 'displayfield',
											value : 'mins'
										}]
							}, {
								fieldLabel : 'Last Name',
								name : 'last'
							}, {
								fieldLabel : 'Company',
								name : 'company'
							}, {
								fieldLabel : 'Email',
								name : 'email',
								vtype : 'email'
							}, new Ext.form.TimeField({
										fieldLabel : 'Time',
										name : 'time',
										minValue : '0',
										maxValue : '60'
									})]
				}],

		buttons : [{
					text : '保存'
				}]
	});

	simple.render(document.body);

})