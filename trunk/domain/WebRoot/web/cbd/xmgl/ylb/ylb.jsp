<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.accessory.dzfj.*"%>
<%@page import="com.klspta.base.util.bean.ftputil.*"%>
<%

    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String layoutPath = basePath + "base/thirdres/dhtmlx//dhtmlxLayout//codebase";
    String toolbarPath = basePath + "base/thirdres/dhtmlx//dhtmlxToolbar//codebase";
    String yw_guid = request.getParameter("yw_guid");
    String tree = AccessoryBean.transfer(AccessoryOperation.getInstance()
            .getAccessorylistByYwGuid(yw_guid));
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("UTF-8");
    String treePath = basePath + "base/thirdres/dhtmlx//dhtmlxTree//codebase";
    boolean b =  AccessoryOperation.getInstance().isHaveAccessory(yw_guid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>信息</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>base/form/css/styles.css">
		<link rel="stylesheet" type="text/css"
			href="<%=treePath%>/dhtmlxtree.css">
		<link rel="stylesheet" type="text/css"
			href="<%=layoutPath%>/dhtmlxlayout.css">
		<link rel="stylesheet" type="text/css"
			href="<%=toolbarPath%>/skins/dhtmlxtoolbar_dhx_skyblue.css">
		<link rel="stylesheet" type="text/css"
			href="<%=layoutPath%>/skins/dhtmlxlayout_dhx_blue.css">
		<link rel="stylesheet" type="text/css"
			href="<%=layoutPath%>/skins/dhtmlxlayout_dhx_skyblue.css">
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=layoutPath%>/dhtmlxcommon.js"></script>
		<script src="<%=layoutPath%>/dhtmlxcontainer.js"></script>
		<script src="<%=layoutPath%>/dhtmlxlayout.js"></script>
		<script src="<%=toolbarPath%>/dhtmlxtoolbar.js"></script>
		<script src="<%=treePath%>/dhtmlxtree.js"></script>
		<script src="<%=treePath%>/ext/dhtmlxtree_json.js"></script>
		<style>
html,body {
	width: 100%;
	height: 100%;
	margin: 0px;
	overflow: hidden;
}

</style>
	</head>
	<script>
  var dhxLayout,tree;
  var i = 1;
function doOnLoad() {
    //parent.dhxLayout.cells("b").hideHeader();
    dhxLayout = new dhtmlXLayoutObject("parentId", "2U","dhx_skyblue");
    dhxLayout.cells("a").setText("附件列表");
    dhxLayout.setCollapsedText("a", "<img src='<%=basePath%>/model/accessory/dzfj/imgs/expand-all.gif' width='16px' height='16px' border='0'>");
    dhxLayout.cells("b").setText("详细内容");
   // dhxLayout.cells("a").hideHeader();
   // dhxLayout.cells("b").hideHeader();
	var width = document.body.clientWidth;
	var height = document.body.clientHeight;
    dhxLayout.cells("a").setWidth(200);

	dhxLayout.cells("b").attachURL("<%=basePath%>web/cbd/xmgl/ylb/mergepage.jsp?yw_guid=<%=yw_guid%>");
	
	
	/********************   初始化附件树   **************************************/
	
	tree = dhxLayout.cells("a").attachTree("0");
	var treeArray = new Array(<%=tree%>);
	tree.setImagePath("<%=treePath%>/imgs/csh_dhx_skyblue/");
	//tree.enableCheckBoxes(false);
	//tree.enableDragAndDrop(false);
	tree.loadJSArray(treeArray);//for loading from array object
	//更改子文件夹图标
	for(i=0;i<treeArray.length;i++){
		if(treeArray[i][4]=='folder'){
			tree.setItemImage2(treeArray[i][0],'folderOpen.gif','folderOpen.gif','folderOpen.gif');
		}
	}
	tree.openAllItems(0);
	dhxLayout.cells("a").progressOff();

	/*添加单击监听事件 郭 2010-11-22*/
	tree.attachEvent("onSelect",function(id){
	dhxLayout.cells("b").progressOff();
	var tree_id;
	for(i=0;i<treeArray.length;i++){
	 
		if(id==treeArray[i][0]){
		tree_id=i;
		break;
		}
	}
	 if(treeArray[tree_id][4]=='file'){//只处理叶子节点
		
		 var file_name=treeArray[tree_id][3];
		
           var file_type='';
           if(file_name.indexOf('.')>0){
            file_type=file_name.substring(file_name.indexOf('.')+1,file_name.length);
            file_type=file_type.toLowerCase();
           }
           if(file_type=='doc'||file_type=='xls'||file_type=='ppt'||file_type=='docx'||file_type=='xlsx'||file_type=='pptx'){
          	    var fileid=file_name.substring(0,file_name.indexOf('.'));//add by 李亚栓 上传word文档时，传文档名称fileid
          		dhxLayout.cells("b").attachURL("<%=basePath%>/model/webOffice/webOffice_read.jsp?file_id="+fileid+"."+"&file_type="+file_type);
           }else
	           if(file_type=='swf'||file_type=='SWF'){
	        	   dhxLayout.cells("b").attachURL("<%=basePath%>/model/accessory/dzfj/need_jsp/flash.jsp?file_id="+id+"&file_type="+file_type);
	           }
	           else{
	           		
	           }
	        }
     else{

           }
       });
       
    /********************   初始化附件树 完毕   **************************************/   
    
   
}
/*判断是有提供全部下载*/
function isHaveAccessory(a){
	if('<%=b%>'=='true'){
       	// a.enableItem('downloadAll');
    }
}

function setImg(){
	alert("456");
}

function getName(name){
	var newName=window.showModalDialog("<%=basePath%>model/accessory/dzfj/need_jsp/input.jsp?name="+escape(name),window,'dialogWidth:400px;dialogHeight:0px;status:no');
	if(newName==undefined){
		return false
	}else{
		return escape(newName) ;
	}
		
}


function upload(){
var file_id=tree.getSelectedItemId();
if(file_id==null || file_id==''){
file_id='0';
}
dhxLayout.cells("b").attachURL("<%=basePath%>model/accessory/dzfj/need_jsp/upload.jsp?yw_guid=<%=yw_guid%>&parent_file_id="+file_id);
dhxLayout.cells("b").progressOff();
}
function download(){
	var file_id=tree.getSelectedItemId();
	// window.open("<%=basePath%>model/accessory/dzfj/need_jsp/getAccessory.jsp?file_id="+file_id+"&type=down");
	var form=document.getElementById("attachfile");
	form.action +="?file_id=" + file_id;
	form.submit();
}

/* 电子附件全部下载功能 
function downloadAll(){
	var yw_guid='<%=yw_guid%>';
	var path = "<%=basePath%>";
    var actionName = "accessoryAction";
    var actionMethod = "downloadAll";
    var parameter="yw_guid="+yw_guid;
	var result = ajaxRequest(path,actionName,actionMethod,parameter);
	window.open("<%=basePath%>/common/pages/accessory/download/"+yw_guid+".zip");
}  */
function emptyFiles(){
	putClientCommond("accessoryAction", "emptyFiles");
	restRequest();
}
</script>
	<body onLoad="doOnLoad()" onunload="emptyFiles()" bgcolor="#FFFFFF" leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0">
		<div id="parentId"
			style="top: 0px; left: 0px; width: 100%; height: 100%;"></div>
		<input type='text' id='name' name='name' value='' style="display:none"/> 	
		<form id="attachfile" action="<%=basePath%>service/rest/accessoryAction/downLoadfile" method="post">
		</form>   
	</body>
</html>

