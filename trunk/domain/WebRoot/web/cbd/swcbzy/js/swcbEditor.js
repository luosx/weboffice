var data;
var simple;
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	simple = new Ext.FormPanel({
				frame : true,
				title : '实物储备资源列表',
				
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
						}],
				items : [{
					html : "<iframe id='report' width=" + (width)
							+ " height=" + (height) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
}

function query() {
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].queryJBB(keyword);
}

function exportExcel() {
	document.frames['report'].print();
}




