<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.web.cbd.xmgl.zjgl.TreeManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String yw_guid= request.getParameter("yw_guid");
   // String tree=  new TreeManager().getParentNOde(yw_guid).toString();
    String tree=  new TreeManager().getTree(yw_guid);
    tree="["+tree+"]";
    System.out.print(tree);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>outlookBar</title>

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
	var updateForm;
	var win;
	var parentMenuTreeId;
    var selectMenuTreeId; 
      var tree;
      var root;
 Ext.onReady(function() {
      root= new Ext.tree.AsyncTreeNode({
	            expanded: true,
	           // expandChildNodes：true,
	            children: <%=tree%>
	        });
	        
	 tree = new Ext.tree.TreePanel({
	        useArrows:true,
	        autoScroll:true,
	        animate:true,
	        enableDD:true,
	        margins: '2 2 0 2',
	        border: false,
	        containerScroll: true,
	        rootVisible: false,
	        frame: true,
	        expandChildNodes:true,
	        loader: new Ext.tree.TreeLoader(),
	        root: root
	        
	    });
	   updateForm=new Ext.form.FormPanel({
	   applyTo:'updateForm',
	   baseCls: 'x-plain',
       labelWidth:60,	
       url:"<%=basePath%>/service/rest/xmmanager/saveZjglTree?yw_guid=<%=yw_guid%>&id="+selectMenuTreeId+"&parent_id="+parentMenuTreeId,
       width:150, 
       defaults:{xtype:"textfield",anchor:'90%'},   
       items: [{	
            name:'tree_name',
            id:'tree_name',
            fieldLabel:'费用名称'      			
        }],				
             buttons: [{
                    text:'保存', handler: function() {
                     var tree_name=  Ext.getCmp("tree_name").getValue();
                      tree_name=escape(escape(tree_name));
                   if(tree_name!=null){
                        putClientCommond("xmmanager","saveZjglTree");
    					putRestParameter("yw_guid",' <%=yw_guid%>');
		   		        putRestParameter("id", selectMenuTreeId);
		   		        putRestParameter("parent_id", parentMenuTreeId);
		   		         putRestParameter("tree_name", tree_name);
    					var result = restRequest();
    					document.location.reload();
    					parent.right.location.reload();
    					}
                   }
                  }]
            });  
         
	    win = new Ext.Window({
                applyTo:'updateCar',
                width:180,
                height:100,
                closeAction:'hide',
				items:updateForm
        	 }); 
	        //增加右键事件
	    tree.on('contextmenu',showRighrClickMenu,RighrClickMenu);
	  
	    //要删除的menuTreeId
	   var RighrClickMenu=new Ext.menu.Menu({
	   items:[{
		   		   text:"添加指出费用",
		   		   pressed:true,
		   		   handler:function(tree){
		
		   		   }
	   		   }
	   		   ]
	   });
	   
	      var leaf_RighrClickMenu=new Ext.menu.Menu({
	   	  items:[{
	   		     text:"添加指出费用",
		   		   pressed:true,
		   		   handler:function(tree){
		   		   		   updateForm.getForm().reset();
                            win.show(); 
                             win.setTitle('添加指出费用')
		   		   }
	   		   }
	   		   ]
	   	});
	   	
	   	function showRighrClickMenu(node,e){
   			e.preventDefault();
   			node.select();
   			selectMenuTreeId=node.id;
   			if(node.leaf){
	   			 parentMenuTreeId=node.parentNode.id;
	   			 leaf_RighrClickMenu.showAt(e.getPoint());
   			}else{
	   			 parentMenuTreeId=node.id;
	   			 RighrClickMenu.showAt(e.getPoint());
   			}
   		}
 
     //表单FormPanel
        var form = new Ext.form.FormPanel({
        renderTo: 'mapTree',
        title   : '资金树管理',
        autoHeight: true,
        width   : 200,
       
        bodyStyle: 'padding: 5px',
        defaults: {
            anchor: '0'
        },
        items   : [
        		tree
   				]
    
    });
    
    function newGuid(){ 
    var guid = ""; 
    for (var i = 1; i <= 32; i++){ 
        var n = Math.floor(Math.random()*16.0).toString(16); 
        guid += n; 
    } 
    return guid; 
} 
            tree.expandAll(); 
});

</script>
	<body bgcolor="#FFFFFF" >
		<div id="mapTree"  style="width:500px;height:500px;OVERFLOW-y:auto;  "/>
	</div>
	<div id="updateCar" class="x-hidden">
			<div id="updateForm" style="width: 102%; height: 90%;margin-left: 10px; margin-top: 5px"></div>
		</div>
	</body>
</html>

