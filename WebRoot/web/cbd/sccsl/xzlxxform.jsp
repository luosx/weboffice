<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.cbd.sccsl.XzlzjjcManager"%>

<%
    String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

String bh = request.getParameter("bh");
String yw_guid = request.getParameter("yw_guid");
String type=request.getParameter("type");
Map<String, Object> map = new XzlzjjcManager().getXZLData(bh);
String returnPath = request.getParameter("returnPath");
String edit = request.getParameter("edit");
if (edit == null || !edit.equals("false")) {
	edit = "true";
}
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>现场巡查情况</title>
		<script src="SlideTrans.js"></script>
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/newformbase.jspf"%>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
			
				<style type="text/css">
body {
	height: 700px;
}

.container,.container img {
	width: 600px;
	height: 400px;
	border: 0;
	vertical-align: top;
}

.container ul,.container li {
	list-style: none;
	margin: 0;
	padding: 0;
}

</style>
			
		<script language="javascript">
	  function back(){
	   this.parent.location.href="<%=returnPath%>";
	  }
	  function save(){
	      putClientCommond("xzlzjjc","saveXzlzj");
	      var zj = document.getElementById("zj").value;
	      var sj = document.getElementById("sj").value;
	      var xzlmc = document.getElementById("xzlmc").value;
	      putRestParameter("zj",zj);
	      putRestParameter("sj",sj);
	      putRestParameter("xzlmc",escape(escape(xzlmc)));
	      putRestParameter("bh","<%=bh%>");
	      myData = restRequest();
	      document.forms[0].submit();
	      if(myData){
	      alert("保存成功！");
	      }else{
	      alert("保存失败！");
	      }
	  }
	  
</script>
	</head>

	<body onload="init();" style="text-align: left;">&nbsp; 
 
		<% 
			if (map != null) { 
		%>
		
	<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					写字楼信息及租金情况
			</div>
			<br>
			<form id="form">
		<table width="1000px" cellspacing="0" cellpadding="0"
			 align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29">
			<tr>
				<td width="14%" colspan="2">
					编号
				</td>
				<td align="left" width="36%">
					<input type="text" class="noborder" name="bh">
				</td>
				<td width="10%">
					写字楼名称
				</td>
				<td  colspan="3" width="40%">
					<input type="text" class="noborder" name="xzlmc" id="xzlmc">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					开发商
				</td>
				<td align="left" >
					<input type="text" class="noborder" name="kfs">
				</td>
				<td>
					投资方
				</td>
				<td colspan="3">
					<input type="text" class="noborder" name="tzf" >
				</td>
			</tr>
			<tr>
				<td colspan="2">
					租金
				</td>
				<td align="left" >
					<input type="text" class="noborder" name="zj" id="zj"
						value="<%=map.get("zj") == null ? "" : map.get("zj")%>">
				</td>
				<td>
					售价
				</td>
				<td colspan="3">
					<input type="text" class="noborder" name="sj" id="sj"
						value="<%=map.get("sj") == null ? "" : map.get("sj")%>">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					物业公司
				</td>
				<td colspan="5" align="left">
					<input type="text" class="noborder" name="wygs">
				</td>
			</tr>
		    <tr>
		     	<td rowspan="2" >
					产品
				</td>
				<td width="10%">产品定位</td>
				<td colspan="5">
					<input type="text" class="noborder" name="cpdw">
				</td>
			</tr>
			<tr>
				<td width="10%">产品类型</td>
				<td >
					<input type="text" class="noborder" name="cplx">
				</td>
				<td width="10%">产业类型</td>
				<td colspan="3">
					<input type="text" class="noborder" name="cylx">
				</td>
			</tr>	
			 <tr>
		     	<td rowspan="7" >
					项目
				</td>
				<td width="10%">入住企业</td>
				<td colspan="5">
					<input type="text" class="noborder" name="rzqy">
				</td>
			</tr>
			<tr>
				<td width="10%">开盘时间</td>
				<td >
					<input type="text" class="noborder" name="kpsj">
				</td>
				<td width="10%">预售许可证</td>
				<td colspan="3">
					<input type="text" class="noborder" name="ysxkz">
				</td>
			</tr>
			<tr>
				<td width="10%">成本测算</td>
				<td >
					<input type="text" class="noborder" name="cbcs">
				</td>
				<td width="10%">楼层</td>
				<td colspan="3">
					<input type="text" class="noborder" name="lc">
				</td>
			</tr>		
			<tr>
				<td width="10%">标准层高</td>
				<td >
					<input type="text" class="noborder" name="bzcg">
				</td>
				<td width="10%">外墙</td>
				<td colspan="3">
					<input type="text" class="noborder" name="wq">
				</td>
			</tr>		
			<tr>
				<td width="10%">采暖</td>
				<td >
					<input type="text" class="noborder" name="cn">
				</td>
				<td width="10%">供电</td>
				<td colspan="3">
					<input type="text" class="noborder" name="gd">
				</td>
			</tr>
			<tr>
				<td width="10%">供水</td>
				<td >
					<input type="text" class="noborder" name="gs">
				</td>
				<td width="10%">电梯</td>
				<td colspan="3">
					<input type="text" class="noborder" name="dt">
				</td>
			</tr>
			<tr>
				<td width="10%">固定车位</td>
				<td >
					<input type="text" class="noborder" name="gdcw">
				</td>
				<td width="10%">停车位租价</td>
				<td >
					<input type="text" class="noborder" name="tcwzj">
				</td>
				<td width="10%">使用率</td>
				<td >
					<input type="text" class="noborder" name="syl">
				</td>
			</tr>
			<tr>
				<td colspan="2">其他</td>
				<td colspan="5">
					<input type="text" class="noborder" name="qt">
				</td>
			</tr>
		</table>
		</form>
		<center>
				<br>
				<br>
				<br>
				<br>
				<div>
					<button type="submit"  onclick="save();" style="width: 50px;height: 30px;">保存</button>
				</div> 
			</center>
		<%} %>
		<br>
		

	</body>
</html>
