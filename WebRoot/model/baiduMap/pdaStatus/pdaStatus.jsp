<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>PDA位置跟踪</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
		<style>		
		html,body {
			font: normal 12px verdana;
			margin: 0;
			padding: 0;
			border: 0 none;
			overflow: hidden;
			height: 100%;
		}
	</style>
<script type="text/javascript">
var WshShell=new ActiveXObject("WScript.Shell");  
var noteBookName=WshShell.ExpandEnvironmentStrings("%COMPUTERNAME%");  

Ext.onReady(function(){

	border =new Ext.Viewport( 
		{
		layout:"border",
		items:[
			    center =    new Ext.Panel({ 
                region: 'center', // a center region is ALWAYS required for border layout
                contentEl: 'center',
                collapsible: false,
                    margins:'0 0 0 0'
            }),
			{
                    region:'east',
                    contentEl: 'mapTree',
                    split:true,
                    width: 270,
                    minSize: 0,
                    maxSize: 300,
                    collapsible: true,
                    collapsed:false,
                    margins:'0 0 0 0'
                }
			  ]
		}
	);
}
);
/**
 * 在center区域生成新的tab
 * 
 */
function addTab(id, title, url_center,url_east) {  
	// 先判断是否已经创建，如果已经创建则active add by guorp 2011-2-16
	var newPanel = parent.center_tabs.getItem(id);	
	var id = id;
	var title = title; 
	var num = 0;
	var url_east = url_east; 
	if (typeof(newPanel) == 'undefined') {
		var ifr = parent.document.createElement("IFRAME");
		parent.document.body.appendChild(ifr);
		ifr.height = '100%';
		ifr.width = '100%';
		ifr.src = url_center; 
		ifr.id = id + "_ifr";
		parent.center_tabs.add({
					id : id,
					contentEl : id + '_ifr',
					title : title,
					iconCls : 'tabs',
					closable : true,
					listeners:{ 
							 'activate':function(){
											//判断：如果子选项卡和east相关联，则每次点击选项卡时，east自动展开      
											if(url_east != "")  { 
					                              parent.Ext.getCmp("east-panel").expand(true); 					                              
					                              if(parent.Ext.get("east").dom.src != url_east){ 
					                              		parent.Ext.getCmp('east-panel').setTitle(title);     
					                              		parent.Ext.get("east").dom.src =  url_east;   
					                              }        					                                                        		       									      
							                }else{   
							                      parent.Ext.getCmp("east-panel").collapse(false);
							                } 
							}
                	}
				}).show();

	} else {
		parent.center_tabs.activate(newPanel);
	}

}
</script>
  </head>
		<body>
		<iframe id="mapTree"  name="mapTree"  style="width: 100%; height: 100%;overflow: auto;"
			src="<%=basePath%>/model/baiduMap/pdaStatus/statusTab.jsp"></iframe> 
	 	<iframe id="center" name="center"  style="width: 100%; height: 100%;overflow: auto;"
			src="<%=basePath%>/model/baiduMap/pages/baiduMap.jsp"></iframe>
	</body>
</html>
