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
	<%@ include file="/web/cbd/yzt/zrb/showRW/js/reportEdit.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="web/cbd/yzt/zrb/showRW/js/table.js"></script>
	<script src="web/cbd/yzt/zrb/showRW/js/panel.js"></script>
	<script src="web/cbd/yzt/zrb/showRW/js/zrbRowEditor.js"></script>
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
		var width = document.body.clientWidth;
		var height = document.body.clientHeight * 0.82;
       	FixTable("ZRB", 1,2, width, height);
       	buildPanel();
    });
  //	Ext.onReady(function(){
  		//Ext.QuickTips.init();
  	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 400,
	  		labelWidth :115,   
	  		labelAlign : "right",
	        url:"",
	        title:"自然斑详细信息",
	        defaults: {
	            anchor: '0'
	        },
	        items   : [
	        	{
 					xtype: 'hidden',
	                id      : 'yw_guid',
	                value:'',
	                fieldLabel: '主键',
	                width :60
            	}
	        	,{
	                xtype: 'textfield',
	                id      : 'zrbbh',
	                value:'',
	                fieldLabel: '自然斑编号',
	                width :60
            	},{
		            xtype: 'numberfield',
	                id      : 'zdmj',
	                value:'',
	                fieldLabel: '占地面积',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id      : 'lzmj',
	                value:'',
	                fieldLabel: '楼座面积(合计)',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id      : 'cqgm',
	                value:'',
	                fieldLabel: '拆迁规模(合计)',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id   : 'zzlzmj',
	                value:'',
	                fieldLabel: '楼座面积(住宅)',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id   : 'zzcqgm',
	                value:'',
	                fieldLabel: '拆迁规模(住宅)',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id   : 'yjhs',
	                value:'',
	                fieldLabel: '预计户数',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id   : 'fzzlzmj',
	                value:'',
	                fieldLabel: '楼座面积(非住宅)',
	                width :60
            	},{
	                xtype: 'numberfield',
	                id   : 'fzzcqgm',
	                value:'',
	                fieldLabel: '拆迁规模(非住宅)',
	                width :60
            	},{
 					xtype: 'textfield',
	                id      : 'bz',
	                value:'',
	                fieldLabel: '备注',
	                width :60
            	}
	        ],
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("zrbHandle/setZrb");
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
  		//form.hide();
  		var elements = new Array("yw_guid","zrbbh","zdmj","lzmj","cqgm","zzlzmj","zzcqgm","yjhs","fzzlzmj","fzzcqgm","bz");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  // })
  </script>
  <body>
  	<div id='show' style="overflow-x:hidden;overflow-y:hidden">
  		<%=new CBDReportManager().getReport("ZRB",new Object[]{"false"},its)%>
  	</div>
  	<div id="deal" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
