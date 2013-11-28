var data;
var simple;
var url = basePath
		+ 'model/report/showReport.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56';
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
							name : '市局'
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
				title : '信访台帐',
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
							text : '所在政区：'
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
							text : '导出',
							iconCls : 'blist',
							menu : [{
										text : '导出EXCEL',
										handler : exportExcel
									}, {
										text : '导出PDF',
										handler : exportPdf
									}]
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
	var c1 = Ext.getCmp("dklx").getValue();
	var c2 = Ext.getCmp("xzq").getValue();
	var para = '';
	if (c1 != null && c2 != null) {
		c1 = escape(escape("'" + c1 + "'"));
		c2 = escape(escape("'" + c2 + "'"));
		para = "jbxs=" + c1 + "  and xzq=" + c2;
	} else if (c1 != null) {
		c1 = escape(escape("'" + c1 + "'"));
		var para = "jbxs=" + c1;
	} else if (c2 != null) {
		c2 = escape(escape("'" + c2 + "'"));
		var para = "xzq=" + c2;
	}
	if(para.length>0){
	document.frames('report').location = url + "&&condition=" + para;
	}
	
}

function exportExcel() {
	window
			.open(basePath
					+ 'model/report/exportFile.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56&type=excel&condition='
					+ condition);
}
function exportHtml() {
	window
			.open(basePath
					+ 'model/report/exportFile.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56&type=html&condition='
					+ condition);
}
function exportPdf() {
	window
			.open(basePath
					+ 'model/report/exportFile.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56&type=pdf&condition='
					+ condition);
}