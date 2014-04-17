<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.swkgl.Fyzcmanager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String reportID = "zrbHandle";
	String keyIndex = "1";
	ITableStyle its = new TableStyleEditRow();
	String list = Fyzcmanager.getInstcne().getList("");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/base/include/reportEdit.jspf"%>
<script src="web/cbd/zcgl/fyzc/js/table.js"></script>
<script src="web/cbd/zcgl/fyzc/js/panel.js"></script>
<script src="base/include/jquery-1.10.2.js"></script>

<%@ include file="/base/include/restRequest.jspf"%>
<script src="web/cbd/zcgl/fyzc/js/fyzcRowEditor_modify.js"></script>
<script src="web/cbd/zcgl/fyzc/js/fyzcRowEditor.js"></script>

<%@ include file="/base/include/ext.jspf"%>


<style type="text/css">
table {
	font-size: 14px;
	background-color: #A8CEFF;
	border-color: #000000;
	/**
		    border-left:1dp #000000 solid;
		    border-top:1dp #000000 solid;
		    **/
	color: #000000;
	border-collapse: collapse;
}

tr {
	border-width: 0px;
	text-align: center;
}

td {
	text-align: center;
	border-color: #000000;
	/**
		    border-bottom:1dp #000000 solid;
		    border-right:1dp #000000 solid;
		    **/
}

.title {
	font-weight: bold;
	font-size: 15px;
	text-align: center;
	line-height: 30px;
	margin-top: 3px;
	background-color: #99CCFF;
}

.trtotal {
	text-align: center;
	font-weight: bold;
	line-height: 30px;
}

.trsingle {
	background-color: #D1E5FB;
	line-height: 40px;
	text-align: center;
}
</style>
</head>
<script type="text/javascript">

$(document).ready(function() {
	var width = document.body.clientWidth + 10;
	var height = document.body.clientHeight;
	FixTable("FYZC", 1, 3, width, height);
});





//以下是修改功能的内容。


//声明缓存数据全局存储变量
	//子项目数据
var sub_data;
	//主项目数据
var data_modify_ora;
var data_modify = new Array();

var form_modify1;
var form_modify2;
var paneloper_modify2 = new Paneloper();
var paneloper_modify22 = new Paneloper();

