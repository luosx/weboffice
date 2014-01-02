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
String reportID = "hxxmHandle";
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
	<script src="web/cbd/yzt/hxxm/showRW/js/hxxmRowEditor.js"></script>
	<script src="web/cbd/yzt/hxxm/showRW/js/table.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/web/cbd/yzt/hxxm/showRW/js/reportEdit.jspf"%>
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
  <body>
  	<div id='show'>
  		<%=new CBDReportManager().getReport("HXXM",new Object[]{},its)%>
  	</div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
