<%@ page language="java" pageEncoding="utf-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    if (permission == null) {
        permission = "no";
    }
    String edit = request.getParameter("edit");
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User) userprincipal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>" />

		<TITLE>法律文书呈批表</TITLE>
		<%
		    if (permission.equals("yes")) {
		%>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/permissionForm.css" type="text/css" />
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/form/PermissionControl.jspf"%>

		<%
		    } else {
		%>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<link rel="stylesheet"
			href="<%=basePath%>web/default/ajgl/css/lacpb.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<%
		    }
		%>
		<script type="text/javascript"
			src="<%=basePath%>/web/jizeNW/lacc/js/sign.js"></script>
		<script>
			var userId = "<%=userid%>";
			var basePath = "<%=basePath%>";
					
		function initEdit(){
			init();
			var singnames = "cbr01#cbdwqm#scqm#scdwzgldqm#cbdwzgldqm"  ;
			signLoad(singnames);
		}
		function save(){
			document.forms[0].submit();
		}
		function refresh(){
			document.location.refresh();
		}
		
		function changeay(check){
			document.getElementById("bz").innerText = "案由："+check.innerText;
		}
		 
		</script>

	</head>
	<body bgcolor="#FFFFFF">
		<div id="fixed" class="Noprn"
			style="position: fixed; top: 20px; left: 0px"></div>
		<div id="fixed33" class="Noprn"
			style="position: fixed; top: -2px; left: 0px">

		</div>
		<div style="margin: 20px" class="tablestyle1" align="center">
			<div align="center">
				<h1 style="font-size:20px;">
					法律文书呈批表
				</h1>
			</div>
			<br>
			<form method="post">
				<table class="lefttopborder1" cellspacing="0" cellpadding="0"
					border="1" bgcolor="#FFFFFF" bordercolor="#000000" width="600">
					<tr class="row1">
						<td width="90">
							<div align="center">
								案&nbsp;&nbsp;&nbsp;由
							</div>
						</td>
						<td colspan="7">
							<textarea style="width: 99%" class="noborder" rows="5" cols="65"
								name="ay"  id="ay"></textarea>
						</td>
					</tr>
					<tr>
						<td height="">
							<div align="center">
								法律文书
								<br>
									名&nbsp;&nbsp;&nbsp;称 
							</div>
						</td>
						<td colspan="7">
							<textarea class="noborder" style="width: 99%" rows="3" cols="65"
								name="flwsmc" id="flwsmc"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								主&nbsp;&nbsp;&nbsp;送
							</div>
						</td>
						<td colspan="7">
							<input type="text" style="width: 99%; height: 100%"
								class="noborder" id="zs" name="zs" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								承&nbsp;办&nbsp;人
							</div>
						</td>
						<td colspan="7">
							<textarea class="noborder" style="width: 99%" rows="5" name="cbr"
								id="cbr"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input class="underline" type="text" name="cbr01" id="cbr01"
										onfocus="underwrite(this)" onClick="sign(this);"
										style="width: 50px" />
									<img width="60" height="25" id="cbr01Sign"
										style="display: none" onclick="delSign(this)"/>
								</div>
								<div>
									日期：
									<input type="text" class="underline" onClick="WdatePicker()"
										name="cbrrq01" id="cbrrq01" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								<p>
									承办单位
								</p>
								<p>
									负责人
								</p>
							</div>
						</td>
						<td colspan="3">
							<textarea rows="5" name="cbdwyj" id="cbdwyj" style="width: 99%"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input class="underline" type="text" name="cbdwqm" id="cbdwqm"
										onfocus="underwrite(this)" onClick="sign(this);"
										style="width: 50px" />
									<img width="60" height="25" id="cbdwqmSign"
										style="display: none" onclick="delSign(this)"/>
								</div>
								<div>
									日期：
									<input type="text" class="underline"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbdwqmrq"
										id="cbdwqmrq" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								<p>
									审查单位
								</p>
								<p>
									负责人
								</p>
							</div>
						</td>
						<td colspan="3">
							<textarea rows="5" name="scyj" id="scyj" style="width: 99%"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input class="underline" type="text" name="scqm" id="scqm"
										onfocus="underwrite(this)" onClick="sign(this);"
										style="width: 50px" />
									<img width="60" height="25" id="scqmSign"
										style="display: none" onclick="delSign(this)"/>
								</div>
								<div>
									日期：
									<input type="text" class="underline"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="scqmrq"
										id="scqmrq" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
							<p>审查单位</p>
								<p>
									主管领导
								</p>
							</div>
						</td>
						<td colspan="3">
							<textarea rows="5" name="scdwzgldyj" id="scdwzgldyj" style="width: 99%"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input class="underline" type="text" name="scdwzgldqm" id="scdwzgldqm"
										onfocus="underwrite(this)" onClick="sign(this);"
										style="width: 50px" />
									<img width="60" height="25" id="scdwzgldqmSign" style="display: none" onclick="delSign(this)"/>
								</div>
								<div>
									日期：
									<input type="text" class="underline"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="scdwzgldqmrq"
										id="scdwzgldqmrq" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
							<p>承办单位</p>
								<p>
									主管领导
								</p>
							</div>
						</td>
						<td colspan="3">
							<textarea rows="5" name="cbdwzgldyj" id="cbdwzgldyj" style="width: 99%"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input class="underline" type="text" name="cbdwzgldqm" id="cbdwzgldqm"
										onfocus="underwrite(this)" onClick="sign(this);"
										style="width: 50px" />
									<img width="60" height="25" id="cbdwzgldqmSign" style="display: none" onclick="delSign(this)"/>
								</div>
								<div>
									日期：
									<input type="text" class="underline"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbdwzgldqmrq"
										id="cbdwzgldqmrq" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>					
					<tr>
						<td>
							<div align="center">
								备&nbsp;&nbsp;&nbsp;注
							</div>
						</td>
						<td colspan="7">
							<textarea style="width: 99%" class="noborder" rows="5" name="bz"
								id="bz"></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script>
<%
if(!permission.equals("yes")){%>
	document.body.onload = initEdit;
<%}else if(permission.equals("yes")){%>
	addBorders();
<%}%>
<%
	String msg = (String)request.getParameter("msg");
%>
if("<%=msg%>" == "success"&&"<%=permission%>"=="yes"){
	alert("表单权限保存成功");
}else if("<%=msg%>" == "success"){
	alert("表单保存成功");
}
</script>
	</body>
</html>
