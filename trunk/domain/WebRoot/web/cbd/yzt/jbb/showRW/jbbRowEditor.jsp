<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "jbbHandle";
String keyIndex = "0";
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
	<%@ include file="/base/include/ext.jspf" %>
	<script src="web/cbd/yzt/jbb/showRW/js/table.js"></script>
	<script src="web/cbd/yzt/jbb/showRW/js/panel.js"></script>
	<script src="web/cbd/yzt/jbb/showRW/js/jbbRowEditor.js"></script>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="base/include/jquery-1.10.2.js"></script>
	
	<%@ include file="/web/cbd/yzt/jbb/showRW/js/reportEdit.jspf"%>
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
	  		background-color: #C0C0C0;
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
  	var view = "<%=view%>";
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		var width = document.body.clientWidth+10;
		var height = document.body.clientHeight;
       	FixTable("JBB", 1,2, width, height);
       	buildPanel();
	});
	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 700,
	  		labelWidth :110,   
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
		                id      : 'jbdkbh',
		                value:'',
		                readOnly:true,
		                fieldLabel: '基本地块编号',  
		                width:'100'	            
	            	}]
	            },{
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
				}]
			},{
				layout:'column',
				items:[{
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
				},{
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
            	}]
	      	},{
				layout:'column',
				items:[{
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
		                readOnly:true,
		                fieldLabel: '建筑规模',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'kzgd',
		                value:'',
		                fieldLabel: '控制高度',
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
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'szjzgm',
		                value:'',
		                fieldLabel: '市政建筑规模',
		                width:'100'
	            	}]
	            },{
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
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'dmcb',
		                value:'',
		                fieldLabel: '地面成本',
		                width:'100'
	            	}]
	            },{
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
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cxb',
		                value:'',
		                fieldLabel: '存蓄比',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cqqd',
		                value:'',
		                readOnly : true,
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
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'combo',
		                id   : 'ssqy',
		                value:'',
		                store:[[0,"民生改善区"],[1,"城市形象提升区"],[2,"产业功能改造区"],[3,"保留微调区"]],
		                fieldLabel: '所属区域',
		                width:'200'
	            	}]
	            }]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("jbbHandle/modify");
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
  		var elements = new Array("jbdkbh","zzsgm","zzzsgm","zzzshs","hjmj","fzzzsgm","fzzjs","zd",
  		                          "jsyd","rjl","jzgm","kzgd","ghyt","gjjzgm","jzjzgm","szjzgm","kfcb",
  		                          "lmcb","dmcb","yjcjj","yjzftdsy","cxb","cqqd","cbfgl");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  </script>
  <body>
	<div id='show'>
  		<%=new CBDReportManager().getReport("JBB",new Object[]{"true"},its)%>
  	</div>
  	<div id="deal" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
