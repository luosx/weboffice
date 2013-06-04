<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String yw_guid=request.getParameter("yw_guid");
%>

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

.STYLE7 {
	font-size: 24px;
	font-weight: bold;
}

.P{
	borderLeft: thin hidden #FF0000;
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
		 	     	用地情况调查表(未备案)
	 	       	</div>
			  	<div style="text-align: right; width: 80%;">
			    	<input name="BH" class="myinput" id="yxxsbh" type="text" size="15" readonly="readonly" style="border:0" />
			  	</div>
			  	
         		<table   style="BORDER-COLLAPSE: collapse" borderColor=#787878 cellPadding=1  align=center border=1 >
         		
         			
         			<tr>
         				<td bgcolor="#BCEE68" rowspan="13" align=center><span class="STYLE1" >现场记录</span></td>
         				<td  align="center" >序   号</td>
         				<td ><input name="xh" type="text" style="border:0" size=30% ></td>
         				<td  align="center">坐落</td>
         				<td ><input name="zl" type="text" style="border:0" size=30%></td>
         			</tr>
         		
         			<tr>
         				<td align="center">用地单位</td>
         				<td><input type="text" name="yddw" style="border:0" size=30% ></td>
         				<td align="center">面积</td>
         				<td><input type="text" name="mj" size=30%></td>
         			</tr>
         			<tr>
         				<td align="center">农用地</td>
         				<td colspan="3"><input type="text" name="nyd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">农用地其中耕地</td>
         				<td colspan="3"><input type="text" name="gengd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">建设用地</td>
         				<td colspan="3"><input type="text" name="jsyd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">未利用地</td>
         				<td colspan="3"><input type="text" name="wlyd" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">符合规划</td>
         				<td colspan="3"><input type="text" name="fhgh" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">不符合规划</td>
         				<td colspan="3"><input type="text" name="bfhgh" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td align="center">占用基本农田</td>
         				<td colspan="3"><input type="text" name="zyjbnt" style="border:0" cols="60" size=75%></td>
         			</tr>
         			<tr>
         				<td  align="center">任务名称</td>
         				<td colspan="3" ><input name="rwmc" id="rwmc" type="text" style="border:0" cols="60" size=75%></td>
         			</tr>	
         			<tr>
         				<td align="center">用地时间</td>
         				<td colspan="3" ><input type="text" name="ydsj" class="Wdate" style="border:0" size=25 onClick="WdatePicker()" readonly ></td>
         			</tr>
         			
         			<tr>
         				<td align="center">坐   标</td>
         				<td colspan="3" ><input type="text" name="zb" style="border:0" size=75%></td>
         			</tr>
         			
         			<tr>
         				<td align="center">建设情况</td>
         				<td colspan="3">
         					<input type="radio" name="jsqk" value="PC" />平场
  							<input type="radio" name="jsqk" value="ZJ" />在建
							<input type="radio" name="jsqk" value="JC" />建成
         				</td>
         			</tr>
         	
         			<tr>
         				<td rowspan="4" bgcolor="#BCEE68" align=center><span class="STYLE1" >核实补录</span></td>
         				<td align="center" >合法用地</td>
         				<td colspan="3">
         					<input type="radio" name="hfyd" color=#191970 value="YES" />是
  							<input type="radio" name="hfyd" color=#DC143C value="NO" />否
  						</td>
  					</tr>
         	
         			<tr>
         				<td align="center">违法违规用地</td>
         				<td colspan="3"><input type="radio" name="wfwglx" value="FFPD" >非法批地<br/>
  							<input type="radio" name="wfwglx" value="WBJY" />未报即用<br/>
							<input type="radio" name="wfwglx" value="BBBY" />边报边用<br/>
							<input type="radio" name="wfwglx" value="WGXY" />未供先用<br/>
							<input type="radio" name="wfwglx" value="WFCYZC" />违反产业政策<br/>
							<input type="radio" name="wfwglx" value="WFZPG" />违反招拍挂<br/>
							<input type="radio" name="wfwglx" value="BCBDW" />补偿不到位<br/>
							<input type="radio" name="wfwglx" value="QT" />其他
						</td>
					</tr>
         			
         			<tr>
         				<td align="center">地方查处情况</td>
         				<td colspan="3">
         					<input type="radio" name="dfccqk" value="YFCC" />依法查处
							<input type="radio" name="dfccqk" value="WYFCC" />未依法查处
         				</td>
         			</tr>
         		
         			<tr>
         				<td align="center">备   注</td>
         				<td colspan="3">
         					<textarea colspan="3" name="bz" rows="5" cols="60" ></textarea>
         				</td>
         			</tr>
         	</table>
         	<div style="text-align: center;">
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