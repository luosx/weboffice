<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.jcpz.PzManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
      String extPath = basePath + "base/thirdres/ext/";
      PzManager manager=PzManager.getInstens();
      String hsq=manager.getHsq();
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Insert title here</title>
	    <meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
			 <link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/fileuploadfield/css/fileuploadfield.css"/>
			    <script type="text/javascript" src="<%=extPath%>examples/ux/fileuploadfield/FileUploadField.js"></script>
	<style type=text/css>
        .upload-icon {
            background: url('<%=extPath%>examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;
        }
    </style>
			
			<script>
 Ext.onReady(function() {
    Ext.QuickTips.init();
    
    var form = new Ext.form.FormPanel({
        renderTo: 'mapTreeInfo',
        //fileUpload: true,
        autoHeight: true,
        title   : '回收期设置',
        frame:true,
        bodyStyle:'padding:5px 0px 0',
        width: 600,
        url:"<%=basePath%>service/rest/pzmanager/setHsq",
        defaults: {
           anchor: '95%',
            allowBlank: false,
            msgTarget: 'side'
        },
        items   : [
   			{   xtype: 'textfield',
                id      : 'hsq',
                value:'<%=hsq%>',
                fieldLabel: '回收期'
            }
        ],
        buttons: [
            {
                text   : '保存',
                handler: function() {
					form.form.submit(
					{ 
						waitMsg: '正在保存,请稍候... ', 
						params: form.getForm().getFieldValues(),
						success:function(){ 
						Ext.Msg.alert('提示','保存成功。');
						parent.menuTree.location.reload()
						}, 
						failure:function(){ 
						Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
						} 
					});
                }
            },
            {
                text   : '刷新',
                handler: function() {
                   document.location.reload()
                }
            }
        ]
    });
    
});

	</script>
	</head>
	<body bgcolor="#FFFFFF"">
	  <div id="mapTreeInfo" />
	</body>
</html>