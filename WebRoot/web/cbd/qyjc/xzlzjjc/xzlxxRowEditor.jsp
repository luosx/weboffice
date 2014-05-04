<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "zrbHandle";
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
	<%@ include file="/web/cbd/qyjc/xzlzjjc/js/reportEdit.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="web/cbd/qyjc/xzlzjjc/js/table.js"></script>
	<script src="web/cbd/qyjc/xzlzjjc/js/panel.js"></script>
	<script src="web/cbd/qyjc/xzlzjjc/js/xzlxxRowEditor.js"></script>
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
  	var view = "<%=view%>";
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 

       	buildPanel();
    });
  //	Ext.onReady(function(){
  		//Ext.QuickTips.init();
  	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 650,
	  		labelWidth :100,   
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
		                id      : 'bh',
		                value:'',
		                fieldLabel: '编号',  
		                width:'100'	            
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '写字楼名称',   
					    id : 'xzlmc',   
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '开发商',   
					    id : 'kfs',   
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
					    fieldLabel : '物业公司',   
					    id : 'wygs',   
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '投资方',   
					    id : 'tzf',   
					    value:'',
		                width:'100'
					}]
				},{
					columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id      : 'sq',
		                value:'',
		                fieldLabel: '商圈', 
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
		                id   : 'cpdw',
		                value:'', 
		                fieldLabel: '产品定位',
		                width:'100'
		            }]
		         },{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'cplx',
		                value:'', 
		                fieldLabel: '产品类型',
		                width:'100'
		            }]
		         },{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'cylx',
		                value:'',  
		                fieldLabel: '产业类型',
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
		                id   : 'rzqy',
		                value:'',
		                fieldLabel: '入住企业',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'kpsj',
		                value:'',
		                fieldLabel: '开盘时间',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ysxkz',
		                value:'',
		                fieldLabel: '预售许可证',
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
		                id   : 'cbcs',
		                value:'',
		                fieldLabel: '成本测算',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'lc',
		                value:'',
		                fieldLabel: '楼层',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bzcg',
		                value:'',
		                fieldLabel: '标准层高(米)',
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
		                id   : 'wq',
		                value:'',
		                fieldLabel: '外墙',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cn',
		                value:'',
		                fieldLabel: '采暖',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'gd',
		                value:'',
		                fieldLabel: '供电',
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
		                id   : 'gs',
		                value:'',
		                fieldLabel: '供水',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'dt',
		                value:'',
		                fieldLabel: '电梯',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'gdcw',
		                value:'',
		                fieldLabel: '固定车位(个)',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'tcwzj',
		                value:'',
		                fieldLabel: '停车位租价',
		                width:'200'
	            	}]
	            },{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'syl',
		                value:'',
		                fieldLabel: '使用率',
		                width:'200'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:0.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'qt',
		                value:'',
		                fieldLabel: '其他',
		                width:'200'
	            	}]
	            },{
					columnWidth:0.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'url',
		                value:'',
		                fieldLabel: '超链接',
		                width:'200'
	            	}]
	            }]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("qyjcManager/saveZJXX");
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
  		var elements = new Array("bh","xzlmc","kfs","wygs","tzf","sq","cpdw","cplx","cylx","rzqy","kpsj",
  		"ysxkz","cbcs","lc","bzcg","wq","cn","gd","gs","dt","gdcw","tcwzj","syl","qt","url");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  	function hideywguid(){
	 		var obj = document.getElementById("XZLXX");
	  		var rowlength = obj.rows.length;
	  		for(var i=0;i< rowlength;i++){
	  			obj.rows[i].cells[obj.rows[i].cells.length-1].style.display="none";
	  		}
			var width = document.body.clientWidth-5;
			var height = document.body.clientHeight * 0.9;
       		FixTable("XZLXX", 2,2, width, height);
	  	}
  // })
  </script>
  <body onload="hideywguid();">
  	<div id='show'>
  		<%=new CBDReportManager().getReport("XZLXX",new Object[]{"%%"},its)%>
  	</div>
  	<div id="deal" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
