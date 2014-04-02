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
			Ext.getCmp("year").setValue(year);
		 Ext.getCmp("month").setValue(month);
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
						} , '-' ,{
							xtype : 'label',
							text : '年：'
						},{
							xtype : 'combo',   
						    id : 'year',   
						    store :[[1,'2010'],[2,'2011'],[3,'2012'],[4,'2013'],[5,'2014'],[6,'2015'],[7,'2016'],[8,'2017'],[9,'2018'],[10,'2019']
						    ,[11,'2020'],[12,'2021'],[13,'2022'],[14,'2023'],[15,'2024'],[16,'2025'],[17,'2026'],[18,'2027'],[19,'2028'],[20,'2029'],[21,'2030']],   
						    width:50,   
						    value:'',   
						    triggerAction: "all",   
						    mode: "local",   
						    allowBlank:false
						}, '-' ,{
							xtype : 'label',
							text : '月：'
						},{
							xtype : 'combo',   
						    id : 'month',   
						    store :[[1,'1'],[2,'2'],[3,'3'],[4,'4'],[5,'5'],[6,'6'],[7,'7'],[8,'8'],[9,'9'],[10,'10'],[11,'11'],[12,'12']],   
						    width:50,   
						    value:'',   
						    triggerAction: "all",   
						    mode: "local",   
						    allowBlank:false,
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
	var year = Ext.getCmp("year").getValue();
	var month = Ext.getCmp("month").getValue();
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].queryZrb(year,month,keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function zsxxlr() {
	document.frames['report'].zsxxlr();
}

function add(){
	document.frames['report'].add();
}

function dele(){
	var year = Ext.getCmp("year").getValue();
	var month = Ext.getCmp("month").getValue();
	document.frames['report'].dele(year,month);
}

function modify(){
	document.frames['report'].modify();
}





