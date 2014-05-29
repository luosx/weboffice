<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.xmgl.zjgl.TreeManager"%>
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
    String tree=  new TreeManager().getTree(yw_guid,year);
    
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
	   		           		var  tree_text=escape(escape(tree_name));
		                 	putClientCommond("xmmanager","modify_tree");
	   				     	putRestParameter("yw_guid",' <%=yw_guid%>');
		   		            putRestParameter("id", selectMenuTreeId);
			   		        putRestParameter("parent_id", parentMenuTreeId);
			   		        putRestParameter("tree_text", tree_text);
			   		        putRestParameter("selet_year", selet_year);
			   		        putRestParameter("rootID", rootID);
    				    	var result = restRequest();
                            parent.right.location.reload();
                         }else{
                            selected_leaf.appendChild(lef);  
                            if(tree_name!=null&&tree_name!=''){
		                    tree_name=escape(escape(tree_name));
		                    putClientCommond("xmmanager","saveZjglTree");
		   					putRestParameter("yw_guid",' <%=yw_guid%>');
			   		        putRestParameter("tree_id", selectMenuTreeId);
			   		        putRestParameter("parent_id", parentMenuTreeId);
			   		        putRestParameter("tree_name", tree_name);
			   		        putRestParameter("rootID", rootID);
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
	    tree.on('contextmenu',showRighrClickMenu,RighrClickMenu);
	  
	    //要删除的menuTreeId
	   var RighrClickMenu=new Ext.menu.Menu({
	   
	   items:[{
		   		   text:"添加费用",
		   		   pressed:true,
		   		   handler:function(tree){ 
  				   		sign_tree='N';
		   		   		updateForm.getForm().reset();
                       	win.show(); 
                       	win.setTitle('添加费用')
		   		   }
	   		   }
	   		   ]
	   });
	   
	      var leaf_RighrClickMenu=new Ext.menu.Menu({
	   	  items:[{
	   		     text:"添加费用",
		   		   pressed:true,
		   		   handler:function(tree){
		   		           sign_tree='N';
		   		   		   updateForm.getForm().reset();
                             win.show(); 
                             win.setTitle('添加费用')
		   		         }
	   		   },
	   		   {
	   		     text:"修改",
		   		   pressed:true,
		   		   handler:function(tree){
		   		            sign_tree='Y';
		   		   		    updateForm.getForm().reset();
		   		   		   var ss= Ext.getCmp("tree_name")
		   		   		    ss.setValue(selected_leaf.text);
                             win.show(); 
                             win.setTitle('修改')
		   		         }
	   		   },
	   		   {
	   		     text:"删除",
		   		   pressed:true,
		   		   handler:function(tree){
		   		    var selet= document.getElementById("selet");
                    var selet_year=selet.options[selet.selectedIndex].value;
		   		            tree_text=escape(escape(selected_leaf.text));
		                    putClientCommond("xmmanager","delt_tree");
		   					putRestParameter("yw_guid",' <%=yw_guid%>');
			   		        putRestParameter("id", selectMenuTreeId);
			   		        putRestParameter("parent_id", parentMenuTreeId);
			   		        putRestParameter("rootId",rootID);
			   		         putRestParameter("tree_text", tree_text);
			   		         putRestParameter("selet_year", selet_year);
    				     	var result = restRequest();
    				     	document.location.reload();
    				     		parent.right.location.reload();
		   		   		  selected_leaf.remove() 
		   		         }
	   		   }
	   		   ]
	   	});
	   	
	   	function showRighrClickMenu(node,e){
	   		
	   		var view = false;
	   		var id ;
	   		var parentId ;
	   		var parent_parent_parentID;
	   		var parent_parentId ;
	   		if(node.parentNode==null){
	   			id = node.id;
	   		}else if(node.parentNode.parentNode==null){
	   			id = node.id;
	   			parentId = node.parentNode.id;
	   		}else if(node.parentNode.parentNode.parentNode==null){
	   			id = node.id;
	   			parentId = node.parentNode.id;
	   			parent_parentId = node.parentNode.parentNode.id;
	   		}else {
	   			id = node.id;
	   			parentId = node.parentNode.id;
	   			parent_parentId = node.parentNode.parentNode.id;
	   			parent_parent_parentID = node.parentNode.parentNode.parentNode.id;
	   		}
	   		var type = "<%=type%>";
	   		var editor ="<%=editor%>";
	   		var editors = editor.split("@");
	   		var array = type.split("@");
	   		if(id=="YJKFZC"||id=="ZJZC"){
	   			return ;
	   		}
	   		if(id=="QQFY"||id=="ZJLR"||id=="CQFY"||id=="SCFY"||id=="SZFY"||id=="CWFY"||id=="GLFY"||id=="CRZJFH"||id=="QTZC"){
	   			for(var i=0;i<array.length;i++){
	   				if(id==array[i] && editors[i]=="y"){
	   					view = true;
	   					if(parentId=="ZJLR"){
	   						rootID="ZJLR";
	   					}else {
	   						rootID = "ZJZC";
	   					}
	   				}
	   			}
	   		}else if(parentId=="QQFY"||parentId=="ZJLR"||parentId=="CQFY"||parentId=="SCFY"||parentId=="SZFY"||parentId=="CWFY"||parentId=="GLFY"||parentId=="CRZJFH"||parentId=="QTZC"){
	   			for(var i=0;i<array.length;i++){
	   				if(parentId==array[i] && editors[i]=="y"){
	   					view = true;
	   					if(parentId=="ZJLR"){
	   						rootID="ZJLR";
	   					}else {
	   						rootID = "ZJZC";
	   					}
	   				}
	   			}
	   		}else if(parent_parentId=="ZJLR"){
	   			for(var i=0;i<array.length;i++){
	   				if(parent_parentId==array[i] && editors[i]=="y"){
	   					view = true;
	   					rootID = "ZJLR";
	   				}
	   			}
	   		}else if (parent_parent_parentID=="ZJLR"){
	   			for(var i=0;i<array.length;i++){
	   				if(parent_parent_parentID==array[i] && editors[i]=="y"){
	   					view = true;
	   					rootID = "ZJLR";
	   				}
	   			}
	   		}
	   		if(!view){
	   			alert("您无权限编辑此项!请与管理员联系");
	   			return;
	   		}
	   		selected_leaf=node;
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
 //

 
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
function  sele_year(){
var slet=document.getElementById("selet");
	for(var i=0;i<slet.length;i++){
		if(slet.options[i].value=='<%=year%>'){
		slet.options[i].selected='true';
	}
}

}


</script>
	<body bgcolor="#FFFFFF"  onload="sele_year()">
	<div align="center" style="width:205px;background-color: #C1D5F0 ;height:30px;">项目：<%=xmmc %>
	</div>
	<div align="center" style="width:205px;margin-top: 5px">
		<fieldset  style="background-color: #DFE8F6 ;height:60px"  >
		<legend>时间选择区</legend>
		时间：<select onchange="change()" id="selet" >
		<option value="2010">2010</option>
		<option value="2011">2011</option>
		<option value="2012">2012</option>
		<option value="2013">2013</option>
		<option value="2014" selected="selected">2014</option>
		<option value="2015">2015</option>
		<option value="2016">2016</option>
		<option value="2017">2017</option>
		<option value="2018">2018</option>
		<option value="2019">2019</option>
		<option value="2020">2020</option>
		</select>
		</fieldset>
		</div>
		<div id="mapTree" />
	</div>
	<div id="updateCar" class="x-hidden">
			<div id="updateForm" style="width:211px; height:250px;margin-left: 5px; margin-top: 5px"></div>
		</div>

	</body>
</html>

