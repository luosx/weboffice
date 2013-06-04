<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

    String edit = request.getParameter("edit");
	String permission = request.getParameter("permission");
	if (permission == null) {
		permission = "no";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
	<head>
	    <base href="<%=basePath%>"/>
		<title>移送信息表</title>
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
<style>
table
{
	border-top:1px solid #2C2B29;
	border-left:1px solid #2C2B29;
	background-color:#ffffff;
	margin-bottom:10px;

}
table tr td
{
	border-right:1px solid #2C2B29;
	border-bottom:1px solid #2C2B29;
	padding:0 10px 0 5px;
	text-align:center;
}

</style>
<script type="text/javascript">
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
	  <div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
      <div style="margin:20px" class="tablestyle1" align="center" >  
      <div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					移送信息表</div>
	  <form id="form" method="post">
	  <br/>
		<table class="" width="600px" cellspacing="0" cellpadding="0"
			align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29">
			<tr>
				<td width="9%" colspan="2">
					案件名称
				</td>
				<td colspan="6" align="left">
					<input id="ajmc" name="ajmc" type="text" class="noborder" />
				</td>
			</tr>
			<tr>
				<td width="9%" colspan="2">
					案件编号
				</td>
				<td  colspan="6" align="left">
					<input id=ajbh" name="ajbh" type="text" class="noborder"  value=""/>
				</td>
			</tr>
			<tr>
				<td rowspan="3" >
					<div align="center">
						当
						<br/>
						事
						<br/>
						人
					</div>
				</td>
				<td  >姓名</td>
				<td align="left">
					<input type="text" id="fzxyrxm" name="fzxyrxm" class="noborder" /></td>
				<td width="10%">性别</td>
				<td width="16%">
						<%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="fzxyrsex" id="fzxyrsex" style="width: 98%"/>
   				        <%}else{ %>
						 <input type="radio" name='fzxyrsex' id='fzxyrsex' value="男"/>男&nbsp;&nbsp;
					     <input type="radio" name='fzxyrsex' id='fzxyrsex' value="女"/>女
							<%} %>
				</td>
				<td width="10%">年龄</td>
				<td width="10%">
					<input type="text" id="fzxyrxm" name="fzxyrxm" class="noborder" /></td>
		 </tr>
		 <tr>
		    <td width="10%" >单位</td>
			<td colspan="1" align="left">
				<input type="text" id="dwzy" name="dwzy" class="noborder" />
			</td>
			<td width="10%" >职业</td>
			<td colspan="4" align="left">
				<input type="text" id="dwzy" name="dwzy" class="noborder" />
			</td>
				
		</tr>
		<tr>
			<td width="10%" >住址</td>
			<td align="left" colspan="5">
					<input type="text" id="address" name="address" class="noborder" />
			</td>
		</tr>
			<tr>
				<td width="10%" colspan="2">
					移送原因
				</td>
				<td colspan="6" align="left">
					<input type="text" id="ysyy" name="ysyy" class="noborder" />
				</td>
			</tr>
			<tr>
				<td width="10%" colspan="2">
					送往单位
				</td>
				<td colspan="6" align="left">
					<input type="text" id="swdw" name="swdw" class="noborder" />
				</td>
			</tr>
			<tr>
				<td width="10%" colspan="2">
					批&nbsp;准&nbsp;人
				</td>
				<td colspan="1" align="left">
					<input type="text" id="pzr" name="pzr" class="noborder" />
				</td>
				<td width="15%" >批准时间</td>
				<td colspan="3" align="left">
					<input type="text" id="pzsj" name="pzsj" onClick="WdatePicker()" readonly="readonly" />
				</td>
			</tr>
		    <tr>
				<td width="10%" colspan="2">办&nbsp;案&nbsp;人</td>
				<td colspan="1" align="left">
					<input type="text" id="bar" name="bar" class="noborder" />
				</td>
				<td width="15%" >办案单位</td>
				<td colspan="3" align="left">
					<input type="text" id="badw" name="badw" />
				</td>
			</tr>
				<tr>
				<td width="10%" colspan="2">
					填&nbsp;发&nbsp;人
				</td>
				<td colspan="1" align="left">
					<input type="text" id="tfr" name="tfr" class="noborder" />
				</td>
				<td width="15%" >
					填发时间
				</td>
				<td colspan="3" align="left">
					<input type="text" id="tfsj" name="tfsj" onClick="WdatePicker()" readonly="readonly" />
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
