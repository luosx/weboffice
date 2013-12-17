<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
	<script type="text/javascript">
        Ext.onReady(function(){
            Ext.QuickTips.init();
            new Ext.form.FormPanel({
                title: '系统维护',
                renderTo: 'mapTreeInfo',
                autoWidth: true,
               	autoHeight: true,
                frame: true,
                bodyStyle: 'padding:20px',
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
                       { xtype: 'textfield', fieldLabel: '系统名称'},
                       { xtype: 'textfield', fieldLabel: '英文名称'}
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
           					{ xtype: 'textfield', inputType:'password',fieldLabel: '旧密码', width: 150}
           					]
           				},
           				{ layout: 'form',border: false, items: [
           					{ xtype: 'textfield', inputType:'password',fieldLabel: '新密码', width: 150 }
           					]
           				},
           				{ layout: 'form',border: false, items: [
           					{ xtype: 'textfield', inputType:'password',fieldLabel: '密码确认', width: 150 }
           					]
           				}]
         			}]
	            },
	            {
                    xtype: 'fieldset',
                    title: '其他参数',
                    autoWidth: true,
                    labelWidth: 250,
                    labelSeparator: ':',
                    autoHeight: true,
                    defaults: { width: 250,allowBlank: true, xtype: 'textfield', msgTarget: 'side'},
                    labelAlign: 'right',
                    items: [
                       { xtype: 'textfield', fieldLabel: '回收期'}
                    ]
                }
            ],
            buttons:[{
                 text:"保存",
                 handler: function(){
                      var res=modifyForm();
                      if(res){
                        putClientCommond("jzmjbbdfx","setValue");
                        putRestParameter("json",json);
                        var result= restRequest();
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
    </script>



</head>

<body>

	<div id="mapTreeInfo" align="left"/>
</body>
</html>
