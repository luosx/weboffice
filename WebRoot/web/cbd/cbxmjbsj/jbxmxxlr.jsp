<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.cbxmjbsj.ProjectManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String extPath = basePath + "base/thirdres/ext/";
String yw_guid = request.getParameter("yw_guid");
ProjectManager projectManager = new ProjectManager();
String selectDkInfo = projectManager.getSelectDkJsonByProjectID(yw_guid);
String notSelectDkInfo = projectManager.getDkInfoArrayJsonByProjectID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>基本项目信息录入</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<%@ include file="/base/include/newformbase.jspf"%>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
	
  </head>
  <script type="text/javascript">
  var win;
  var winForm;
  Ext.onReady(function(){
  	//用于选择基本地块的数据
	var leftDs = new Ext.data.ArrayStore({
		data: <%=notSelectDkInfo%>,
		fields: ['text','value']
	}); 
	var rightDs = new Ext.data.ArrayStore({ 
		data:<%=selectDkInfo%>,
	    fields: ['text','value'],
	    sortInfo: {
	    	field: 'value',
	        direction: 'ASC'
	    }
	});
	 
	winForm = new Ext.form.FormPanel({
		width:600,
		bodyStyle: 'padding:10px;',
		region: 'center',
		items:[
			{
		    	xtype: 'textfield',
		        id: 'xmnametext',
		        value:'',
		        width:250,
		        fieldLabel: '项目名称'
	        },
	        {
				xtype: 'itemselector',
			    name: 'itemselector',
				imagePath: '<%=extPath%>examples/ux/images/',
				fieldLabel: '基本地块列表',
			    multiselects: [{
		        	width: 220,
		            height: 280,
		            store: leftDs,
		            displayField: 'text',
		            valueField: 'value'
			        },{
			        width: 220,
			        height: 280,
			        store: rightDs,
			        displayField: 'text',
		            valueField: 'value',
			        tbar:[{
			        	text: '清空已选基本地块',
			            handler:function(){
				        	winForm.getForm().findField('itemselector').reset();
				        }
			        }]       
			    }]		        
			}
		],	
        buttons: [{
        	text: '保存',
        	handler: function(){
            	if(winForm.getForm().isValid()){
            		savejbdk();
            	}		
	   			win.hide();
            }
        }]
	});
	  	
  	win = new Ext.Window({
  		renderTo: 'jbdkInfo',
    	layout: 'fit',
        title: '请选择基本地块',
        closeAction: 'hide',
        width:600,
        height:440,
        x: 40,
        y: 110,
        items:winForm
  	});
	//ext结束
  });
  
  //弹出添加地块窗口
  function openWinForm(){
  	win.show();
  	var varxmnametext = document.getElementById("xmname").value;
  	Ext.getCmp('xmnametext').setValue(varxmnametext);  
  }
  
  //保存地块
  function savejbdk(){
  	var values = winForm.form.findField('itemselector').getValue();
  	var xmname = document.getElementById("xmname").value;
  	putClientCommond("projectManager","saveProject");
	putRestParameter("yw_guid","<%=yw_guid%>");
	putRestParameter("values",values);
	putRestParameter("xmname",escape(escape(xmname)));
	var varpath = restRequest();
	document.location.href=varpath;
  }
  
  	//保存表单方法
	function save(){
		if(checkNotNull()){
			document.forms[0].submit(); 
		}	
	}
	
	//初始化
	function initXM(){
		init();
	}
	
	//字段非空验证
	function checkNotNull(){
		var reg = new RegExp("^[0-9]+(.[0-9]{2})?$");
		
		var xmname = document.getElementById('xmname').value;
		
		var zd = document.getElementById('zd').value;
		var gm = document.getElementById('gm').value;
		var hs = document.getElementById('hs').value;
		var cb = document.getElementById('cb').value;
		var zzcqfy = document.getElementById('zzcqfy').value;
		var qycqfy = document.getElementById('qycqfy').value;
		var qtfy = document.getElementById('qtfy').value;
		var azftzcb = document.getElementById('azftzcb').value;
		
		if(xmname == ''||zd == ''||gm == ''||hs == ''||cb ==''||zzcqfy == ''||qycqfy ==''||qtfy ==''||azftzcb ==''){
			alert('基本信息字段不能为空');
			return false;
		}else{
			if(!reg.test(zd)||!reg.test(gm)||!reg.test(hs)||!reg.test(cb)||!reg.test(zzcqfy)||!reg.test(qycqfy)||!reg.test(qtfy)||!reg.test(azftzcb)){
				alert('请输入正确格式的数字');
				return false;
			}
		}
		return true;
	}
  </script>
  <style type="text/css">
  	.stytable{
		border-left-color:#000000;
		border-left-style:solid;
		border-left-width:1px;
		border-top-color:#000000;
		border-top-style:solid;
		border-top-width:1px;
	}
	.stytd{
		border-right-color:#000000;
		border-right-style:solid;
		border-right-width:1px;
		border-bottom-color:#000000;
		border-bottom-style:solid;
		border-bottom-width:1px;
		height:38px;
		border-top-width:0px; 
		border-bottom:1px solid #2C2B29; 
		border-left-width:0; 
		border-right:1px solid #2C2B29;
		font-size: 14px;
		FONT-FAMILY:"宋体","Verdana"; 
		vertical-align:middle;		
	}
  </style>
  <body bgcolor="#FFFFFF" style="margin:0 0;padding:0 0;">
  	<div align="left">
  		<img src="base/form/images/save.png" onclick="formSave()" style="cursor:hand" title="保存"/><br/>
  		<img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>
  	</div>
  	<div align="center">
		<h1>
			储备项目基础数据登记表
		</h1>
	</div>
	<form method="post">
		<table cellpadding="0" cellspacing="0" align="center" class="stytable">
			<tr>
				<td class="stytd">
					<label>&nbsp;项目名称</label>
				</td>
				<td width="200" class="stytd">
					<input type="text" id="xmname" name="xmname" >
				</td>
				<td class="stytd">
					<label>&nbsp;包含地块</label>
				</td>
				<td width="200" class="stytd">
					&nbsp;<input type="button" onclick="openWinForm()" value="添加地块">
				</td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;占地（公顷）</label></td>
				<td class="stytd"><input type="text" id="zd" name="zd"></td>
				<td class="stytd"><label>&nbsp;规模（万㎡）</label></td>
				<td class="stytd"><input type="text" id="gm" name="gm"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;户数（户）</label></td>
				<td class="stytd"><input type="text" id="hs" name="hs"></td>
				<td class="stytd"><label>&nbsp;成本（亿元）</label></td>
				<td class="stytd"><input type="text" id="cb" name="cb"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;住宅拆迁费用（亿元）</label></td>
				<td class="stytd"><input type="text" id="zzcqfy" name="zzcqfy"></td>
				<td class="stytd"><label>&nbsp;企业拆迁费用（亿元）</label></td>
				<td class="stytd"><input type="text" id="qycqfy" name="qycqfy"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;其他费用（亿元）</label></td>
				<td class="stytd"><input type="text" id="qtfy" name="qtfy"></td>
				<td class="stytd"><label>&nbsp;安置房投资成本（亿元）</label></td>
				<td class="stytd"><input type="text" id="azftzcb" name="azftzcb"></td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;住宅货币投资成本（亿元）</label></td>
				<td class="stytd"><input type="text" id="zzhbtzcb" name="zzhbtzcb"></td> 
				<td class="stytd"><label>&nbsp;拆迁货币投资（亿元）</label></td>
				<td class="stytd"><input type="text" id="cqhbtz" name="cqhbtz"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;其他费用占比</label></td>
				<td class="stytd"><input type="text" id="qtfyzb" name="qtfyzb"></td>
				<td class="stytd"><label>&nbsp;楼面成本（万元/㎡）</label></td>
				<td class="stytd"><input type="text" id="lmcb" name="lmcb"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;楼面成交价（万元/㎡）</label></td>
				<td class="stytd"><input type="text" id="lmcjj" name="lmcjj"></td>
				<td class="stytd"><label>&nbsp;房屋售价（万元/㎡）</label></td>
				<td class="stytd"><input type="text" id="fwsj" name="fwsj"></td>
			</tr>
			
			<tr>
				<td class="stytd"><label>&nbsp;租金（元/㎡/天）</label></td>
				<td class="stytd"><input type="text" id="zj" name="zj"></td>
				<td class="stytd"><label>&nbsp;评估土地价值</label></td>
				<td class="stytd"><input type="text" id="pgtdjz" name="pgtdjz"></td>
			</tr>
			<tr>
				<td class="stytd"><label>&nbsp;抵押率</label></td>
				<td class="stytd"><input type="text" id="tyl" name="tyl"></td>
				<td class="stytd"><label>&nbsp;融资损失&nbsp;</label></td>
				<td class="stytd"><input type="text" id="rzss" name="rzss"></td>
			</tr>
		</table>
	</form>
	<div id="jbdkInfo" />
  </body>
  <script type="text/javascript">
  	document.body.onload = initXM;
  </script>
</html>