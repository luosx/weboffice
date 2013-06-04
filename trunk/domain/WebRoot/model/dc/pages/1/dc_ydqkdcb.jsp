<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String yw_guid=request.getParameter("yw_guid");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<style type="text/css">
<!--
.STYLE1 {
	font-size: 16px;
	font-weight: bold;
}

.STYLE6 {
	font-size: 24px;
	font-weight: bold;
}

.P{
	borderLeft: thin hidden #FF0000;
}

.STYLE7 {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>
<html>
	<head>
	<base target="_self" /> 
		<title  >用地情况调查表</title>
		<%@ include file="/form/formbase.jspf" %>
	</head>
	
	<body onload="init()">
		     <form method="post" id='form1' name='form1'>
		     	<div align="center" class="STYLE7">
		 	     	用地情况调查表（已备案）
	 	       	</div>
			  	
			  	
         		<table   style="BORDER-COLLAPSE: collapse" borderColor=#787878 cellPadding=1  align=center border=1 >
         			<tr>
         				<td bgcolor="#BCEE68" rowspan="20" align=center><span class="STYLE1" >现场记录</span></td>
         				<td  align="center" >序号</td>
         				<td ><input name="xh" type="text" style="border:0" size=75%></td>
         			</tr>
         			<tr>
         				<td  align="center">任务名称</td>
         				<td ><input name="rwmc" type="text" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td  align="center">坐落</td>
         				<td ><input name="zl" type="text" style="border:0" cols="60" size=75%></td>
         			</tr>
         		
         			<tr>
         				<td align="center">面积</td>
         				<td><input type="text" name="mj" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">农用地</td>
         				<td><input type="text" name="nyd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">农用地其中耕地</td>
         				<td><input type="text" name="gengd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">建设用地</td>
         				<td><input type="text" name="jsyd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">未利用地</td>
         				<td><input type="text" name="wlyd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">符合规划</td>
         				<td><input type="text" name="fhgh" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">不符合规划</td>
         				<td><input type="text" name="bfhgh" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">占用基本农田</td>
         				<td><input type="text" name="zyjbnt" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">压盖审批面积</td>
         				<td><input type="text" name="ygspmj" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">压盖审批比率</td>
         				<td><input type="text" name="ygspbl" style="border:0" cols="60" size=75%></td>
         			</tr>		
         			<tr>
         				<td align="center">压盖供地面积</td>
         				<td><input type="text" name="yggdmj" style="border:0" cols="60" size=75%></td>
         			</tr>	
         			<tr>
         				<td align="center">压盖供地比率</td>
         				<td><input type="text" name="yggdbl" style="border:0" cols="60" size=75%></td>
         			</tr>
         			
         			<tr>
         				<td align="center">坐标</td>
         				<td ><input type="text" name="zb" style="border:0" cols="60" size=75%></td>
         			</tr>
         			
         			<tr>
         				<td align="center">批准时间</td>
         				<td  ><input type="text" name="spsj"  class="Wdate" style="border:0" cols="60" size=25 onClick="WdatePicker()" readonly></td>
         			</tr>
         			<tr>
         				<td align="center">审批项目名称</td>
         				<td  ><input type="text" name="spxmmc"  style="border:0" cols="60" size=75%></td>
         			</tr>
         			
         			<tr>
         				<td align="center">供地时间</td>
         				<td ><input type="text" name="gdsj" class="Wdate" onClick="WdatePicker()" readonly style="border:0" cols="60" size=25></td>
         			</tr>
         		<tr>
         				<td align="center">供地项目名称</td>
         				<td ><input type="text" name="gdxmmc" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td bgcolor="#BCEE68" rowspan="2" align=center><span class="STYLE1" >核实补录</span></td>
         					<td colspan="3" >
         					<input type="radio" name="hcbl" value="PEWZ" >批而未征<br/>
  							<input type="radio" name="hcbl" value="XZ" />闲置<br/>
							<input type="radio" name="hcbl" value="WFCYZC" />违反产业政策<br/>
							<input type="radio" name="hcbl" value="WFZPG" />违反招拍挂<br/>
							<input type="radio" name="hcbl" value="QT" />其他
						</td>
         			</tr>
         			
         			<tr>
         				<td align="center">备   注</td>
         				<td colspan="3">
         					<textarea name="bz" rows="5" cols="60" ></textarea>
         				</td>
         			</tr>
         				
         	</table>
         	
         	<div style="text-align: center; ">
         	<input  id="1" type="button" value="保存" onclick='submitForm();window.close();'/>&nbsp;&nbsp;&nbsp;&nbsp;
            <input  id="uploadfile" type="button" value="上传" onClick='uploadphoto()'/>     	
			</div>	
			<input  name="status" type='hidden'>
        </form> 
	</body>
</html>
<script>
function submitForm(){
	var path = "<%=basePath%>";
    var actionName = "sHManageAC";
    var actionMethod = "updateStatus";
    var parameter="yw_guid=<%=yw_guid%>&flag=1";
	var result = ajaxRequest(path,actionName,actionMethod,parameter);
	document.getElementById('status').value=1;
    document.form1.submit();
}
function takephoto(){
    var Shell=new ActiveXObject("WScript.Shell"); 
    try{ 
        var para="C:\\klspta\\PhotoTake\\PhotoTake.exe"+" "+"d:\\photos\\" + " " + "<%=yw_guid%>"+ " " + " ";
        a.exec(para);
    } catch(e) { 
        Ext.Msg.alert('提示','您的电脑未安装此程序，或安装路径不正确，请系统管理员。'); 
    } 
}

function uploadphoto(){
    var rwmc = document.getElementById('rwmc').value.replace(' ','');
    var Shell=new ActiveXObject("WScript.Shell"); 
    try{ 
        var para = "C:\\klspta\\uploadfile.exe"+" "+"d:\\photos\\" + " " + "<%=yw_guid%>"+ " " + rwmc + " " + "50";
        Shell.exec(para);
    } catch(e) { 
        alert('提示','您的电脑未安装此程序，或安装路径不正确，请系统管理员。'); 
    } 
}
</script>