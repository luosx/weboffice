<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String name = ProjectInfo.getInstance().PROJECT_NAME;

	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId=null;
	if (principal instanceof User) {
	   userId = ((User)principal).getUserID();
	} else {
	    userId =null;
	}
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
<%@ include file="/base/include/ext.jspf" %>
<script src="<%=basePath%>/base/include/ajax.js"></script>
		<script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	height:100%;
	width:100%;
	background: #fff;
}

-->
.Font9Black {
	font-family: "宋体";
	font-size: 9pt;
	color: #444444;
}

.Font9Blue {
	font-family: "宋体";
	font-size: 9pt;
	color: #001F6D;
}

.Font9BlueInfo {
	font-family: "宋体";
	font-size: 9pt;
	color: #2C5DA5;
}

body,td,div,span,li {
	font-family: "仿宋";
	font-size: 10pt;
	color: #065587;
}

.hand {
	cursor: hand;
	height:20px;
}
div.c{width:100%; overflow:hidden;}
div.selected{cursor: hand;float:left;width:65px;height:20px;margin-top:0px;border:0px solid #333; line-height:31px;;background:url("<%=basePath%>web/<%=name%>/framework/images/left/select.PNG") no-repeat 0 0;}
div.unSelected{cursor: hand;float:left;width:65px;height:20px;margin-top:0px;border:0px solid #333; line-height:31px;;background:url("<%=basePath%>web/<%=name%>/framework/images/left/unSelected.PNG") no-repeat 0 0;}
</style>
<script type="text/javascript">
var path = "<%=basePath%>";
var actionName = "mapAuthorOperation";
var actionMethod = "getExtTreeByUserid";
var parameter = "userid=<%=userId%>";
var myData = "[{text:'市局',checked:false, leaf: 0,id:'1',children: [{text:'苏C898001',serverid:'10_YZ_WYXCHC',layerid:'2',type:'dynamic',checked:false, leaf: 1,id:'2@10_YZ_WYXCHC@2',parentId:'1'},{text:'苏C898002',serverid:'10_YZ_WYXCHC',layerid:'2',type:'dynamic',checked:false, leaf: 1,id:'2@10_YZ_WYXCHC@2',parentId:'1'},{text:'苏C898003',serverid:'10_YZ_WYXCHC',layerid:'2',type:'dynamic',checked:false, leaf: 1,id:'2@10_YZ_WYXCHC@2',parentId:'1'}]},{text:'鼓楼区',checked:false, leaf: 0,id:'1',children: [{text:'苏C898004',serverid:'10_YZ_WYXCHC',layerid:'2',type:'dynamic',checked:false, leaf: 1,id:'2@10_YZ_WYXCHC@2',parentId:'1'},{text:'苏C898005',serverid:'10_YZ_WYXCHC',layerid:'2',type:'dynamic',checked:false, leaf: 1,id:'2@10_YZ_WYXCHC@2',parentId:'1'},{text:'苏C898006',serverid:'10_YZ_WYXCHC',layerid:'2',type:'dynamic',checked:false, leaf: 1,id:'2@10_YZ_WYXCHC@2',parentId:'1'}]}]";
//var myData = ajaxRequest(path, actionName, actionMethod, parameter);
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
 //tree.getRootNode().collapse(true); 
});
function selectCode(code) {

		alert(code);
	}
	function changeStyle(obj) {
   
		if(obj.className=="unSelected"){
			obj.className='selected';
		}else{
			obj.className="unSelected";
		}
	}
	
</script>
</head>
<body>
	<table cellpadding="0" cellspacing="0" border="0"  width='106%' style='vertical-align: middle; text-align: center;border:0px solid #8E8E8E;'>
	<tr>
	<td style='text-align: left;'; colspan=4 height="40"  style="background-image:url('<%=basePath%>web/<%=name%>/framework/images/left/top_bk.PNG')"><img style="position:absolute;left:10;top:7;" src="<%=basePath%>web/<%=name%>/framework/images/left/blank.png" width="16" height="16" />
	<font style="position:absolute;left:10;top:7;"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请选择统计类别</strong></font>
	</td>
	</tr>
	
		<tr>
			<td><div onclick="changeStyle(this);selectCode('320300');" class='unSelected'>全部</div></td>
			<td class='hand' onClick='selectCode("320300")'>市&nbsp;局</td>
			<td class='hand' onClick='selectCode("320302")'>鼓楼区</td>
			<td class='hand' onClick='selectCode("320303")'>云龙区</td>

		</tr>
		<tr>
			<td class='hand' onClick='selectCode("320322")'>丰县</td>
			<td class='hand' onClick='selectCode("320305")'>贾汪区</td>
			<td class='hand' onClick='selectCode("320311")'>泉山区</td>
			<td class='hand' onClick='selectCode("320312")'>铜山区</td>
		</tr>
		<tr>
			<td class='hand' onClick='selectCode("320321")'>沛县</td>
			<td class='hand' onClick='selectCode("320324")'>睢宁县</td>
			<td class='hand' onClick='selectCode("320381")'>新沂市</td>
			<td><div onclick="changeStyle(this);selectCode('320382');" class='unSelected'>邳州市</div></td>
		</tr>
		<tr>
		<td>
		<div onclick="changeStyle(this)" class='selected'>全部</div>
		</td>
		<td>
		<div onclick="changeStyle(this)" class='unSelected'>行驶</div>
		</td>
		<td>
		<div onclick="changeStyle(this)" class='unSelected'>停车</div>
		</td>
		<td>
		<div onclick="changeStyle(this)" class='unSelected'>熄火</div>
		</td>		
		</tr>
	</table>
<div id="mapTree"  style="margin-Left:0px;margin-Right:-14px;margin-Top:0px">
</div>

</body>
</html>