function buildPanel_modify1() {
	//级联下拉菜单-房源筹集项目数据源
	var store_modify = new Ext.data.SimpleStore({ //把二维数组交给store－－－－－步骤2
		fields : [ "value", "text" ],
		data : data_modify
	});
	
	//定义接收本次选择的主项目所属所有子项目的信息数组
	var sub_cache;
	
	form_modify1 = new Ext.form.FormPanel({
		autoHeight : true,
		frame : true,
		bodyStyle : 'padding:5px 0px 0',
		width : 800,
		labelWidth : 130,
		labelAlign : "right",
		url : "",
		title : "修改--房源筹集与结余情况",
		defaults : {
			anchor : '0'
		},
		layout : 'form',
		items : [ {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'combo',
					id : 'mc_modify',
					store : store_modify,
					mode : "local",
					displayField : "text",
					valueField : "value",
					emptyText : "-------------请选择-------------",
					forceSelection : true,
					fieldLabel : '房源筹集项目',
					width : '100',
					listeners : {
						'select': function(){
							//获取缓存数据
							var guid = this.value;				
							var data_cache = new Array();
							var num = 0;
							for(var i=0;i<sub_data.length;i++){
								if(guid == sub_data[i].PARENT_ID){
									data_cache[num] = sub_data[i];
									num = num + 1;
								}
							}
							sub_cache = data_cache;
							
							//将数据自动填充进表格中。
							
							for(var i=0;i<data_modify_ora.length;i++){
								if(guid == data_modify_ora[i].YW_GUID){
									$("#gzly_modify").val(data_modify_ora[i].GZLY);
									$("#gzfy_modify").val(data_modify_ora[i].GZFY);
									$("#gzjzgm_modify").val(data_modify_ora[i].GZJZGM);
									$("#dycbzj_modify").val(data_modify_ora[i].DYCBZJ);
									$("#fwdj_modify").val(data_modify_ora[i].FWDJ);
									$("#qtfy_modify").val(data_modify_ora[i].QTFY);
									$("#jyqtfy_modify").val(data_modify_ora[i].JYQTFY);
									$("#jyfy_modify").val(data_modify_ora[i].JYFY);
									$("#jyjzgm_modify").val(data_modify_ora[i].JYJZGM);
									$("#zj_modify").val(data_modify_ora[i].ZJ);
									$("#yw_guid_modify").val(data_modify_ora[i].YW_GUID);
									$("#zyzj_modify").val(data_modify_ora[i].ZYZJ);
								}
							}
							
						}
					}
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'textfield',
					id : 'gzly_modify',
					value : '',
					fieldLabel : '来源',
					width : '100'
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'textfield',
					id : 'gzfy_modify',
					value : '',
					fieldLabel : '购置房源套数',
					width : '100',
					listeners:{
						'blur' : function(){
							var all = $("#gzfy_modify").val();
							var jyfy;
							var used = 0;
							
							for(var i=0;i<sub_cache.length;i++){
								used = used + parseInt(sub_cache[i].FY);
							}
							
							jyfy = all - used;
							$("#jyfy_modify").val(jyfy);
						}
					}
					
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'textfield',
					id : 'gzjzgm_modify',
					decimalPrecision : 2,
					value : '',
					fieldLabel : '购置建筑规模',
					width : '100',
					listeners:{
						'blur' : function(){
							var all = $("#gzjzgm_modify").val();
							var jyjzgm;
							var used = 0;
							
							for(var i=0;i<sub_cache.length;i++){
								used = used + sub_cache[i].JZGM*1;
							}
							
							jyjzgm = all - used;
							$("#jyjzgm_modify").val(jyjzgm.toFixed(2));
						}
					}
				} ]
			} ]
		}, {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'dycbzj_modify',
					decimalPrecision : 2,
					value : '',
					fieldLabel : '动用储备资金',
					width : '100'
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'textfield',
					fieldLabel : '房屋单价',
					id : 'fwdj_modify',
					decimalPrecision : 2,
					value : '',
					width : '100',
					listeners : {
						"blur" : function(){
							var fwdj = $("#fwdj_modify").val();
							var jzgm = $("#jyjzgm_modify").val();
							$("#zyzj_modify").val((fwdj*jzgm).toFixed(2));
						}
					}
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'qtfy_modify',
					decimalPrecision : 2,
					value : '',
					fieldLabel : '其他费用',
					width : '100'
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'jyqtfy_modify',
					decimalPrecision : 2,
					value : '',
					fieldLabel : '结余其他费用',
					width : '100',
					listeners: {
						"blur" : function(){
							var jyqtfy = $("#jyqtfy_modify").val();
							var zyzj = $("#zyzj_modify").val();
							$("#zj_modify").val((jyqtfy*1+zyzj*1).toFixed(2));
						}
					}
				} ]
			} ]
		}, {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'jyfy_modify',
					value : '',
					readOnly : true,
					fieldLabel : '房源结余',
					width : '100'
				} ]
			},{
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'zyzj_modify',
					decimalPrecision : 2,
					value : '',
					readOnly : true,
					fieldLabel : '占压资金',
					width : '100',
					listeners: {
						"change" : function(){
							var jyqtfy = $("#jyqtfy_modify").val();
							var zyzj = $("#zyzj_modify").val();
							$("#zj_modify").val(jyqtfy*1+pzyzj*1);
							alert((jyqtfy*1+pzyzj*1).toFixed(2));
						}
					}
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'jyjzgm_modify',
					decimalPrecision : 2,
					value : '',
					readOnly : true,
					fieldLabel : '结余建筑规模',
					width : '100',
					listeners : {
						"change" : function(){
							var fwdj = $("#fwdj_modify").val();
							var jzgm = $("#jyjzgm_modify").val();
							$("#zyzj_modify").val((fwdj*jzgm).toFixed(2));
						}
					}
				} ]
			} ]
		}, {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					decimalPrecision : 2,
					readOnly : true,
					fieldLabel : '总计',
					id : 'zj_modify',
					value : '',
					width : '100'
				} ]
			} ]
		}, {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'hidden',
					id : 'yw_guid_modify',
					value : ''
					
				} ]
			} ]
		} ]

	});
	var elements_modify2 = new Array("gzly_modify","gzfy_modify","gzjzgm_modify","dycbzj_modify","fwdj_modify","qtfy_modify","jyqtfy_modify","jyfy_modify","jyjzgm_modify","zj_modify","yw_guid_modify","zyzj_modify");
	paneloper_modify2.init(form_modify1,elements_modify2);
	paneloper_modify2.setRestUrl("fyzcHandle/modifyFyzc");
}


