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
    String xzqh = ManagerFactory.getUserManager().getUserWithId(userid).getXzqh();
    String name = UtilFactory.getXzqhUtil().getBeanById(xzqh).getCatonname();
	System.out.println(name + "-------------------------------------------------------------");
	System.out.println("edit:" + edit);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<TITLE>信访举报</TITLE>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<%} %>
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
			document.getElementById('bh2').value=document.getElementById('bh').value;
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
<% 
System.out.println("打印：" + (fixed!=null && fixed.equals("fixedPrint")) );
System.out.println("保存：" + !"false".equals(edit));
if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	
}else if(!"false".equals(edit)){%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1>违法案件线索反馈信息</h1></div>
<form method="post">
<div style="width:100%;"><span style="margin-left: 330px;">线索号：
 <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="bh" id="bh" style="width: 97%"/>
   				        <%}else{ %>
<input type="text" name="bh" id="bh" style="width:150px;background-color:transparent;border:0px;"></span>
<%} %> 
</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
  <tr>
    <td colspan="6"><div align="left">&nbsp;调查处理中务必做到保护举报人。</div></td>
  </tr>
  <tr>
    <td width="35" rowspan="8"><p align="center">基<br/><br/>本<br/><br/>信<br/><br/>息</p></td>
    <td width="92"><div align="center">线索类型</div></td>
    <td colspan="4">
     <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="xslx" id="xslx" style="width: 98%"/>
   				        <%}else{ %>
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name='xslx' id='xslx' value="一般违法线索" checked/>一般违法线索&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="radio" name='xslx' id='xslx' value="重大违法线索"/>重大违法线索
							<%} %>
							</div>
						</td>										
  </tr>
  <tr>
    <td><div align="center">办理方式</div></td>
    <td colspan="4">   <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="blfs" id="blfs" style="width: 98%"/>
   				        <%}else{ %>
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name='blfs' id='blfs' value="转办"/>转办&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="radio" name='blfs' id='blfs' value="交办"/>交办&nbsp;&nbsp;&nbsp;&nbsp;
					      <input type="radio" name='blfs' id='blfs' value="挂牌督办"/>挂牌督办&nbsp;&nbsp;&nbsp;&nbsp;
					      <input type="radio" name='blfs' id='blfs' value="派人直查"/>派人直查
							<%} %>
							</div></td>
  </tr>
  <tr>
    <td><div align="center">举报人</div></td>
    <td colspan="2"><input type="text" class="textcls" name="jbr" id="jbr" style="width: 98%;"/></td>
    <td width="69"><div align="center">举报方式</div></td>
    <td width="160"><input type="text" class="noborder" name="jbfs" id="jbfs" style="width: 98%"/></td>
  </tr>
  <tr>
    <td rowspan="2"><div align="center">举报联系方式</div></td>
    <td width="75" height="16"><div align="center">联系地址</div></td>
    <td colspan="3"><input type="text" class="noborder" name="lxdz" id="lxdz" style="width: 98%"/></td>
  </tr>
  <tr>
    <td><div align="center">邮政编码</div></td>
    <td width="155"><input type="text" class="noborder" name="yzbm" id="yzbm" style="width: 98%"/></td>
    <td><div align="center">联系电话</div></td>
    <td><input type="text" class="noborder" name="lxdh" id="lxdh" style="width: 98%"/></td>
  </tr>
  <tr>
    <td><div align="center">被举报单位</div></td>
    <td colspan="4"><input type="text" class="noborder" name="bjbdw" id="bjbdw" style="width: 98%"/></td>
  </tr>
  <tr>
    <td><div align="center">问题发生地</div></td>
    <td colspan="4"><input type="text" class="noborder" name="wtfsd" id="wtfsd" style="width: 98%"/></td>
  </tr>
  <tr>
    <td><div align="center">问题发生时间</div></td>
    <td colspan="2"><input type="text" class="noborder" id="wtfssj" name="wtfssj"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly style="width: 98%" /></td>
    <td><div align="center">登记时间</div></td>
    <td><input type="text" class="noborder" id="djsj" name="djsj"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly style="width: 98%" /></td>
  </tr>
  <tr>
    <td><p align="center">线<br/><br/>索<br/><br/>摘<br/><br/>要</p></td>
    <td colspan="5"><textarea rows="10" name="xszy" id="xszy" style="width: 99%"></textarea></td>
  </tr>
  
  <tr>
    <td rowspan="3"><div align="center">反<br/><br/>馈<br/><br/>信<br/><br/>息</div></td>
    <td height="29"><div align="center">反馈单位</div></td>
    <td colspan="4"><input type="text" class="noborder" name="fkdw" id="fkdw" style="width: 98%"/></td>
  </tr>
  <tr>
    <td height="29" colspan="3"> <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="ssqk" id="ssqk" style="width: 98%"/>
   				        <%}else{ %>
						 &nbsp;&nbsp;&nbsp;<input type="radio" name='ssqk' id='ssqk' value="基本属实"/>基本属实&nbsp;&nbsp;
					     <input type="radio" name='ssqk' id='ssqk' value="部分属实"/>部分属实&nbsp;&nbsp;
					      <input type="radio" name='ssqk' id='ssqk' value="基本不属实"/>基本不属实
							<%} %>
							</div></td>
    <td><div align="center">是否立案</div></td>
    <td> <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="sfla" id="sfla" style="width: 98%"/>
   				        <%}else{ %>
						&nbsp;&nbsp;&nbsp;<input type="radio" name='sfla' id='sfla' value="是"/>是&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="radio" name='sfla' id='sfla' value="否"/>否
							<%} %>
							</div></td>
  </tr>
  <tr>
    <td height="89"><div align="center">线索情况说明</div></td>
    <td colspan="4"><textarea rows="8" name="xsqksm" id="xsqksm" style="width: 99%"></textarea></td>
  </tr>
  <tr>
    <td><div align="center">备<br/><br/>注</div></td>
    <td colspan="5"><textarea rows="8" name="bz" id="bz" style="width: 99%"></textarea></td>
  </tr>
</table>
	<input type="text"   class="noborder"  style="width: 70%;display:none;"  value="<%=name%>" name="qy" id="qy" />
			</form>
				  <div style="width:100%;"><span style="margin-left: 330px;"> 线索号：<input type="text" name="bh2" id="bh2" style="width:150px;background-color:transparent;border:0px;"></span></div>
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
