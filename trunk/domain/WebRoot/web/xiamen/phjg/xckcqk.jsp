<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.PADDataManager"%>
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
input{
	height:25px;
	background:none;
	
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
	<body onLoad="init(); return false;" style="text-align: left;">&nbsp; 
 	<div align="left" id="fixed" class="Noprn" style="position: fixed; top: 5px; left:0px"></div>	
	<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					实地巡查情况表
			</div>
			<br>
		<form method="post">
		<table width="600px" cellspacing="0" cellpadding="0" align='center' border='1' style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29; border-bottom:none; background:#ffffff">
		 <tr>
		 	<td>项目名称</td>
		 	<td colspan="3"><input type="text" name="phjgxmmc" id="phjgxmmc" ></td>
		 </tr>
		 <tr>
		 	<td>用地单位</td>
		 	<td><input type="text" name="phjgyddw" id="phjgyddw" ></td>
		 	<td>单位类型</td>
		 	<td><input type="text" name="phjgdwlx" id="phjgdwlx" ></td>
		 </tr>  
		 <tr>
		 	<td>批准文号</td>
		 	<td><input type="text" name="phjgpzwh" id="phjgpzwh" ></td>
		 	<td>批准日期</td>
		 	<td><input type="text" name="phjgpzrq" id="phjgpzrq" ></td>
		 </tr> 
		 <tr>
		 	<td>取得方式</td>
		 	<td><input type="text" name="phjghdfs" id="phjghdfs" ></td>
		 	<td>批准用途</td>
		 	<td><input type="text" name="phjgpzyt" id="phjgpzyt" ></td>
		 </tr>  
		 <tr>
		 	<td>土地坐落</td>
		 	<td colspan="3"><input type="text" name="phjgtdzl" id="phjgtdzl" ></td>
		 </tr>
		 <tr>
		 	<td>土地现状</td>
		 	<td><input type="text" name="phjgtdxz" id="phjgtdxz" ></td>
		 	<td colspan="2"><input type="text" name="phjgtdxzduo" id="phjgtdxzduo" ></td>
		 </tr>
		  <tr>
		 	<td>上级用地部门备注</td>
		 	<td colspan="3"><input type="text" name="phjgsjydbmbz" id="phjgsjydbmbz" ></td>
		 </tr>
		  <tr>
		 	<td>国土所备注</td>
		 	<td colspan="3"><input type="text" name="phjggtsbz" id="phjggtsbz" ></td>
		 </tr>
		</table>
		</form>
		<% 
			if (map != null) { 
		%>
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
						}
					%>
				</ul>
				<ul class="num" id="idNum">
				</ul>
			</div>
			<br />
			<%
				}
			%>
		</center>
		<%
			}
		%>
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
