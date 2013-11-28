var data;
var simple;
var url = basePath
		+ 'model/report/showReport.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56';
var condition="";
		
Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

		var dklxStore=new Ext.data.JsonStore({fields:['name'],
			data:[{name:'电话'},{name:'传真'}]
			})

	simple = new Ext.FormPanel({
				frame : true,
				title : '信访汇总',
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
						}, '-', {
							xtype : 'button',
							text : '查询',
							handler : query
						}, '-', {
							text : '导出',
							iconCls : 'blist',
							menu : [{
										text : '导出EXCEL',
										handler:exportExcel
									}, {
										text : '导出HTML',
										handler:exportHtml
									}, {
										text : '导出PDF',
										handler:exportPdf
									}]
						}],
				items : [{
					html : "<iframe id='report' width=" + (width-50) + " height="
							+ (height-80) + " src=" + url + "></iframe>"
				}]
			});
	simple.render(document.body);
}

function query() {
	var c1 = Ext.getCmp("dklx").getValue();
	if(c1!=null){
	c1=escape(escape("'"+c1+"'"));
	var para ="jbxs="+c1;
	document.frames('report').location=url+"&&condition="+para;
	condition=para;
	}
	//alert(docu);
}

function exportExcel() {
    window.open(basePath+'model/report/exportFile.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56&type=excel&condition='+condition);
}
function exportHtml(){
	window.open(basePath+'model/report/exportFile.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56&type=html&condition='+condition);
}
function exportPdf(){
	window.open(basePath+'model/report/exportFile.jsp?id=0C5AF6F77991434B9E9967ABCB9F5D56&type=pdf&condition='+condition);
}