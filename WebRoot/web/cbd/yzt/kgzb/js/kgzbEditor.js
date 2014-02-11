var data;
var simple; 
var combo;
var array = new Array();
var url = basePath
		+ '/web/cbd/yzt/kgzb/kgzbRowEditor.jsp?view=' + view;
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	simple = new Ext.FormPanel({
				frame : true,
				title : '控规指标表',
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
							id:"add",
							handler : add
						}, '-', {
							xtype : 'button',
							text : '修改',
							id:"modify",
							handler : modify
						}, '-', {
							xtype : 'button',
							text : '删除',
							id:"dele",
							handler : dele
						}],
				items : [{
					html : "<iframe id='report' width=" + (width)
							+ " height=" + (height) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
	//确定是否有编辑修改权限，没有权限时隐藏操作按钮
	if(view == "R"){
		var toolbar = simple.getTopToolbar();
		toolbar.remove("insertGIS");
		toolbar.remove("modify");
		toolbar.remove("add");
		toolbar.remove("dele");
	}
}


function query() {
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].queryZrb(keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function add(){
	document.frames['report'].add();
}

function dele(){
	document.frames['report'].dele();
}

function modify(){
	document.frames['report'].modify();
}





