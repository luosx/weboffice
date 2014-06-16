<%@page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
		<script src="web/cbd/qyjc/esfzj/js/quickmsg.js"></script>
		<%@ include file="/base/include/restRequest.jspf"%>
		<style type="css/text">
			.msg .x-box-mc {   
				font-size:14px;   
			}   
            #msg-div {   
	            position:absolute;   
	            left:650px;   
	            top:410px;   
	            width:300px;   
	            z-index:99;   
	            float:left;
			}   

			.msg-close{  
				width:10px; 
				height:10px; 
				position:absolute; top:5px; right:10px;cursor:hand;   
			}   
			.msg-h{   
			 float:left;
				font-size:13px;   
				color:#2870b2;   
				font-weight:bold;   
				margin:10px 0;   
 			}  
		</style>
		<script type="text/javascript">
  var left;
  var treeTextList="";
  var node;
  var mydata;
  Ext.onReady(function(){
  	putClientCommond("scjcManager", "getesfTree");
    mydata = restRequest();
    
    NodeMouseoverPlugin = Ext.extend(Object, {  
		   	init: function(tree) {  
		       if (!tree.rendered) {  
		           tree.on('render', function() {this.init(tree)}, this);  
		           return;  
		       }  
		       this.tree = tree;  
		       tree.body.on('mouseover', this.onTreeMouseover, this, {delegate: 'div.x-tree-node-el'});  
		    	tree.body.on('mouseout', this.onTreeMouseout, this, {delegate: 'div.x-tree-node-el'});  
		   },  
  
		   onTreeMouseover: function(e, t) {  
		    /** 
		       var nodeEl = Ext.fly(t).up('div.x-tree-node-el'); 
		    **/  
		    var nodeId = t.getAttribute('ext:tree-node-id');//t.getAttributeNS('ext', 'tree-node-id');  
		   console.log('node id ' + nodeId);  
		    if (nodeId) {  
		        this.tree.fireEvent('mouseover', this.tree.getNodeById(nodeId), e);  
		    }  
		   },  
		onTreeMouseout : function(e , t) {  
		    /** 
		       var nodeEl = Ext.fly(t).up('div.x-tree-node-el'); 
		    **/  
		    var nodeId = t.getAttribute('ext:tree-node-id');//t.getAttributeNS('ext', 'tree-node-id');  
		    if (nodeId) {  
		        this.tree.fireEvent('mouseout', this.tree.getNodeById(nodeId), e);  
		    }  
		}  
});  
    
  	node= new Ext.tree.AsyncTreeNode({
	    expanded: true,
	   children:  mydata                  
	});
  
  	left = new Ext.tree.TreePanel({
		region:"west",
		id:'west',
		title:"基本信息列表",
		collapsible: true,
	    useArrows: true,
	    plugins: new NodeMouseoverPlugin(),  
	    autoScroll: true,
	    animate: true,
	    //enableDD: true,
	    autoHeight: false,
	    width: 200,
	    border: false,
	    margins: '2 2 0 2',
	    containerScroll: true,
	    rootVisible: false,
	    listeners:{'checkchange':function(node,checked){
			var nodes=left.getChecked();
      		var n=0;
      		for(i=0;i<nodes.length;i++){
      			if(nodes[i].text=="基本信息列表"){//如果是父节点，则不加入treeTextList
               	}else{
	   				if(n>0){
	   					treeTextList+=",";
	   				}
	   				treeTextList+=nodes[i].id;
	   				n++;
	   			}
      		}
      		var url = "<%=basePath%>web/cbd/tjbb/chart.jsp?xml=esfzj.xml&lbxx="+treeTextList;
      		url=encodeURI(url);
      		url=encodeURI(url);
      		document.getElementById("xxtj").src=url;
		 	treeTextList="";
        } , 'mouseover' : function(node) {  
        		if(node.id==0){
        			return ;
        		}
        		
        		putClientCommond("scjcManager", "getFloatTable");
        		putRestParameter("bh",node.id);
        		putRestParameter("tablename","esfzjqknd_pjzj");
    			mydata = restRequest();
                Ext.QuickMsg.show('', mydata ,'100px', 2, Ext.get('fl'), [0, 0], 't-t', true, false);   
                var oSon = window.document.getElementById("fl");  
			     if (oSon == null) return;  
			     with (oSon){  
			      //innerText = guoguo.value;  
			      style.display = "block";  
			      style.pixelLeft = window.event.clientX + window.document.body.scrollLeft + 6;  
			   
		          style.pixelTop = window.event.clientY + window.document.body.scrollTop + 9;  
			   
			     } 
                
				}},
		root:node,
		buttons: [{
                    text:'保存', handler: function() {
                    	var nodes=left.getChecked();
			      		var n=0;
			      		for(i=0;i<nodes.length;i++){
			      			if(nodes[i].text=="基本信息列表"){//如果是父节点，则不加入treeTextList
			               	}else{
				   				if(n>0){
				   					treeTextList+=",";
				   				}
				   				treeTextList+=nodes[i].id;
				   				n++;
				   			}
			      		}
			      		putClientCommond("scjcManager", "saveesfTree");
			      		putRestParameter("items",treeTextList );
    					msg = restRequest();
			      		if(msg){
			      			treeTextList = "";
			      			alert("保存成功");
			      		}
                    }
                 }]
	});
    
	var center = new Ext.Panel({
		region:"center",
		items: [{
                    contentEl: 'center1',
                    title: '示意图',
                   	height: 800
                }]
	});
		
	var vp = new Ext.Viewport({
		layout:"border",
		items:[left,center]
	})
	
	 left.render();
     left.getRootNode().expand(true);
});

    
	function init(){
		document.getElementById("center1").innerHTML="<iframe id='xxtj' name='xxtj' style='width: 100%; height: 380px; overflow: auto;' src='<%=basePath%>web/cbd/tjbb/chart.jsp?xml=esfzj.xml&lbxx='></iframe>";
	}

</script>
	</head>
	<body onload="init();">
		<div id="fl"  style="position:absolute; z-index:5808;"></div>
		<div id="west" class="x-hide-display"></div>
		<div id="center1"></div>
		
	</body>
</html>
