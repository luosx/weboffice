<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String xmmc = request.getParameter("xmmc");
	String reportID = "XMKGZBBCX";
	String keyIndex = "1";
	String yw_guid = request.getParameter("yw_guid");
	if(xmmc!=null){
		xmmc = new String(xmmc.getBytes("iso-8859-1"),"utf-8");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>项目控规指标表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="DatePicker.js"></script>
		<style>
input,img {
	vertical-align: middle;
}
</style>
		<script>
		var basePath="<%=basePath%>";
		
var ydxzlx;
var data;
var formPanel;
var radio ;
var simple;
var array1 = new Array();
var array2 = new Array();
var array3 = new Array();
var array4 = new Array();
var combo4;
var combo1;
var combo2;
var combo3;
var dkbh;
var qy;
var xqy;
var fp_add;
var fp;

var deleteformPanel;

var url = basePath
		+ 'web/cbd/xmgl/xmkgzb/xmkgzbReport.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>';
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
			
		});
function getQYComoBox() {
		array1 = new Array();
		array1.push("中心区");
		array1.push("东扩区");
		var combo = new Ext.form.ComboBox({
				store : array1,
				width : 60,
				id:"qy",
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				fieldLabel: '区域',
				emptyText : "-请选择区域-",
				selectOnFocus : true,
				listeners:{
	         	'change':function(){
		         	array2 = new Array();
			        qy = combo1.value;
				        if(qy==("中心区")){
							array2.push("西北区");
							array2.push("西南区");
							array2.push("东北区");
							array2.push("东南区");
						}else if(qy==("东扩区")){
							array2.push("A街区");
							array2.push("B街区");
							array2.push("C街区");
							array2.push("D街区");
							array2.push("E街区");
						}
					combo2.store.loadData(array2);
		          }
	        	}
			});
		return combo;
}

function getXQYComoBox() {
	qy = document.getElementById("qy");
	array2 = [];
	var combo = new Ext.form.ComboBox({
				store : array2,
				width : 60,
				id:"xqy",
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				fieldLabel: '小区域',
				emptyText : "请选择小区域",
				selectOnFocus : true,
				listeners :{
	         	'change':function(){
	         	 xqy = combo2.value;
				array3 = new Array();
				putClientCommond("xmkgzbbmanager","getDKMC");
				var list = restRequest();
				for(var i=0;i<list.length;i++ ){
						if(xqy==(list[i].QY)){
							array3.push(list[i].DKMC);
						}
					}
					combo3.store.loadData(array3);
		          }
		        }
			});
			
	return combo;
}
function getDKBHComoBox() {
	array3 = [];
	var combo = new Ext.form.ComboBox({
				store : array3,
				width : 60,
				id:"dkmc",
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				fieldLabel: '地块编号',
				emptyText : "请选择地块",
				selectOnFocus : true,
				listeners :{
		         	'change':function(){
		         	dkbh = combo3.value;
		          }
		        }
			});
			
	return combo;
}

function getDKXZLXComoBox() {
	array4.push("经营性建设用地");
	array4.push("非经营性建设用地");
	array4.push("代征绿地及水域");
	var combo = new Ext.form.ComboBox({
				store : array4,
				width : 60,
				id:"ydxzlx",
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				fieldLabel: '用地性质',
				emptyText : "-请选择用地性质-",
				selectOnFocus : true,
				listeners :{
	         	'change':function(){
	         	if(combo4.value=="经营性建设用地"){
	         	ydxzlx = "1";
	         	}else if(combo4.value=="非经营性建设用地"){
	         	ydxzlx = "2";
	         	}else if(combo4.value=="代征绿地及水域"){
	         	ydxzlx = "3";
	         	}
          }
        }
			});
			
	return combo;
}
function initComponent() {
		
			combo1 = getQYComoBox();
			combo2 = getXQYComoBox();
			combo3 = getDKBHComoBox();
			combo4 = getDKXZLXComoBox();
			fp_add = new Ext.FormPanel({
		        fileUpload: true,
		        width: 300,
		        frame: true,
		        header : false,
		        title: '添加地块',
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
				    combo1,combo2,combo3,combo4],
		        buttons: [{
		            text: '保存',
		            handler: function(){
		            if(dkbh==null||dkbh==''||ydxzlx==null||ydxzlx==''||qy==null||qy==''||xqy==null||xqy==''){
							alert("请填写完整之后再保存！！"); 
				    }else{
				            dkbh=escape(escape(dkbh));
							ydxzlx=escape(escape(ydxzlx));
							qy=escape(escape(qy));
							xqy=escape(escape(xqy));
							putClientCommond("xmkgzbbmanager","saveDK");
							putRestParameter("yw_guid","<%=yw_guid%>");
							putRestParameter("dkbh",dkbh);
							putRestParameter("ydxzlx",ydxzlx);
							putRestParameter("qy",qy);
							putRestParameter("xqy",xqy);
							var msg=restRequest();
								if('success'==msg){
									alert("保存成功！");
									document.location.reload();
								}else{
									alert("保存失败！");
								}
				    }
			            }
			        },{
			            text: '取消',
			            handler: function(){
			        		fp.hide();
			            }
		        }]
			});
	simple = new Ext.FormPanel({
				header : false,
				frame : true,
				title : '项目控规指标表',
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
						},'-',{
							xtype : 'button',
							text : '添加地块',
							handler : add
						},'-',{
							xtype : 'button',
							text : '删除地块',
							handler : dele
						}],
				items : [{
					html : "<iframe id='report' width=" + (width - 25)
							+ " height=" + (height - 48) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
	fp = new Ext.Window({ 
		   		closeAction:"hide",
		    	title:'添加地块',    
		        frame: true,   
		        labelWidth:300,   
		        width: 310,   
		        height:198,   
		        items: [   
		            fp_add   
		        ]   
		    }); 
}

function query() {
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].query( keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function dele(){
	document.frames['report'].dele();
}
function add(){
		fp.show();
}

		</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="update" class="x-hidden">
			<div id="updateForm"
				style="width: 100%; height: 90%; margin-left: 10px; margin-top: 5px"></div>
		</div>
		
	</body>
</html>