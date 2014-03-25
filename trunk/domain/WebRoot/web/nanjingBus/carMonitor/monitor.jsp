﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<script src="../framework/js/jquery-1.8.1.js" type="text/javascript" language="javascript"></script>
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
<!-- 以下部分供菜单使用-->
	*,body,ul,li,h1,h2{ margin:0; padding:0; list-style:none;}
	body{font:12px "宋体"; padding-top:20px;}
	#menu { width:200px; margin:auto;}
	#menu h1 { cursor:pointer; color:#FFF; font-size:12px; padding:5px 0 3px 10px; border:#C60 1px solid; margin-top:1px;  background-color:#F93;}
	#menu h2 { cursor:pointer; color:#777; font-size:12px; padding:5px 0 3px 10px; border:#E7E7E7 1px solid; border-top-color:#FFF; background-color:#F4F4F4;}
	#menu ul { padding-left:15px; height:100px;border:#E7E7E7 1px solid; border-top:none;overflow:auto;}
	#menu ul li {padding:5px 0 3px 10px;}
	.no { display:none;}
</style>
<script language="JavaScript">
<!--菜单控制系列//
function ShowMenu(obj,noid){
	var block =	document.getElementById(noid);
	var n = noid.substr(noid.length-1);
	if(noid.length==4){
		var ul = document.getElementById(noid.substring(0,3)).getElementsByTagName("ul");
		var h2 = document.getElementById(noid.substring(0,3)).getElementsByTagName("h2");
		for(var i=0; i<h2.length;i++){
			h2[i].innerHTML = h2[i].innerHTML.replace("+","-");
			h2[i].style.color = "";
		}
		obj.style.color = "#FF0000";
		for(var i=0; i<ul.length; i++){if(i!=n){ul[i].className = "no";}}
	}else{
		var span = document.getElementById("menu").getElementsByTagName("span");
		var h1 = document.getElementById("menu").getElementsByTagName("h1");
		for(var i=0; i<h1.length;i++){
			h1[i].innerHTML = h1[i].innerHTML.replace("+","-");
			h1[i].style.color = "";
		}
		obj.style.color = "#0000FF";
		for(var i=0; i<span.length; i++){if(i!=n){span[i].className = "no";}}
	}
	if(block.className == "no"){
		block.className = "";
		obj.innerHTML = obj.innerHTML.replace("-","+");
	}else{
		block.className = "no";
		obj.style.color = "";
	}
}
//-->

//点击后menu变成搜索公交路线的东西
function showSearchPage1(){
	parent.showSearchPage();
}
//点击2路向服务器发请求，并获取到2路所有公交车的相关信息并动态添加出选项元素并打开。
function showMyBuses(lineId,spanId){
	$.post("/domain/service/rest/getCarMenu/getBusList",
			function(data){
				//alert(data);
				var str = "";
				var jsonObj = eval("("+data+")");
				for(var sub in jsonObj){
					var subObj = jsonObj[sub];
					$("#"+spanId).append("<h2 onclick='parent.displayBusOnMap("+subObj.location+")'>"+subObj.busCard+"("+subObj.status+")"+"</h2>");
				}
				$("#"+spanId).removeClass();
				//alert($("#"+spanId).html());
				parent.displayBusLineOnMap("2");
				
	});
}


</script>

</head>
<body>
	<div id="menu" >
	<h1 onClick="javascript:ShowMenu(this,'NO0')"> - 监察</h1>
	<span id="NO0" class="no">
		<a onClick="showSearchPage1();"><h2 > - 根据公交信息查询</h2></a>
	
		<h2 onClick="javascript:ShowMenu(this,'NO01')"> - 根据GPS编号查询</h2>
		
		<h2 onClick="javascript:ShowMenu(this,'NO02')"> - 暂留1-1</h2>
	
		<h2 onClick="javascript:ShowMenu(this,'NO03')"> - 暂留2-1</h2>
	
	</span>
    
	<h1 onClick="showMyBuses(2,'NO2')"> - 2路</h1>
	<span id="NO2" >
		

	</span>

<!--  </div>
	<div id="search_page" style="display:none">
		<h1>公交线路查询</h1>
		查询:<input id="search_info" />
		
	</div>-->
</body>
</html>
<script type="text/javascript">
function doLocation(){
	parent.addMark('坐标点');
}

</script>

