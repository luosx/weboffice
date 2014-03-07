<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.yzt.kgzb.Control"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String type = request.getParameter("type");
	String reportID = "oldTable";
	String keyIndex = "1";
	ITableStyle its = new TableStyleEditRow();
	String view = request.getParameter("view");
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
		<script src="base/include/jquery-1.10.2.js"></script>
		<%@ include file="/web/cbd/yzt/kgzb/js/reportEdit.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="web/cbd/yzt/kgzb/js/table.js"></script>
		<script src="web/cbd/yzt/kgzb/js/panel.js"></script>
		<script src="web/cbd/yzt/kgzb/js/kgzbRowEditor.js"></script>
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
}

.trtotal {
	text-align: center;
	font-weight: bold;
	line-height: 30px;
}

.trsingle {
	background-color: #D1E5FB;
	line-height: 20px;
	text-align: center;
}
</style>
	</head>
	<script type="text/javascript">
  	var form;
  	var view = "<%=view%>";
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		var width = document.body.clientWidth;
		var height = document.body.clientHeight * 0.95;
       	FixTable("SWCBR", 1,1, width, height-5);
       	buildPanel();
    });
  //	Ext.onReady(function(){
  		//Ext.QuickTips.init();
  	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 500,
	  		labelWidth :115,   
	  		labelAlign : "right",
	        url:"",
	        title:"自然斑详细信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items   : [{
        		layout:'column',
        		items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
			            xtype : 'combo',   
					    fieldLabel : '区域',   
					    id : 'qy',   
					    store :[[1,'A街区'],[2,'B街区'],[3,'C街区'],[4,'D街区'],[5,'西北区'],[6,'东北区'],[7,'西南区'],[8,'东南区']],   
					    width:100,   
					    value:'',   
					    triggerAction: "all",   
					    mode: "local",   
					    allowBlank:false
            		}]
           		},{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'dkmc',
		                value:'',
		                fieldLabel: '地块名称',
		                width :60
		            }]
		        }]
            },{
           		layout:'column',
        		items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
			            xtype : 'combo',   
					    fieldLabel : '用地性质',   
					    id : 'ydxz',   
					    store :[[1,'居住用地'],[2,'混合使用'],[3,'商务设施'],[4,'市政用地'],[5,'绿化用地'],[6,'文化娱乐'],[7,'中小学用地'],[8,'教育科研'],[9,'商业金融'],[10,'代征绿地'],[11,'代征水域']],   
					    width:100,   
					    value:'',   
					    triggerAction: "all",   
					    mode: "local",   
					    allowBlank:false,
					    listeners:{                
						    'select': function(){ 
						    	 var value = Ext.getCmp('ydxz').getRawValue();     
						    	 if(value=="混合使用"){                
							     	Ext.getCmp("ydxzdh").setValue("C2、C3、R2");
							     }else if(value=="居住用地"){
							     	Ext.getCmp("ydxzdh").setValue("R2");
							     }else if(value=="商务设施"){
							     	Ext.getCmp("ydxzdh").setValue("C2、C3");
							     }else if(value=="市政用地"){
							     	Ext.getCmp("ydxzdh").setValue("U");
							     }else if(value=="绿化用地"){
							     	Ext.getCmp("ydxzdh").setValue("G2");
							     }else if(value=="中小学用地"){
							     	Ext.getCmp("ydxzdh").setValue("R5");
							     }else if(value=="文化娱乐"){
							     	Ext.getCmp("ydxzdh").setValue("C3");
							     } else if(value=="教育科研"){
							     	Ext.getCmp("ydxzdh").setValue("C6");
							     }else if(value=="商业金融"){
							     	Ext.getCmp("ydxzdh").setValue("C");
							     }else if(value=="代征绿地"){
							     	Ext.getCmp("ydxzdh").setValue("");
							     }else if(value=="代征水域"){
							     	Ext.getCmp("ydxzdh").setValue("");
							     }else{
							     	Ext.getCmp("ydxzdh").setValue("");
							     }	
							  }				                       
						    }                
				    	}]
			    	},{
			    		columnWidth:.5,
	        			layout:'form',
	        			items:[{
		        			xtype: 'textfield',
			                id      : 'ydxzdh',
			                value:'',
			                fieldLabel: '用地性质代号',
			                width :60,
			                disabled:true
			         }] 
			     }] 
           	 },{
	            	layout:'column',
	        		items : [{
		        		columnWidth:.5,
		        		layout:'form',
		        		items:[{
			                xtype: 'numberfield',
			                id      : 'jsydmj',
			                value:'',
			                fieldLabel: '建设用地面积(公顷)',
			                width :60
			             }]
			         },{
			         	columnWidth:.5,
		        		layout:'form',
		        		items:[{
			                xtype: 'numberfield',
			                id   : 'rjl',
			                value:'',
			                fieldLabel: '容积率',
			                width :60
			           }]
			        }]
            	},{
	            	layout:'column',
	        		items : [{
		        		columnWidth:.5,
		        		layout:'form',
		        		items:[{
			                xtype: 'numberfield',
			                id   : 'ghjzgm',
			                value:'',
			                fieldLabel: '规划建筑规模(万㎡)',
			                width :60
		               	}]
		             },{
		             	columnWidth:.5,
		        		layout:'form',
		        		items:[{
			             	xtype: 'numberfield',
			                id   : 'jzkzgd',
			                value:'',
			                fieldLabel: '建筑控制高度(米)',
			                width :60
					    }]
					}]
            	},{
            		layout:'column',
	        		items : [{
		        		columnWidth:.5,
		        		layout:'form',
		        		items:[{
			                xtype: 'textfield',
			                id   : 'jzmd',
			                value:'',
			                fieldLabel: '建筑密度',
			                width :60
			            }]
			         },{
			         	columnWidth:.5,
		        		layout:'form',
		        		items:[{
			                xtype: 'textfield',
			                id   : 'lhl',
			                value:'',
			                fieldLabel: '绿化率',
			                width :60
		            	}]
		            }]
            	},{
            		layout:'column',
	        		items : [{
		        		columnWidth:.5,
		        		layout:'form',
		        		items:[{
		 					xtype: 'numberfield',
			                id      : 'nbzs',
			                value:'',
			                fieldLabel: '南北纵深(米)',
			                width :60
			             }]
			         },{
			         	columnWidth:.5,
		        		layout:'form',
		        		items:[{
		 					xtype: 'numberfield',
			                id      : 'dxmk',
			                value:'',
			                fieldLabel: '东西面宽(米)',
			                width :60
			            }]
			         }]
            	},{
            		layout:'column',
	        		items : [{
		        		columnWidth:.5,
		        		layout:'form',
		        		items:[{
		 					xtype: 'textfield',
			                id      : 'ghsjly',
			                value:'',
			                fieldLabel: '规划数据来源',
			                width :60
			            }]
            		},{
	            		columnWidth:.5,
		        		layout:'form',
		        		items:[{
		 					xtype: 'textfield',
			                id      : 'bz',
			                value:'',
			                fieldLabel: '备注',
			                width :60
			            }]
            		}]
	        }],
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("kgzbmanager/save");
							paneloper.save();
	                	}
	            	},   
	            	{
	                	text   : '取消',
	                	handler: function() {
	            			paneloper.cancel();
	                	}
	            	}
	        ]
	  });	
  		form.render("deal");
  		form.hide();
  		var elements = new Array("qy","dkmc","ydxz","ydxzdh","jsydmj","rjl","ghjzgm","jzkzgd","jzmd","lhl","nbzs","dxmk","ghsjly","bz");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  // })
  </script>
	<body>
		<div id='show' style="overflow-x: hidden; overflow-y: hidden">
			<%=new CBDReportManager().getReport("SWCBR",
							new Object[] { "%%" }, its)%>
		</div>
		<div id="deal" style="position: absolute; left: 5px; top: 5px;"></div>
		<form id="attachfile"
			action="<%=basePath%>service/rest/zrbHandle/update" method="post">
		</form>
	</body>
</html>
