<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
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
		<title>处罚决定主要事项</title>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<%} %>
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
<% if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixedPrint" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	}else if(!"false".equals(edit)){%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
      <div style="margin:20px" class="tablestyle1" align="center" >  
      <div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					处罚决定主要事项</div>
	  <form id="form" method="post">
	  <br/>
		<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
<tr>
<td rowspan="7"><div align="center">案<br/>件<br/>基<br/>本<br/>情<br/>况</div></td>
<td rowspan="5"><div align="center">占地类型及面积（m²）</div></td>
<td rowspan="3"><div align="center">农用地</div></td>
<td><div align="center">基本农田</div></td>
<td><input id="jbnt" name="jbnt" type="text" /></td>
</tr>
<tr>
<td><div align="center">耕地</div></td>
<td><input id="gd" name="gd" type="text" /></td>
</tr>

<tr>
<td><div align="center">其他农用地</div></td>
<td><input id="qtnyd" name="qtnyd" type="text" /></td>
</tr>

<tr>
<td><div align="center">建设用地</div></td>
<td colspan="2"><input id="jsyd" name="jsyd" type="text" /></td>
</tr>

<tr>
<td><div align="center">未利用地</div></td>
<td colspan="2"><input id="wlyd" name="wlyd" type="text" /></td>
</tr>

<tr>
<td><div align="center">建筑面积（m²）</div></td>
<td><input id="jzmj" name="jzmj" type="text" /></td>
<td><div align="center">占地面积合计（m²）</div></td>
<td><input id="zdmjhj" name="zdmjhj" type="text" /></td>
</tr>

<tr>
<td><div align="center">符合规划面积（m²）</div></td>
<td><input id="fhghmj" name="fhghmj" type="text" /></td>
<td><div align="center">不符合规划面积（m²）</div></td>
<td><input id="bfhghmj" name="bfhghmj" type="text" /></td>
</tr>
  <tr>
    <td  width="130" height="38" colspan="2"><div align="center">应拆除建筑面积</div></td>
    <td width="130"><input id="yccjzmj" name="yccjzmj" type="text" /></td>
    <td width="130"><div align="center">应没收建筑面积</div></td>
    <td width="130"><input id="ymsjzmj" name="ymsjzmj" type="text" /></td>
  </tr>
  <tr>
    <td height="39" colspan="2"><div align="center">应收罚款金额</div></td>
    <td><input id="ysfkje" name="ysfkje" type="text" /></td>
    <td><p align="center">&nbsp;</p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="28" colspan="3"><div align="center">提出追究土地违法责任人责任情况</div></td>
    <td colspan="2">
         <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="tczjzrqk" id="tczjzrqk" style="width: 98%"/>
   				        <%}else{ %>
						 &nbsp;&nbsp;<input type="radio" name='tczjzrqk' id='tczjzrqk' value="党纪政纪责任"/>党纪政纪责任&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="radio" name='tczjzrqk' id='tczjzrqk' value="刑事责任"/>刑事责任
							<%} %>
     </div>
    </td>
  </tr>
  <tr>
    <td width="49" rowspan="3"><div align="center">责任人</div></td>
    <td width="69" height="28"><div align="center">人&nbsp;&nbsp;数</div></td>
    <td><input id="zrrrs" name="zrrrs" type="text"/></td>
    <td><input type="button" id="add" value="增加" onclick="openAdd()"></td>
    <td><input type="button" id="delete" value="删除" onclick="openDelete()"></td>
  </tr>
  <tr>
    <td height="37"><div align="center">姓&nbsp;&nbsp;名</div></td>
    <td><div align="center">性&nbsp;&nbsp;别</div></td>
    <td ><div align="center">职&nbsp;&nbsp;务</div></td>
    <td><div align="center">级&nbsp;&nbsp;别</div></td>
  </tr>
  <tr style="height:80px;">
    <td>
    	<textarea id="zrrxm" name="zrrxm" style="width: 96%;height:80px;" ></textarea>
    </td>
    <td>		
    	<textarea  name="zrrsex" id="zrrsex" style="width: 96%;height:80px;" ></textarea>
    </td>
    <td>
    	<textarea id="zrrzw" name="zrrzw" style="width: 96%;height:80px;"></textarea>
    </td>
    <td>					
    	<textarea  name="zrrjb" id="zrrjb" style="width: 96%;height:80px;" ></textarea>
	</td>
  </tr>
  <tr>
    <td height="110" colspan="2"><div align="center">备注</div></td>
    <td colspan="3">
    <textarea style="width: 98%" rows="5"  name="zrqkbz" id="zrqkbz"></textarea></td>
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

function openAdd(){
 var returnValues=window.showModalDialog('<%=basePath%>web/qingdaoNW/lacc/cfjd/changePersonNumber.jsp',window,'dialogWidth=300px;dialogHeight=200px;status=no;scroll=no');
 if(returnValues&&returnValues[0]){
 	document.getElementById('zrrxm').value+=(returnValues[0]+'\n');
 	document.getElementById('zrrsex').value+=(returnValues[1]+'\n');
 	document.getElementById('zrrzw').value+=(returnValues[2]+'\n');
 	document.getElementById('zrrjb').value+=(returnValues[3]+'\n');
 	var arr=document.getElementById('zrrxm').value.split("\n");
 	document.getElementById('zrrrs').value=arr.length-1;
 }
}

function openDelete(){
var array=new Array(4);
	array[0]=document.getElementById('zrrxm').value;
	array[1]=document.getElementById('zrrsex').value;
	array[2]=document.getElementById('zrrzw').value;
	array[3]=document.getElementById('zrrjb').value;
var returnValues=window.showModalDialog('<%=basePath%>web/qingdaoNW/lacc/cfjd/changePersonNumber.jsp?type=delete',array,'dialogWidth=300px;dialogHeight=200px;status=no;scroll=no');
 if(returnValues&&returnValues[0]){
 	document.getElementById('zrrxm').value=(document.getElementById('zrrxm').value).replace(returnValues[0]+'\n','');
 	document.getElementById('zrrsex').value=(document.getElementById('zrrsex').value).replace(returnValues[1]+'\n','');
 	document.getElementById('zrrzw').value=(document.getElementById('zrrzw').value).replace(returnValues[2]+'\n','');
 	document.getElementById('zrrjb').value=(document.getElementById('zrrjb').value).replace(returnValues[3]+'\n','');

 	var arr=document.getElementById('zrrxm').value.split("\n");
 	document.getElementById('zrrrs').value=arr.length-1;
 }

}
</script>
</body>
</html>
