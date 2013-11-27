<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>外业成果统计</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>base/form/reportExcel.js"></script>
	<%@ include file="/base/include/ext.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>	
  </head>
  <script type="text/javascript">
  Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	// 问题发生地数据
	var districtStore = new Ext.data.JsonStore({
				fields : ['name'],
				data : [{
							name : '鸡泽县'
						}, {
							name : '鸡泽镇'
						}, {
							name : '小寨镇'
						}, {
							name : '双塔镇'
						}, {
							name : '浮图店乡'
						}, {
							name : '吴官营乡'
						}, {
							name : '风正乡'
						}, {
							name : '曹庄镇'
						}]
			});

	simple = new Ext.FormPanel({
				renderTo:'updateForm',
				frame : true,
				title : '外业成果统计',
				bodyStyle : 'padding:0 0 0 0',
				tbar : [{
							xtype : 'label',
							text : '选择行政区：'
						}, {
							id : 'district',
							xtype : 'combo',
							store : districtStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						}, '-', {
							xtype : 'label',
							text : ' 选择日期：'
						}, {
							id : 'date1',
							xtype : 'datefield',
							format:'y/m/d',
							readonly : true
						}, {
							xtype : 'label',
							text : ' ——'
						}, {
							id : 'date2',
							xtype : 'datefield',
							format:'y/m/d',
							readonly : true
						}, '-', {
							xtype : 'button',
							text : '统计',
							handler : statis
						}, '-', {
						    xtype : 'button',
							text : '导出EXCEL',
							handler : expExcel					
						}]
			});
	//simple.render(document.body);
}

function statis() {
	var c1 = Ext.getCmp("district").getValue();
	var c2 = Ext.getCmp("date1").getRawValue();
	var c3 = Ext.getCmp("date2").getRawValue();
	if(!c1){
		Ext.Msg.alert("提示","请选择行政区！");
		return;
	}
	if(!c2){
		Ext.Msg.alert("提示","请选择开始时间！");
		return;		
	}
	if(!c3){
		Ext.Msg.alert("提示","请选择结束时间！");
		return;	
	}
	if(c2>c3){
		Ext.Msg.alert("提示","开始时间必须小于结束时间！");
		return;	
	}
	putClientCommond("dtxcManager", "staticWycg");
	putRestParameter("xzq", escape(escape(c1)));
	putRestParameter("start", c2);
	putRestParameter("end", c3);
	var result = restRequest();
	
	document.getElementById('statis').innerHTML = result;

}

function expExcel(){
	var excel = new ReportExcel();
	excel.Init();
	excel.setCells(7);
	excel.setRows(100);
	excel.buildTable("title", "1", "1");
	excel.buildTable("report", "2", "1");
	excel.showTable();
}
  </script>
  <body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="updateForm" style="width: 100%;"></div>					
		<div id="statis" style="width:100%;text-align:center;"></div>
  </body>
</html>
