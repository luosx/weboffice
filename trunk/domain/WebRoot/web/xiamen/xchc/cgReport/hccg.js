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

	var xzqStore = new Ext.data.JsonStore({
				fields : ['name','value'],
				data : [{
							name : '厦门市',
							value : '350200'
						},{
							name : '思明区',
							value : '350203'
						},{
							name : '湖里区',
							value : '350206'
						},{
							name : '海沧区',
							value : '350205'
						},{
							name : '翔安区',
							value : '350213'
						},{
							name : '同安区',
							value : '350212'
						},{
							name : '集美区',
							value : '350211'
						}]
			})

	simple = new Ext.FormPanel({
				frame : true,
				title : '巡查核查台账',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '行政区：'
						}, {
							id : 'xzq',
							xtype : 'combo',
							width : 100,
							store : xzqStore,
							displayField : 'name',
							valueField :'value',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						},'-',{
							xtype : 'label',
							text : ' 选择日期：'
						}, {
							id : 'begindate',
							xtype : 'datefield',
							format:'y/m/d',
							readonly : true
						}, {
							xtype : 'label',
							text : ' — '
						}, {
							id : 'enddate',
							xtype : 'datefield',
							format:'y/m/d',
							readonly : true
						},
						'-', {
							xtype : 'button',
							text : '查询',
							handler : query
						}, '-', {
							xtype : 'button',
							text : '导出Excel',
							handler : exportExcel
						},'-',{
							xtype : 'button',
							text : '查看位置',
							id : 'location',
							hidden : false,
							handler : seeLocation													
						}],
				items : [{
					html : "<iframe id='report' width=" + (width - 50)
							+ " height=" + (height - 80) + " src = "+url+"></iframe>"
				}]
			});
	simple.render(document.body);
}

function query() {
	var xzq = Ext.getCmp("xzq").getValue();
	var begindate = Ext.getCmp("begindate").getValue();
	var enddate = Ext.getCmp("enddate").getValue();
	if(begindate>enddate){
		Ext.Msg.alert('提示','开始时间不能大于结束时间！');
		return;
	}
	//var keyword = Ext.getCmp("keyword").getValue();
	//document.frames['report'].query(xzq ,begindate, enddate);
	document.getElementById('report').src= url+"?xzq="+xzq+"&begindate="+begindate+"&enddate="+enddate;
	//Ext.getCmp('location').setVisible(true) ;	
}

function exportExcel() {
	document.frames['report'].print();
}

function seeLocation(){
	var xzq = Ext.getCmp("xzq").getValue();
	var begindate = Ext.getCmp("begindate").getValue();
	var enddate = Ext.getCmp("enddate").getValue();
	putClientCommond("xchc","seeLocation");
	putRestParameter("xzq",xzq);
	putRestParameter("begindate",begindate);
	putRestParameter("enddate",enddate);
	var result = restRequest();	
	var url = basePath+"web/xiamen/xchc/cglb/location.jsp?type=3&yw_guid=1";  
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	window.open(url,"","width="+width+",height="+height);		
}