<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.menu.MenuBean"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "base/thirdres/ext/";
      ProjectInfo project=ProjectInfo.getInstance();
      String loginname1=project.getProjectLoginName1();
      String loginname2=project.getProjectLoginName2();
      Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
      String userId = ((User)principal).getUserID();
  	User user = ManagerFactory.getUserManager().getUserWithId(userId);
  	String username = user.getUsername();
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title></title>

	<style type="text/css">
		.x-fieldset {
			border: 0pxsolid #B5B8C8;
			display: block;
		}
	</style>
	<script src="js/adapter/ext/ext-base.js" type="text/javascript"></script>
	<script src="js/ext-all.js" type="text/javascript"></script>
	<%@ include file="/base/include/ext.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script type="text/javascript">
        Ext.onReady(function(){
            Ext.QuickTips.init();
            new Ext.form.FormPanel({
                title: '系统维护',
                renderTo: 'mapTreeInfo',
                width:'100%',
           
                frame: true,
                bodyStyle: 'padding:0,300,0px',
     	        items: [
                {
                    xtype: 'fieldset',
                    title: '系统名称',    
                    autoWidth: false,
                    labelWidth: 250,
                    labelSeparator: ':',
                    autoHeight: false,
                    defaults: { width: 250,allowBlank: true, xtype: 'textfield', msgTarget: 'side'},
                    labelAlign: 'right',
                    items: [
                       { xtype: 'textfield',id:'ChName', fieldLabel: '系统名称',value:'<%=loginname1%>',allowBlank:false},
                       { xtype: 'textfield',id:'EnName', fieldLabel: '英文名称',value:'<%=loginname2%>',allowBlank:false}
                    ]
                },
                {
                    xtype: 'fieldset',
                    title: '密码修改',
                    autoWidth: false,
                    labelWidth: 250,
                    labelSeparator: ':',
                    autoHeight: true,
                    defaults: { width: 150,allowBlank: false, xtype: 'textfield', msgTarget: 'side'},
                    labelAlign: 'right',
                    items: [
         				{ xtype: 'container',autoEl: {}, layout: 'column', width: 900,items: [
           				{ layout: 'form',border: false, items: [
           					{ xtype: 'textfield',id:'oldpass', inputType:'password',fieldLabel: '旧密码', width: 150,allowBlank:false}
           					]
           				},
           				{ layout: 'form',border: false, items: [
           					{ xtype: 'textfield',id:'newpass', inputType:'password',fieldLabel: '新密码', width: 150,allowBlank:false }
           					]
           				},
           				{ layout: 'form',border: false, items: [
           					{ xtype: 'textfield',id:'validpass', inputType:'password',fieldLabel: '密码确认', width: 150,allowBlank:false }
           					]
           				}]
         			}]
	            }
            ],
            buttons:[{
                 text:"保存",
                 handler: function(){
                      var res=modifyForm();
                      if(res){
                      	
                        putClientCommond("projectInfo","save");
                        putRestParameter("ChName",escape(escape(Ext.getCmp('ChName').getValue())));
                        putRestParameter("EnName",Ext.getCmp('EnName').getValue());
                        var result= restRequest();
                        if(Ext.getCmp('oldpass').getValue()!='' && Ext.getCmp('newpass').getValue()!='' ){
     		
	                        putClientCommond("personInfo","changePwdInfo");
	                        putRestParameter("oldpass",Ext.getCmp('oldpass').getValue());
	                        putRestParameter("newpass",Ext.getCmp('newpass').getValue());
	                        putRestParameter("userName","<%=username%>");
	                        result= restRequest();
     					}
                        alert("保存成功");
                        window.location.reload();
                      }else{
                        alert("保存失败");
                      }
                 }
              }
            ]
        })        
     });
     function modifyForm(){
     	if(Ext.getCmp('ChName').getValue()=='' || Ext.getCmp('ChName').getValue()==''){
     		return false;
     	}
     	if(Ext.getCmp('oldpass').getValue()=='' && Ext.getCmp('newpass').getValue()=='' ){
     		return true;
     	}else 
     	if(Ext.getCmp('oldpass').getValue()=='' ||Ext.getCmp('newpass').getValue()=='' ){
     		return false;
     	}
     	if( Ext.getCmp('newpass').getValue()!= Ext.getCmp('validpass').getValue()){
     		alert("密码不一致");
     		return false;
     	}
     	return true;
     }
    </script>
</head>

<body>

	<div style="width: 100%" id="mapTreeInfo" align="left"/>
</body>
</html>
