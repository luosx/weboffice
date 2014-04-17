<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.console.flex.FlexManager"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String roleId=request.getParameter("roleId");
    String nodeName=URLDecoder.decode(request.getParameter("nodeName"), "utf-8");
    //String tree=FlexManager.getInstance().getWidgetCheckTreeByRoleId(roleId);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>组件授权</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf"%>
		<style>
body {
	font-family: helvetica, tahoma, verdana, sans-serif;
	padding: 0px;
scrollbar-3dlight-color:#D4D0C8; 
  scrollbar-highlight-color:#fff; 
  scrollbar-face-color:#E4E4E4; 
  scrollbar-arrow-color:#666; 
  scrollbar-shadow-color:#808080; 
  scrollbar-darkshadow-color:#D7DCE0; 
  scrollbar-base-color:#D7DCE0; 
  scrollbar-track-color:#;
}
</STYLE>
	</head>
	<script>
	 	  putClientCommond("flexAction","getWidgetCheckTreeByRoleId");
      putRestParameter("roleId","<%=roleId%>");
      var myData=restRequest();
      var mapTree = eval(myData);
 Ext.onReady(function() {
        
	   var tree  = new Ext.tree.TreePanel({
	        useArrows:true,
	        autoScroll:true,
	        animate:true,
	        enableDD:true,
	        margins: '2 2 0 2',
	            autoScroll: true,
	        border: false,
	        containerScroll:true,
	        rootVisible:false,
	        frame: true,

	        loader: new Ext.tree.TreeLoader(),
	        root: new Ext.tree.AsyncTreeNode({
	            expanded: false,
	            children:mapTree
	        }),
             listeners:{'checkchange':function(node,checked){
		                   node.expand();
		                   node.attributes.checked = checked;
		                   if(checked){
			                  
		                   }
 							node.eachChild(function(child) {
		                       child.ui.toggleCheck(checked);
		                       child.attributes.checked = checked;
		                       child.fireEvent('checkchange', child, checked);
		                   });
		                 
             }

             
             }
	    });
 		
 
  		
        var form = new Ext.form.FormPanel({
        renderTo: 'mapTree',
        title   : '<%=nodeName%>-flex组件授权',
        autoHeight: true,
        width   : 300,
       
        bodyStyle: 'padding: 5px',
        defaults: {
            anchor: '0'
        },
        items   : [
        		tree
   				],
        buttons: [
            {
                text   : '保存',
                handler: function() {
                    	var treeIdList="";
                		var nodes=tree.getChecked();
                		var n=0;
                		for(i=0;i<nodes.length;i++){
                			    if(nodes[i].attributes.leaf==0){
                			     continue;
                			    }
                				if(n>0){
                					treeIdList+=",";
                				}
                				treeIdList+=nodes[i].id;
                				n++;
                		}
						putClientCommond("flexAction","saveWidgetRoleMap");
		   		        putRestParameter("roleId", "<%=roleId%>");
		   		        putRestParameter("widgetList", treeIdList);
    					var result=restRequest();
					
					if(result=="success"){
						Ext.Msg.alert("提示","保存组件授权成功"); 
					}else{
						Ext.Msg.alert("提示","保存组件授权失败，请稍后重试或联系管理员。"); 
					}
						treeIdList="";
				}
          	}
        ]
    });
  tree.render();
    tree.getRootNode().expand(true);
});


</script>

	<body bgcolor="#FFFFFF" >
		<div id="mapTree"  style="width:300px;height:500px;OVERFLOW-y:auto;  "/>
	</body>
</html>

