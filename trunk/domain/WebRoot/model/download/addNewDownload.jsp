<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="java.rmi.server.UID"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.model.download.GetDownloadInfoList"%>
<%@page import="com.klspta.model.download.DownloadInfoBean"%>
<%@page import="com.klspta.model.download.GetDownloadQueryResult"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String fullName = "";
    if (principal instanceof User) {
        fullName = ((User) principal).getFullName();
    } else {
        fullName = principal.toString();
    }
    String ywid = request.getParameter("ywid");
    String flag = request.getParameter("flag");
    GetDownloadInfoList gdil = new GetDownloadInfoList();
    DownloadInfoBean dib = gdil.getOneDownloadInfo(ywid);
    GetDownloadQueryResult gdqr = new GetDownloadQueryResult();
    String sectionList = gdqr.getSectionList();
    String title = "";
    String people = "";
    String section = "";
    String date = "";
    String content = "";
    String type = "";
    if (dib != null) {
        title = dib.getTitle();
        people = dib.getPeople();
        section = dib.getSection();
        date = dib.getDate();
        content = dib.getContent();
        type = dib.getType();
    }
  if (people.equals("")) {
        people = fullName;
    }
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Date curDate = new Date(System.currentTimeMillis());//获取当前时间     
    String str = formatter.format(curDate);
    if (date.equals("")) {
        date = str;
    }
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
		<%@ include file="/base/include/ext.jspf"%>
		<script
			src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css" />
	</head>


	<script type="text/javascript">
var id;
//生成唯一识别码
id = "<%=new UID().toString().replaceAll(":", "-")%>";
if("<%=ywid%>"!="null"){
	id = "<%=ywid%>"
}
var MyForm;
var dialog;
var button;
var fp
Ext.onReady(function(){
	fp = new Ext.FormPanel({
        fileUpload: true,
        width: 500,
        frame: true,
        applyTo: 'import',
        autoHeight: true,
        labelWidth: 60,
        defaults: {
            allowBlank: false,
            msgTarget: 'side'
        },
        items: [{
        	xtype: 'compositefield',
			items: [{
				xtype: 'fileuploadfield',
				width: 300,
				id:'filePath',
				emptyText: '请选择...',
				fieldLabel: '文件路径',
				buttonText: '浏览'
        	},{xtype:'button',
				text: '导入',
				width: 80,
				handler: function(){  
					fp.getForm().submit({
						url: '<%=basePath%>service/rest/accessac/uploadFile?ywid='+id,
						waitMsg: '上传并处理数据...',
						success: function(){
							document.frames('ifr').location.reload();
						},
						failure: function(form, action){   
 							Ext.Msg.alert('错误',action.result.msg);   
						}
					 });              
				 }
       		}]
       }]	
    });	


 MyForm=new Ext.form.FormPanel({
	title:"新增下载项目",
	labelAlign:"left",
	renderTo: 'formDiv',
    autoHeight: true,
	width:700,
	url:"<%=basePath%>service/rest/saveForm/saveForm?flag=<%=flag%>",
	bodyStyle: 'padding: 10px',
	defaults: {
    	anchor: '-50'
    },
	items:[{
            xtype: 'textfield',
            id: 'KC02',
            value: '<%=title%>',
            fieldLabel: '标题',
            allowBlank: false,
            blankText: '标题不能为空'
        },{
    		xtype     : 'hidden',
        	id: 'ywid',
        	name: 'ywid',
        	value: id
    	},{
    		xtype     : 'textfield',
        	id: 'KC03',
        	value:'<%=people%>',
        	anchor: '-400',
        	readOnly: true,
        	fieldLabel: '发布人'
    	},{
            xtype: 'combo',
            id: 'KC06',
            mode: 'local',
            triggerAction: 'all',
            forceSelection: true,
            fieldLabel: '发布部门',
            hiddenName: 'section',
            allowBlank: false,
            blankText: '请选择类型',
            emptyText: '请选择',
            anchor: '-400',
            displayField: 'text',
            valueField: 'value',
            value: '<%=section%>',
            store: new Ext.data.JsonStore({
            	fields : ['text', 'value'],
            	data   : [<%=sectionList%>]
            })
        },{
            xtype: 'combo',
            id: 'KC05',
            mode: 'local',
            triggerAction: 'all',
            forceSelection: true,
            fieldLabel: '类型',
            hiddenName: 'type',
            allowBlank: false,
            blankText: '请选择类型',
            emptyText: '请选择',
            anchor: '-400',
            displayField: 'text',
            valueField: 'value',
            value: '<%=type%>',
            store: new Ext.data.JsonStore({
            	fields : ['text', 'value'],
            	data   : [<%=UtilFactory.getXzqhUtil().getPublicCode("DOWNLOADTYPE")%>]
            })
        },{
                xtype     : 'datefield',
                id: 'KC04',
                value:'',
                anchor: '-400',
                format:'Y-m-d',
                value: '<%=date%>',
                fieldLabel: '发布时间'
        },{
        	xtype: 'htmleditor',
        	labelAlign: 'top',
        	fieldLabel: '详细内容',
        	id: 'KC07',
        	value: "<%=content%>",
        	anchor: '98%'
        },fp],
	html: "<iframe id='ifr' name='ifr' width=100% height=100% frameborder=0 scrolling='no' src='model/download/accessory_list.jsp?ywid="+id+"'></iframe>",
	buttons: [{
	    	text   : '保存',
	   		handler: function() {
			MyForm.form.submit({ 
				waitMsg: '正在保存,请稍候... ', 
				success: function(){
					Ext.Msg.alert('提示','保存成功。');
					document.frames('ifr').location.reload();
					window.opener.location.href = window.opener.location.href;
				},
				failure: function(form, action){   
	 				Ext.Msg.alert('错误',"保存失败，请检查所填项是否都已完成");   
				} 
				});
			}
		},{
       		text   : '刷新',
            handler: function() {
            	document.location.reload()
            }
        }]
	})
});

</script>
	<body body style="background-color: #FFFFFF">
		<div id="formDiv"></div>
		<div id="import"></div>
	</body>
</html>