<%@page language="java" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.jizeNW.lacc.TjfxManager"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    //用户信息
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userID="";
    if (principal instanceof User) {
        userID=((User)principal).getUserID();
    }else{
        userID=principal.toString();
    }
    String qyTree=new TjfxManager().getQyTreeByXzqh(userID);
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察统计分析</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>

<script type="text/javascript">	

  var left;
  var treeTextList="";
  var node= new Ext.tree.AsyncTreeNode({
	            expanded: true,
	            children:  <%=qyTree%>                  
	     });
	        
  Ext.onReady(function(){
	left = new Ext.tree.TreePanel({
		region:"west",
		id:'west',
		title:"行政区",
		collapsible: true,
	    useArrows: true,
	    autoScroll: true,
	    animate: true,
	    enableDD: true,
	    autoHeight: false,
	    width: 200,
	    border: false,
	    margins: '2 2 0 2',
	    containerScroll: true,
	    rootVisible: false,

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
		                   var id=node.attributes.id;
		                   
		                 //获取选中的节点
		                var nodes=left.getChecked();
                		var n=0;
                		for(i=0;i<nodes.length;i++){
               				if(nodes[i].text=="徐州市"){//如果父节点是本辖区，则不加入treeTextList
               				}else{
	               				if(n>0){
	               					treeTextList+=",";
	               				}
	               				treeTextList+=nodes[i].text;
	               				n++;
               				}
                		}
		               frames["xxtj"].treeList=treeTextList;
		               //frames["xxfx"].treeList=treeTextList;
		               //frames["xxfx"].frames["pt"].treeList=treeTextList;
		               //frames["xxfx"].frames["zz"].treeList=treeTextList;
		               treeTextList="";
                  }
             },
		root:node	
	});
    
	var center = new Ext.Panel({
		region:"center",
		
		items: [{
                    contentEl: 'center1',
                    title: '违法案件统计',
                   	height: 500,
                    handler: statist
                }]
		
	});
		
	var vp = new Ext.Viewport({
		layout:"border",
		items:[left,center]
	})
	
	 left.render();
     left.getRootNode().expand(true);
});

//统计
function statist(){

}

//分析
function analy(){


}
</script>
	</head>
	<body>
         <div id="west" class="x-hide-display"></div>
        <div id="center1" >
        	<iframe id="xxtj" name="xxtj" style="width: 100%;height:100%; overflow: auto;" src="web/jizeNW/lacc/ajtz/tjtab.jsp"></iframe>
        </div>
        
	</body>
</html>
