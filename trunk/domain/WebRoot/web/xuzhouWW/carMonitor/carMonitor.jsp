<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String name = ProjectInfo.getInstance().getProjectName();
%>

<html>
	<head>
		<title>执法监察系统</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="demo.css" rel="stylesheet" type="text/css" />
		<%@ include file="/base/include/ext.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
		
		<script>
var path = "<%=basePath%>";
var loadFlag=true;
var tree;
var mapTree;
var xzqflag=false;
var childNode;
var cids="";

//页面初始时加载
function lineLoad(){
  ajaxRequest("<%=basePath%>","hander","flushGps","");
  var result = ajaxRequest("<%=basePath%>","hander","countAllCar","");
  result=eval(result);
  for(var i=0;i<result.length;i++){
   var xzqcode=result[i].xzqcode;
   var xzqname=result[i].xzqname;
   var child=result[i].child;
   var parent=result[i].parent;
   document.getElementById(xzqcode).innerHTML=xzqname+"("+child+"/"+parent+")";
  }
}
//选择判断
	function changeStyle(obj) {
	cids=getCheckNodes();
	var arr = document.getElementsByTagName('div');
	var num = arr.length;
	if(obj.id.length==6){       
	       if(obj.id=="320300" ){
	       	    xzqflag=true;
	            if(obj.className=="unSelected"){
			     obj.className='ZQselected';
		         }else{
			      obj.className="unSelected";
	     	      }
	            for(var i=1;i<9;i++){
	            arr[i].className="unSelected";
	       }
	      }else{ 
	            xzqflag=false;
	            arr[0].className="unSelected";
		        if(obj.className=="unSelected"){
			    obj.className='ZQselected';
		        }else{
			    obj.className="unSelected";
		       }}
	}else{
		if(obj.className=="unSelected"){
			obj.className='selected';
		}else{
			obj.className="unSelected";
		}
	}
	}
	
