<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "tdzcglManager";
String keyIndex = "0";
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
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/base/include/reportEdit.jspf"%>
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
  	//

  	function addRow(){
  		var xmarray = new Array();
  		putClientCommond("hxxmHandle","getHxxmmc");
		var hxxmmc = restRequest();
		if(xmarray.length>0){
			xmarray=[];
		}
		for(var i=0;i<hxxmmc.length;i++ ){
			xmarray.push(hxxmmc[i].XMNAME);
		}
		xmmc.store.loadData(xmarray);
  		
		var dkarray = new Array();
  		putClientCommond("hxxmHandle","getdkmc");
		hxxmmc = restRequest();
		if(dkarray.length>0){
			dkarray=[];
		}
		for(var i=0;i<hxxmmc.length;i++ ){
			dkarray.push(hxxmmc[i].DKMC);
		}
		dkmc.store.loadData(dkarray);
  		
		var form = document.getElementById("fi-form");
		var display = form.style.display;
		if(display == "none"){
			form.style.display = "";
		}else{
			form.style.display = "none";
		}
		
  	}
  	
  	function init(){
  		  		 xmmc = new Ext.form.ComboBox({
	 	      fieldLabel: '项目名称',
	 	     	id:'xmmc',
				store : ["核心区一期"],
				width : 150,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "-请选择项目名称-",
				selectOnFocus : true
			});
  		 dkmc = new Ext.form.ComboBox({
	 	      fieldLabel: '地块名称',
	 	     	id:'dkmc',
				store : ["NW01","NW02","NW03"],
				width : 150,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "-请选择地块名称-",
				selectOnFocus : true
			});
  		var status = new Ext.form.ComboBox({
	 	      fieldLabel: '状态',
	 	     	id:'zt',
				store : ["已出库","待清理","未受偿","未供地","长期库存","已出让但未入库项目"],
				width : 150,
				displayField : 'state',
				typeAhead : true,
				mode : 'local',
				forceSelection : true,
				triggerAction : 'all',
				emptyText : "-请选择状态-",
				selectOnFocus : true
			});
	var fp = new Ext.FormPanel({
		renderTo: 'fi-form',
        fileUpload: true,
        width: 300,
        frame: true,
        title: '添加地块',
        autoHeight: true,
        bodyStyle: 'padding: 10px 10px 0 10px;',
        labelWidth: 70,
        defaults: {
            anchor: '95%',
            allowBlank: false,
            msgTarget: 'side'
        },
		items: [
			xmmc, dkmc, status],
        buttons: [{
            text: '保存',
            handler: function(){
				var xmmc = Ext.getCmp('xmmc').getValue();
				var dkmc = Ext.getCmp('dkmc').getValue();
				var status = Ext.getCmp('zt').getValue();
                if(fp.getForm().isValid()){
	                fp.getForm().submit({
	                    url: "<%=basePath%>service/rest/tdzcglManager/add?xmmc="+xmmc+"&dkmc=" + dkmc + "&status=" + status,
	                    waitMsg: '地块正在导入...',
	                    success: function(fp, o){
	                        //msg('Success', 'Processed file "'+o.result.file+'" on the server');
	                    	document.getElementById("fi-form").style.display = "none";
	                    	alert("导入成功");
	                    	//fp.getForm().reset();
	                    	document.location.reload();
	                	}
	                });
                }
            }
        },{
            text: '取消',
            handler: function(){
                document.getElementById("fi-form").style.display = "none";
                //fp.getForm().reset();
            }
        }]
	});
  	}
  
  </script>
  <body onload="init();return false;" style="overflow-y:hidden">
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
  		&nbsp;
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="print();"  />&nbsp;&nbsp;&nbsp;
		<img src="base/form/images/add.png" width="20px" height="20px" title="添加新写字楼信息" onClick="addRow();"  />&nbsp;&nbsp;&nbsp;
	</div>
	<div id="fi-form" style="position:absolute; left:200px; top:200px; width:200px; height:100px; background:#FFFFFF; display:none;" ></div>
  	<div id='show'>
  		<%=new CBDReportManager().getReport("TDZCGL",its)%>
  	</div>
  </body>
</html>
