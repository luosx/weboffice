<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.PADDataManager"%>
<%@page import="com.klspta.web.jizeNW.xfjb.XfjbManager"%>
<%@page import="com.klspta.web.xiamen.xchc.XchcData"%>
<%
    String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

String yw_guid = request.getParameter("yw_guid");
String returnPath = request.getParameter("returnPath");
Object principal1 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String userid = ((User)principal1).getUserID();
if(yw_guid == null || yw_guid.equals("")){
	//yw_guid不存在时，创建一个新的yw_guid
	yw_guid = new XchcData().SetNewRecord(userid);
}
Map<String, Object> map = new PADDataManager().getXckcqkData(yw_guid);
String host = UtilFactory.getConfigUtil().getConfig("ftp.host");
int port = Integer.parseInt(UtilFactory.getConfigUtil().getConfig("ftp.port"));
String username = UtilFactory.getConfigUtil().getConfig("ftp.username");
String password = UtilFactory.getConfigUtil().getConfig("ftp.password");
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>现场巡查情况</title>
		<script src="SlideTrans.js"></script>
		<%@ include file="/base/include/newformbase.jspf"%>
		<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
			
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
	    	//保存表单方法
	function save(){
			document.forms[0].submit(); 
	}

</script>
	</head>
	<body onload="init(); return false;" style="text-align: left;">&nbsp; 
 	<div align="left" id="fixed" class="Noprn" style="position: fixed; top: 5px; left:0px"></div>	
	<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					实地巡查情况表
			</div>
			<br>
	<form method="post">
		<table width="600px" cellspacing="0" cellpadding="0"
			 align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29">
			<tr>
				<td width="15%">
					任务编号
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" readonly
						value="<%=yw_guid%>">
				</td>
				<td width="16%">
					巡查时间
				</td>
				<td width="32%">
					<input type="text" class="noborder" id="hcrq" name="hcrq"  >
				</td>
			</tr>
			<tr>
				<td>
					用地单位
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" id="yddw" name="yddw" >
				</td>
				<td>
					用地时间
				</td>
				<td colspan="2">
					<input type="text" class="noborder" id="ydsj" name="ydsj">
				</td>
			</tr>
						<tr>
				<td>
					巡查人
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" id="impuser" name="impuser" >
				</td>
				<td>
					所在政区
				</td>
				<td colspan="2">
					<input type="text" class="noborder" id="impxzq" name="impxzq" >
				</td>
			</tr>
		     <tr>
   				<td>
					建设项目
				</td>
				<td colspan="4">
					<input type="text" class="noborder" id="xmmc" name="xmmc">
				</td>

			</tr>
			<tr>
				<td>
					建设情况
				</td>
				<td colspan="4" align="left">
					<textarea align="left" cols="45" class="noborder" id="jsqk" name="jsqk"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					建设面积
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" id="mj" name="mj" >
				</td>
			</tr>
			<tr>
				<td>
					地方查处情况
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" id="dfccqk" name="dfccqk" >
				</td>
			</tr>
			<tr>
				<td>
					现场情况描述
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" id="xcms" name="xcms" >
				</td>
			</tr>
			<tr>
		     	<td>
				违法违规类型
				</td>
				<td colspan="4">
					<input type="text" class="noborder" id="wfwglx" name="wfwglx" >
				</td>
			</tr>
		</table>
		</form>
		<br>
		<center>
			<div class="container" id="idContainer2" align="center" >
				<ul id="idSlider2">
					<%
						String[] images = map.get("ZPBH") == null ? null : map.get(
									"ZPBH").toString().split(",");
							if (images != null) {
								for (int i = 0; i < images.length; i++) {
					%>
					
						<img 
							src="ftp://<%=username%>:<%=password%>@<%=host%>:<%=port%>/<%=images[i]%>.jpg"
							alt="图片上传预览" />
					<br/>

					<%
						}}
					%>
				</ul>
				<ul class="num" id="idNum">
				</ul>
			</div>
			<br />

		</center>

	</body>
</html>
