<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>计划制定项目选择页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  <script type="text/javascript"> 
  	Ext.onReady(function(){
			winForm = new Ext.form.FormPanel({
		        //title: 'ItemSelector Test',
		        width:600,
		        //url:"<%=basePath%>formOperationAC.do?method=",
		        bodyStyle: 'padding:10px;',
		        region: 'center',//定位
		        items:[
			        {
		                xtype: 'textfield',
		                id: 'findusers',
		                value:'',
		                emptyText:'利用username(用户名)首字母快速查询',
		                maxLength:1,
		                maxLengthText: '只能输入一个字符',
		                width:250,
		                fieldLabel: '快速查找',
		                enableKeyEvents : true,
		                listeners:{
		                		'keyup':findusers
                       	}             
	            	},
		       		 //多选
		        	{
			            xtype: 'itemselector',
			            name: 'itemselector',
				        imagePath: '<%=extPath%>examples/ux/images/',
				        fieldLabel: '人员列表',
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
			                 text: '清空已选人员',
			                 handler:function(){
				             winForm.getForm().findField('itemselector').reset();
				            }
			              }]       
			            }]		        
		        	 }],	
			          buttons: [{
			            text: '保存',
			            handler: function(){
			                if(winForm.getForm().isValid()){  
			                    Ext.getCmp('personName').setValue(winForm.form.findField('itemselector').getValue());  
			                 }		
						   win.hide();
			              }
			         }]
		       });
		       
        });
	})
  
  
  </script>
  
  <body>
  	<div id="choseYear" align="center">
		<label >请选择计划制定年度:</label>
		<select id="beginYear">
			<option value="2012">2012</option>
			<option value="2013">2013</option>
			<option value="2014">2014</option>
		
		</select>&nbsp;
		<label>----</label>
		<select id="endYear">
			<option value="2012">2012</option>
			<option value="2013">2013</option>
			<option value="2014">2014</option>

		</select>
	</div>
	<div id="choseXmmc">
		
	</div>
    
  </body>
</html>
