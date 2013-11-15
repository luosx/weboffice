<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User) userprincipal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>外业成果导入</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script
			src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css" />

	</head>
	<style type="text/css">
</style>

	<script type="text/javascript">
  
  var form;
  var win;
  Ext.onReady(function(){
  	 form = new Ext.form.FormPanel({  
	  renderTo:'importForm',
	  labelAlign: 'right',    
	  labelWidth: 60,  
	  frame:true,
      url:  "http://" + window.location.href.split("/")[2] + '/domain/service/rest/cgdrManager/uploadResult?userid=<%=userid%>',
	  width: 500, 
	  fileUpload: true,
	  autoHeight: true,
	        bodyStyle: 'padding: 10px 10px 0 10px;',
	        defaults: {
	            anchor: '98%',
	            allowBlank: false,
	            msgTarget: 'side'
	        },  
	
	  items: [{
	            xtype: 'fileuploadfield',
	            emptyText: '请选择zip格式外业成果包..',
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
		var tp ="zip";
		//返回符合条件的后缀名在字符串中的位置
		var rs=tp.indexOf(last); 
		//如果返回的结果大于或等于0，说明包含允许上传的文件类型
		if(rs>=0&&filePath!=""){ 
	      form.getForm().submit({  
	      	waitMsg: '数据处理中...',
	        success: function(form, action){  
	        	 var result = action.result.msg;
	        	 var array = result.split('@');
	             Ext.Msg.alert('提示','文件导入成功！,共导入'+array[0]+'条核查成果！',function(btn){
		             if(array[1].indexOf('XC')!=-1){
				          Ext.MessageBox.confirm('提示','是否填写巡查日志？',function(btn){ 
			              if(btn=='yes'){ 
			              array[1] = array[1].replace(/#/g,'@');
			                 document.location.href='<%=basePath%>web/jizeWW/dtxc/xcrz/xcrz.jsp?simInfo='+array[1];
			              }else{
			              	document.location.href='<%=basePath%>web/jizeWW/dtxc/wyxc/PADDataListTab.jsp';
			              }    
			             }); 
			         }	             	             
	             });  
	        },  
	        failure: function(){  
	           Ext.Msg.alert('错误', '文件导入失败');  
	        }  
	      });
	    }else if(filePath==""){
	    	Ext.Msg.alert('错误', '请选择需要导入的文件！');
	    }
	    else{
	        Ext.Msg.alert('错误', '导入文件类型错误！请选择zip文件,字母小写');  
	    }  
	   }  
	  },{
	            text: '重置',
	            handler: function(){    
	               form.getForm().reset();
	            }
	        }]  
	  }); 
  win = new Ext.Window({
                applyTo:'importWin',
                title:'请选择巡查成果文件',
                width:515,
                resizable:false,
                closable:false,
                closeAction:'hide',
                html:'<div style="font-size:12px;">说明：将由平板导出的巡查成果zip包导入系统中，其中巡查成果zip包中包含每日巡查日志和<br/>外业设备采集的图斑和照片等</div>',
				items:form
    });  
  win.show();
  })
  
   
  
  </script>
	<body>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>
