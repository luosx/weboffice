<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.yzt.kgzb.Control"%>
<%@page import="com.klspta.web.cbd.jtfx.scjc.ScjcManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String type=request.getParameter("type");
String reportID = "oldTable";
String keyIndex = "1";
ITableStyle its = new TableStyleEditRow();
String year = Calendar.getInstance().get(Calendar.YEAR)+"";		
String month = Calendar.getInstance().get(Calendar.MONTH)+1+"";
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
	<%@ include file="/web/cbd/qyjc/esfxx/js/reportEdit.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="web/cbd/qyjc/esfzj/js/table.js"></script>
	<script src="web/cbd/qyjc/esfzj/js/panel.js"></script>
	<script src="web/cbd/qyjc/esfzj/js/esfRowEditor.js"></script>
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
  	var form;
  	var view = "<%=view%>";
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		//var width = document.body.clientWidth;
		//var height = document.body.clientHeight * 0.95;
       	//FixTable("ESFQK", 0,1, width-5, height-30);
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
	        title:"二手房详细信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items   : [{
	        	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
			            xtype : 'combo',   
					    fieldLabel : '所属区域',   
					    id : 'ssqy',   
					    store :[[1,'CBD中心区'],[2,'CBD东扩区']],   
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
						xtype : 'combo',   
					    fieldLabel : '小区类型',   
					    id : 'xqlb',   
					    store :[[1,'老旧房'],[2,'新居房']],   
					    width:100,   
					    value:'',   
					    triggerAction: "all",   
					    mode: "local",   
					    allowBlank:false
					}]
				}]
            },{
            	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'xqmc',
		                value:'',
		                fieldLabel: '小区名称',
		                width :100
	                }]	                
            	},{
		            columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'esfzl',
		                value:'',
		                fieldLabel: '二手房总量',
		                width :100
	                }]
            	}]
            },{
            	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'esfjj',
		                value:'',
		                disabled:true,
		                fieldLabel: '二手房均价',
		                width :100
	                }]	                
            	},{
		            columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'esfjjzf',
		                value:'',
		                disabled:true,
		                fieldLabel: '二手房均价涨幅',
		                width :100
	                }]
            	}]
            },{
            	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'czl',
		                value:'',
		                fieldLabel: '出租量',
		                width :100
	                }]	                
            	},{
		            columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'czfjj',
		                value:'',
		                disabled:true,
		                fieldLabel: '出租房均价',
		                width :100
	                }]
            	}]
            },{
            	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'czfjjzf',
		                value:'',
		                disabled:true,
		                fieldLabel: '出租房均价涨幅',
		                width :100
	                }]	                
            	}]
            },{
            	layout : 'column',
	        	items : [{
	        		columnWidth:1,
	        		layout:'form',
	        		items:[{
	 					xtype: 'textarea',
		                id      : 'bz',
		                value:'',
		                fieldLabel: '备注',
		                width :300
	                }]
            	},{
	        		columnWidth:1,
	        		layout:'form',
	        		items:[{
	 					xtype: 'textarea',
		                id      : 'yw_guid',
		                value:'',
		                hidden:true,
		                fieldLabel: '备注',
		                width :300
	                }]
            	}]
            }],
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("scjcManager/save");
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
  		var elements = new Array("ssqy","xqlb","xqmc","esfzl","esfjj","esfjjzf","czl","czfjj","czfjjzf","bz","yw_guid");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  // })
  function hideywguid(){
  		var obj = document.getElementById("ESFQK");
  		var rowlength = obj.rows.length;
  		for(var i=0;i< rowlength;i++){
  			//if(i!=1){
  				obj.rows[i].cells[obj.rows[i].cells.length-1].style.display="none";
  				obj.rows[i].cells[obj.rows[i].cells.length-1].innerText;
  			//}
  		}
  		var width = document.body.clientWidth;
		var height = document.body.clientHeight * 0.95;
       	FixTable("ESFQK", 0,1, width, height);
  	}
  </script>
  <body onload="hideywguid();">
  	<div id="show" style="overflow-x:hidden;overflow-y:hidden">
  	<%=new CBDReportManager().getReport("ESFQK",new Object[] {year,month,"false"},its,"1000px")%>
  	</div>
  	<div id="deal" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