//点击选择事件处理动态树
 function selectCode(){
   var xzqh_all=  document.getElementsByTagName('div');//div数组
   var  xzqh_select='';
   for(var i=0;i<9;i++){
        if(xzqh_all[i].className=="ZQselected"& xzqh_all[i].id.length==6){
        xzqh_select+=xzqh_all[i].id+"/";
     }
   }
   var status="2";
   if(document.getElementById("xs").className=="selected"&&document.getElementById("tz").className=="unSelected"){
      status="1";
   }
   else if(document.getElementById("tz").className=="selected"&&document.getElementById("xs").className=="unSelected"){
      status="0";
   }
   var parameter="xzqdm="+xzqh_select+"&status="+status;
   var res = ajaxRequest("<%=basePath%>","hander","getCarTree",parameter);
   res=eval(res);
   var resflag=true;	
   if(res==""){
      resflag=false;
   }else{
     if(res[0][0]==null){
      resflag=false;
     }
   }
   tree='['; 
     if(resflag){
        var cars;
        if(cids!=""){
         cars=cids.split(",");
        }else{
          cars=null;
        }
       	for(var i=0;i<res.length;i++ ){
        if(res[i][0]!=null){
            var root= res[i][0].xzqname;
            var code= res[i][0].xzqcode;
            tree+="{text:'"+root+"',checked:true, leaf: 0,id:'"+code+"',children: [";
	       	for(var j=0;j<res[i].length;j++){
	   		 	 var carId=res[i][j].carid;
	   		 	 var carName=res[i][j].carname;
	   		 	 var carStatus=res[i][j].carstatus;	
	   		 	 var carLx=res[i][j].carlx;	
	   		 	 var checkFlag=false;
	   		 	 var name="";
	   		 	 if(cars!=null){
	   		 	 for(var k=0;k<cars.length;k++){
	   		 	    if(cars[k]==carName){
	   		 	      checkFlag=true;
	   		 	      cars.remove(cars[k]);
	   		 	    }
	   		 	 }
	   		 	 }
	   		 	 if(checkFlag){
	   		 	  if(carStatus=="going"){
	   	            if(carLx!="0"){
	   		 	      tree+="{text:'<font color=green>"+carName+"(行驶)</font><img onclick=\"showVideo("+carLx+")\" src=\"<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png\" width=\"16\" height=\"16\" />',checked:true, leaf:'1',id:'"+carId+"'},"
	   		 	    }else{
	   		 	      tree+="{text:'<font color=green>"+carName+"(行驶)</font>',checked:true, leaf:'1',id:'"+carId+"'},"
	   		 	    }
	   		 	  }else{
	   	            if(carLx!="0"){
	   		 	      tree+="{text:'<font color=red>"+carName+"(停止)</font><img onclick=\"showVideo("+carLx+")\" src=\"<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png\" width=\"16\" height=\"16\" />',checked:true, leaf:'1',id:'"+carId+"'},"
	   		 	    }else{
	   		 	      tree+="{text:'<font color=red>"+carName+"(停止)</font>',checked:true, leaf:'1',id:'"+carId+"'},"
	   		 	    }	   		 	  
	   		 	  }
	   		 	}else{
	   		 	  if(carStatus=="going"){
	   	            if(carLx!="0"){
	   		 	      tree+="{text:'<font color=green>"+carName+"(行驶)</font><img onclick=\"showVideo("+carLx+")\" src=\"<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png\" width=\"16\" height=\"16\" />',checked:false, leaf:'1',id:'"+carId+"'},"
	   		 	    }else{
	   		 	      tree+="{text:'<font color=green>"+carName+"(行驶)</font>',checked:false, leaf:'1',id:'"+carId+"'},"
	   		 	    }
	   		 	  }else{
	   	            if(carLx!="0"){
	   		 	      tree+="{text:'<font color=red>"+carName+"(停止)</font><img onclick=\"showVideo("+carLx+")\" src=\"<%=basePath%>web/<%=name%>/framework/images/menu/viewC1.png\" width=\"16\" height=\"16\" />',checked:false, leaf:'1',id:'"+carId+"'},"
	   		 	    }else{
	   		 	      tree+="{text:'<font color=red>"+carName+"(停止)</font>',checked:false, leaf:'1',id:'"+carId+"'},"
	   		 	    }	   		 	  
	   		 	  }
	   		 	}
	    	 }
	    	 tree=tree.substring(0,tree.length-1);
	    	 tree+="]},";
           }
   		 }
         if(cars!=null){
   		   for(var i=0;i<cars.length;i++){
   		     parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('remove',cars[i]);
   		   }
   		 }
   		 tree=tree.substring(0,tree.length-1);	
       }
       tree+="]";
        //////////////////////////////////////////////// 	
         var mapTree = eval(tree);

         /////////////////	//加载树
         	
Ext.onReady(function(){
    tree = new Ext.tree.TreePanel({ 
        el:'mapTree',  
        useArrows:true,  
        autoScroll:true, 
		frame: true, 			//显示树形列表样式   
        animate:true,
        enableDD:true,
        margins: '0 0 0 0',
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
             if(node.attributes.leaf=='1'){
                var txt=node.attributes.text;
                var name="";
                var flag=true;
                if(txt.indexOf("停止")>0){
                  flag=false;
                  name=txt.substring(txt.indexOf("苏"),txt.indexOf("停止")-1);
                }else{
                  flag=true;
                  name=txt.substring(txt.indexOf("苏"),txt.indexOf("行驶")-1);
                }
			    if(checked){
		          if(xzqflag){
		            if(flag){
		             doLocation(node.attributes.id,name,"1");
		             }else{
		             doLocation(node.attributes.id,name,"0");
		             }
		          }else{
		             if(!flag){
		               doLocation(node.attributes.id,name,"0");
		             }else{
		                clearTimeout(t);		             
		                timedCount();
		             }
		          }   
				}else{
				    parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('remove',name);
				}
		      }else{
		           if(checked){
		             locationMapByXZQ(node.attributes.id);
		           }else{
		             clearMapByXZQ(node.attributes.id); 
		           }
		       }
           }
        }
    });
   
   var treeSorter=new Ext.tree.TreeSorter(tree,{
       folderSort:true,
       dir:'asc'
   });
   document.getElementById("mapTree").innerHTML="";
   tree.render();
  //先展开用于初始化ext的checked选项,否则无法获取mapService的可见图层
   tree.getRootNode().expand(true);
  });
  }
 

function doLocation(id,name,status){
    var path = "<%=basePath%>";
    var actionName = "hander";
    var actionMethod = "getCarInfo";
    var parmeter="carids="+id;
    var res = ajaxRequest(path,actionName,actionMethod,parmeter); 
    res=eval(res);
    parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('locate',name,res[0].carX,res[0].carY,status,res[0].CARFLAG);
    parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").setCenterAtAndZoom(res[0].carX,res[0].carY,10,false);
} 	


 var start_x=0;
 var start_y=0;
 var end_x=0;
 var end_y=0;
