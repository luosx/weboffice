<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String yw_guid = request.getParameter("yw_guid");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>信访地图标注</title>
 	<%@ include file="/base/include/restRequest.jspf" %>
<style >
html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }
.map_nav{ width:150px; height:29px; line-height:20px;background:url(images/nav_m.png) no-repeat;  position:absolute; top:52px; right:70px; z-index:1000;}
.map_nav ul {margin-left:6px;margin-top:4px;}
.map_nav li img{ cursor: pointer; margin-left:1px;}
.map_nav li{ float:left; width:40px;}
.map_nav span{ padding:0px 7px; cursor:pointer; display:block; color: #666; }
</style>
</head>
  <script type="text/javascript">
	/*保存标注*/
	function saveBiaoZhu(){
		if(confirm('是否要保存标注坐标？')){
			var temp = document.centerframe.center.lower.tempValue;
			if(temp != "undefined"){
				putClientCommond("xfAction","saveBiaozhu");
				putRestParameter("strzb",temp);
				putRestParameter("yw_guid","<%=yw_guid%>");
				var flag = restRequest();
				if(flag == "1"){
					alert("标注保存成功！");
				}
			}
		}
	}
	/*点标注*/
	function setPoint(){
		document.centerframe.center.drawPoint();
	}
	/*面标注*/
	function drawLine(){
		document.centerframe.center.drawPolygon();
	}
	/*删除标注*/
	function deleteBiaoZhu(){
		if(confirm('是否要删除标注坐标？')){
			putClientCommond("xfAction","deleteBiaozhu");
			putRestParameter("yw_guid","<%=yw_guid%>");
			var flag = restRequest();
			if(flag == "1"){
				alert("标注信息已被删除！");
				document.frames("centerframe").document.location="<%=basePath%>base/fxgis/framework/gisViewFrame.jsp?dtbzflag=true&yw_guid=<%=yw_guid%>";
			}
		}
	}
</script>
	<body bgcolor="#FFFFFF">
		<div id="statusTab" style="width:100%"></div>
		<div id="tab" class="map_nav" style="width:480px;height:150px;position:absolute;margin-right:10px; top:50px;display:block; ">
			<ul>
			  <li><span id="point" onClick='setPoint()'><div style='width:45px;padding-left:2px;padding-top: 2px'>点标注</div></span></li>
			  <li><span id="areas" onClick='drawLine()' ><div style='width:45px;padding-left:2px;padding-top: 2px'>面标注</div></span></li>
		      <li><span id="save" onClick='saveBiaoZhu()'><div style='width:55px;padding-left:2px;padding-top: 2px'>保存标注</div></span></li>
		      <li><span id="save" onClick='deleteBiaoZhu()'><div style='width:55px;padding-left:2px;padding-top: 2px'>删除标注</div></span></li>
	        </ul>
   		</div>
		<iframe id="centerframe" name="centerframe"  style="width: 100%; height:100%;overflow: auto;border: 0px" src="<%=basePath%>base/fxgis/framework/gisViewFrame.jsp?dtbzflag=true&yw_guid=<%=yw_guid%>"></iframe>
	</body>
</html>
