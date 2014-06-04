<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.web.cbd.zxzjgl.ReportManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
   	String year="2014";
	String table="";
	List<Map<String, Object>> lr=null;
	List<Map<String, Object>> zc=null;
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
	User user = ManagerFactory.getUserManager().getUserWithId(userId);
	List<Role>  role = ManagerFactory.getRoleManager().getRoleWithUserID(userId);
	String rolename = role.get(0).getRolename();
	//String types[] = "ZJLR@ZJZC@YJKFZC@QQFY@CQFY@SZFY@CWFY@GLFY@CRZJFH@QTZC".split("@");
	//String edirots[] = "n@n@n@n@n@n@n@n@n@n".split("@");
	ReportManager re  = new ReportManager();
	table = re.getReport( year, rolename);
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
		<%@ include file="/base/include/ext.jspf" %>
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
  	$(document).ready(function () { 
		var width = document.body.clientWidth ;
		var height = document.body.clientHeight * 0.9;
       	FixTable("table", 0,3, width, height);
    });

 
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
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow-x:hidden;overflow-y:hidden;">
	 <div align="center" style="margin-top: 10px;"><h3>资金管理明细表</h3></div>
	   <%=table%>
	</body>

</html>
