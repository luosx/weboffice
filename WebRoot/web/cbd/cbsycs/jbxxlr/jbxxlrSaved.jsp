<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.cbsycs.jbxxlr.EnterManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid = request.getParameter("yw_guid");
String strMsg = request.getParameter("msg");
EnterManager enterManager = new EnterManager();
List<List<Map<String, Object>>> resultList = enterManager.getSavedFields(yw_guid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>区域成本及收益测算</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="/base/form/css/commonForm.css" type="text/css" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
  <script type="text/javascript">
  	//保存表单方法
	function formSave(){
		document.forms[0].submit();
	}
	
	//提示信息
	function alertMsg(){
		if("<%=strMsg%>" == "success"){
			alert("数据保存成功");
		}
	}
  </script>
  <style type="text/css">
	table{
		border-left-color:#000000;
		border-left-style:solid;
		border-left-width:1px;
		border-top-color:#000000;
		border-top-style:solid;
		border-top-width:1px;
	}
    td{
		border-right-color:#000000;
		border-right-style:solid;
		border-right-width:1px;
		border-bottom-color:#000000;
		border-bottom-style:solid;
		border-bottom-width:1px;
		}
  
  </style>
  <body onload = "alertMsg()">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px">
  		<img src="base/form/images/save.png" onclick="formSave()" style="cursor:hand" title="保存"/><br/>
  		<img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>
  	</div>
  	<div align="center">
		<h1>
			基本地块数据登记表
		</h1>
	</div>
	<form method="post" action="<%=basePath%>service/rest/basicInfo/saveData?yw_guid=<%=yw_guid %>">
		<table cellpadding="0" cellspacing="0" align="center" style="border:1px, #000000, solid">
			<tr>
				<td>
					<label>基本地块编号</label>
				</td>
				<td>
					<input type="text" id="jbdkbh" name="jbdkbh" >
				</td>
				<td>
					<label>所属区域</label>
				</td>
				<td>
					<select id="qua">
						<option>CBD中心区小计</option>
					</select>
					<select id="qub">
						<option>针织路西侧项目</option>
					</select>
				</td>
			</tr>
			<%
				String strControl = "disabled";
				int temp = 0;//用于控制一个td显示两个字段
				for (int i = 0; i < resultList.size(); i++) {
					%>
					<tr><td colspan="4" bgcolor="#0099CC"><label><%=resultList.get(i).get(0).get("shuxing") %></label></td></tr>
					<%
					temp = resultList.get(i).size();//将字段个数赋值给temp
					for (int j = 0; j < resultList.get(i).size();) {
						%>
						<tr>
							<td><label><%=resultList.get(i).get(j).get("ziduanming") %></label></td>
							<td><input type="text" id="<%=resultList.get(i).get(j).get("bieming") %>" name="<%=resultList.get(i).get(j).get("bieming") %>" value="<%=resultList.get(i).get(j).get("value")==null || resultList.get(i).get(j).get("value").equals("null")?"":resultList.get(i).get(j).get("value") %>" <%=resultList.get(i).get(j).get("fangshi").equals("公式")?"disabled":"" %>></td>
							<%
								if(j+1 == temp){//用于规避数组越界
									break;
								}
							%>
							<td><label><%=resultList.get(i).get(j+1).get("ziduanming") %></label></td>
							<td><input type="text" id="<%=resultList.get(i).get(j+1).get("bieming") %>" name="<%=resultList.get(i).get(j+1).get("bieming") %>" value="<%=resultList.get(i).get(j+1).get("value")==null || resultList.get(i).get(j+1).get("value").equals("null")?"":resultList.get(i).get(j+1).get("value") %>" <%=resultList.get(i).get(j+1).get("fangshi").equals("公式")?"disabled":"" %>></td>
						</tr>
						<%
						j = j + 2;
					}
				}
			%>
		</table>
	</form>
  </body>
</html>
