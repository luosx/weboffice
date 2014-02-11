var data;
var simple;
var url = basePath
		+ 'model/report/showReport.jsp?id=21F66D13F4C046B88D7DFA3A30CD8360';
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
				title : '外业成果汇总',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '上报人：'
						}, {
							id : 'dklx',
							name:'dklx',
							xtype : 'textfield'
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

function query(){
	var impuser = Ext.getCmp("dklx").getValue();
	if(impuser!=null){
		impuser=escape(escape("'"+impuser+"'"));
     para="impuser="+impuser;
	 document.frames('report').location=url+"&&condition="+para;
		}
}

function exportExcel() {
    window.open(basePath+'model/report/exportFile.jsp?id=21F66D13F4C046B88D7DFA3A30CD8360&type=excel&condition='+condition);
}
function exportHtml(){
	window.open(basePath+'model/report/exportFile.jsp?id=21F66D13F4C046B88D7DFA3A30CD8360&type=html&condition='+condition);
}
function exportPdf(){
	window.open(basePath+'model/report/exportFile.jsp?id=21F66D13F4C046B88D7DFA3A30CD8360&type=pdf&condition='+condition);
}