function checkNodes(){
	var nodevalue="";
	var nodeids;
    var rootNode=tree.getRootNode();//获取根节点
    findchildnode(rootNode); //开始递归
	nodevalue=nodevalue.substr(0, nodevalue.length - 1);
	 function findchildnode(node){
		var childnodes = node.childNodes;
		var nd;
		 for(var i=0;i<childnodes.length;i++){ //从节点中取出子节点依次遍历
				  nd = childnodes[i];
				  nodevalue += nd.id + ",";
				  if(nd.hasChildNodes()){ //判断子节点下是否存在子节点
				    findchildnode(nd); //如果存在子节点 递归
		 }   
	    }
	 }
	nodeids=nodevalue.split(",");
	var carids="";
	var flag=false;
    for(var i=0;i<nodeids.length;i++){
       if(tree.getNodeById(nodeids[i]).attributes.checked&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
       var status=tree.getNodeById(nodeids[i]).attributes.text;
       if(status.indexOf("行驶")>0){
            carids+=tree.getNodeById(nodeids[i]).attributes.id+",";
            flag=true;
       }
      }
    }
    if(flag){
      carids=carids.substring(0,carids.length-1);
      var path = "<%=basePath%>";
      var actionName = "hander";
      var actionMethod = "getCarInfo";
      var parmeter="carids="+carids;
      var res = ajaxRequest(path,actionName,actionMethod,parmeter); 
      res=eval(res);
      //alert(res[0].carX+res[0].carY+res[0].ANGLE);
      for(var i=0;i<res.length;i++){
         parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('monitor',res[i].CARNAME,res[i].carX,res[i].carY,"1",res[i].CARFLAG,res[i].ANGLE);
      }
    }else{
         clearTimeout(t);	
    }  
  }
  var t;  
  function timedCount()  
  {  
    checkNodes();
    t=setTimeout("timedCount()",100000);  
  }
  

  //页面刷新
  function reload_carMonitor(){
    clearMap();
    window.location.reload();
  }
  
  function getCheckNodes(){
    var nodevalue=getNodes();
	var nodeids=nodevalue.split(",");
	if(nodevalue==""){
	  nodeids.length=0;
	}
	var carids="";
    for(var i=0;i<nodeids.length;i++){
       if(tree.getNodeById(nodeids[i]).attributes.checked&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
         var txt =tree.getNodeById(nodeids[i]).attributes.text;
         if(txt.indexOf("停止")>0){
            carids+=txt.substring(txt.indexOf("苏"),txt.indexOf("停止")-1)+",";
         }else{
            carids+=txt.substring(txt.indexOf("苏"),txt.indexOf("行驶")-1)+",";
         }
       }
    }
    return carids.substring(0,carids.length-1);
  }
  
  function getNodes(){
    var nodevalue="";
    var rootNode=tree.getRootNode();//获取根节点
    findchildnode(rootNode); //开始递归
	nodevalue=nodevalue.substr(0, nodevalue.length - 1);
	 function findchildnode(node){
		var childnodes = node.childNodes;
		var nd;
		 for(var i=0;i<childnodes.length;i++){ //从节点中取出子节点依次遍历
				  nd = childnodes[i];
				  nodevalue += nd.id + ",";
				  if(nd.hasChildNodes()){ //判断子节点下是否存在子节点
				    findchildnode(nd); //如果存在子节点 递归
		 }   
	   }
	 }
    return nodevalue;
  }
  
  function showVideo(puid){
window.showModalDialog("<%=basePath%>web/<%=name%>/videoMonitor/pop.jsp?puid="+puid,window,"dialogWidth=704px;dialogHeight=288px;status=no;scroll=no");
  }
  
  
  function clearMap(){
    var nodevalue=getNodes();
	var nodeids=nodevalue.split(",");
    for(var i=0;i<nodeids.length;i++){
       var carName="";
       if(tree.getNodeById(nodeids[i]).attributes.checked&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
       var txt=tree.getNodeById(nodeids[i]).attributes.text;
       if(txt.indexOf("行驶")>0){
            carName=txt.substring(txt.indexOf("苏"),txt.indexOf("行驶")-1);
       }else{
            carName=txt.substring(txt.indexOf("苏"),txt.indexOf("停止")-1);
       }
       parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('remove',carName);
      }
    }
  }
  
  function clearMapByXZQ(xzqcode){
    var nodevalue=getNodes();
	var nodeids=nodevalue.split(",");
    for(var i=0;i<nodeids.length;i++){
       var carName="";
       if(tree.getNodeById(nodeids[i]).parentNode.id==xzqcode&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
       var txt=tree.getNodeById(nodeids[i]).attributes.text;
       if(txt.indexOf("行驶")>0){
            carName=txt.substring(txt.indexOf("苏"),txt.indexOf("行驶")-1);
       }else{
            carName=txt.substring(txt.indexOf("苏"),txt.indexOf("停止")-1);
       }
       parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").carMonitor('remove',carName);
      }
    }
  }
  
  function locationMapByXZQ(xzqcode){
        var nodevalue=getNodes();
		var nodeids=nodevalue.split(",");
	    for(var i=0;i<nodeids.length;i++){
	       if(tree.getNodeById(nodeids[i]).parentNode.id==xzqcode&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
	       var txt=tree.getNodeById(nodeids[i]).attributes.text;
	       if(txt.indexOf("行驶")>0){
	            var id=tree.getNodeById(nodeids[i]).attributes.id;
	            var name=txt.substring(txt.indexOf("苏"),txt.indexOf("行驶")-1);
	            doLocation(id,name,"1");
	            if(xzqcode!="320300"){
	            	 clearTimeout(t);		             
		             timedCount();
	            }
	       }else{
	            var id=tree.getNodeById(nodeids[i]).attributes.id;
	            var name=txt.substring(txt.indexOf("苏"),txt.indexOf("停止")-1);
	            doLocation(id,name,"0");
	       }
	      }
	    }
  }
