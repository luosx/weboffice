<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.bean.ftputil.FTPOperation"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.DtxcManager"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.PADDataManager"%>
<%
    String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

String yw_guid = request.getParameter("yw_guid");

String type=request.getParameter("type");
Map<String, Object> map = new PADDataManager().getWphcData(yw_guid);
String returnPath = request.getParameter("returnPath");
String edit = request.getParameter("edit");
if (edit == null || !edit.equals("false")) {
	edit = "true";
}
String host = UtilFactory.getConfigUtil().getConfig("ftp.host");
int port = Integer.parseInt(UtilFactory.getConfigUtil().getConfig("ftp.port"));
String username = UtilFactory.getConfigUtil().getConfig("ftp.username");
String password = UtilFactory.getConfigUtil().getConfig("ftp.password");
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>现场巡查情况</title>
		<script src="SlideTrans.js"></script>
		<%@ include file="/base/include/restRequest.jspf"%>
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
	      var xjclyj="";
	      var xjyj = document.getElementsByName('xjclyj');
	      for(vi = 0; vi < xjyj.length; vi++ ){
	      	if(xjyj[vi].checked){
	      		xjclyj = xjyj[vi].value;
	      	}
	      }
	      var xjbz=document.getElementById('xjbz').value;
	      putClientCommond("dtcc","saveXckcqkData");
	      putRestParameter("xjclyj",escape(escape(xjclyj)));
	      putRestParameter("xjbz",escape(escape(xjbz)));
	      putRestParameter("yw_guid","<%=yw_guid%>");
	      myData = restRequest();
	      if(myData=="true"){
	      alert("保存成功！");
	      }else{
	      alert("保存失败！");
	      }
	  }
	  
	   function init(){
	  	var xjclyj = '<%=map.get("xjclyj")%>';
	  	var xjyj = document.getElementsByName('xjclyj');
	  	for(vi = 0; vi < xjyj.length; vi++){
	  		if(xjyj[vi].value == xjclyj){
	  			xjyj[vi].checked = true;
	  		}
	  	}
	  }
</script>
	</head>

	<body onload="init();" style="text-align: left;">&nbsp; 
 
		<% 
			if (map != null) { 
		%>
		
	<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					实地巡查情况表
			</div>
			<br>
		<table width="600px" cellspacing="0" cellpadding="0"
			 align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29">
			<tr>
				<td width="15%">
					任务编号
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("yw_guid") == null ? "" : map.get("yw_guid")%>">
				</td>
				<td width="16%">
					巡查时间
				</td>
				<td width="32%">
					<input type="text" class="noborder" readonly
						value="<%=map.get("HCRQ") == null ? "" : map.get("HCRQ")%> ">
				</td>
			</tr>
			<tr>
				<td>
					用地单位
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("YDDW") == null ? "" : map.get("YDDW")%>">
				</td>
				<td>
					用地时间
				</td>
				<td colspan="2">
					<input type="text" class="noborder" readonly
						value="<%=map.get("YDDW") == null ? "" : map.get("YDDW")%>">
				</td>
			</tr>
						<tr>
				<td>
					巡查人
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("IMPUSER") == null ? "" : map.get("IMPUSER")%>">
				</td>
				<td>
					所在政区
				</td>
				<td colspan="2">
					<input type="text" class="noborder" readonly
						value="<%=map.get("IMPXZQ") == null ? "" : map.get("IMPXZQ")%>">
				</td>
			</tr>
		     <tr>
		     				<td>
					建设项目
				</td>
				<td colspan="4">
					<input type="text" class="noborder" readonly
						value="<%=map.get("XMMC") == null ? "" : map.get("XMMC")%>">
				</td>

			</tr>
			<tr>
				<td>
					建设情况
				</td>
				<td colspan="4" align="left">
					<textarea align="left" cols="45" class="noborder" readonly><%=map.get("JSQK") == null ? "" : map.get("JSQK")%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					建设面积
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" readonly value=<%=map.get("MJ") == null ? "" : map.get("MJ")%>亩>
				</td>
			</tr>
			<tr>
				<td>
					地方查处情况
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("DFCCQK") == null ? "" : map.get("DFCCQK")%> ">
				</td>
			</tr>
			<tr>
				<td>
					现场情况描述
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("XCMS") == null ? "" : map.get("XCMS")%> ">
				</td>
			</tr>
			<tr>
		     	<td>
				违法违规类型
				</td>
				<td colspan="4">
					<input type="text" class="noborder" readonly
						value="<%=map.get("WFWGLX") == null ? "" : map.get("WFWGLX")%>">
				</td>
			</tr>
		</table>
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
						}
					%>
				</ul>
				<ul class="num" id="idNum">
				</ul>
			</div>
			<br />
			<%
				}
				} else {
			%>
			<center>
				<br>
				<br>
				<br>
				<br>
				<div>
					<h1>
						无核查数据！！
					</h1>
				</div>
			</center>
			<%
				}
			%>
		</center>

	</body>
</html>
