<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.bean.ftputil.FTPOperation"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.DtxcManager"%>
<%
    String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

String yw_guid = request.getParameter("yw_guid");

String type=request.getParameter("type");
if(type!=null&&"td".equals(type)){
	type="土地";
}else if(type!=null&&"kc".equals(type)){
	type="矿产";
}

Map<String, Object> map = new DtxcManager().getXckcqkData(yw_guid);
String returnPath = request.getParameter("returnPath");
String edit = request.getParameter("edit");
if (edit == null || !edit.equals("false")) {
	edit = "true";
}
String hiddenSave = request.getParameter("hiddenSave");

String host = UtilFactory.getConfigUtil().getConfig("ftp.host");
int port = Integer.parseInt(UtilFactory.getConfigUtil().getConfig("ftp.port"));
String username = UtilFactory.getConfigUtil().getConfig("ftp.username");
String password = UtilFactory.getConfigUtil().getConfig("ftp.password");
		
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String fullName = ((User) principal).getFullName();
String roleName = ManagerFactory.getRoleManager().getRoleWithUserID(((User)principal).getId()).get(0).getRolename();
System.out.println(map.get("XCDD") + "---------------------------");
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
					巡查单位
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("XCX") == null ? "" : map.get("XCX")%> <%=map.get("XCS") == null ? "" : map.get("XCS")%> ">
				</td>
				<td width="16%">
					巡查时间
				</td>
				<td width="32%">
					<input type="text" class="noborder" readonly
						value="<%=map.get("XCSJ") == null ? "" : map.get("XCSJ")%> ">
				</td>
			</tr>
			<tr>
				<td>
					巡查地点
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("XCDD") == null ? "" : map.get("XCDD")%> ">
				</td>
			</tr>
			<tr>
				<td>
					建设单位
				</td>
				<td colspan="2" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("JSDW") == null ? "" : map.get("JSDW")%>">
				</td>
				<td>
					建设项目
				</td>
				<td>
					<input type="text" class="noborder" readonly
						value="<%=map.get("jsxm") == null ? "" : map.get("jsxm")%>">
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
					<textarea align="left" cols="45" class="noborder" readonly><%=map.get("CJMJ") == null ? "" : map.get("CJMJ")%></textarea>
				</td>
			</tr>
			<tr>
				<td rowspan="3">
					用地批准
					<br />
					文&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件
				</td>
				<td width="17%">
					批准文号
				</td>
				<td colspan="3">
					<input type="text" class="noborder" readonly
						value="<%=map.get("PZWH") == null ? "" : map.get("PZWH")%> ">
				</td>
			</tr>
			<tr>
				<td>
					供地文号
				</td>
				<td colspan="3">
					<input type="text" class="noborder" readonly
						value="<%=map.get("GDWH") == null ? "" : map.get("GDWH")%> ">
				</td>
			</tr>
			<tr>
				<td>
					土地证编号
				</td>
				<td colspan="3">
					<input type="text" class="noborder" readonly
						value="<%=map.get("TDZBH") == null ? "" : map
								.get("TDZBH")%> ">
				</td>
			</tr>
			<tr>
				<td>
					国&nbsp;&nbsp;土&nbsp;&nbsp;所
					<br />
					处理意见
				</td>
				<td colspan="4" align="left">
					<input type="text" class="noborder" readonly
						value="<%=map.get("SJCLYJ") == null ? "" : map
						.get("SJCLYJ")%> ">
				</td>
			</tr>
			<tr>
				<td>
					国&nbsp;&nbsp;土&nbsp;&nbsp;所
					<br />
					备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注
				</td>
				<td colspan="4" height=60px align="left">
					<textarea class="noborder" readonly><%=map.get("SJBZ") == null ? "" : map.get("SJBZ")%></textarea>
				</td>
			</tr>
			<tr>
				<td style="display:none">
					处理意见
				</td>
				<td colspan="4" align="left" style="display:none">
					<input type="radio" name="xjclyj" value="建议立案" />
					建议立案
					<input type="radio" name="xjclyj" value="合法" />
					合法
					<input type="radio" name="xjclyj" value="上报" />
					上报
					<input type="radio" name="xjclyj" value="不予立案" />
					不予立案
				</td>
			</tr>
			<tr>
				<td style="display:none">
					备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注
				</td>
				<td colspan="4" height=60px align="left" style="display:none">
					<textarea class="noborder" id="xjbz"
						<%=edit.equals("false") ? "readonly" : ""%>><%=map.get("XJBZ") == null ? "" : map.get("XJBZ")%></textarea>
				</td>
			</tr>
			<tr>
				<td style="display:none">
					领导批示
				</td>
				<td colspan="4" height=60px align="left" style="display:none">
					<textarea class="noborder" id="xjldps"
						<%=edit.equals("false") ? "readonly" : ""%>><%=map.get("XJLDPS") == null ? "" : map.get("XJLDPS")%></textarea>
				</td>
			</tr>
				<tr>
				<td style="display:none">
					市级处理
					<br />
					意&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;见
				</td>
				<td colspan="4" align="left" style="display:none">
					<input type="radio" name="shiclyj" value="建议立案" />
					建议立案
					<input type="radio" name="shiclyj" value="合法" />
					合法
				</td>
			</tr>
			<tr>
				<td style="display:none">
					市级备注
				</td>
				<td colspan="4" height=60px align="left" style="display:none">
					<textarea class="noborder" id="SHIBZ"
						<%=edit.equals("false") ? "readonly" : ""%>><%=map.get("SHIBZ") == null ? "" : map.get("SHIBZ")%></textarea>
				</td>
			</tr>
			<tr>
				<td style="display:none">
					市级领导批示
				</td>
				<td colspan="4" height=60px align="left" style="display:none">
					<textarea class="noborder" id="shildps"
						<%=edit.equals("false") ? "readonly" : ""%>><%=map.get("SHILDPS") == null ? "" : map.get("SHILDPS")%></textarea>
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
