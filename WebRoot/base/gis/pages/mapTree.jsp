<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";

    	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId=null;
		if (principal instanceof User) {
		   userId = ((User)principal).getUserID();
		} else {
		    userId =null;
		}
   		//String tree = MapTreeUtil.getInstance().getExtTreeByMapTreeList(MapTreeUtil.getInstance().getMemoMapTreeBeanListByUserId(userId));
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
		<script src="<%=basePath%>/base/include/ajax.js"></script>
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
var path = "<%=basePath%>";
var actionName = "mapAuthorOperation";
var actionMethod = "getExtTreeByUserid";
var parameter = "userid=<%=userId%>";
var myData = ajaxRequest(path, actionName, actionMethod, parameter);
var mapTree = eval(myData);
var tree;
var loadFlag=true;
/*********树形菜单展开收缩功能**add by 李如意 2011-07-13****/	  
	function closeOrOpenNode(){
		var str = document.getElementById("closeOrOpenNode").value; 
		if(str == "op"){ 
			tree.getRootNode().expand(true); 
			document.getElementById("closeOrOpenNode").src = "<%=basePath%>/common/images/collapse-all.gif";
			document.getElementById("closeOrOpenNode").alt = "收起";   
			document.getElementById("closeOrOpenNode").value = "cl";
			return;
		}else{ 
			tree.getRootNode().collapse(true);  
			document.getElementById("closeOrOpenNode").src = "<%=basePath%>/common/images/expand-all.gif";
			document.getElementById("closeOrOpenNode").alt = "展开";    	  
			document.getElementById("closeOrOpenNode").value = "op";
			return;		 
		}
	}
	
Ext.onReady(function(){
    tree = new Ext.tree.TreePanel({ 
        el:'mapTree',  
        title:"<div align='left'><img id=\"closeOrOpenNode\" value=\"op\" src='<%=basePath%>/base/thirdres/ext/examples/docs/resources/expand-all.gif' alt='展开' class=x-btn-text onclick=\"closeOrOpenNode();\" /></div>", 
        useArrows:true,  
        autoScroll:true, 
		frame: true, 			//显示树形列表样式   
        animate:true,
        enableDD:true,
        margins: '2 2 0 2',
        autoScroll: true,
        border: false,
        containerScroll: true,
        rootVisible: false,
        checkModel: 'cascade',
        onlyLeafCheckable: false,
        loader: new Ext.tree.TreeLoader({
        	baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI }
        }),
        root: new Ext.tree.AsyncTreeNode({
            expanded: false,
            children: mapTree
        }),
        /* 添加图层树控制 add by 郭润沛 2011-1-30*/
        listeners: {
            'checkchange': function(node, checked){
				changeMap();
            },
              'beforecollapsenode': function(node,deep,anim){
if(deep && loadFlag){
loadFlag=false;
try{
 changeMap();
 }catch(ex){
 //document.location.reload();
 }
 }
            }
        }
    });

 tree.render();
  //先展开用于初始化ext的checked选项,否则无法获取mapService的可见图层
 tree.getRootNode().expand(true); 

//再合并
 tree.getRootNode().collapse(true); 
});
/*当某个mapserice异常时，将下属图层设为不可用 add by guorp 2011-2-22*/
function unChecked(serviceid_2){

                    var checked= tree.getChecked();
                    for(var j=0;j<checked.length;j++){
		                    var node=checked[j]
		                    var id=node.id
		                    var mapServices=id.split("@");
		                    var serverid=mapServices[1]
		                    if(serverid!=null &&serverid!='null' && serviceid_2==serverid){
checked[j].disable();
                    	}
                    }
//alert(serviceid+"取消")
}

/*根据图层树的选中情况，控制图层的显示*/
function changeMap(){
                 //1、获取所有选中的叶子
	
                    var checked= tree.getChecked();
                    //2.循环所有选中的叶子，构建visiable数组
                   try{
        parent.center.mapServices.length
        }catch(ex){
       // changeMap()
        //document.location.reload()
        }
                    for (var i = 0; i < parent.center.mapServices.length; i++) {
                    	
                    if(parent.center.mapServices[i].type == "wmts" || parent.center.mapServices[i].type == "mywms"){
                    	var flag=false;
                    	for(var k=0;k<checked.length;k++){
                            var node=checked[k];
                    	    var id=node.id;
                    	    var mapServices=id.split("@");
 		                    var serverid=mapServices[1]
 		                    if((parent.center.mapServices[i].id==serverid) && (serverid != undefined)){
 		                    	flag=true;
 		                    	break;
 		                    }
                    	}
                    	var la = parent.center._$layers[parent.center.mapServices[i].id];
            			if(flag){
            				if(!parent.center.map.getLayer(la.id)){
            					parent.center.map.addLayer(la,1);
            				}
            			}else{
            				parent.center.map.removeLayer(la);
            			}
                    }else{
                    	//重置visiable
                        parent.center.mapServices[i].visiable=[];
                   		for(var j=0;j<checked.length;j++){
		                    var node=checked[j]
		                    var id=node.id
		                    var mapServices=id.split("@");
		                    var serverid=mapServices[1]
		                    var layerid=mapServices[2]
		                    if(serverid!=null &&serverid!='null' && layerid!=null && layerid!='null' && !checked[j].disabled && serverid==parent.center.mapServices[i].id){
		                    	var v=parent.center.mapServices[i].visiable.length;
		                    	parent.center.mapServices[i].visiable[v]=layerid;
		                    }
                    	}
                    //对图层id进行排序
                    parent.center.mapServices[i].visiable.sort(AscSort);
                    //alert(parent.center.mapServices[i].id+"   "+ parent.center.mapServices[i].visiable)
                    parent.center.setMapVisiable(parent.center.mapServices[i].id, parent.center.mapServices[i].visiable)
            }
                    }
}


  function  AscSort(x, y)    
  {   
   return  x==y?0:(x>y?1:-1);   
}    
    
 function  DescSort(x, y)    
  {   
   return  x==y?0:(x>y?-1:1);   
}  
</script>
	<body bgcolor="#FFFFFF">
		<div id="mapTree"  style="margin-Left:0px;margin-Right:-14px;margin-Top:0px"/>
	</body>
</html>