function buildForm_modify() {
	//这是下拉菜单的数据源
	var store_modify = new Ext.data.SimpleStore({ //把二维数组交给store－－－－－步骤2
		fields : [ "value", "text" ],
		data : data_modify
	});

	form_modify2 = new Ext.form.FormPanel({
		autoHeight : true,
		frame : true,
		bodyStyle : 'padding:5px 0px 0',
		width : 800,
		labelWidth : 130,
		labelAlign : "right",
		url : "",
		title : "修改--房源使用项目",
		defaults : {
			anchor : '0'
		},
		layout : 'form',
		items : [ {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'combo',
					id : 'parent_id_modify',
					store : store_modify,
					mode : "local",
					displayField : "text",
					valueField : "value",
					emptyText : "-------------请选择-------------",
					forceSelection : true,
					fieldLabel : '房源筹集项目',
					width : '100',
					listeners : {
						'select': function(){
							var parent_id = this.value;
							$("#parent_id_modify2").val(parent_id);
							//alert(parent_id);
							var chosen = new Array();
							var num = 0;
							for(var i=0;i<sub_data.length;i++){
								if(sub_data[i].PARENT_ID == parent_id){
									chosen[num] = [sub_data[i].YW_GUID,sub_data[i].FYMC];
									//alert(sub_data[i].FYMC);
									num = num + 1;
								}
							}
							var sub_store = new Ext.data.SimpleStore({ //把二维数组交给store－－－－－步骤2
								fields : [ "value", "text" ],
								data : chosen
							});
							Ext.getCmp("fymc_modify").store = sub_store;
							Ext.getCmp("fymc_modify").valueField = "value";
							Ext.getCmp("fymc_modify").displayField = "text";
							//Ext.getCmp("fymc_modify").emptyText = "";
							
							//将单价赋给隐藏域，以便计算。
							for(var i=0;i<data_modify_ora.length;i++){
								if(data_modify_ora[i].YW_GUID == parent_id){
									$("#dj").val(data_modify_ora[i].FWDJ);
								}
							}
						}
					}
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [{
					xtype : 'combo',
					id : 'fymc_modify',
					//store : store_modify,
					mode : "local",
					//displayField : "text",
					//valueField : "value",
					emptyText : "",
					forceSelection : true,
					fieldLabel : '房源使用项目',
					width : '100' ,
					listeners : {
						"select" : function(){
							var guid = this.value;
							
							for(var i=0;i<sub_data.length;i++){
								if(guid == sub_data[i].YW_GUID){
									$("#fy_modify").val(sub_data[i].FY);
									
									$("#jzgm_modify").val(sub_data[i].JZGM);
									$("#djzyzj_modify").val(sub_data[i].DJZYZJ);
									$("#qtfy_child_modify").val(sub_data[i].QTFY);
									$("#zj_child_modify").val(sub_data[i].ZJ);
									$("#yw_guid_child_modify").val(sub_data[i].YW_GUID);
									
								}
							}
						}
					}
				}]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'fy_modify',
					value : '',
					fieldLabel : '使用房源数',
					width : '140'
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'jzgm_modify',
					value : '',
					fieldLabel : '建筑规模',
					width : '140',
					listeners : {
						"blur" : function(){
							var dj = $("#dj").val();
							var jzgm = $("#jzgm_modify").val();
							$("#djzyzj_modify").val((dj*jzgm).toFixed(2));
							
							var djzyzj = $("#djzyzj_modify").val();
							var qtfy = $("#qtfy_child_modify").val();
							$("#zj_child_modify").val((djzyzj*1+qtfy*1).toFixed(2));
						}
					}
				
				} ]
			} ]
		}, {
			layout : 'column',
			items : [ {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					id : 'djzyzj_modify',
					value : '',
					readOnly : true,
					fieldLabel : '抵减占压资金',
					width : '140',
					listeners:{
						"change" : function(){
							var djzyzj = $("#djzyzj_modify").val();
							var qtfy = $("#qtfy_child_modify").val();
							$("#zj_child_modify").val((djzyzj*1+qtfy*1).toFixed(2));
						}
					}
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					fieldLabel : '其他费用',
					id : 'qtfy_child_modify',
					value : '',
					width : '140',
					listeners:{
						"blur" : function(){
							var djzyzj = $("#djzyzj_modify").val();
							var qtfy = $("#qtfy_child_modify").val();
							$("#zj_child_modify").val((djzyzj*1+qtfy*1).toFixed(2));
						}
					}
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'numberfield',
					fieldLabel : '总计',
					id : 'zj_child_modify',
					value : '',
					readOnly : true,
					width : '140'
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'hidden',
					id : 'yw_guid_child_modify',
					value : ''
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'hidden',
					id : 'dj',
					value : ''
				} ]
			}, {
				columnWidth : .5,
				layout : 'form',
				items : [ {
					xtype : 'hidden',
					id : 'parent_id_modify2',
					value : ''
				} ]
			} ]
		} ]
	});
	var elements_modify22 = new Array("parent_id_modify2","fymc_modify","fy_modify","jzgm_modify","djzyzj_modify","qtfy_child_modify","zj_child_modify","yw_guid_child_modify","dj");
	paneloper_modify22.init(form_modify2,elements_modify22);
	paneloper_modify22.setRestUrl("fyzcHandle/modifyFyzc_fy");
	
}





