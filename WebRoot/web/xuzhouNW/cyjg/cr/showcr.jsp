<%@ page language="java" pageEncoding="utf-8"%>

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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	    <base href="<%=basePath%>"/>
		<TITLE>建设用地出让表</TITLE>
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
		<script type="text/javascript" src="<%=basePath%>web/xuzhouNW/dtxc/xcrz/js/xcrz.js"></script>
        <script>
		function initEdit(){
			init();
			var edit="<%=edit%>";
			if(edit=='false'){
				 var formlist = document.getElementById('form');
        		 for(var i=0;i<formlist.length;i++)
         		 {
             			if(formlist[i].type=='text'||formlist[i].type=='textarea'||formlist[i].type=='select-one')
             				formlist[i].disabled=true;
         		 }		
			}
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
<%	}else{%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1>建设用地出让表</h1></div>
<form method="post">
<table id="xcrztable" class="lefttopborder1" cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
   <tr>
   		<td>批次</td>
   		<td>
   			<input type="text" class="noborder" name="pc" id="pc" style="width: 97%"/>
   		</td>
   		<td>批复文号</td>
   		<td>
   			<input type="text" class="noborder" name="pfwh" id="pfwh" style="width: 97%"/>
   		</td>
   </tr>
   <tr>
   		<td>供地</td>
   		<td>
   			<input type="text" class="noborder" name="gd" id="gd" style="width: 97%"/>
   		</td>
   		<td>涉及招拍挂公告号</td>
   		<td>
   			<input type="text" class="noborder" name="fs" id="fs" style="width: 97%"/>
   		</td>
   </tr>
      <tr>
   		<td>土地用途</td>
   		<td>
   			<input type="text" class="noborder" name="tdyt" id="tdyt" style="width: 97%"/>
   		</td>
   		<td>使用期限</td>
   		<td>
   			<input type="text" class="noborder" name="syqx" id="syqx" style="width: 97%"/>
   		</td>
   </tr>
  <tr>
   		<td>供地面积</td>
   		<td>
   			<input type="text" class="noborder" name="gdmj" id="gdmj" style="width: 97%"/>
   		</td>
   		<td>出让金</td>
   		<td>
   			<input type="text" class="noborder" name="crj" id="crj" style="width: 97%"/>
   		</td>
   </tr>
     <tr>
   		<td>受让人</td>
   		<td>
   			<input type="text" class="noborder" name="srr" id="srr" style="width: 97%"/>
   		</td>
   		<td>成交时间</td>
   		<td>
   			<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cjsj" id="cjsj" style="width: 97%"/>
   		</td>
   </tr>
   <tr>
   		<td colspan='2'>出让合同编号</td>
   		<td colspan='2'>
   			<input type="text" class="noborder" name="crhtbh" id="crhtbh" style="width: 97%"/>
   		</td>
   </tr>
   <tr>
   		<td >备注</td>
   		<td colspan='3'>
   			<input type="text" class="noborder" name="bz" id="bz" style="width: 97%"/>
   		</td>
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
