var data;
var simple;
var array = new Array();
var url = basePath
		+ '/web/cbd/yzt/jbb/showRW/jbbRowEditor.jsp';
var condition = "";
var combo;
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
							text : '修改',
							id : 'modify',
							handler : update
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
	}
}


function initFile(){
	 combo = new Ext.form.ComboBox({
	 	      fieldLabel: '基本斑编号',
	 	     	id:'zrbbh',
				store : array,
				width : 150,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "-请选择基本斑编号-",
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
            emptyText: 'Select an file',
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
	                    url: basePath + "service/rest/gisfactory/getGis?type=2&guid="+guid,
	                    waitMsg: '坐标串正在导入...',
	                    success: function(fp, o){
	                        //msg('Success', 'Processed file "'+o.result.file+'" on the server');
	                    	document.getElementById("fi-form").style.display = "none";
	                    	alert("导入成功");
	                    	parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
							parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "4", guid, "TBBH");
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
	document.frames['report'].queryJBB(keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function insertGIS(){
	putClientCommond("jbbHandle","getJBBBH");
	var jbbbh = restRequest();
	if(array.length>0){
		array=[];
	}
	for(var i=0;i<jbbbh.length;i++ ){
	array.push(jbbbh[i].DKMC);
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

function update(){
	document.frames['report'].update();
}




