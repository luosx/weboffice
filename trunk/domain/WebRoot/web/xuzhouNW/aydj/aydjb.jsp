<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.jinan.aydj.AydjManager"%>
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
	String activityName=new String(request.getParameter("activityName").getBytes("ISO-8859-1"), "gbk");
	String formname = "aydjb";
	String zfjcType=request.getParameter("zfjcType");
	String[] editfiles = new AydjManager().getAydjbEditfiles(activityName,formname,zfjcType);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>案源登记表</title>
<%if(permission.equals("yes")){ %>
<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
<%@ include file="/base/include/restRequest.jspf" %>
<%@ include file="/base/form/PermissionControl.jspf"%>
<%}else{ %>
<%@ include file="/base/include/formbase.jspf"%>
<script type="text/javascript" src="/web/jinan/aydj/aydjjs.js"></script>
<style>
	textarea{width:99% ; background:none; border:none; height:40px }
	input{width:99% ;background:none; border:none;}
	table{border-top:1px solid #666666; border-left:1px solid #000000; font:"宋体"; font-size:12px}
	td{border-bottom:1px solid #666666; border-right:1px solid #000000; height:20px}
	table{bor:1px solid #000000; background:#FFFFFF } 
</style>
<%}%>
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
		function save(num){
		
			var form = document.getElementById("form");
			if(num == "0"){
				form.submit();
			}else{
				form.submit();
				//window.location.reload();
			}
		}
		function textChange(num){
		    parent.parent.change=num;
		}
	</script>
</head>

<body>
<form id="form" method="post">
<DIV  align=center  style="HEIGHT: 30px;FONT-WEIGHT: bold; FONT-SIZE: 18pt; FONT-FAMILY: 宋体">
				<label id="formtitle">案 源 登 记 表</label>
</DIV>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="130px"><div align="right">
      <p>案源主题&nbsp;</p>
      </div></td>
    <td colspan="3"><textarea name="ayzt" id="ayzt" onchange="textChange('0');" style="width:99%"></textarea></td>
    </tr>
  <tr>
    <td><div align="right">接案时间&nbsp;</div></td>
    <td width="40%">
      <input type="text" class="noborder" id="jasj" name="jasj"
		onClick="WdatePicker()" onchange="textChange('0');" readonly style="width: 98%" />
    </td>
    <td width="70px" align="right">案件来源&nbsp;</td>
    <td>
        <%if(permission.equals("yes")){ %>
    	<input  name="ajly" id="ajly"  style="width:98%"/>
    	<%}else{ %>
		<select name="ajly" id="ajly">
    		<option selected="selected">请选择</option>
			<option value="卫片执法">卫片执法</option>
			<option value="巡查发现">巡查发现</option>
			<option value="群众举报">群众举报</option>
		</select>    
		<%} %>
	</td>
  </tr>
  <tr>
    <td><div align="right">案件分类&nbsp;</div></td>
    <td colspan="3"><textarea name="ajfl" id="ajfl" onchange="textChange('0');"></textarea></td>
    </tr>
  <tr>
    <td><div align="right">举报内容&nbsp;</div></td>
    <td colspan="3"><textarea name="jblr" id="jblr" onchange="textChange('0');"></textarea></td>
    </tr>
  <tr>
    <td><div align="right">举报人&nbsp;</div></td>
    <td><input type="text" name="jbr" id="jbr" style="width:50%" onchange="textChange('0');"/></td>
    <td align="right">联系电话&nbsp;</td>
    <td><input type="text" name="lxdh" id="lxdh" style="width:50%" onchange="textChange('0');"/></td>
  </tr>
  <tr>
    <td><div align="right">案件交办时间&nbsp;</div></td>
    <td><input type="text" class="noborder" id="ajjbsj" name="ajjbsj"
			onClick="WdatePicker()" readonly="readonly" style="width: 98%" onchange="textChange('0');"/></td>
    <td align="right">登记录入人&nbsp;</td>
    <td><input type="text" name="djlrr" id="djlrr" style="width:50%" onfocus="underwrite(this)"  onchange="textChange('0');"/></td>
  </tr>
  <tr>
    <td><div align="right">案件承办单位&nbsp;</div></td>
    <td><input type="text" name="ajcbdw" id="ajcbdw" style="width:90%" onchange="textChange('0');"/></td>
    <td align="right">案件接收人&nbsp;</td>
    <td><input type="text" onfocus="underwrite(this)" name="ajjsr" id="ajjsr" style="width:50%" onchange="textChange('0');"/></td>
  </tr>
  <tr>
    <td><div align="right">经办人实地初查意见&nbsp;</div></td>
    <td colspan="3"><textarea name="jbrsdccyj" id="jbrsdccyj" onchange="textChange('0');"></textarea></td>
    </tr>
  <tr>
    <td><div align="right">经办人&nbsp;</div></td>
    <td><input type="text" onfocus="underwrite(this)" name="jinbr" id="jinbr" style="width:50%" onchange="textChange('0');"/></td>
    <td align="right">初查日期&nbsp;</td>
    <td><input type="text" class="noborder" id="ccrq" name="ccrq"
		onClick="WdatePicker()" readonly style="width: 98%" onchange="textChange('0');"/></td>
  </tr>
  <tr>
    <td><div align="right">处室（单位）审核意见&nbsp;</div></td>
    <td colspan="3"><textarea name="csshyj" id="csshyj" onchange="textChange('0');"></textarea></td>
    </tr>
  <tr>
    <td><div align="right">负责人&nbsp;</div></td>
    <td><input type="text" name="fzr" id="fzr" style="width:50%" onfocus="underwrite(this)" onchange="textChange('0');"/></td>
    <td align="right">审核日期&nbsp;</td>
    <td><input type="text" class="noborder" id="shrq" name="shrq"
			onClick="WdatePicker()" readonly style="width: 98%"onchange="textChange('0');" /></td>
  </tr>
</table>
<%if(!permission.equals("yes")){ %>
	<p align="center">
		<!-- <INPUT class="button" id="Tstorage" onClick="save('0')" type="button" value="暂存">
		  --> <INPUT class="button" id="storage" onClick="save('1')" type="button" value="保存"/>
	</p>
<%}else{%>	
	<INPUT class="button" id="storage" onClick="save123()" type="button" value="保存"/>
<%} %>
</form>

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
