var data;
var simple; 
var combo;
var array = new Array();
var url = basePath
		+ '/web/cbd/qyjc/xzlzjjc/xzlxx/xzlxxRowEditor.jsp?view=' + view;
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
			initFile();
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
							text : '导入坐标',
							id : 'insertGIS',
							handler : insertGIS
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

function initFile(){
	 combo = new Ext.form.ComboBox({
	 	      fieldLabel: '写字楼名称',
	 	     	id:'xzlmc',
				store : array,
				width : 150,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "-请选择写字楼编号-",
				selectOnFocus : true
			});
	var fp = new Ext.FormPanel({
		renderTo: 'fi-form',
        fileUpload: true,
        width: 300,
        frame: true,
        title: '坐标导入',
        autoHeight: true,
        bodyStyle: 'padding: 10px 10px 0 10px;',
        labelWidth: 70,
        defaults: {
            anchor: '95%',
            allowBlank: false,
            msgTarget: 'side'
        },
		items: [
			combo,{
            xtype: 'fileuploadfield',
            id: 'form-file',
            emptyText: '请选择txt文件位置',
            fieldLabel: '文件位置',
            name: 'file-path',
            buttonText: '',
            buttonCfg: {
                iconCls: 'upload-icon'
            }
        }],
        buttons: [{
            text: '保存',
            handler: function(){
				var guid = Ext.getCmp('xzlmc').getValue();
                if(fp.getForm().isValid()){
	                fp.getForm().submit({
	                    url: basePath + "service/rest/gisfactory/getGis?type=4&guid="+guid,
	                    waitMsg: '坐标串正在导入...',
	                    success: function(fp, o){
	                        //msg('Success', 'Processed file "'+o.result.file+'" on the server');
	                    	document.getElementById("fi-form").style.display = "none";
	                    	alert("导入成功");
							parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
							parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "7", guid, "XZLMC");
	                    	fp.getForm().reset();
	                	}
	                });
                }
            }
        },{
            text: '取消',
            handler: function(){
                document.getElementById("fi-form").style.display = "none";
                fp.getForm().reset();
            }
        }]
	});
	//document.getElementById("ext-comp-1014").style.width = '80';
	document.getElementById("form-file").style.width = '150';
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

function insertGIS(){
	putClientCommond("qyjcManager","getXZLMC");
	var zrbbh = restRequest();
	if(array.length>0){
		array=[];
	}
	for(var i=0;i<zrbbh.length;i++ ){
		array.push(zrbbh[i].XZLMC);
	}
	combo.store.loadData(array);
	var form = document.getElementById("fi-form");
	var display = form.style.display;
	if(display == "none"){
		form.style.display = "";
	}else{
		form.style.display = "none";
	}
}




