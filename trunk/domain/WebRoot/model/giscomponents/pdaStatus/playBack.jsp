﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.klspta.common.util.Globals"%>
<%@page import="java.util.List"%>
<%@page import="com.klspta.common.util.UtilFactory"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    List xzqList=UtilFactory.getCommonCodeUtil().getCodeByID(Globals.getProjectCode() + "%");
    String xzq = UtilFactory.getCommonCodeUtil().transferCodeBeans2Option(xzqList);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="<%=basePath%>gisapp/pages/components/pdaStatus/timer.js"></script>
<script type="text/javascript" src="playBack.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>form/DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="<%=basePath%>/common/js/ajax.js"></script>
<script>
    var path = '<%=basePath%>';
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
        <td align="center"><input  id="start" name="start" type="button" onclick='check_playBack("dynamic")' value="回放" style="color:#00509F"/></td> 
        <td><input  id="cover" name="cover" type="button" onclick='check_playBack("static")' value="平铺显示" style="color:#00509F"/></td>
    </tr>
</table>
</body>
</html>