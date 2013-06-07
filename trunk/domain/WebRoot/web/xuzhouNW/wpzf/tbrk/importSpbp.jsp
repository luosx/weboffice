<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/label.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>审批报盘导入</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
<%@ include file="/base/include/restRequest.jspf" %>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
<script type="text/javascript">

Ext.onReady(function(){  
   
  var form = new Ext.form.FormPanel({  
  renderTo:'import',
  labelAlign: 'right',  
  title: '卫片批量导入（请导入以ZIP为后缀名的文件）',  
  labelWidth: 60,  
  frame:true,
  url: '<%=basePath%>importSpbp.do?method=uploadFile',
  width: 500,  
  fileUpload: true,
  autoHeight: true,
        bodyStyle: 'padding: 10px 10px 0 10px;',
        labelWidth: 60,
        defaults: {
            anchor: '98%',
            allowBlank: false,
            msgTarget: 'side'
        },  

  items: [{
            xtype: 'fileuploadfield',
            emptyText: '请选择...',
            fieldLabel: '文件路径',
            name: 'file',
            buttonText: '浏览&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
            buttonCfg: {
                iconCls: 'upload-icon'
            }
        }],  
    
  buttons: [{  
  text: '导入',  
  handler: function() {
    var filePath=form.getForm().findField('file').getRawValue();
	//alert(filePath);
	var re = /(\\+)/g;  
	var filename=filePath.replace(re,"#"); 
	//对路径字符串进行剪切截取
    var one=filename.split("#"); 
	//获取数组中最后一个，即文件名
	var two=one[one.length-1]; 
    //再对文件名进行截取，以取得后缀名
	var three=two.split("."); 
	//获取截取的最后一个字符串，即为后缀名
	var last=three[three.length-1];
	//添加需要判断的后缀名类型
	var tp ="ZIP"; 
	//返回符合条件的后缀名在字符串中的位置
	var rs=tp.indexOf(last); 
	//如果返回的结果大于或等于0，说明包含允许上传的文件类型
	if(rs>=0&&filePath!=""){ 
	  alert(rs);  
      form.getForm().submit({  
        success: function(form, action){  
           Ext.Msg.alert('信息', '文件导入成功！');  
        },  
        failure: function(){  
           Ext.Msg.alert('错误', '文件导入失败');  
        }  
      });
    }else if(filePath==""){
    	Ext.Msg.alert('错误', '请选择需要导入的文件！');
    }
    else{
        Ext.Msg.alert('错误', '导入文件类型错误！请选择ZIP文件');  
    }  
   }  
  },{
            text: '重置',
            handler: function(){    
               form.getForm().reset();
            }
        }]  
  });  

  });  

</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<center>
	<font size='2'>
	<br>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;欢迎使用卫片图斑批量导入功能，本平台仅限管理员使用，操作请谨慎。</p>
	<br>
	</font>
        <div id='import' style=" margin-left:50px; width:100px; height:100px;text-align: left;">
        </div>
        </center>
		</body>
</html>