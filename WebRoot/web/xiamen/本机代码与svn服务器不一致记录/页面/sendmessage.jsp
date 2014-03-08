<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String roleId = request.getParameter("roleId");
Role roleBean=ManagerFactory.getRoleManager().getRoleWithId(roleId);
if(roleBean==null)
	roleBean=new Role();
String users=ManagerFactory.getUserManager().getSelectUserJsonByRoleId(roleId);
String userInfoArray=ManagerFactory.getUserManager().getUserInfoArrayJsonByRoleId(roleId);
String guid = request.getParameter("guid");
String ydzt = request.getParameter("ydzt");
if(ydzt!=null){
	ydzt = UtilFactory.getStrUtil().unescape(ydzt);
}
String ydwz = request.getParameter("ydwz");
if(ydwz!=null){
	ydwz = UtilFactory.getStrUtil().unescape(ydwz);
}
String zdmj = request.getParameter("zdmj");
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String fullname = ((User)principal).getFullName();
String userId = ((User)principal).getId();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>通知短信</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script src="<%=basePath%>/base/form/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>/base/thirdres/ext/examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=basePath%>/base/thirdres/ext/examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/base/thirdres/ext/examples/ux/css/MultiSelect.css"/>	
   </head>
   <script type="text/javascript">
   		
   		var winForm;
        Ext.onReady(function(){
           var win;
           var f=new Ext.form.FormPanel({
              renderTo: 'container',
              title:"发送短信",
              height: 600,
              width: 800,
              url:'<%=basePath%>/service/rest/messageManager/send?userId=<%=userId%>',
              labelWidth: 80,
              labelAlign: "right",
              buttonAlign:"center",
              frame: true,
              items: [
              {
		            xtype:'fieldset',
		            title: '选择接收人',
		            collapsible: false,
		            autoHeight:true,
		            defaults: {width: 650},
		            items :[{	  
		            		xtype:'textarea',             
		                    fieldLabel: '组织人员',
		                    //emptyText:'请选择人员...',
		                    enableKeyEvents:true,
		                    name: 'users',
		                    id:'users',
							listeners: {
							     'focus': {
							       fn: function(o, evt) {
                       				//弹出选择人员列表窗体
							           if(!win){	           
							           		win = new Ext.Window({
							                layout: 'fit',
							                title: '请选择人员列表',
							                closeAction: 'hide',
							                width:600,
							                height:440,
							                x: 80,
							                y: 110,
							                items:winForm
							            });    
							        }
							        win.show();							       	
							       },scope:this
							     }
							   }

		                },{
		                	xtype:'textarea', 
		                    fieldLabel: '输入手机号',
		                    name: 'phones',
		                    id:'phones'		                    
		                },{
		                	fieldLabel: "备注",
		                	html:'<div style="margin-top:5px;">输入多个手机号码以逗号（英半角）分割，如12345678900,00123456789。</div>'
		                }]
        	  },
              {
		            xtype:'fieldset',
		            title: '消息内容',
		            collapsible: false,
		            autoHeight:true,
		            defaults: {width: 650},
		            items :[{	  
		            		xtype:'textarea',             
		                    fieldLabel: '',
		                    maxLength:2000,
		                    name: 'content',
		                    value:'你好！<%=ydwz%>，发现有违章建筑，违法当事人：<%=ydzt%>，违法面积<%=zdmj%>亩，请尽快处理。'
		                },{
		                	fieldLabel: "备注",
		                	html:'<div style="margin-top:5px;">最大长度为2000个字符。单条短信支持的长度： 移动办公助理为70个字符，硬件Modem与移动网关支持半角140个字符，当包含汉字等双字节字符时为70个字符，外部程序为可控长度，超出部分自动截取为多条短信。</div>'
		                }]
        	  },
        	  {
		            xtype:'fieldset',
		            title: '发送选项',
		            collapsible: false,
		            autoHeight:true,
		            defaults: {width: 650},
		            items :[{
                        xtype: 'compositefield',
                        fieldLabel: '自动署名',
                        combineErrors: false,
                        items: [
                           {
                               xtype: 'checkbox',
                               boxLabel: '', 
                               name:'isauto',
                               id:'isauto',
                               listeners : { 
                               		"check" : function(obj,ischecked){
                               				if(ischecked){
                               					Ext.getCmp('autoname').setValue('<%=fullname%>');
                               				}else{
                               					Ext.getCmp('autoname').setValue('');
                               				}
                               		}
                               }   
                                                           							
                           },{
                           	   xtype: 'textfield',
                           	   width: 630,
                           	   name :'autoname',
                           	   id :'autoname' 
                           }
                        ]
                    },{
                        xtype: 'compositefield',
                        fieldLabel: '定时发送',
                        combineErrors: false,
                        items: [
                           {
                               xtype: 'checkbox',
                               boxLabel: '', 
                               name:'istime',
                               listeners : { 
                               		"check" : function(obj,ischecked){
                               				if(ischecked){
                               					//WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
                               				}else{
                               					document.getElementById('time').value = '';
                               				}
                               		}
                               }                                                           							
                           },{
                           	   html :'<input type="text" id="time" name="time" onClick="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})" style="width:630px;background-image:url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif);background-repeat:no-repeat;background-position:right;">' 
                           }
                        ]
                    }] 
        	  },{
        	  	xtype: 'textfield',
                name:'guid',
                hidden : true,
                value:'<%=guid%>'     	  
        	  },         	  
        	  {
        	  	xtype: 'textfield',
                name:'fullname',
                hidden : true,
                value:'<%=fullname%>'     	  
        	  }
        	  ],
              buttons:[{
                 text:"发送",
                 handler: function(){
                 	var users = Ext.getCmp('users').getValue();
                 	var phones = Ext.getCmp('phones').getValue();
                 	if(users == '' && phones == ''){
                 		Ext.Msg.alert('提示','请选择接收人，选择组织人员或输入手机号码！');
                 		return;
                 	}                	                	
                    f.form.submit({
                       waitTitle:"请稍候",
                       waitMsg:"正在提交表单数据，请稍候",
                       success:function(form,action){ 
				           //if(action.result.msg){
				               Ext.Msg.alert('提示',action.result.msg); 
				           //} 
					   }, 
					   failure:function(){ 
							Ext.Msg.alert('提示','发送失败，请稍后重试或联系管理员。');
					   } 
                    });
                    
                 }
              }]
           });
     //用于多选的用户信息 
	  var leftDs = new Ext.data.ArrayStore({
	       data: <%=userInfoArray%>,
	       fields: ['value','text']
	   	}); 
	  var rightDs = new Ext.data.ArrayStore({ 
	       data:<%=users%>,
	       fields: ['value','text'],
	       sortInfo: {
	           field: 'value',
	           direction: 'ASC'
	       }
	   	}); 
    //window中的formPanel
			winForm = new Ext.form.FormPanel({
		        //title: 'ItemSelector Test',
		        width:600,
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
				        imagePath: '<%=basePath%>/base/thirdres/ext/examples/ux/images/',
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
			            	var var_myData;
			                if(winForm.getForm().isValid()){  
			                	var users = winForm.form.findField('itemselector').getValue();
			                    if(users!=''&& users.substring(0,1)==','){
			                    	users = users.substring(1,users.length);
			                    	var_myData = checkusersmobilephone(users);//验证电话号码是否正确
			                    }
			                    var_myData = var_myData.split("#");
			                    if("的电话号码不对!请提醒他修改！" == var_myData[0]){//没有错误的电话号码
			                    	
			                    }else{
			                    	alert(var_myData[0]);//电话号码错误的提示出来
			                    }
			                    Ext.getCmp('users').setValue(var_myData[1]);//电话号码正确的添加到发送名单中  
			                 }		
						   win.hide();
			              }
			         }]
		       });           
           
           
        });
        
        function findusers(){
        	var keyWord = Ext.getCmp('findusers').getValue();
            putClientCommond("userAction","getUserInfoArrayJsonByRoleId");
            putRestParameter("roleId","<%=roleId%>");
            putRestParameter("keyWord",escape(escape(keyWord)));
            var myData = restRequest(); 	   		
	   		winForm.getForm().findField('itemselector').restore(myData);
        }
        function checkusersmobilephone(users){
        	putClientCommond("messageManager","checkUsersMobilephone");
            putRestParameter("users",escape(escape(users)));
            var myData = restRequest();
            return myData;
        }         
       
  </script>
  <body>
    <div id="container" style="width:100%;height:100%;text-align:left;">
    </div>
  </body>
</html>
