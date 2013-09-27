<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
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
    String xzqh = ManagerFactory.getUserManager().getUserWithId(userid).getXzqh();
   	String name = UtilFactory.getXzqhUtil().getBeanById(xzqh).getCatonname();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<TITLE>立案呈批表</TITLE>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<%} %>
		<script type="text/javascript"">
		var userId = "<%=userid%>";
		var basePath = "<%=basePath%>";
		
		function initEdit(){
			init();
		}
		
		function saveBy(){
			var yw_guid='<%=yw_guid%>';  
            putClientCommond("lacc","saveBhAy");
 			putRestParameter("yw_guid",yw_guid);
			var res=restRequest();		
		}
		
		function save(){	
			if(checkNull()){			
				document.forms[0].submit();
			}
		}
		
		function checkNull(){
			var ay = document.getElementById('ay').value;
			var dwmc = document.getElementById('dwmc').value; 
			var grxm = document.getElementById('grxm').value;
			var ajly = document.getElementById('ajly').value;
			var slrq = document.getElementById('slrq').value;
			var jzrq = document.getElementById('jzrq').value;
			if(ay == ''){
				alert('案由为空!');
				return false;
			}
			if(dwmc == '' && grxm == ''){
				alert('违法单位(人)为空！');
				return false;
			}
			if(ajly == ''){
				alert('案件来源为空！');
				return false;				
			}
			if(slrq == ''){
				alert('受理日期为空！');
				return false;					
			}
			if(jzrq == ''){
				alert('截止日期为空！');
				return false;
			}
			return true;
		}
		
		function refresh(){
			document.location.refresh();
		}
			
		</script>
		
	</head>
	
<body bgcolor="#FFFFFF" >
<% 
if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	
}else if(!"false".equals(edit)){%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1 style="font-size:16px;">案件立案呈批表</h1></div>
<br>
<form method="post">
<div style="width:600px;text-align:center;"><span style="font-size:14px;">
 <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="bh" id="bh" style="width: 97%"/>
   				        <%}else{ %>
<input type="text" name="bh" id="bh" readonly="readonly" style="width:180px;background-color:transparent;border:0px;"></span>
<%} %> 
</div>
<br>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="700">
  <tr>
    <td colspan="2"><div align="center">案&nbsp;&nbsp;由</div></td>
    <td colspan="6"><textarea class="noborder" rows="5" style="width: 99%;font-size:14px;" name="ay"  id="ay"></textarea></td>
  </tr>
  <tr>
    <td rowspan="2" colspan="2"><div style="text-align:center;">违法单位</div></td>
    <td width="34"><div align="center">名称</div></td>
    <td colspan="3"><input type="text" class="noborder" name="dwmc" id="dwmc" style="width: 98%"/></td>
    <td width="80"><div align="center">法定代表人</div></td>
    <td width="120"><input type="text" class="noborder" name="fddbr" id="fddbr" style="width: 97%"/></td>
  </tr>
  <tr>
    <td><div align="center">地址</div></td>
    <td colspan="3"><input type="text" class="noborder" name="dwdz" id="dwdz" style="width: 98%"/></td>
    <td><div align="center">电话</div></td>
    <td><input type="text" class="noborder" name="dwdh" id="dwdh" style="width: 97%" onblur="registerDh()"/></td>
  </tr>
  <tr>
    <td rowspan="3" colspan="2"><div align="center">违法人或直<br>接责任人</div></td>
    <td><div align="center">姓名</div></td>
    <td width="140"><input type="text" class="noborder" name="grxm" id="grxm" style="width: 98%"/></td>
    <td width="40"><div align="center">性别</div></td>
    <td width="50">
    <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="grxb" id="grxb" style="width: 97%"/>
   				        <%}else{ %>
							<select style="width: 90%" id="grxb"    name="grxb">
								<option  value="男"  selected="selected">
									男								</option>
								<option  value="女" >
									女								</option>
							</select>
							<%} %>    </td>
    <td><div align="center">年龄</div></td>
    <td><input type="text" class="noborder" name="grnl" id="grnl" style="width: 97%" onblur="registerNl()"/></td>
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
    <td colspan="6" align="left">				
    	<input class="noborder" name="ajly" id="ajly" style="width: 98%"/>  				       
    </td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">受理日期</div></td>
    <td colspan="2"><input type="text" class="noborder" id="slrq" name="slrq"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"    readonly style="width: 98%" /></td>
    <td colspan="2"><div align="center">填表日期</div></td>
    <td colspan="2"><input type="text" class="noborder" id="tbrq" name="tbrq"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"    readonly style="width: 98%" /></td> 	
  </tr>
  <tr>
    <td colspan="2"><div align="center">主要违法<br/>
    事&nbsp;&nbsp;&nbsp;&nbsp;实</div></td>
    <td colspan="6"><textarea rows="5" name="zywfss" id="zywfss" style="width: 99%"></textarea></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">立&nbsp;&nbsp;案<br/>
   依&nbsp;&nbsp;据</div></td>
    <td colspan="6"><textarea rows="5" name="layj" id="layj" style="width: 99%"></textarea></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">承办人<br/>
    建&nbsp;&nbsp;议</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="cbrjy" id="cbrjy" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="cbrqm" id="cbrqm" onfocus="underwrite(this)" style="width:50px" />
			<img  width="60" height="25" id="fjldSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbrqmrq" id="cbrqmrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
 <tr>
    <td colspan="2"><div align="center">承办部门<br/>
    意&nbsp;&nbsp;&nbsp;&nbsp;见</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="cbbmyj" id="cbbmyj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="cbbmqm" id="cbbmqm" onfocus="underwrite(this)" style="width:50px" />
			<img  width="60" height="25" id="zdslSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="cbbmqmrq" id="cbbmqmrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
 <tr>
    <td colspan="2"><div align="center">会&nbsp;&nbsp;审<br/>
    意&nbsp;&nbsp;见</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="hsyj" id="hsyj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="hsqm" id="hsqm" onfocus="underwrite(this)" style="width:50px" />
			<img  width="60" height="25" id="zdldSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="hsqmrq" id="hsqmrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">主管领导<br/>
      批&nbsp;&nbsp;&nbsp;&nbsp;示</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="zgldps" id="zgldps" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="zgldqm" id="zgldqm" onfocus="underwrite(this)" style="width:50px" />
			<img  width="60" height="25" id="sjfgjzSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="zgldqmrq" id="zgldqmrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">备&nbsp;&nbsp;注</div></td>   
    <td colspan="6">   	
    	<textarea rows="3" name="bz" id="bz" style="width: 99%;font-size:14px;"></textarea>
    </td>
  </tr>
</table>
	<input type="text"   class="noborder"  style="width: 70%;display:none;"  value="<%=name%>" name="qy" id="qy" />
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
	saveBy();
}
</script>
</html>
