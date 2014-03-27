<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
	
	h1 {  color:#FFF; font-size:12px; padding:5px 0 3px 10px; border:#C60 1px solid; margin-top:1px;  background-color:#F93;text-align:center;}
	#searchResult {border:2px solid black;width:90%;height:230px;overflow-y:auto; overflow-x:auto;margin-left: auto; margin-right: auto;}
	span {text-decoration:none;font-size:13px}
	a{text-decoration:none;color:#ffffff}
	button{cursor:pointer;}
	#search_div {margin-left: auto; margin-right: auto;text-align: center}
	#search{background-color:#6F7071;color:#FFFFFF;opacity:0.8;border:0;width:50px;height:22px;border-radius:4px 4px 4px 4px}
	#back {background-color:#6F7071;color:#FFFFFF;opacity:0.8;border:0;width:80px;height:22px;border-radius:4px 4px 4px 4px}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=q3i2iXOKCWLVGY4hddgk92I9"></script>
<script src="../framework/js/jquery-1.8.1.js" type="text/javascript" language="javascript"></script>
<title>南京智能公交监察系统</title>
</head>
<body>
	<h1>公交线路查询</h1>
	
	<div id="search_div">
		<input id="busInfo" />&nbsp&nbsp<button id="search" onclick="search();">搜索</button>
	
		</br></br>
	
		<div id="searchResult"></div>
		</br>
		<button id="back" onclick="backToMain();">返回</button>
	</div>
</html>
<script type="text/javascript">
function backToMain(){
	parent.showMain();
}

//公交路线搜索服务
/*
var map = parent.map;

var busline = new BMap.BusLineSearch(map,{
    renderOptions:{map:map},
        onGetBusListComplete:function(result){
        	alert(result);
           if(result) {
             var fstLine = result.getBusListItem(0);//获取第一个公交列表显示到map上
             
             busline.getBusLine(fstLine);
           }
        }
});
*/
function search(){
    var busName = parseInt($("#busInfo").val());
   // alert(parent.map);
    //alert(busline);
    //alert(busName);
    parent.busSearch(busName);
}


//展示查询公交路线的结果
var searchResult = null;
function showResult(result){
	searchResult = result;
	var innerHtml = "";
	for(var i=0;i<result.getNumBusList();i++){
		var busListItem = result.getBusListItem(i);
		innerHtml = innerHtml + "<a href='javascript:showResultOnMap("+i+");'><span>"+busListItem.name+"</span></a></br>";
		
	}
	$("#searchResult").html(innerHtml);
}
//在之前父页面的地图上显示点选的查询结果
function showResultOnMap(num){
	parent.busline.getBusLine(searchResult.getBusListItem(num));
}
</script>

