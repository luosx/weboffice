var data;
var simple;
var url = basePath
		+ '/web/cbd/yzt/hxxm/hxxmRowEditor.jsp';
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	simple = new Ext.FormPanel({
				frame : true,
				title : '红线项目列表',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
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
						}, '-', {
							xtype : 'button',
							text : '添加',
							handler : add
						}, '-', {
							xtype : 'button',
							text : '删除',
							handler : dele
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
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].query(yddw , keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function add(){
	document.frames['report'].add();
}

function dele(){
	alert("dele");
}



