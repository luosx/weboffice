<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<% 	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String name = ProjectInfo.getInstance().PROJECT_NAME;
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
		    <%@ include file="/base/include/restRequest.jspf" %>
		<script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
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
	font-family: "仿宋";
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
	width: 65px;
	height: 20px;
	margin-top: 0px;
	border: 0px solid #333;
	line-height: 31px;;
	background:
		url("<%=basePath%>web/<%=name%>/framework/images/left/gjhf_select.PNG")
		no-repeat 5 5;
}

div.unSelected {
	cursor: hand;
	float: left;
	width: 65px;
	height: 20px;
	margin-top: 0px;
	border: 0px solid #333;
	line-height: 31px;;
	
}
</style>
<script type="text/javascript">
var path = "<%=basePath%>";
var tree;
var loadFlag=true;

//选择判断
	function changeStyle(obj) {
	var arr = document.getElementsByTagName('div');

		    if(obj.className=="unSelected"){
		    arr[0].className="unSelected";
			obj.className='selected';
		    }else{
			obj.className="unSelected";
		     }
       }
	
//点击选择事件处理动态树
 function selectCode(){
   var xzqh_all=  document.getElementsByTagName('div');//div数组
   var  xzqh_select='';
   for(var i=0;i<8;i++){
        if(xzqh_all[i].className=="selected"& xzqh_all[i].id.length==6){
       xzqh_select+=xzqh_all[i].id+"/";
     }
   }
   var status="2";
   var parameter="xzqdm="+xzqh_select+"&status="+status;
   var res = ajaxRequest("<%=basePath%>","hander","getCarTree",parameter);
   res=eval(res);	
   tree='['; 
     if(res.length>0){
       	for(var i=0;i<res.length;i++ ){
        if(res[i][0]!=null){
            var root= res[i][0].xzqname;
            tree+="{text:'"+root+"',checked:true, leaf: 0,id:'"+i+1+"',children: [";
	       	for(var j=0;j<res[i].length;j++){
	   		 	 var carId=res[i][j].carid;
	   		 	 var carName=res[i][j].carname;	 
	   		 	      tree+="{text:'"+carName+"',checked:false, leaf:'1',id:'"+carId+"'},"  		 	  
	    	 }
	    	 tree=tree.substring(0,tree.length-1);
	    	 tree+="]},";
           }
   		 }
         tree=tree.substring(0,tree.length-1);	
         tree+="]";
         var mapTree = eval(tree);
         	
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
        listeners: {
            'checkchange': function(node, checked){
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
     var count=0;
      for(var i=0;i<nodeids.length;i++){
         if(tree.getNodeById(nodeids[i]).attributes.checked&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
                   count+=1;
         }
      }  
        if(count<=1){
           document.getElementById("playback").disabled=false;
        }else{
           document.getElementById("playback").disabled=true;
        } 
   

     }}
    });
   var treeSorter=new Ext.tree.TreeSorter(tree,{
       folderSort:true,
       dir:'asc'
   });
   document.getElementById("mapTree").innerHTML="";
   document.getElementById("times").innerHTML="";
   tree.render();
  //先展开用于初始化ext的checked选项,否则无法获取mapService的可见图层
   tree.getRootNode().expand(true); 
   
   var panel=new Ext.Panel({
		preventBodyReset: true,
		 labelWidth:60,	
		 width:259,
		 layout:'form',
		frame:true,
		defaults:{xtype:"datetimefield",anchor:'90%'},   
	    items: [ {  
		    fieldLabel:'开始时间', 
            id:'sater_time',   
            format:'H:i'  
            },{  
            fieldLabel:'结束时间',  
            id:'over_time',   
            format:'H:i'  
            }
	],
        buttons: [{
            id:'showTrajectory',
            disabled:false,
         	text:'显示轨迹',
         	handler: showTrajectory 
          },{
            id:'playback',
            disabled:false,
         	text:'回放轨迹',
         	handler: playback
          }],
		renderTo: 'times'
	});
	
  });
  }
   document.getElementById("sater_time").value='2013-01-01 09:30:45'; 
   document.getElementById("over_time").value='2013-01-01 10:15:45'; 
 }
 	
 function showTrajectory(){
	   var para=gjhf();
	   if(para!=null){
		   var arrs=para.split("@");
		   var carids=arrs[0].split(",");
		      parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").showTrack(escape(arrs[0]),arrs[1],arrs[2]);
		     // alert("车辆编号"+carids[i]+arrs[1]+arrs[2]);
	   }
  }
	
   function playback(){
	   var para=gjhf();
	   if(para!=null){
		   var arrs=para.split("@");
		   var carids=arrs[0].split(",");
		  parent.frames["mapView"].frames["lower"].swfobject.getObjectById("FxGIS").playBack(escape(carids[0]),arrs[1],arrs[2]);
	   }
	}
	
   function gjhf(){
    var  sater_time=Ext.getCmp("sater_time").getValue();
    var  startdate = Ext.util.Format.date(sater_time, 'Y-m-d H:i');
    var  over_time=Ext.getCmp("over_time").getValue();
    var overdate = Ext.util.Format.date(over_time, 'Y-m-d H:i');
    var result;
   if(sater_time!=''&over_time!=''){
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
	  var carnumber='';
      for(var i=0;i<nodeids.length;i++){
       if(tree.getNodeById(nodeids[i]).attributes.checked&&tree.getNodeById(nodeids[i]).attributes.leaf=='1'){
         //  var carid=encodeURI(encodeURI(tree.getNodeById(nodeids[i]).attributes.text));
           var car_number=tree.getNodeById(nodeids[i]).attributes.text;
          //轨迹回放传值------------------------------------
          carnumber+=car_number+",";
           
       }
      } 
      if(carnumber!=''){
        result=carnumber+"@"+startdate+"@"+overdate;
        //回放轨迹
        //playback(car_number,startdate,overdate);
        //显示轨迹
        //showTrajectory(car_number,startdate,overdate);
       }else{alert("请选择车辆")}

   }else{alert("请填写时间")}
      return result;
	}
	


