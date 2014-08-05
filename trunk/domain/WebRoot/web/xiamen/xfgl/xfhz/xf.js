var data;
var simple;
var url = basePath
		+ 'web/xiamen/xfgl/xfhz/xfReport.jsp';
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	var dklxStore = new Ext.data.JsonStore({
				fields : ['name'],
				data : [{
							name : '电话'
						}, {
							name : '传真'
						}]
			})

	var xzqStore = new Ext.data.JsonStore({
				fields : ['name'],
				data : [{
							name : '局机关'
						}, {
							name : '直属分局'
						}, {
							name : '集美分局'
						}, {
							name : '海沧分局'
						}, {
							name : '同安分局'
						}, {
							name : '翔安分局'
						}]
			})

	simple = new Ext.FormPanel({
				frame : true,
				title : '12336举报台账',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '举报形式：'
						}, {
							id : 'dklx',
							xtype : 'combo',
							store : dklxStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						}, {
							xtype : 'label',
							text : '处理机关：'
						}, {
							id : 'xzq',
							xtype : 'combo',
							store : xzqStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						}, '-', {
							xtype : 'button',
							text : '查询',
							handler : query
						}, '-', {
							xtype : 'button',
							text : '导出Excel',
							handler : exportExcel
						}],
				items : [{
					html : "<iframe id='report' width=" + (width - 50)
							+ " height=" + (height - 80) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
}

function query() {
	var dklx = Ext.getCmp("dklx").getValue();
	var xzq = Ext.getCmp("xzq").getValue();
	dklx = escape(escape(dklx));
	xzq = escape(escape(xzq));
	document.getElementById('report').src= url+"?dklx="+dklx+"&xzq="+xzq;
}

function exportExcel() {
	document.frames['report'].exportExcel();
}
