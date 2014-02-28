<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.swkgl.AzfzcManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "AZFZC";
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
	<%@ include file="/base/include/reportEdit.jspf"%>
	<script src="web/cbd/zcgl/azfzcgl/js/table.js"></script>
	<script src="web/cbd/zcgl/azfzcgl/js/panel.js"></script>
	<script src="base/include/jquery-1.10.2.js"></script>
	<%@ include file="/base/include/restRequest.jspf"%>	
	<script src="web/cbd/zcgl/azfzcgl/js/azfRowEditor.js"></script>
	
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
  	var form;
  	var form2;
  	var paneloper2 = new Paneloper();
  	 $(document).ready(function () { 
		var width = document.body.clientWidth+10;
		var height = document.body.clientHeight;
       	FixTable("AZFZC", 2,1, width, height);
       	buildPanel();
    });
  	function buildPanel(){
	  form2 = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 800,
	  		labelWidth :130,   
	  		labelAlign : "right",
	        url:"",
	        title:"土地资产信息",
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
		                id      : 'ydmc',
		                value:'',
		                fieldLabel: '用地名称',  
		                width:'100'	            
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '土地一级开发成本',   
					    id : 'tdyjkfzt',   
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '占地面积',   
					    id : 'zdmj',   
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
					    fieldLabel : '建设用地',   
					    id : 'jsyd',   
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '规划容积率',   
					    id : 'ghrjl',   
					    value:'',
		                width:'100'
					}]
				},{
					columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id      : 'ghjzgm',
		                value:'',
		                fieldLabel: '规划建筑规模', 
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
		                id   : 'ghyt',
		                value:'', 
		                fieldLabel: '规划用途',
		                width:'100'
		            }]
		         },{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'kg',
		                value:'', 
		                fieldLabel: '控高',
		                width:'100'
		            }]
		         },{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id   : 'tdcb',
		                value:'',  
		                fieldLabel: '土地成本',
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
		                id   : 'yjkxcazfts',
		                value:'',
		                fieldLabel: '预计可形成安置房套数',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'gdfs',
		                value:'',
		                fieldLabel: '供地方式',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'tdkfjsbcxy',
		                value:'',
		                fieldLabel: '土地开发建设补偿协议',
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
		                id   : 'tdyj',
		                value:'',
		                fieldLabel: '土地移交',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'azfjsdw',
		                value:'',
		                fieldLabel: '安置房建设单位',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'tdcrht',
		                value:'',
		                fieldLabel: '土地出让合同',
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
		                id   : 'crhtydkgsj',
		                value:'',
		                fieldLabel: '出让合同约定开工时间',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'tdz',
		                value:'',
		                fieldLabel: '土地证',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bz',
		                value:'',
		                fieldLabel: '备注',
		                width:'100'
	            	}]
            	}]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper2.setRestUrl("zafzc/addAZFzc");
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
  		form2.render("deal2");
  		form2.hide();
  		var elements2 = new Array("ydmc","tdyjkfzt","zdmj","jsyd","ghrjl","ghjzgm","ghyt","kg","tdcb","yjkxcazfts","gdfs",
  		"tdkfjsbcxy","tdyj","azfjsdw","tdcrht","crhtydkgsj","tdz","bz");
  		paneloper2.init(form2,elements2);
  		paneloper2.hide();
  	}
  // })
  </script>
  <body>
  	<div id='show'>
  		<%=new CBDReportManager().getReport("AZFZC",new Object[]{"%%"},its)%>
  	</div>
  	<div id="deal2" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
