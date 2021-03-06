<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    if(permission==null){
        permission = "no";
    }
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User)userprincipal).getUserID();
    String edit = request.getParameter("edit");
    String yw_guid = request.getParameter("yw_guid");
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
    String Data= df.format(new Date());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<TITLE>结案呈批表</TITLE>
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
			var singnames = "cbrqm01#cbdwqm#scqm#cbdwzgldqm#scdwzgldqm"  ;
				signLoad(singnames);
	
		}
			function save(){
				document.forms[0].submit();
			}
			function refresh(){
				document.location.refresh();
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
<div align="center"><h1 style="font-size:20px;">违法案件结案呈批表</h1></div><br />
<form method="post">
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
  <tr>
    <td><div align="center">案&nbsp;&nbsp;&nbsp;由</div></td>
    <td colspan="3"><textarea class="noborder" rows="5" style="width: 99%" name="ay" id="ay"></textarea></td>
  </tr>
  <tr>
    <td><div align="center">立案时间</div></td>
    <td><input type="text" class="noborder" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="lasj" id="lasj" readonly style="width: 90%"/></td>
    <td><div align="center">立案编号</div></td>
    <td><input type="text" class="noborder" name="bh" id="bh" style="width: 90%"/></td>
  </tr>
  <tr>
    <td><div align="center">调查时间</div></td>
    <td colspan="3"><div align="center"><input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dcsjks" id="dcsjks" readonly style="width: 30%"/>到&nbsp;&nbsp;&nbsp;<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="<%=Data%>" name="dcsjjs" id="dcsjjs" readonly style="width: 40%"/></div></td>
  </tr>
  <tr>
    <td><div align="center">当&nbsp;&nbsp;事&nbsp;&nbsp;人</div></td>
    <td colspan="3"><input type="text" style="width: 99%" class="noborder" id="dsr" name="dsr"/></td>
  </tr>
  <tr height="120">
    <td><div align="center">
      <p>主要违法</p>
      <p>事实及处理</p>
      <p>结&nbsp;&nbsp;&nbsp;果</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="wfss" id="wfss" style="width: 99%"></textarea></td>
  </tr>
  <tr>
    <td><div align="center"><p>承办人</p><p>意&nbsp;&nbsp;见</p></div></td>
    <td colspan="3"><textarea rows="5"  name="cbryj" id="cbryj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="cbrqm01" id="cbrqm01" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
									<img  width="60" height="25" id="cbrqm01Sign" style="display:none" onclick="delSign(this)"/></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbrrq01" id="cbrrq01" readonly  style="width: 80px"/></div>
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
      <p>审查单位</p>
      <p>主管领导</p>
      <p>意&nbsp;&nbsp;&nbsp;见</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="scdwzgldyj" id="scdwzgldyj" style="width: 99%"></textarea>   
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="scdwzgldqm" id="scdwzgldqm" onfocus="underwrite(this)" onClick="sign(this);" style="width: 50px"/>
		  	<img  width="60" height="25" id="scdwzgldqmSign" style="display:none" onclick="delSign(this)"/></div>
		    <div >日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="scdwzgldqmrq" id="scdwzgldqmrq" readonly style="width: 80px"/></div>
		 </div>	
    </td>
  </tr>
    <tr>
    <td><div align="center">
      <p>承办单位</p>
      <p>主管领导</p>
      <p>意&nbsp;&nbsp;&nbsp;见</p>
    </div></td>
    <td colspan="3"><textarea rows="5" name="cbdwzgldyj" id="cbdwzgldyj" style="width: 99%"></textarea>   
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="cbdwzgldqm" id="cbdwzgldqm" onfocus="underwrite(this)" onClick="sign(this);" style="width: 50px"/>
		  	<img  width="60" height="25" id="cbdwzgldqmSign" style="display:none" onclick="delSign(this)"/></div>
		    <div >日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbdwzgldqmrq" id="cbdwzgldqmrq" readonly style="width: 80px"/></div>
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
