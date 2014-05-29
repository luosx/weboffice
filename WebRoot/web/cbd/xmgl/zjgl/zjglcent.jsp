<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.zjgl.Contorl" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.web.cbd.xmgl.zjgl.ReportManager"%>
<%@page import="com.klspta.web.cbd.xmgl.Xmmanager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid=request.getParameter("yw_guid");
	String xmmc=request.getParameter("xmmc");
   	String year=request.getParameter("year");
   	String type=request.getParameter("type");
   	String editor=request.getParameter("editor");
	String table="";
	List<Map<String, Object>> lr=null;
	List<Map<String, Object>> zc=null;
	if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	} else {
		xmmc = "";
	}
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
	User user = ManagerFactory.getUserManager().getUserWithId(userId);
	List<Role>  role = ManagerFactory.getRoleManager().getRoleWithUserID(userId);
	String rolename = role.get(0).getRolename();
	String keyset = "";
	if(!yw_guid.equals("")&&!yw_guid.equals("null")){
		if("all".equals(type)){
			  Contorl contorl=new Contorl(yw_guid,year);
			  table=contorl.getTextMode();
		}else {
			String types[] = type.split("@");
			String edirots[] = editor.split("@");
			ReportManager re  = new ReportManager();
			table = re.getReport(yw_guid,year,rolename);
		}
   }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>办理过程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="base/include/jquery-1.10.2.js"></script>
		<%@ include file="/base/include/restRequest.jspf" %>

