<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>
		<TITLE>发现制止土地违法行为清单</TITLE>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<style type="text/css">

		</style>
		<script type="text/javascript">
			function save(){
				document.forms[0].submit();
			}		
		</script>
	</head>
	
<body bgcolor="#FFFFFF" onload="init();">
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1 style="font-size:20px;">发现制止土地违法行为清单</h1></div><br/>
<form method="post">
<div style="width:600px;text-align:left;">
<span style="font-size:14px;">填报单位：厦门市国土资源与房产管理局</span>
<span style="font-size:14px;padding-left: 200px;">计量单位：件、亩</span>
</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
 <tr>
 	<td>用地项目名称</td>
 	<td><input type="text" name="ydxmmc" id="ydxmmc" ></td>
 	<td>用地主体</td>
 	<td><input type="text" name="ydzt" id="ydzt" ></td>
 </tr>
 <tr>
 	<td>用地位置</td>
 	<td colspan="3"><input type="text" name="ydwz" id="ydwz" ></td>
 </tr>  
 <tr>
 	<td>占地面积</td>
 	<td><input type="text" name="zdmj" id="zdmj" ></td>
 	<td>耕地面积</td>
 	<td><input type="text" name="gdmj" id="gdmj" ></td>
 </tr> 
 <tr>
 	<td>建筑面积(m2)</td>
 	<td><input type="text" name="jzmj" id="jzmj" ></td>
 	<td>建筑现状</td>
 	<td><input type="text" name="jzxz" id="jzxz" ></td>
 </tr>  
 <tr>
 	<td>用途</td>
 	<td><input type="text" name="yt" id="yt" ></td>
 	<td>是否符合<br>土地利用<br>总体规划</td>
 	<td><select name="sffhtdlyztgh" id="sffhtdlyztgh"><option value="是">是</option><option value="否">否</option></select></td>
 </tr>
  <tr>
 	<td>发现时间</td>
 	<td><input type="text" name="fxsj" id="fxsj" style="background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly></td>
 	<td>制止情况</td>
 	<td><input type="text" name="zzqk" id="zzqk" ></td>
 </tr>
 <tr>
 	<td>制止通知书编号</td>
 	<td colspan="3"><input type="text" name="zztzsbh" id="zztzsbh" ></td>
 </tr> 
  <tr>
 	<td>违建制止后<br>继续制止</td>
 	<td><input type="text" name="wjzzhjxzz" id="wjzzhjxzz" ></td>
 	<td>有用地审批<br>且超占</td>
 	<td><input type="text" name="yydspqcz" id="yydspqcz" ></td>
 </tr> 
  <tr>
 	<td>违法类型</td>
 	<td colspan="3">
 		<select name="wflx" id="wflx">
 			<option value="本年批准本年建设(B)">本年批准本年建设(B)</option>
 			<option value="本年未批先建(W)">本年未批先建(W)</option>
 			<option value="本年批而未用(P)">本年批而未用(P)</option>
 			<option value="往年批而未用当年实地建设(PJ)">往年批而未用当年实地建设(PJ)</option>
 		</select>
 	</td>
 </tr> 
</table>
</form>
</div>
</body>
<script>
<%
	String msg = (String)request.getParameter("msg");
%>
if("<%=msg%>" == "success"){
	alert("表单保存成功");  
}
</script>
</html>
