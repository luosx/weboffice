<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String name = ProjectInfo.getInstance().PROJECT_NAME;
	String resourcePath = basePath + "web/" + name + "/framework";
%>
<html>
	<head>
		<title>left</title>
		<meta http-equiv="X-UA-Compatible" content="IE=7">
	</head>
	<script><!--
function turn(){
 if(parent.content.cols=="211,9,*"){
 frameshow.src="<%=resourcePath%>/images/left/partline_right.png";
 oa_tree.title="显示";
 parent.document.getElementById("content").cols="0,9,*";
 parent.document.getElementById("content").rows=parent.document.getElementById("content").rows;
 //parent.content.cols="0,9,*";
}
else{
frameshow.src="<%=resourcePath%>/images/left/partline_left.png";
oa_tree.title="隐藏";
parent.document.getElementById("content").cols="211,9,*";
 parent.document.getElementById("content").rows=parent.document.getElementById("content").rows;
//parent.content.cols="211,9,*";
} 
	/*force ie10 redraw*/
	/*if(navigator.userAgent.indexOf('MSIE 7.0') != -1){
	var w = parent.document.body.clientWidth;
	parent.document.body.style.width = w + 1 + 'px';
	setTimeout(function(){
	parent.document.body.style.width = w - 1 + 'px';
	parent.document.body.style.width = 'auto';
	}, 0);
	}*/
}
function show()
{

	if(parent.content.cols=="0,9,*"){
		 frameshow.src="<%=resourcePath%>/images/left/partline_right.png";
		 oa_tree.title="显示";
		
		 parent.document.getElementById("content").cols="211,9,*";
		  parent.document.getElementById("content").rows=parent.document.getElementById("content").rows;
		  //parent.content.cols="211,9,*";
		 /*force ie10 redraw*/
		/*if(navigator.userAgent.indexOf('MSIE 7.0') != -1){
			var w = parent.document.body.clientWidth;
			parent.document.body.style.width = w + 1 + 'px';
			setTimeout(function(){
				parent.document.body.style.width = w - 1 + 'px';
				parent.document.body.style.width = 'auto';
			}, 0);
		}*/
	}
}
--></script>
	<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url('<%=resourcePath%>/images/left/partline.png');
	background-repeat: repeat-y;
}
</style>
	<body>

		<div id=oa_tree onclick="turn();" title=隐藏工具栏
			style="padding-top: 200px;">
			<img align="absmiddle" id=frameshow
				src="<%=resourcePath%>/images/left/partline_left.png">
		</div>

	</body>
</html>