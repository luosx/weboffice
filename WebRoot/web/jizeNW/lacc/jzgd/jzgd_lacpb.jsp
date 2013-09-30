<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.ManagerFactory"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    String yw_guid = request.getParameter("yw_guid");
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    if(permission==null){
        permission = "no";
    }
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User)userprincipal).getUserID();
    String edit = request.getParameter("edit");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<title>立案呈批表</title>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<script>
		var userId = "<%=userid%>";
			var basePath = "<%=basePath%>";
		
			function initEdit(){
					init();
					var singnames = "ddcbr01#ddcbr02#cbdwqm#scqm#zgldqm#zyldqm";
					var sfzd1 = document.getElementById('sfzd1');
					if(sfzd1.checked){
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
<div align="center"><h1 style="font-size:20px;">立 案 呈 批 表</h1></div>
<form method="post">
<div style="width:600px;text-align:right;"><span style="font-size:14px;">编号：
<input type="text" name="bh" id="bh" style="width:180px;background-color:transparent;border:0px;"></span>
</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
  <tr>
    <td colspan="2"><div align="center">案由</div></td>
    <td colspan="6"><textarea class="noborder" rows="5" style="width: 99%;font-size:14px;" name="ay"  id="ay"></textarea></td>
  </tr>
  <tr>
    <td width="30" rowspan="5"><div align="center">当<br/>
      事<br/>
    人</div></td>
    <td width="50" rowspan="2"><div align="center">单位</div></td>
    <td width="34"><div align="center">名称</div></td>
    <td colspan="3"><input type="text" class="noborder" name="dwmc" id="dwmc" style="width: 98%"/></td>
    <td width="80"><div align="center">法定代表人</div></td>
    <td width="120"><input type="text" class="noborder" name="fddbr" id="fddbr" style="width: 97%"/></td>
  </tr>
  <tr>
    <td><div align="center">地址</div></td>
    <td colspan="3"><input type="text" class="noborder" name="dwdz" id="dwdz" style="width: 98%"/></td>
    <td><div align="center">电话</div></td>
    <td><input type="text" class="noborder" name="dwdh" id="dwdh" style="width: 97%" <%if(!permission.equals("yes")){ %>onblur="registerDh()"<%} %>/></td>
  </tr>
  <tr>
    <td rowspan="3"><div align="center">个人</div></td>
    <td><div align="center">姓名</div></td>
    <td width="140"><input type="text" class="noborder" name="grxm" id="grxm" style="width: 98%"/></td>
    <td width="40"><div align="center">性别</div></td>
    <td width="50">
		<select style="width: 90%;height: 30px" id="grxb"    name="grxb">
			<option  value="男"  selected="selected">
				男								</option>
			<option  value="女" >
				女								</option>
		</select>
		  </td>
    <td><div align="center">年龄</div></td>
    <td><input type="text" class="noborder" name="grnl" id="grnl" style="width: 97%"  onblur="registerNl()" /></td>
  </tr>
  <tr>
    <td><div align="center">单位</div></td>
    <td colspan="3"><input type="text" class="noborder" name="grdw" id="grdw" style="width: 98%"/></td>
    <td><div align="center">职务</div></td>
    <td><input type="text" class="noborder" name="grzw" id="grzw" style="width: 97%"/></td>
  </tr>
  <tr>
    <td><div align="center">地址</div></td>
    <td colspan="3"><input type="text" class="noborder" name="grdz" id="grdz" style="width: 98%"/></td>
    <td><div align="center">电话</div></td>
    <td><input type="text" class="noborder" name="grdh" id="grdh" style="width: 97%" onblur="registerDh()"/></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">案件来源</div></td>
    <td colspan="2" align="left">
							<select style="width: 80%;height: 30px" id="ajly"    name="ajly">
								<option  value="上级督办"  selected="selected">
									上级督办
								</option>
								<option  value="领导交办" >
									领导交办
								</option>
								<option  value="巡查发现" >
									巡查发现
								</option>
								<option  value="分局报告" >
									分局报告
								</option>
								<option  value="信访反映" >
									信访反映
								</option>
								<option  value="卫星执法" >
									卫片执法
								</option>
								<option  value="媒体披露" >
									媒体披露
								</option>
								<option  value="电话举报" >
									电话举报
								</option>
    </td>
    <td colspan="2"><div align="center">是否重大案件</div></td>
    <td colspan="2">
    		<input type="radio" name="sfzd" id="sfzd1"  value="是"> <label for="sfzd1">是</label> 
    		<input type="radio" name="sfzd" id="sfzd2"  value="否"> <label for="sfzd2">否</label>
    </td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">受理日期</div></td>
    <td colspan="6"><input type="text" class="noborder" id="slrq" name="slrq"
onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"    readonly style="width: 98%" /></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">主要违法<br/>
    事&nbsp;&nbsp;&nbsp;&nbsp;实</div></td>
    <td colspan="6"><textarea rows="5" name="zywfss" id="zywfss" style="width: 99%"></textarea></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">备注</div></td>
    
    <td colspan="6">
    	<textarea rows="5" name="bz" id="bz" style="width: 99%;font-size:14px;" ></textarea>
    </td>
  </tr>
</table>
	<input type="text"   class="noborder"  style="width: 70%;display:none;"  value="" name="qy" id="qy" />
</form>
</div>
</body>
<script>
<%
if(!permission.equals("yes")){%>
	document.body.onload = initEdit;
<%}else if(permission.equals("yes")){%>
	addBorders();
	document.getElementById('zyld').style.display='block';
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
