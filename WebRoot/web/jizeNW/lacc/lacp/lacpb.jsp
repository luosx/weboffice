<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    //String name = UtilFactory.getXzqhUtil().getBeanById(ManagerFactory.getRoleManager().getRoleWithUserID(userid).get(0).getXzqh()).getCatonname();
    String xzqh = ManagerFactory.getUserManager().getUserWithId(userid).getXzqh();
   	String name = UtilFactory.getXzqhUtil().getBeanById(xzqh).getCatonname();
   	String wfInsId1 = request.getParameter("wfInsId");
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
		<script type="text/javascript" src="<%=basePath%>/web/jizeNW/lacc/js/sign.js"></script>
		<script>
		var userId = "<%=userid%>";
			var basePath = "<%=basePath%>";
		
		function initEdit(){
			init();
			    document.getElementById("bh2").value=document.getElementById("bh").value
			    document.getElementById("ay2").value="案由："+document.getElementById("ay").value
				var singnames = "ddcbr01#ddcbr02#sjfgjz#fjld#zdsl#zdld";
				signLoad(singnames);
		}
			function save(){
			var bh = document.getElementById("bh");  
			var ay = document.getElementById("ay"); 
			var sjfgjzrq =document.getElementById("sjfgjzrq").value; 
			var yw_guid='<%=yw_guid%>';  
            putClientCommond("lacc","saveBhAy");
 			putRestParameter("yw_guid",yw_guid);
 			putRestParameter("sjfgjzrq",sjfgjzrq);
 			putRestParameter("ay",escape(escape(ay.value)));
			putRestParameter("bh",escape(escape(bh.value)));
			var res=restRequest();
			
				document.forms[0].submit();
			}
			function refresh(){
				document.location.refresh();
			}
			
			function changeay(check){
				document.getElementById("ay2").innerText = "案由："+check.innerText;
			}
			function writeBZ(text){
				if(text=='其他需备注的写在此处...'){
					document.getElementById('bz').value='';
				}
			}
			function writeSM(text){
				if(text==''){
					document.getElementById('bz').value='其他需备注的写在此处...';
				}			
			}
			//删除冗余数据
			function deleteData(){
				var ay = document.getElementById('ay').value;
				var zywfss = document.getElementById('zywfss').value;
				if(ay == ''&& zywfss == ''){
				  putClientCommond("startWorkflowLacc","deleteWorkflow");
     			  putRestParameter("yw_guid","<%=yw_guid%>");
     			  putRestParameter("wfInsId", "<%=wfInsId1%>");
      			  restRequest();
				}
			}			
		</script>
		
	</head>
	
<body bgcolor="#FFFFFF">
<% 
if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	
}else if(!"false".equals(edit)){%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1>违法案件立案呈批表</h1></div>
<form method="post">
<div style="width:600px;text-align:right;"><span style="font-size:14px;">立案编号：
 <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="bh" id="bh" style="width: 97%"/>
   				        <%}else{ %>
<input type="text" name="bh" id="bh" style="width:180px;background-color:transparent;border:0px;"></span>
<%} %> 
</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
  <tr>
    <td colspan="2"><div align="center">案由</div></td>
    <td colspan="6"><textarea class="noborder" rows="5" style="width: 99%;font-size:14px;" name="ay" onkeyup="changeay(this)" id="ay"></textarea></td>
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
    <td><input type="text" class="noborder" name="dwdh" id="dwdh" style="width: 97%" onblur="registerDh()"/></td>
  </tr>
  <tr>
    <td rowspan="3"><div align="center">个人</div></td>
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
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="ajly" id="ajly" style="width: 98%"/>
   				        <%}else{ %>
							<select style="width: 25%" id="ajly"    name="ajly">
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
							<%} %>    
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
    <td colspan="2"><div align="center">大&nbsp;&nbsp;&nbsp;&nbsp;队<br/>
      承&nbsp;办&nbsp;人<br/>
    建&nbsp;&nbsp;&nbsp;&nbsp;议</div></td>
    <td colspan="6" >
	<textarea rows="5"  cols="70" name="ddcbrjy" id="ddcbrjy" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div  class="divLeftFloat">签名：<input class="underline" type="text" name="ddcbr01" id="ddcbr01" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
									<img  id="ddcbr01Sign" style="display:none;" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="ddcbrrq01" id="ddcbrrq01" readonly  style="width: 80px"/></div>
			<br/><br/><div class="divLeftFloat">签名：<input class="underline" type="text" name="ddcbr02" id="ddcbr02" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
									<img  width="50px" height="20" id="ddcbr02Sign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="ddcbrrq02" id="ddcbrrq02" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">分局领导<br/>
    审查意见</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="fjldyj" id="fjldyj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="fjld" id="fjld" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
			<img  width="60" height="25" id="fjldSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="fjldrq" id="fjldrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
 <tr>
    <td colspan="2"><div align="center">支队审理<br/>
    意&nbsp;&nbsp;&nbsp;&nbsp;见</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="zdslyj" id="zdslyj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="zdsl" id="zdsl" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
			<img  width="60" height="25" id="zdslSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="zdslrq" id="zdslrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
 <tr>
    <td colspan="2"><div align="center">支队领导<br/>
    审核意见</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="zdldyj" id="zdldyj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="zdld" id="zdld" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
			<img  width="60" height="25" id="zdldSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="zdldrq" id="zdldrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">市&nbsp;&nbsp;&nbsp;&nbsp;局<br/>
      分管局长<br/>
    签批意见</div></td>
    <td colspan="6">
		<textarea rows="5" cols="70" name="sjfgjzyj" id="sjfgjzyj" style="width: 99%"></textarea>
    	 <div class="div80">
		  	<div class="divLeftFloat">签名：<input class="underline" type="text" name="sjfgjz" id="sjfgjz" onfocus="underwrite(this)" onClick="sign(this);"    style="width:50px" />
			<img  width="60" height="25" id="sjfgjzSign" style="display:none" /></div>
		    <div>日期：<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="sjfgjzrq" id="sjfgjzrq" readonly  style="width: 80px"/></div>
		 </div>	</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">备注</div></td>
    
    <td colspan="6">
    	<textarea rows="5" name="ay2" id="ay2" style="width: 99%;border-bottom:0.5px #000 solid;font-size:14px;"></textarea>
    	
    	<textarea rows="5" name="bz" id="bz" style="width: 99%;font-size:14px;" onfocus="writeBZ(this.value)" onblur="writeSM(this.value)">其他需备注的写在此处...</textarea>
    </td>
  </tr>

</table>
	<input type="text"   class="noborder"  style="width: 70%;display:none;"  value="<%=name%>" name="qy" id="qy" />
			</form>
				  <div style="width:600px;text-align:right;"><span style="font-size:14px;"> 立案编号：<input type="text" name="bh" id="bh2" style="width:180px;background-color:transparent;border:0px;"></span></div>
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
