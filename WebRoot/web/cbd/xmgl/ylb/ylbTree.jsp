<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.xmgl.zjgl.TreeManager"%>
<%@page import="com.klspta.base.util.bean.ftputil.AccessoryBean"%>
<%@page import="com.klspta.model.accessory.dzfj.AccessoryOperation"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String yw_guid= request.getParameter("yw_guid");
    	String xmmc=request.getParameter("xmmc");
    	String year=request.getParameter("year");
    	String type=request.getParameter("type");
    	String editor=request.getParameter("editor");
    	if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	} else {
		xmmc = "";
	}
    	String tree = AccessoryBean.transfer(AccessoryOperation.getInstance()
                .getAccessorylistByYwGuid(yw_guid));
    
    tree="["+tree+"]";
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
    var selected_leaf;
    var sign_tree="";
    var rootID;
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
       labelWidth:40,	
       url:"<%=basePath%>/service/rest/xmmanager/saveZjglTree?yw_guid=<%=yw_guid%>&id="+selectMenuTreeId+"&parent_id="+parentMenuTreeId,
       width:185, 
       defaults:{xtype:"textfield",anchor:'90%'},   
       items: [{	
            name:'tree_name',
            id:'tree_name',
            fieldLabel:'名称'      			
        }],				
             buttons: [{
                    text:'保存', handler: function() {
                     win.hide(); 
                     var tree_name = Ext.getCmp("tree_name").getValue();
                    var selet= document.getElementById("selet");
                    var selet_year=selet.options[selet.selectedIndex].value;
                     var lef=new Ext.tree.TreeNode({ 
                         text:tree_name,
                         isLeaf:'ture'
                                 });
                        if(sign_tree=="Y"){
                           selected_leaf.setText(tree_name) ;
	   		             var   tree_text=escape(escape(tree_name));
		                      putClientCommond("xmmanager","modify_tree");
		   				     	putRestParameter("yw_guid",' <%=yw_guid%>');
			   		           putRestParameter("id", selectMenuTreeId);
			   		           putRestParameter("parent_id", parentMenuTreeId);
			   		           putRestParameter("tree_text", tree_text);
			   		            putRestParameter("selet_year", selet_year);
    				    	    var result = restRequest();
                            	parent.right.location.reload();
                            }else{
                            selected_leaf.appendChild(lef);  
                            if(tree_name!=null&&tree_name!=''){
		                    tree_name=escape(escape(tree_name));
		                    putClientCommond("xmmanager","saveZjglTree");
		   					putRestParameter("yw_guid",' <%=yw_guid%>');
			   		        putRestParameter("id", selectMenuTreeId);
			   		        putRestParameter("parent_id", parentMenuTreeId);
			   		        putRestParameter("tree_name", tree_name);
			   		        putRestParameter("selet_year", selet_year);
    					var result = restRequest();
    					document.location.reload();
    					parent.right.location.reload();
    					}
    					else{
    					alert("请输入信息后再保存！");
    					}       
                                 }
                       sign_tree='';
                 
                   }
                  }]
            });  
        
	    win = new Ext.Window({
                applyTo:'updateCar',
                width:200,
                height:100,
                closeAction:'hide',
				items:updateForm
        	 }); 
	        //增加右键事件

	   
	 

 
     //表单FormPanel
        var form = new Ext.form.FormPanel({
        renderTo: 'mapTree',
        title   : '资金操作树',
        autoHeight: true,
        width   : 210,
       	
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
           //  root.reload();

});
function change(){
var selet=document.getElementById("selet");
var index=selet.selectedIndex;
var selet_value=selet.options[index].value;
var url="<%=basePath%>web/cbd/xmgl/zjgl/zjglcent.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>&year="+selet_value+"&type=<%=type%>&editor=<%=editor %>";
parent.right.location.href=url;
var urltree="<%=basePath%>web/cbd/xmgl/zjgl/zjglTree.jsp?yw_guid=<%= yw_guid%>&xmmc=<%=xmmc%>&year="+selet_value+"&type=<%=type%>&editor=<%=editor %>";
parent.left.location.href=urltree;
}



</script>
	<body bgcolor="#FFFFFF" >
	<div align="center" style="width:205px;background-color: #C1D5F0 ;height:30px;">项目：<%=xmmc %>
	</div>
		<div id="mapTree" />
	</div>
	<div id="updateCar" class="x-hidden">
			<div id="updateForm" style="width:211px; height:250px;margin-left: 5px; margin-top: 5px"></div>
		</div>

	</body>
</html>

