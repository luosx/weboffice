<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.net.URLDecoder"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    if(permission==null){
        permission = "no";
    }
    String edit = request.getParameter("edit");
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
    String Data= df.format(new Date());
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User)userprincipal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<TITLE>违法案件处理决定呈批表</TITLE>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
				<link rel="stylesheet"
			href="<%=basePath%>web/default/ajgl/css/lacpb.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<%} %>
		<script type="text/javascript" src="<%=basePath%>/web/jizeNW/lacc/js/sign.js"></script>	
		<script>
			var userId = "<%=userid%>";
			var basePath = "<%=basePath%>";
	
		function initEdit(){
				init();
				var singnames = "cbr01#cbdwqm#scqm#zgldqm"  ;
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
<% if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	}else if(!"false".equals(edit)){%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1 style="font-size:20px;">违法案件处理决定呈批表</h1></div><br>
<form method="post">
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
  <tr>
    <td><div align="center">案&nbsp;&nbsp;&nbsp;由</div></td>
    <td colspan="3"><textarea class="noborder" rows="5" style="width: 99%" name="ay" onkeyup="changeay(this)" id="ay"></textarea></td>
  </tr>
  <tr>
    <td><div align="center">立案时间</div></td>
    <td><input type="text" class="noborder" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="lasj" id="lasj" readonly style="width: 90%"/></td>
    <td><div align="center">立案编号</div></td>
    <td><input type="text" class="noborder" name="bh" id="bh" style="width: 90%"/></td>
  </tr>
  <tr>
    <td><div align="center">调查时间</div></td>
    <td colspan="3"><div align="center"><input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dcsjks" id="dcsjks" readonly style="width: 30%"/>到&nbsp;&nbsp;&nbsp;<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<%=Data%>" name="dcsjjs" id="dcsjjs" readonly style="width: 40%"/></div></td>
  </tr>
  <tr>
    <td><div align="center">当&nbsp;&nbsp;事&nbsp;&nbsp;人</div></td>
    <td colspan="3"><input type="text" style="width: 99%" class="noborder" id="dsr" name="dsr"/></td>
  </tr>
  <tr height="120">
    <td><div align="center">
      <p>主要违法</p>
      <p>事实及性质</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="zywfss" id="zywfss" style="width: 99%"></textarea></td>
  </tr>
  <tr>
    <td><div align="center"><p>承办人</p><p>建&nbsp;&nbsp;议</p></div></td>
    <td colspan="3"><textarea rows="5"  name="cbrjy" id="cbrjy" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="cbr01" id="cbr01" onfocus="underwrite(this)"  onClick="sign(this);" style="width: 50px"/>
		     <img  width="60" height="25" id="cbr01Sign" style="display:none" onclick="delSign(this)"/>
		  	</div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbrrq01" id="cbrrqQ01" readonly  style="width: 80px"/></div>
		 </div>   
    </td>
  </tr>

  <tr>
    <td><div align="center">
      <p>承办单位</p>
      <p>意&nbsp;&nbsp;&nbsp;&nbsp;见</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="cbdwyj" id="cbdwyj" style="width: 99%"></textarea>  
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="cbdwqm" id="cbdwqm" onfocus="underwrite(this)" onClick="sign(this);" style="width: 50px"/>
		  	<img  width="60" height="25" id="cbdwqmSign" style="display:none" onclick="delSign(this)"/></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbdwqmrq" id="cbdwqmrq" readonly style="width: 80px"/></div>
		 </div>	   
    </td>
  </tr>
  <tr>
    <td><div align="center">
      <p>审&nbsp;&nbsp;&nbsp;&nbsp;查</p>
      <p>意&nbsp;&nbsp;&nbsp;&nbsp;见</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="scyj" id="scyj" style="width: 99%"></textarea>   
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="scqm" id="scqm" onfocus="underwrite(this)" onClick="sign(this);" style="width: 50px"/>
		  	<img  width="60" height="25" id="scqmSign" style="display:none" onclick="delSign(this)"/></div>
		    <div >日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="scqmrq" id="scqmrq" readonly style="width: 80px"/></div>
		 </div>	
    </td>
  </tr>
    <tr>
    <td><div align="center">
      <p>主管领导</p>
      <p>意&nbsp;&nbsp;&nbsp;见</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="zgldyj" id="zgldyj" style="width: 99%"></textarea>   
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="zgldqm" id="zgldqm" onfocus="underwrite(this)" onClick="sign(this);" style="width: 50px"/>
		  	<img  width="60" height="25" id="zgldqmSign" style="display:none" onclick="delSign(this)"/></div>
		    <div >日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="zgldqmrq" id="zgldqmrq" readonly style="width: 80px"/></div>
		 </div>	
    </td>
  </tr>
  <tr>  
    <td><div align="center">备&nbsp;&nbsp;&nbsp;注</div></td>
    <td colspan="3"><textarea rows="5" name="bz" id="bz" style="width: 99%"></textarea></td>
  </tr>
</table>
</form>
</div>
</body>
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
</html>
