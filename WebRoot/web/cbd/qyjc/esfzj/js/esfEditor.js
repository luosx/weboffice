var data;
var simple; 
var combo;
var array = new Array();
var url = basePath
		+ '/web/cbd/qyjc/esfzj/esfRowEditor.jsp?view=' + view;
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
//			Ext.getCmp("year").setValue(year);
//		 Ext.getCmp("month").setValue(month);
		});

function initComponent() {

	simple = new Ext.FormPanel({
				frame : true,
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
						} , '-', {
							xtype : 'button',
							text : '结束',
							id:"end",
							handler : end,
						
						    listeners:{'select':function(){
								var year = Ext.getCmp("year").lastSelectionText;
								var month = Ext.getCmp("month").lastSelectionText;
								var news=document.frames['report'].document.getElementById("show");
								var table=document.frames['report'].document.getElementById("ESFQK");
								putClientCommond("scjcManager", "query_year_month");
								putRestParameter("year", year);
								putRestParameter("month", month);
								var reslut = restRequest();
								news.innerHTML=reslut;
								var obj = document.frames['report'].document.getElementById("ESFQK");
						  		var rowlength = obj.rows.length;
						  		for(var i=0;i< rowlength;i++){
						  			//if(i!=1){
						  				obj.rows[i].cells[obj.rows[i].cells.length-1].style.display="none";
						  				obj.rows[i].cells[obj.rows[i].cells.length-1].innerText;
						  			//}
						  		}
								var width = document.body.clientWidth;
								var height = document.body.clientHeight * 0.95;
						       	document.frames['report'].FixTable("ESFQK", 0,1, width-10, height-25);
						    }}
						}
						],
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

function end(){
	document.frames['report'].end();
}

function zsxxlr() {
	document.frames['report'].zsxxlr();
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





