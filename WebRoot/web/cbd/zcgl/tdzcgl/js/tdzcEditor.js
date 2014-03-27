var data;
var simple;
var url = basePath
		+ '/web/cbd/zcgl/tdzcgl/tdzcRowEditor.jsp';
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
				bodyStyle : 'padding:0 0 0',
				overflow:'auto',
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
							id : 'add',
							handler : add
						}, '-', {
							xtype : 'button',
							text : '修改',
							id:'modify',
							handler : modify
						}, '-', {
							xtype : 'button',
							text : '删除',
							id:'dele',
							handler : dele
						}],
				items : [{
					html : "<iframe id='report' width=" + (width - 10)
							+ " height=" + (height - 57) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
	if(view == "R"){
		var toolbar = simple.getTopToolbar();
		toolbar.remove("modify");
		toolbar.remove("add");
		toolbar.remove("dele");
	}
}

function initFile(){
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
		items: [{
            xtype: 'textfield',
            id:'zrbbh',
            width:190,
            fieldLabel: '自然斑编号'
        },{
            xtype: 'fileuploadfield',
            id: 'form-file',
            emptyText: 'Select an file',
            fieldLabel: '文件位置',
            name: 'file-path',
            buttonText: '',
            buttonCfg: {
                iconCls: 'upload-icon'
            }
        }],
        buttons: [{
            text: 'Save',
            handler: function(){
				var guid = Ext.getCmp('zrbbh').getValue();
                if(fp.getForm().isValid()){
	                fp.getForm().submit({
	                    url: basePath + "service/rest/gisfactory/getGis?type=1&guid="+guid,
	                    waitMsg: '坐标串正在导入...',
	                    success: function(fp, o){
	                        //msg('Success', 'Processed file "'+o.result.file+'" on the server');
	                    	document.getElementById("fi-form").style.display = "none";
	                    	alert("导入成功")
	                	}
	                });
                }
            }
        },{
            text: 'Reset',
            handler: function(){
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

function insertGIS(){
	var form = document.getElementById("fi-form");
	var display = form.style.display;
	if(display == "none"){
		form.style.display = "";
	}else{
		form.style.display = "none";
	}
}

function modify(){
	document.frames['report'].modify();
}




