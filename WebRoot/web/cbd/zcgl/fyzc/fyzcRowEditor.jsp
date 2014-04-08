<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.swkgl.Fyzcmanager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "zrbHandle";
String keyIndex = "1";
ITableStyle its = new TableStyleEditRow();
String list = Fyzcmanager.getInstcne().getList();
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
	<script src="web/cbd/zcgl/fyzc/js/fyzcRowEditor.js"></script>
	
	<%@ include file="/base/include/ext.jspf" %>
	
	
	<style type="text/css">
  		table{
		    font-size: 14px;
		    background-color: #A8CEFF;
		    border-color:#000000;
		    /**
		    border-left:1dp #000000 solid;
		    border-top:1dp #000000 solid;
		    **/
		    color:#000000;
		    border-collapse: collapse;
  		}
  		tr{
    		border-width: 0px;
    		text-align:center;
  		}
  		td{
    		text-align:center;
    		border-color:#000000;
		    /**
		    border-bottom:1dp #000000 solid;
		    border-right:1dp #000000 solid;
		    **/
		  }
		.title{
		    font-weight:bold;
		    font-size: 15px;
		    text-align:center;
		    line-height: 30px;
			margin-top: 3px;
		  }
	  	.trtotal{
		  	text-align:center;
		    font-weight:bold;
		    line-height: 30px;
		   }
	  	.trsingle{
		    background-color: #D1E5FB;
		    line-height: 20px;
		    text-align:center;
		   }
	</style>
  </head>
  <script type="text/javascript">
  var form2;
  var form1;
  	var paneloper2 = new Paneloper();
  	 $(document).ready(function () { 
		var width = document.body.clientWidth+10;
		var height = document.body.clientHeight;
       	FixTable("FYZC", 1,3, width, height);
       	buildPanel1();
       	buildPanel2();
    });
  	function buildPanel1(){
	  form2 = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 800,
	  		labelWidth :130,   
	  		labelAlign : "right",
	        url:"",
	        title:"房源资产信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items : [{
	        	layout : 'column',
	        	items : [{
	        		columnWidth:.33,
	        		layout:'form',
	        		items:[
	        		{
		                xtype: 'textfield',
		                id      : 'mc',
		                value:'',
		                fieldLabel: '名称',  
		                width:'100'	
				    }]                
	            },{
	            	columnWidth:.33,
		        	layout:'form',
	            	items:[          		
		        		
		                xtype: 'textfield',
		                id      : 'gzfyly',
		                value:'',
		                fieldLabel: '购置房源套数',  
		                width:'100'              
	            	}]
	            },{
	            	columnWidth:.33,
		        	layout:'form',
	            	items:[          		
		        		{
		                xtype: 'textfield',
		                id      : 'gzfyts',
		                value:'',
		                fieldLabel: '购置房源套数',  
		                width:'100'              
	            	}]
	            },{
	        		columnWidth:.33,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'gzjzgm',
		                value:'',
		                fieldLabel: '购置建筑规模',  
		                width:'100'	            
	            	}]
	            }]
         	},{
	         	layout : 'column',
	        	items : [{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'dycbzj',
		                value:'', 
		                fieldLabel: '动用储备资金',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '购置单价',   
					    id : 'gzdj',   
					    value:'', 
		                width:'100'
					}]
				},{
					columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id      : 'lyfyts',
		                value:'',
		                fieldLabel: '利用房源套数',
		                width:'100'
            		}]
            	}]
			},{
	           	layout:'column',
	           	items:[{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'lyjzgm',
		                value:'',
		                fieldLabel: '利用建筑规模',
		                width:'100'
		            }]
		         },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'fyclts',
		                value:'',
		                fieldLabel: '房源存量套数',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'jzmjcl',
		                value:'',
		                fieldLabel: '建筑面积存量',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'zyzjcl',
		                value:'',
		                fieldLabel: '占用资金存量',
		                width:'100'
	            	}]
	            },{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'ftlx',
		                value:'',
		                fieldLabel: '分摊利息',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'fymc',
		                value:'',
		                fieldLabel: '费用名称',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zje',
		                value:'',
		                fieldLabel: '总金额',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'mpfmft',
		                value:'',
		                fieldLabel: '每平方米分摊',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ylyfyft',
		                value:'',
		                fieldLabel: '已利用房源分摊',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.9,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bz',
		                value:'',
		                fieldLabel: '备注',
		                width:'500'
	            	}]
            	},{
	            	columnWidth:.9,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'yw_guid',
		                value:'',
		                hidden:true,
		                fieldLabel: 'yw_guid',
		                width:'500'
	            	}]
            	}]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper2.setRestUrl("fyzcHandle/addFyzc");
							paneloper2.save();
	                	}
	            	},   
	            	{
	                	text   : '取消',
	                	handler: function() {
	            			paneloper2.cancel();
	                	}
	            	}
	        ]
	  });		
  	}
  	function buildPanel2(){
	  form1 = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 800,
	  		labelWidth :130,   
	  		labelAlign : "right",
	        url:"",
	        title:"房源资产信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items : [{
	        	layout : 'column',
	        	items : [{
	        		columnWidth:.33,
	        		layout:'form',
	        		items:[
	        		{
		                xtype: 'textfield',
		                id      : 'mc',
		                value:'',
		                fieldLabel: '名称',  
		                width:'100'	
				    }]                
	            },{
	            	columnWidth:.33,
		        	layout:'form',
	            	items:[          		
		        		{
		                xtype: 'textfield',
		                id      : 'gzfyts',
		                value:'',
		                fieldLabel: '购置房源套数',  
		                width:'100'              
	            	}]
	            },{
	        		columnWidth:.33,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'gzjzgm',
		                value:'',
		                fieldLabel: '购置建筑规模',  
		                width:'100'	            
	            	}]
	            }]
         	},{
	         	layout : 'column',
	        	items : [{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'dycbzj',
		                value:'', 
		                fieldLabel: '动用储备资金',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '购置单价',   
					    id : 'gzdj',   
					    value:'', 
		                width:'100'
					}]
				},{
					columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id      : 'lyfyts',
		                value:'',
		                fieldLabel: '利用房源套数',
		                width:'100'
            		}]
            	}]
			},{
	           	layout:'column',
	           	items:[{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'lyjzgm',
		                value:'',
		                fieldLabel: '利用建筑规模',
		                width:'100'
		            }]
		         },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'fyclts',
		                value:'',
		                fieldLabel: '房源存量套数',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'jzmjcl',
		                value:'',
		                fieldLabel: '建筑面积存量',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'zyzjcl',
		                value:'',
		                fieldLabel: '占用资金存量',
		                width:'100'
	            	}]
	            },{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'ftlx',
		                value:'',
		                fieldLabel: '分摊利息',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'fymc',
		                value:'',
		                fieldLabel: '费用名称',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zje',
		                value:'',
		                fieldLabel: '总金额',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'mpfmft',
		                value:'',
		                fieldLabel: '每平方米分摊',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ylyfyft',
		                value:'',
		                fieldLabel: '已利用房源分摊',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zjfyft',
		                value:'',
		                fieldLabel: '结转房源分摊',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'fwjkzj',
		                value:'',
		                fieldLabel: '房屋价款总计',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'dqdj',
		                value:'',
		                fieldLabel: '当前单价',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.9,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bz',
		                value:'',
		                fieldLabel: '备注',
		                width:'500'
	            	}]
            	},{
	            	columnWidth:.9,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'yw_guid',
		                value:'',
		                hidden:true,
		                fieldLabel: 'yw_guid',
		                width:'500'
	            	}]
            	}]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	                	}
	            	},   
	            	{
	                	text   : '取消',
	                	handler: function() {
	                	}
	            	}
	        ]
	  });		
  	}
  	var win;
function showWindow() {
	var tabs = new Ext.TabPanel({
				id : 'pan',
				autoTabs : true,
				activeTab : 0,
				height : 400,
				enableTabScroll : true,
				deferredRender : false,
				border : false,
				scrollDuration : 0.35,
				scrollIncrement : 100,
				animScroll : true,
				defaults : {
					autoScroll : true
				}
			});
		tabs.add(form2).show();
		tabs.add(form1).show();
	if (!win) {
		win = new Ext.Window({
					renderTo : Ext.getBody(),
					id:'wind',
					layout : 'fit',
					title:'属性查询',
					width : 450,
					height : 400,
					plain : true,
					closeAction : 'hide',
					items : tabs,
					buttons : [{
								text : '关闭',
								handler : function() {
									win.hide();
								}
							}]
				});
	} else {
		win.items.removeAt(0);		
		win.items.add("pan", tabs);
		win.doLayout();
	}
	win.show();
	
}
  
  </script>
  <body>
  	<div id='show'>
  		<%=list %>
  	</div>
  	<div id="deal2" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
