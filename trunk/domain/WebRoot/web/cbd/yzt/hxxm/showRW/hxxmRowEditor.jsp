<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.web.cbd.yzt.jbb.JbbManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Map<String, String> proMap = JbbManager.getDKMCMap();
String extPath = basePath + "base/thirdres/ext/";
String reportID = "HXXM";
String keyIndex = "1";
ITableStyle its = new TableStyleEditRow();
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
	<script src="web/cbd/yzt/hxxm/showRW/js/table.js"></script>
	<script src="web/cbd/yzt/hxxm/showRW/js/panel.js"></script>
	<script src="web/cbd/yzt/hxxm/showRW/js/hxxmRowEditor.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/web/cbd/yzt/hxxm/showRW/js/reportEdit.jspf"%>
	<script src="base/include/jquery-1.10.2.js"></script>
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
		    line-height: 50px;
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
  	var win;
  	var winForm;
  	var table = new tableoper();
	Ext.onReady(function(){
		Ext.QuickTips.init();
    	var leftDs = new Ext.data.ArrayStore({
	       data: <%=proMap.get("left")%>,
	       fields: ['value','text']
	   	}); 
 		var rightDs = new Ext.data.ArrayStore({ 
	       fields: ['value','text'],
	       sortInfo: {
	           field: 'value',
	           direction: 'ASC'
	       }
	  	});
 		
 		winForm = new Ext.form.FormPanel({
	   		bodyStyle: 'padding:10px;',
     		width:500,
        	items:[{
	          	xtype: 'itemselector',
	            name: 'itemselector',
	            imagePath: '<%=extPath%>examples/ux/images/',
	            fieldLabel: '基本地块列表',
	            multiselects:[
	         		{
	                  width: 180,
	                  height: 245,
	                  store: leftDs,
	                  displayField: 'text',
	                  valueField: 'value'
	           		},{
	           		  width: 180,
		              height: 245,
		              store: rightDs,
		              displayField: 'text',
	                  valueField: 'value',	
	                  tbar:[{
	                  		text: '清空已选列表',
	                  		handler:function(){
	                  			winForm.getForm().findField('itemselector').reset();
	                  		}
				      }]
			     	}	
            	]
         }],
       		buttons: [{
       		text: '保存',
       		handler: function(){
       			if(winForm.getForm().isValid()){
       				var itemselector = winForm.form.findField('itemselector').getValue();
       				//将选择的基本地块数据保存到数据库
       				if(obj_id != undefined){
						table.init(document.getElementById("HXXM"));
						var row = obj_id.split("_")[0];
						var cell = obj_id.split("_")[1];
						table.setValue(row, cell, itemselector);
       					var key = document.getElementById(row + "_" + "<%=keyIndex%>");
					    putClientCommond("<%=reportID%>", "update");
					    putRestParameter("key", key.innerText);
					    putRestParameter("vindex", cell);
					    putRestParameter("value", itemselector);
					    restRequest();
       				}
       				win.hide();
       				document.location.reload();
       			}
       		}
       	},{
		        text: '取消',
       		handler: function(){
				win.hide();
       		}
       	}]
	});
 		
   		win = new Ext.Window({
	    layout: 'fit',
	    title: '请选择基本地块',
	    closeAction: 'hide',
	    width:550,
	    height:380,
	    x: 2340,
	    y: 110,
	    items:winForm
		});
})
  
  
  </script>
  <script type="text/javascript">
  	var form;
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		var width = document.body.clientWidth;
		var height = document.body.clientHeight-20;
       	FixTable("HXXM", 2,2, width, height);
       	buildPanel();
	});
	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 800,
	  		labelWidth :130,   
	  		labelAlign : "right",
	        url:"",
	        title:"红线项目信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items : [{
	         	layout : 'column',
	        	items : [{
	        		columnWidth:.33,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'xmmc',
		                value:'',
		                fieldLabel: '项目名称',  
		                width:'100'	            
	            	}]
	            },{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'zd',
		                value:'', 
		                fieldLabel: '占地',
		                width:'100'
		            }]
		         },{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id   : 'jsyd',
		                value:'',  
		                fieldLabel: '建设用地',
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
		                id   : 'rjl',
		                value:'',
		                fieldLabel: '容积率',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'jzgm',
		                value:'',
		                fieldLabel: '建筑规模',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ghyt',
		                value:'',
		                fieldLabel: '规划用途',
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
		                id   : 'gjjzgm',
		                value:'',
		                fieldLabel: '公建建筑规模',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'jzjzgm',
		                value:'',
		                fieldLabel: '居住建筑规模',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'szjzgm',
		                value:'',
		                fieldLabel: '市政建筑规模',
		                width:'100'
	            	}]
	            }]
	        },{	
	        	layout:'column',
				items:[{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '总征收规模',   
					    id : 'zzsgm',   
					    value:'',
					    disabled:true,
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '住宅征收规模',   
					    id : 'zzzsgm',   
					    disabled:true,
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '住宅征收户数',   
					    id : 'zzzshs',
					    disabled:true,   
					    value:'',
		                width:'100'
					}]
				}]
			},{
				layout:'column',
				items:[{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '户均面积',   
					    id : 'hjmj', 
					    disabled:true,  
					    value:'',
		                width:'100'
					}]
				},{
					columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id      : 'fzzzsgm',
		                value:'',
		                disabled:true,
		                fieldLabel: '非住宅征收规模', 
		                width:'100'
            		}]
	      		},{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'fzzjs',
		                value:'', 
		                disabled:true,
		                fieldLabel: '非住宅家数',
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
		                id   : 'kfcb',
		                value:'',
		                fieldLabel: '开发成本',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'lmcb',
		                value:'',
		                fieldLabel: '楼面成本',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'dmcb',
		                value:'',
		                fieldLabel: '地面成本',
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
		                id   : 'yjcjj',
		                value:'',
		                fieldLabel: '预计成交价',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'yjzftdsy',
		                value:'',
		                fieldLabel: '预计政府土地收益',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cxb',
		                value:'',
		                fieldLabel: '存蓄比',
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
		                id   : 'cqqd',
		                value:'',
		                fieldLabel: '拆迁强度',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cbfgl',
		                value:'',
		                fieldLabel: '成本覆盖率',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zzcqfy',
		                value:'',
		                fieldLabel: '住宅拆迁费用',
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
		                id   : 'qycqfy',
		                value:'',
		                fieldLabel: '企业拆迁费用',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'qtfy',
		                value:'',
		                fieldLabel: '其他费用',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'azftzcb',
		                value:'',
		                fieldLabel: '安置房投资成本',
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
		                id   : 'zzhbtzcb',
		                value:'',
		                fieldLabel: '住宅货币投资成本',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cqhbtz',
		                value:'',
		                fieldLabel: '拆迁货币投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'qtfyzb',
		                value:'',
		                fieldLabel: '其他费用占比',
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
		                id   : 'lmcjj',
		                value:'',
		                fieldLabel: '楼面成交价',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'fwsj',
		                value:'',
		                fieldLabel: '房屋售价',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zj',
		                value:'',
		                fieldLabel: '租金',
		                width:'100'
	            	}]
            	}]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("");
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
  		var elements = new Array("xmmc","zd","jsyd","rjl", "jzgm","ghyt", "gjjzgm",
  		     "jzjzgm", "szjzgm", "zzsgm", "zzzsgm", "zzzshs", "hjmj", "fzzzsgm", 
			 "fzzjs", "kfcb", "lmcb", "dmcb","yjcjj","yjzftdsy","cxb",  "cqqd", "cbfgl", 
			 "zzcqfy", "qycqfy", "qtfy", "azftzcb", "zzhbtzcb", "cqhbtz","qtfyzb","lmcjj",
			 "fwsj", "zj");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  </script>
  <body>
  	<div id='show'>
  		<%=new CBDReportManager().getReport("HXXM",new Object[]{},its)%>
  	</div>
  	<div id="deal" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