var win_modify;
var tabs_modify;
function showModifyWindow() {
	//下拉菜单数据源获取
	
	//主项目数据源
	var myData = new Array();
	var num = 0;
	_resetParameters();
	putClientCommond("fyzcHandle", "getAllMc");
	var jsonObj = restRequest();
	data_modify_ora = jsonObj;

	for ( var i = 0; i < jsonObj.length; i++) {

		myData[num] = [ jsonObj[i].YW_GUID, jsonObj[i].MC ];
		num = num + 1;
	}
	data_modify = myData;
	
	//子项目数据源
	_resetParameters();
	putClientCommond("fyzcHandle", "getAllMc_fy");
	sub_data = restRequest();
	//alert(sub_data[0].FYMC);

	
	
	
	
	
	buildForm_modify();
	buildPanel_modify1();
	tabs_modify = new Ext.TabPanel({
		id : 'pan_modify',
		autoTabs : true,
		activeTab : 0,
		height : 500,
		enableTabScroll : true,
		deferredRender : false,
		border : false,
		scrollDuration : 0.35,
		scrollIncrement : 100,
		animScroll : true,
		defaults : {
			autoScroll : true
		},
		items : [ form_modify1, form_modify2 ]

	});

	//tabs.add(form2);
	//tabs.add(form1);
	if (!win_modify) {
		win_modify = new Ext.Window({
			renderTo : Ext.getBody(),
			id : 'wind_modify',
			layout : 'fit',
			title : '属性查询',
			width : 700,
			height : 300,
			plain : true,
			closeAction : 'hide',
			items : tabs_modify,
			buttons : [ {
				text : '保存',
				handler : function() {
					
					if(tabs_modify.getActiveTab() == form_modify1){
						paneloper_modify2.save();
					}
					if(tabs_modify.getActiveTab() == form_modify2){
						paneloper_modify22.save();
					}
					
				}
			}, {
				text : '关闭',
				handler : function() {
					win_modify.hide();
				}
			} ]
		});
	} else {
		win_modify.items.removeAt(0);
		win_modify.items.add("pan_modify", tabs_modify);
		win_modify.doLayout();
	}
	win_modify.show();

}














	var form2;
	var form1;
	
	var paneloper2 = new Paneloper();
	var paneloper22 = new Paneloper();
	

	function buildPanel1() {
		form1 = new Ext.form.FormPanel({
			autoHeight : true,

			frame : true,
			bodyStyle : 'padding:5px 0px 0',
			width : 800,
			labelWidth : 130,
			labelAlign : "right",
			url : "",
			title : "房源筹集与结余情况",
			defaults : {
				anchor : '0'
			},
			layout : 'form',
			items : [ {
				layout : 'column',
				items : [ {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'textfield',
						id : 'mc',
						value : '',
						fieldLabel : '名称',
						width : '100',
						mode : "local"
					} ]
				}, {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'textfield',
						id : 'gzly',
						value : '',
						fieldLabel : '来源',
						width : '100'
					} ]
				}, {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'textfield',
						id : 'gzfy',
						value : '',
						fieldLabel : '购置房源套数',
						width : '100'
					} ]
				}, {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'textfield',
						id : 'gzjzgm',
						value : '',
						fieldLabel : '购置建筑规模',
						width : '100'
					} ]
				} ]
			}, {
				layout : 'column',
				items : [ {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'numberfield',
						id : 'dycbzj',
						value : '',
						fieldLabel : '动用储备资金',
						width : '100'
					} ]
				}, {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'textfield',
						fieldLabel : '房屋单价',
						id : 'fwdj',
						value : '',
						width : '100'
					} ]
				}, {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'numberfield',
						id : 'qtfy',
						value : '',
						fieldLabel : '其他费用',
						width : '100'
					} ]
				}, {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'numberfield',
						id : 'jyqtfy',
						value : '',
						fieldLabel : '结余其他费用',
						width : '100'
					} ]
				} ]
			},  {
				layout : 'column',
				items : [ {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'hidden',
						id : 'yw_guid',
						value : ''
						
					} ]
				} ]
			} ]

		});
		var elements2 = new Array("mc","gzly","gzfy","gzjzgm","dycbzj","fwdj","qtfy","jyqtfy","yw_guid");
		paneloper2.init(form1,elements2);
		paneloper2.setRestUrl("fyzcHandle/addFyzc");
	}

	var data = new Array();
	function buildForm() {
		//这是下拉菜单的数据源
		var store = new Ext.data.SimpleStore({ //把二维数组交给store－－－－－步骤2
			fields : [ "value", "text" ],
			data : data
		});

		form2 = new Ext.form.FormPanel({
			autoHeight : true,
			frame : true,
			bodyStyle : 'padding:5px 0px 0',
			width : 800,
			labelWidth : 130,
			labelAlign : "right",
			url : "",
			title : "房源使用项目",
			defaults : {
				anchor : '0'
			},
			layout : 'form',
			items : [ {
				layout : 'column',
				items : [  {
					columnWidth : .5,
					layout : 'form',
					items : [ {
						xtype : 'textfield',
						id : 'fymc',
						value : '',

						fieldLabel : '房源使用项目',
						width : '140'
					} ]
				} ]
			}]
					
				
			} 
		);
		var elements22 = new Array("fymc");
		paneloper22.init(form2,elements22);
		paneloper22.setRestUrl("fyzcHandle/addFyzc_fy");
	}

	var win;
	var tabs;
	function showWindow() {
		var myData = new Array();
		var num = 0;
		_resetParameters();
		putClientCommond("fyzcHandle", "getAllMc");
		var jsonObj = restRequest();

		for ( var i = 0; i < jsonObj.length; i++) {

			myData[num] = [ jsonObj[i].YW_GUID, jsonObj[i].MC ];
			num = num + 1;
		}
		data = myData;
		
		
		buildForm();
		buildPanel1();
		tabs = new Ext.TabPanel({
			id : 'pan',
			autoTabs : true,
			activeTab : 0,
			height : 500,
			enableTabScroll : true,
			deferredRender : false,
			border : false,
			scrollDuration : 0.35,
			scrollIncrement : 100,
			animScroll : true,
			defaults : {
				autoScroll : true
			},
			items : [ form1, form2 ]

		});

		//tabs.add(form2);
		//tabs.add(form1);
		if (!win) {
			win = new Ext.Window({
				renderTo : Ext.getBody(),
				id : 'wind',
				layout : 'fit',
				title : '属性查询',
				width : 700,
				height : 300,
				plain : true,
				closeAction : 'hide',
				items : tabs,
				buttons : [ {
					text : '保存',
					handler : function() {
						
						if(tabs.getActiveTab() == form1){
							paneloper2.save();
						}
						if(tabs.getActiveTab() == form2){
							paneloper22.save();
						}

					}
				}, {
					text : '关闭',
					handler : function() {
						win.hide();
					}
				} ]
			});
		} else {
			win.items.removeAt(0);
			win.items.add("pan", tabs);
			win.doLayout();
		}
		win.show();

	}
	
	
	//以下是删除功能部分
		var form_delMain;
		var data_delMain = new Array();
		var paneloper22_delMain = new Paneloper();
		
		
		var data_delSub = new Array();
		var paneloper22_delSub = new Paneloper();
		
	function buildForm_delMain() {
		//这是下拉菜单的数据源
		var store_delMain = new Ext.data.SimpleStore({ 
			fields : [ "value", "text" ],
			data : data_delMain
		});
			
		var store_delSub = new Ext.data.SimpleStore({ 
			fields : [ "value", "text" ],
			data : data_delSub
		});
		form_delMain = new Ext.form.FormPanel({
			autoHeight : true,
			frame : true,
			bodyStyle : 'padding:5px 0px 0',
			width : 800,
			labelWidth : 130,
			labelAlign : "right",
			url : "",
			title : "项目删除",
			defaults : {
				anchor : '0'
			},
			layout : 'form',
			items : [ {
				layout : 'column',
				items : [  {
					columnWidth : 1,
					layout : 'form',
					items : [ {
						xtype : 'combo',
						id : 'mc_delMain',
						store : store_delMain,
						mode : "local",
						displayField : "text",
						valueField : "value",
						forceSelection : true,
						fieldLabel : '房源筹集项目',
						width : '140',
						listeners : {
							"select" : function(){
								var guid_del = this.value;
								$("#yw_guid_delMain").val(guid_del);
							}
						}
					} ]
				},{
					xtype : 'button',
					id : 'button_delMain',
					text : '删除',
					width : '75',
					handler : function(){
						paneloper22_delMain.save();
					}
				} ]
			},{
				layout : 'column',
				items : [  {
					columnWidth : 1,
					layout : 'form',
					items : [ {
						xtype : 'combo',
						id : 'mc_delSub',
						store : store_delSub,
						mode : "local",
						displayField : "text",
						valueField : "value",
						forceSelection : true,
						fieldLabel : '房源使用项目',
						width : '140',
						listeners : {
							"select" : function(){
								var guid_del = this.value;
								$("#fymc_delSub").val(guid_del);
							}
						}
					} ]
				},{
					xtype : 'button',
					id : 'button_delSub',
					text : '删除',
					width : '75',
					handler : function(){
						paneloper22_delSub.save();
					}
				} ]
			},{
				layout : 'column',
				items : [  {
					columnWidth : 1,
					layout : 'form',
					items : [ {
						xtype : 'hidden',
						id : 'yw_guid_delMain',
						value: '',
						width : '65'
						
					} ]
				},{
					columnWidth : 1,
					layout : 'form',
					items : [ {
						xtype : 'hidden',
						id : 'fymc_delSub',
						value: '',
						width : '65'
						
					} ]
				} ]
			}]
					
				
			} 
		);
		var elements22_delMain = new Array("yw_guid_delMain");
		paneloper22_delMain.init(form_delMain,elements22_delMain);
		paneloper22_delMain.setRestUrl("fyzcHandle/delByYwGuid");
		
		var elements22_delSub = new Array("fymc_delSub");
		paneloper22_delSub.init(form_delMain,elements22_delSub);
		paneloper22_delSub.setRestUrl("fyzcHandle/delSub");
	}
	
	
	
	
	
	
	
	
	
	var win_del;
	var tabs_del;
	function showWindow_del() {
		var myData = new Array();
		var num = 0;
		_resetParameters();
		putClientCommond("fyzcHandle", "getAllMc");
		var jsonObj = restRequest();

		for ( var i = 0; i < jsonObj.length; i++) {

			myData[num] = [ jsonObj[i].YW_GUID, jsonObj[i].MC ];
			num = num + 1;
		}
		data_delMain = myData;
		
		_resetParameters();
		putClientCommond("fyzcHandle", "getfymc");
		var data_fymc = restRequest();
		
		for(var i=0;i<data_fymc.length;i++){
			data_delSub[i] = [data_fymc[i].FYMC,data_fymc[i].FYMC];
		}
		
		buildForm_delMain();
		tabs_del = new Ext.TabPanel({
			id : 'pan_del',
			autoTabs : true,
			activeTab : 0,
			height : 500,
			enableTabScroll : true,
			deferredRender : false,
			border : false,
			scrollDuration : 0.35,
			scrollIncrement : 100,
			animScroll : true,
			defaults : {
				autoScroll : true
			},
			items : [ form_delMain ]

		});

		//tabs.add(form2);
		//tabs.add(form1);
		if (!win_del) {
			win_del = new Ext.Window({
				renderTo : Ext.getBody(),
				id : 'wind_del',
				layout : 'fit',
				title : '删除窗口',
				width : 440,
				height : 170,
				plain : true,
				closeAction : 'hide',
				items : tabs_del,
				buttons : [ {
					text : '关闭',
					handler : function() {
						win_del.hide();
					}
				} ]
			});
		} else {
			win_del.items.removeAt(0);
			win_del.items.add("pan_del", tabs_del);
			win_del.doLayout();
		}
		win_del.show();

	}
	
</script>
<body>
	<div id='show'>
		<%=list%>
	</div>
	<div id="deal2" style="position: absolute; left: 5px; top: 5px;"></div>
	<form id="attachfile"
		action="<%=basePath%>service/rest/fyzcHandle/addFyzc" method="post">
	</form>
</body>
</html>