</script>
	</head>
	<body onload="selectCode()">
		<table cellpadding="0" cellspacing="0" border="0" width='106%'
			style='vertical-align: middle; text-align: center; border: 0px solid #8E8E8E;'>
			<tr>
				<td style='text-align: left;' ; colspan=4 height="40"
					style="background-image:url('<%=basePath%>web/<%=name%>/framework/images/left/top_bk.PNG')">
					<img style="position: absolute; left: 10; top: 7;"
						src="<%=basePath%>web/<%=name%>/framework/images/left/blank.png"
						width="16" height="16" />
					<font style="position: absolute; left: 10; top: 7;"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;选择政区</strong>
					</font>
				</td>
			</tr>

			<tr>
				<td>
				<div id="320301" onclick="changeStyle(this);selectCode();"
						class='selected'>
						市&nbsp;局
					</div>
				</td>
				<td>
					<div id="320382" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						邳州市
					</div>
				</td>
				<td>
					<div id="320324" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						睢宁县
					</div>
				</td>
				<td>
					<div id="320381" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						新沂市
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div id="320321" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						丰&nbsp;县
					</div>
				</td>
				<td>
					<div id="320305" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						贾汪区
					</div>
				</td>
				<td>
				       <div id="320322" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						沛&nbsp;县
					</div>
				</td>
				<td>
					<div id="320312" onclick="changeStyle(this);selectCode();"
						class='unSelected'>
						铜山区
					</div>
				</td>
			</tr>
		</table>
		<div id="mapTree" style="margin-Left: 0px; height:250px; width:259px; margin-Right: -14px; margin-Top: 0px; overflow: auto;" ></div>
		<div id="times"
			style="margin-Left: 0px; margin-Right: -14px; margin-Top: 0px">
		</div>
		<br>

	</body>
</html>
