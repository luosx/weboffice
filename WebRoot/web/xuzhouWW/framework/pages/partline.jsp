<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String name = ProjectInfo.getInstance().PROJECT_NAME;
String resourcePath=basePath+"web/"+name+"/framework";
%>
<html>
<head>
<title>left</title>
</head>
<script>
function turn(){
 if(parent.content.cols=="261,7,*"){
 frameshow.src="<%=resourcePath%>/images/left/partline_right.png";
 oa_tree.title="显示";
	top.left.cols="0,*";
 parent.content.cols="0,7,*";
}
else{
frameshow.src="<%=resourcePath%>/images/left/partline_left.png";
oa_tree.title="隐藏";
 top.left.cols="6,*";
parent.content.cols="261,7,*";} 
}
</script>
<style type="text/css">
body { margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px;
background-image : url('../images/split/menu_bk.PNG');background-repeat : repeat-y;
}
</style>
<body >

					<div  id=oa_tree onclick="turn();" title=隐藏工具栏 style="padding-top:200px;">
						<img align="absmiddle" id=frameshow src="<%=resourcePath%>/images/left/partline_left.png">
					</div>
	
</body>
</html>