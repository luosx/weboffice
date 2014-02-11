var data;
var simple;
var url = basePath
		+ 'model/report/showReport.jsp?id=F0F8ABCF9D8C4ECF8A4F76F5A5F71799';
var condition="";
		
Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

		var dklxStore=new Ext.data.JsonStore({fields:['name'],
			data:[{name:'合法用地'},{name:'违法用地'}]
			})

	simple = new Ext.FormPanel({
				frame : true,
				title : '卫片汇总',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '地块类型：'
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
	var para = "";
if(c1=='合法用地'){
para='DKLX=1';
}
if(c1=='违法用地'){
para='DKLX=2';
}
	
	
	document.frames('report').location=url+"&&condition="+para;
	condition=para;
	//alert(docu);
}

function exportExcel() {
    window.open(basePath+'model/report/exportFile.jsp?id=F0F8ABCF9D8C4ECF8A4F76F5A5F71799&type=excel&condition='+condition);
}
function exportHtml(){
	window.open(basePath+'model/report/exportFile.jsp?id=F0F8ABCF9D8C4ECF8A4F76F5A5F71799&type=html&condition='+condition);
}
function exportPdf(){
	window.open(basePath+'model/report/exportFile.jsp?id=F0F8ABCF9D8C4ECF8A4F76F5A5F71799&type=pdf&condition='+condition);
}