<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
    table-layout:fixed;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align: center;
}
input{
	border: 1px solid #6933F2;
	height: 20px;
	align:center;
	width:100px;
	padding: 0px;
	
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.title{
	background-color:#95DD9E;
	font-weight: bold;
	line-height: 15px;
	text-align: center;
}

.tr03 {
	background-color:#FFFFCC;
	font-weight: bold;
	line-height: 15px;
	text-align: center;
}
.tr02 {
	background-color:#CCFFFF;
	font-weight: bold;
	line-height: 15px;
	text-align: center;
}
.tr01 {
	background-color:#FFCC99;
	font-weight: bold;
	line-height: 15px;
	text-align: center;
}
.tr04 {
	background-color:#C7EDCC;
	font-weight: bold;
	line-height: 15px;
	text-align: center;
}
.tr05 {
	background-color:#FFF69A;
	background-color:#FFCC99;
	line-height: 15px;
	text-align: center;
}
</style>
<script type="text/javascript">
	
	var changeText = "";
	var array = ["jl2", "yy", "ey", "cqye", "sany", "siy", "wy", "ly", "qy", "bqy" ,"jy" ,"siyue" ,"syy", "sey" ,"lrsp"];
	var msg = "";
  	$(document).ready(function () { 
		
    });
    
    function init(){
    	complr();
    	compzc();
    	fix();
    }
    
    function fix(){
    	var width = document.body.clientWidth ;
		var height = document.body.clientHeight * 0.85;
       	FixTable("table", 0,3, width, height);
    }
    
    function complr(){
    	putClientCommond("xmmanager","getTreeMapLR");
    	putRestParameter("yw_guid","<%=yw_guid%>");
    	putRestParameter("year","<%=year%>");
    	var msg = restRequest(); 
    	msg = eval( '(' + msg + ')')[0];
    	tobj = document.getElementById("table");
    	for(var key in msg){
    		var id = key + "@ysfy";
			var value = 0;
			var childids = msg[key].split(",");
   			for(var j = 0 ; j < childids.length ; j++){
    			if(document.getElementById(childids[j] + "@ysfy").tagName == "INPUT"){
    				value += parseFloat(document.getElementById(childids[j] + "@ysfy").value==""?"0":
    					document.getElementById(childids[j] + "@ysfy").value);
    			}else{
    				value += parseFloat(document.getElementById(childids[j] + "@ysfy").innerHTML==""?"0":
    					document.getElementById(childids[j] + "@ysfy").innerHTML);
    			}
   			}
  			document.getElementById(id).innerHTML=  value  ;
    	
    		for(var z = 0 ; z < array.length; z++){
    			var id = key + "@"+ array[z];
				var value = 0;
    			for(var j = 0 ; j < childids.length ; j++){
	    			if(document.getElementById(childids[j] + "@"+ array[z]).tagName == "INPUT"){
	    				value += parseFloat(document.getElementById(childids[j] + "@" + array[z]).value==""?"0":
	    					document.getElementById(childids[j] + "@"+array[z]).value);
	    			}else{
	    				value += parseFloat(document.getElementById(childids[j] + "@" + array[z]).innerHTML==""?"0":
	    					document.getElementById(childids[j] + "@" + array[z]).innerHTML);
	    			}
    			}
   				document.getElementById(id).innerHTML=  value  ;
    		}
    	}
    }
    
    function compzc(){
    	putClientCommond("xmmanager","getTreeMap");
    	putRestParameter("yw_guid","<%=yw_guid%>");
    	putRestParameter("year","<%=year%>");
    	var msg = restRequest(); 
    	msg = eval( '(' + msg + ')')[0];
    	tobj = document.getElementById("table");
    	for(var key in msg){
    		var id = key + "@1@ysfy";
			var value = 0;
			var childids = msg[key].split(",");
   			for(var j = 0 ; j < childids.length ; j++){
    			if(document.getElementById(childids[j] + "@1@ysfy").tagName == "INPUT"){
    				value += parseFloat(document.getElementById(childids[j] + "@1@ysfy").value==""?"0":
    					document.getElementById(childids[j] + "@1@ysfy").value);
    			}else{
    				value += parseFloat(document.getElementById(childids[j] + "@1@ysfy").innerHTML==""?"0":
    					document.getElementById(childids[j] + "@1@ysfy").innerHTML);
    			}
   			}
  			document.getElementById(id).innerHTML=  value  ;
    	
    		for(var z = 0 ; z < array.length; z++){
	    		for(var t = 1; t <= 8 ;t++){
	    			var id = key + "@"+t+"@"+ array[z];
					var value = 0;
	    			for(var j = 0 ; j < childids.length ; j++){
		    			if(document.getElementById(childids[j] + "@"+t+"@"+ array[z]).tagName == "INPUT"){
		    				value += parseFloat(document.getElementById(childids[j] + "@"+t+"@" + array[z]).value==""?"0":
		    					document.getElementById(childids[j] + "@"+t+"@"+array[z]).value);
		    			}else{
		    				value += parseFloat(document.getElementById(childids[j] + "@"+t+"@" + array[z]).innerHTML==""?"0":
		    					document.getElementById(childids[j] + "@"+t+"@" + array[z]).innerHTML);
		    			}
	    			}
    				document.getElementById(id).innerHTML=  value  ;
	    		}
    		}
    	}
    }
    
    function sava(){
    	putClientCommond("xmmanager","saveZJGL_ZJZC");
    	putRestParameter("yw_guid","<%=yw_guid%>");
    	putRestParameter("year","<%=year%>");
    	putRestParameter("val",escape(escape(changeText)));
    	var msg=restRequest(); 
    	changeText = "";
    	if(msg){
    		alert("保存成功");
    	}
    }
    
	function addrzxq(check){
		var val = check.value;
		if(!isNaN(val)){ 
			var id=check.id;
			if(val==""){
				val="0";
			}
			changeText += id + "#" + val + ":";
		}else{
			alert("请填写有效数据！");
			check.value="";
		}
	}
	function addzjlr(check){
		var val = check.value;
		if(!isNaN(val)){  

		}else{
			alert("请填写有效数据！");
			check.value="";
		}
 	 }
 
	 function change(){
	 	
	 }
 
  function FixTable(TableID, FixColumnNumber,FixRowNumber, width, height) {
    if ($("#" + TableID + "_tableLayout").length != 0) {
        $("#" + TableID + "_tableLayout").before($("#" + TableID));
        $("#" + TableID + "_tableLayout").empty();
    }
    else {
        $("#" + TableID).after("<div id='" + TableID + "_tableLayout' style='overflow:hidden;height:" + height + "px; width:" + width + "px;'></div>");
    }
    $('<div id="' + TableID + '_tableFix"></div>'
    + '<div id="' + TableID + '_tableHead"></div>'
    + '<div id="' + TableID + '_tableColumn"></div>'
    + '<div id="' + TableID + '_tableData"></div>').appendTo("#" + TableID + "_tableLayout");
    var oldtable = $("#" + TableID);
    var tableFixClone = oldtable.clone(true);
    tableFixClone.attr("id", TableID + "_tableFixClone");
    $("#" + TableID + "_tableFix").append(tableFixClone);
    var tableHeadClone = oldtable.clone(true);
    tableHeadClone.attr("id", TableID + "_tableHeadClone");
    $("#" + TableID + "_tableHead").append(tableHeadClone);
    var tableColumnClone = oldtable.clone(true);
    tableColumnClone.attr("id", TableID + "_tableColumnClone");
    $("#" + TableID + "_tableColumn").append(tableColumnClone);
    $("#" + TableID + "_tableData").append(oldtable);
    $("#" + TableID + "_tableLayout table").each(function () {
        $(this).css("margin", "0");
    });
    var HeadHeight = 0;
    var rowsNumber = 0;
	$("#" + TableID + "_tableColumn tr:lt(" + FixRowNumber + ")").each(function () {
        HeadHeight += $(this).outerHeight(true);
        rowsNumber++;
    });
    HeadHeight += 2;
    $("#" + TableID + "_tableHead").css("height", HeadHeight);
    $("#" + TableID + "_tableFix").css("height", HeadHeight);
    var ColumnsWidth = 0;
    var ColumnsNumber = 0;
    $("#" + TableID + "_tableColumn tr:last td:lt(" + FixColumnNumber + ")").each(function () {
        ColumnsWidth += $(this).outerWidth(true);
        ColumnsNumber++;
    });
    ColumnsWidth += 2;

	if (ColumnsNumber >= 2) ColumnsWidth--;

    $("#" + TableID + "_tableColumn").css("width", ColumnsWidth);
    $("#" + TableID + "_tableFix").css("width", ColumnsWidth);
    $("#" + TableID + "_tableData").scroll(function () {
        $("#" + TableID + "_tableHead").scrollLeft($("#" + TableID + "_tableData").scrollLeft());
        $("#" + TableID + "_tableColumn").scrollTop($("#" + TableID + "_tableData").scrollTop());
    });
    $("#" + TableID + "_tableFix").css({ "overflow": "hidden", "position": "relative", "z-index": "50", "background-color": "Silver" });
    $("#" + TableID + "_tableHead").css({ "overflow": "hidden", "width": width - 17, "position": "relative", "z-index": "45", "background-color": "Silver" });
    $("#" + TableID + "_tableColumn").css({ "overflow": "hidden", "height": height - 17, "position": "relative", "z-index": "40", "background-color": "Silver" });
    $("#" + TableID + "_tableData").css({ "overflow": "scroll", "width": width, "height": height, "position": "relative", "z-index": "35" });
    if ($("#" + TableID + "_tableHead").width() > $("#" + TableID + "_tableFix table").width()) {
        $("#" + TableID + "_tableHead").css("width", $("#" + TableID + "_tableFix table").width());
        $("#" + TableID + "_tableData").css("width", $("#" + TableID + "_tableFix table").width() + 17);
    }
    if ($("#" + TableID + "_tableColumn").height() > $("#" + TableID + "_tableColumn table").height()) {
        $("#" + TableID + "_tableColumn").css("height", $("#" + TableID + "_tableColumn table").height());
        $("#" + TableID + "_tableData").css("height", $("#" + TableID + "_tableColumn table").height() + 17);
    }
    $("#" + TableID + "_tableFix").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableHead").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableColumn").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableData").offset($("#" + TableID + "_tableLayout").offset());
}

</script>
<script type="text/javascript">
	
</script>
	</head>
	<body onload="init();" bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow-x:hidden;overflow-y:hidden;">
	<div style="position:absolute; z-index:2008;"><img width="30" height="30" src="" onclick="sava();"></div>
	<table>
	<tr>
	<td id='CQFY@2.1.2 拆迁费用@YJKFZC@1@ysfy1' rowspan='8' class='tr03'>
		</td>
	</tr>
	</table>
	 <div align="center" style="margin-top: 10px;"><h3><%=xmmc%>-资金管理</h3></div>
	   <%=table + "</table>"%>
	</body>
</html>
