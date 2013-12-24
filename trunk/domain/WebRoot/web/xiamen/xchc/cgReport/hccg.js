var data;
var simple;
var url = basePath
		+ 'web/xiamen/xchc/cgReport/cgReport.jsp';
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
							name : '厦门市'
						}, {
							name : '直属区'
						}, {
							name : '集美区'
						}, {
							name : '海沧区'
						}, {
							name : '同安区'
						}, {
							name : '翔安区'
						}]
			})

	simple = new Ext.FormPanel({
				frame : true,
				title : '巡查台账',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '用地单位：'
						}, {
							id : 'yddw',
							xtype : 'combo',
							store : xzqStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						},{
							xtype : 'label',
							text : '关键字：'
						}, {xtype:'textfield',id:'keyword',width:200,emptyText:'请输入关键字进行查询'},'-', {
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
	var yddw = Ext.getCmp("yddw").getValue();
	alert(yddw)
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].query(yddw , keyword);
}

function exportExcel() {
	document.frames['report'].print();
}