<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>卫片执法检查土地违法案件查处整改情况统计表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>base/form/reportExcel.js"></script>
	<%@ include file="/base/include/ext.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>	
  </head>
  <style type="text/css">
 	body{
  		text-align: center;
  	}
  	#report{
  		font-size: 12px;
  		text-align: center;
  		border-collapse:collapse;
  		border:1px #000 solid;
  	}
  	#report td{
  		border:1px #000 solid;
  	}	
  </style>
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
							name : '厦门市'
						}, {
							name : '同安区'
						}, {
							name : '翔安区'
						}, {
							name : '集美区'
						}, {
							name : '海沧区'
						}, {
							name : '湖里区'
						}, {
							name : '思明区'
						}]
			});

	simple = new Ext.FormPanel({
				renderTo:'updateForm',
				frame : true,
				title : '土地违法整改统计',
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
							width : 100,
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
		<div id="updateForm" align="left" style="width: 100%;"></div>					
		<div id="statis" style="width:100%;text-align:center;"></div>
		<h1>厦门市2012年度卫片执法检查土地违法案件查处整改情况统计表</h1>
		<br>
		<table id="report" border="1" cellpadding="0" cellspacing="0" width="">
			<tr>
				<td rowspan="4" width="50">行政区(镇、街)</td>
				<td rowspan="2" colspan="4" width="200">违法宗数</td>
				<td colspan="6" width="300">已立案宗数</td>
				<td rowspan="3" colspan="2" width="120">非立案处理宗数④</td>
				<td rowspan="3" colspan="2" width="140">履职到位率(②＋④)÷①</td>
				<td rowspan="3" colspan="2" width="140">整改到位率(③＋④)÷①</td>
				<td rowspan="4" width="50">备注</td>
			</tr>
			<tr>
				<td colspan="6" width="300">359</td>
			</tr>			
			<tr>
				<td rowspan="2" width="50">宗数①</td>
				<td rowspan="2" width="50">违法用地面积</td>
				<td rowspan="2" width="50">占用耕地面积</td>
				<td rowspan="2" width="50">占用耕地比例</td>
				<td colspan="2" width="100">未结案宗数</td>
				<td colspan="4" width="200">已结案宗数②</td>
			</tr>
			<tr>
				<td>本月数</td>
				<td>上月数</td>
				<td>本月数</td>
				<td>上月数</td>
				<td>其中已整改到位宗数③</td>
				<td>上月数</td>
				<td>本月数</td>
				<td>上月数</td>
				<td>本月数</td>
				<td>上月数</td>
				<td>本月数</td>
				<td>上月数</td>
			</tr>
		</table>
  </body>
</html>
