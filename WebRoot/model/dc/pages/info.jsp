<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
var restUrl = "";

if(restUrl == null || restUrl == ""){
	var query = window.location.href;
	var ss = query.split("/");
	restUrl = "http://" + ss[2] + "/gisland/service/rest/";
}
</script>
<%@ include file="/base/include/ext.jspf" %>
<script type="text/javascript" src="<%=basePath%>base/gis/pages/framework/frameworkHttpRequest.js"></script>
<script src="<%=basePath%>/base/include/ajax.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>base/form/DatePicker/WdatePicker.js"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	margin-right: 1;
	height: 100%;
	background-color: #FFFFFF;
	font: normal 12px verdana;
}

.los {
	width: 100%;
	height: 30px;
	line-height:30px;
	background-image: url('images/left/left_bg.PNG');
}
</style>
<script type="text/javascript">
function analyse(obj){
var start=document.getElementById("startTime").value;
if(start==null||start==""){
  alert("请选择开始时间！");
  return;
}
var end=document.getElementById("endTime").value;
if(end==null||end==""){
  alert("请选择结束时间！");
  return;
}
 var path = "<%=basePath%>";
	    var actionName = "sHManageAC";
	    var actionMethod = "analyseXcHc";
	    var parameter="start="+start+"&end="+end;
		var r = ajaxRequest(path,actionName,actionMethod,parameter);
        var res=r.split("@");
        document.getElementById('result').innerHTML="<b>外业情况汇总:</b><br><br><font color='#00509F' size=2>共核查"+res[0]+"个图斑，总面积为"+res[1]+"亩。其中：<br>合法图斑"+res[2]+"个，涉及面积"+res[3]+"亩；<br>违法图斑"+res[4]+"个，涉及面积"+res[5]+"亩。<br><br>共巡查"+res[6]+"个图斑，总面积为"+res[7]+"亩。其中：<br>合法图斑"+res[8]+"个，涉及面积"+res[9]+"亩；<br>违法图斑"+res[10]+"个，涉及面积"+res[11]+"亩。</font><br><br>";
}
function exportXcAnalyse(){
 var path = "<%=basePath%>";
    var actionName = "sHManageAC";
	    var actionMethod = "expExcel";
	    var parameter="flag=0";
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		if(result){
		   window.open("downCG.jsp");
		}
}
function exportHcAnalyse(){
 var path = "<%=basePath%>";
    var actionName = "sHManageAC";
	    var actionMethod = "expExcel";
	    var parameter="flag=1";
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		if(result){
		   window.open("downCG.jsp");
		}
}
</script>
</head>

<body >
<div id='result' name='result' width:100%;height:30%;overflow:auto;">
</div>
<br>
开始时间：<input id="startTime" class="Wdate"  onClick="WdatePicker()"/>
<br>
结束时间：<input id="endTime"   class="Wdate"  onClick="WdatePicker()"/>
<div style="margin-top:10px">
<input  id="analyse" name="analyse" type="button" onclick='analyse(1)' value="外业情况统计" style="color:#00509F;width:120px"/><br>
</div><br>
<input  type="button" onclick='exportXcAnalyse()' value="导出巡查Execl" style="color:#00509F;width:120px"/>
<input  type="button" onclick='exportHcAnalyse()' value="导出核查Execl" style="color:#00509F;width:120px"/>
</body>
</html>
