<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.klspta.base.util.impl.PublicCodeUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String pathGisland=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	String xzq = PublicCodeUtil.getInstance("NEW WITH UTIL FACTORY!").getCodeByIDAndRank2Option("330000");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="<%=basePath%>model/baiduMap/pdaStatus/timer.js"></script>
<script type="text/javascript" src="playBack.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>/base/form/DatePicker/WdatePicker.js"></script> 
<script src="<%=basePath%>/base/include/ajax.js"></script> 
<script>
	var path = '<%=basePath%>';
	var pathGisland='<%=pathGisland%>';

</script>
  <script type="text/javascript">
  function showResult(){
  	parent.parent.center.clearOverlays(); 
  	parent.parent.center.playBackAfterDrawAllPolygon(); 
  }
  </script>
<body>
<table style="font-size:13px">
	<tr>
	<td>所在政区：</td>
	<td>
		<select id="szzq" name="szzq" style="width:154px" onchange="onXSelectChange(this);">
		<option value='0'>-----------请选择----------</option>   
			<%=xzq %>
		</select>
	</td>
	</tr>
	<tr>
	<td>设备名称：</td>
	<td>
		<select id="sb" name="sb" style="width:154px" onchange="onDSelectChange(this);">
		</select>
	</td>
	</tr>
	<tr>
		<td>开始时间：</td><td><input id="startTime" name="startTime" class="Wdate"  onClick="WdatePicker()" onchange="onStSelectChange(this);"/></td>
	</tr>
	<tr>
		<td>结束时间：</td><td><input id="endTime" name="endTime" class="Wdate"  onClick="WdatePicker()" onchange="onEndSelectChange(this);"/></td>
	</tr>	
	<tr>
		<td align="center">
			<input  id="start" name="start" type="button" onclick='check_playBack("dynamic")' value="轨迹回放" style="color:#00509F;width:70px"/>
		</td> 
		<td>
			<input  id="cover" name="cover" type="button" onclick='parent.parent.center.reSetMap();check_playBack("static")' value="直接显示" style="color:#00509F"/>
			<input  id="clear" name="clear" type="button" onclick='parent.parent.center.clearOverlays();' value="清除" style="color:#00509F"/>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" id="GpsResult" name="GpsResult" value="显示全部图斑"  style="color:#00509F" />
		</td> 
	</tr>
</table>
<br><br>
<textarea id='notice' name='notice' cols=26 rows=6></textarea>
</body>
</html>