</script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	height: 100%;
	width: 100%;
	background: #DFE8F6;
}


body,td,div,span,li {
	font-family: "宋体";
	font-size: 10pt;
	color: #065587;
}

.hand {
	cursor: hand;
	height: 20px;
}

div.c {
	width: 100%;
	overflow: hidden;
}

div.selected {
	cursor: hand;
	float: left;
	width: 120px;
	height: 20px;
	margin-top: 0px;
	border: 0px solid #333;
	line-height: 31px;;
	background:
		url("<%=basePath%>web/<%=name%>/framework/images/left/select.PNG")
		no-repeat 36 5;
}

div.ZQselected {
	cursor: hand;
	float: left;
	width: 120px;
	height: 20px;
	margin-top: 0px;
	border: 0px solid #333;
	line-height: 31px;;
	background:
		url("<%=basePath%>web/<%=name%>/framework/images/left/xzqh_bk.png")
		no-repeat 15 5;
}

div.unSelected {
	cursor: hand;
	float: left;
	width: 120px;
	height: 20px;
	margin-top: 0px;
	border: 0px solid #333;
	line-height: 31px;;
	
}
</style>
</head>
	<body  onload="lineLoad();selectCode();" >
		<table cellpadding="0" cellspacing="0" border="0" width='106%'
			style='vertical-align: middle; text-align: center; border: 0px solid #8E8E8E;'>
			<tr>
				<td style='text-align: left;' ; colspan=4 height="40"
					style="background-image:url('<%=basePath%>web/<%=name%>/framework/images/left/top_bk.PNG')">
					<img style="position: absolute; left: 10; top: 7;"
						src="<%=basePath%>web/<%=name%>/framework/images/left/blank.png"
						width="16" height="16" />
					<font style="position: absolute; left: 10; top: 7;"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;执法监察车选择</strong>
					</font>
					<img onclick="reload_carMonitor()" class='hand' style="position:absolute;right:16;top:5;" src="<%=basePath%>web/<%=name%>/framework/images/left/reload.png" width="16" height="16" />
				</td>
			</tr>
			<tr>
				<td>
					<div id="320300" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						全&nbsp;市(103/103)
					</div>
				</td>
				<td>
					<div id="320301" onclick="changeStyle(this);selectCode();"
						class='ZQselected'>
						市&nbsp;局(103/103)
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div id="320305" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						贾汪区(103/103)
					</div>
				</td>
				<td>
					<div id="320321" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						丰&nbsp;县(103/103)
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="320312" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						铜山区(103/103)
					</div>
				</td>
				<td>
					<div id="320322" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						沛&nbsp;县(103/103)
					</div>
				</td>
			</tr>
			<tr>
				<td>
				<div id="320382" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						邳州市(103/103)
					</div>
				</td>
				<td>
					<div id="320324" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						睢宁县(103/103)
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="320381" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						新沂市(103/103)
					</div>
				</td>
				<td>
	                             &nbsp;
				</td>
			</tr>
			<tr>
			<td>
				<div id="xs" onclick="changeStyle(this);selectCode()"
					class='selected'>
					行驶
				</div>
			</td>
			<td>
				<div id="tz" onclick="changeStyle(this);selectCode()"
					class='selected'>
					停车
				</div>
			</td>
			</tr>
		</table>
		<div id="mapTree" style="margin-Left: 0px; height:260px; width:259px; margin-Right: -14px; margin-Top: 0px; overflow: auto;" ></div>
	</body>
</html>
