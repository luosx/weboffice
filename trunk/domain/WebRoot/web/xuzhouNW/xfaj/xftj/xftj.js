var data;
var simple;
var url = basePath
		+ 'model/report/showReport.jsp?id=A8A2D88812384234B6DA4D89931C7A06';
var condition;
		
Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	// 问题发生地数据
	var districtStore = new Ext.data.JsonStore({
				fields : ['name'],
				data : [{
							name : '全市'
						}, {
							name : '泉山区'
						}, {
							name : '云龙'
						}, {
							name : '全部'
						}, {
							name : '全部'
						}, {
							name : '全部'
						}, {
							name : '全部'
						}]
			});

	simple = new Ext.FormPanel({
				frame : true,
				title : '信访统计',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '问题发生地：'
						}, {
							id : 'district',
							xtype : 'combo',
							store : districtStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						}, '-', {
							xtype : 'label',
							text : ' 选择日期：'
						}, {
							id : 'date1',
							xtype : 'datefield',
							format:'y/m/d',
							readonly : true
						}, {
							xtype : 'label',
							text : ' ——'
						}, {
							id : 'date2',
							xtype : 'datefield',
							format:'y/m/d',
							readonly : true
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
	var c1 = Ext.getCmp("district").getValue();
	var c2 = Ext.getCmp("date1").getRawValue();
	var c3 = Ext.getCmp("date2").getRawValue();

	var para = "1=1 ";
	if (c1 != "" && c1 != "全市") {
		c1=escape(escape(c1));
		para += "and wtfsd7='" + c1 + "'";
	}
	if (c2 != "") {
		para += " and to_date(djrq,'YYYY/MM/DD')>to_date('"+c2+"','YY/MM/DD')";
	}
	if (c3 != "") {
		para += " and to_date(djrq,'YYYY/MM/DD')<to_date('"+c3+"','YY/MM/DD')";
	}
	document.frames('report').location=url+"&&condition="+para;
	condition=para;
	//alert(docu);
}

function exportExcel() {
    window.open(basePath+'model/report/exportFile.jsp?id=A8A2D88812384234B6DA4D89931C7A06&type=excel&condition='+condition);
}
function exportHtml(){
	window.open(basePath+'model/report/exportFile.jsp?id=A8A2D88812384234B6DA4D89931C7A06&type=html&condition='+condition);
}
function exportPdf(){
	window.open(basePath+'model/report/exportFile.jsp?id=A8A2D88812384234B6DA4D89931C7A06&type=pdf&condition='+condition);
}