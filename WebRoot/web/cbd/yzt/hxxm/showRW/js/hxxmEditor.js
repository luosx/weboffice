var data;
var simple;
var combo;
var array = new Array();
var url = basePath
		+ 'web/cbd/yzt/hxxm/showRW/hxxmRowEditor.jsp';
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
							text : '导入坐标',
							handler : insertGIS
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
							id : 'update',
							handler : update
						},'-', {
							xtype : 'button',
							text : '删除',
							id : 'dele',
							handler : dele
						}, '-', {
							xtype : 'button',
							text : '结束',
							id:"end",
							handler : end
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
		toolbar.remove("update");
		toolbar.remove("add");
		toolbar.remove("dele");
	}
}

function end(){
	document.frames['report'].end();
}

function initFile(){
	 combo = new Ext.form.ComboBox({
	 	      fieldLabel: '项目名称',
	 	     	id:'zrbbh',
				store : array,
				width : 150,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "-请选择项目名称-",
				selectOnFocus : true
			});
	var fp = new Ext.FormPanel({
		renderTo: 'fi-form',
        fileUpload: true,
        width: 300,
        frame: true,
        title: '坐标导入',
        monitorValid:false,
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
		    anchor: '95%',
            xtype: 'fileuploadfield',  
            allowBlank :false,
            id: 'form-file',
            emptyText: '请选择一个txt文件',
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
				var guid = Ext.getCmp('zrbbh').getValue();
                if(fp.getForm().isValid()){
	                fp.getForm().submit({
	                    url: basePath + "service/rest/gisfactory/getGis?type=3&guid="+guid,
	                    waitMsg: '坐标串正在导入...',
	                    success: function(fp, o){
	                        //msg('Success', 'Processed file "'+o.result.file+'" on the server');
	                    	document.getElementById("fi-form").style.display = "none";
	                    	alert("导入成功");
	                    	parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
							parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "6", guid, "XMMC");
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
	document.frames['report'].queryHxxm(keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function add(){
	document.frames['report'].add();
}

function update(){
	document.frames['report'].update();
}

function dele(){
	document.frames['report'].dele();
}

function insertGIS(){
	putClientCommond("hxxmHandle","getHxxmmc");
	var hxxmmc = restRequest();
	if(array.length>0){
		array=[];
	}
	for(var i=0;i<hxxmmc.length;i++ ){
		array.push(hxxmmc[i].XMNAME);
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




