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
		<title>处罚决定落实情况</title>
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

		}
		function save(){
		   document.forms[0].submit(); 
		}
		function refresh(){
				document.location.refresh();
		}



function openAdd(){
 var returnValues=window.showModalDialog('<%=basePath%>web/jinan/cfjdzysx/changePersonNumber.jsp',window,'dialogWidth=300px;dialogHeight=200px;status=no;scroll=no');
 if(returnValues&&returnValues[0]){
 	document.getElementById('lszrrxm').value+=(returnValues[0]+'\n');
 	document.getElementById('lszrrsex').value+=(returnValues[1]+'\n');
 	document.getElementById('lszrrzw').value+=(returnValues[2]+'\n');
 	document.getElementById('lszrrjb').value+=(returnValues[3]+'\n');
 	var arr=document.getElementById('lszrrxm').value.split("\n");
 	document.getElementById('yjzjzrrrs').value=arr.length-1;
  }
}

function openDelete(){
var array=new Array(4);
	array[0]=document.getElementById('lszrrxm').value;
	array[1]=document.getElementById('lszrrsex').value;
	array[2]=document.getElementById('lszrrzw').value;
	array[3]=document.getElementById('lszrrjb').value;
var returnValues=window.showModalDialog('<%=basePath%>web/jinan/cfjdzysx/changePersonNumber.jsp?type=delete',array,'dialogWidth=300px;dialogHeight=200px;status=no;scroll=no');
 if(returnValues&&returnValues[0]){
 	document.getElementById('lszrrxm').value=(document.getElementById('lszrrxm').value).replace(returnValues[0]+'\n','');
 	document.getElementById('lszrrsex').value=(document.getElementById('lszrrsex').value).replace(returnValues[1]+'\n','');
 	document.getElementById('lszrrzw').value=(document.getElementById('lszrrzw').value).replace(returnValues[2]+'\n','');
 	document.getElementById('lszrrjb').value=(document.getElementById('lszrrjb').value).replace(returnValues[3]+'\n','');

 	var arr=document.getElementById('lszrrxm').value.split("\n");
 	document.getElementById('yjzjzrrrs').value=arr.length-1;
 }

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
					处罚决定落实情况</div>
	  <form id="form" method="post">
	  <br/>
		<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
  <tr>
    <td height="38" colspan="2"><div align="center">应拆除建筑面积</div></td>
    <td width="140"><input id="yccjzmj" name="yccjzmj" type="text" /></td>
    <td width="130"><div align="center">已拆除建筑面积</div></td>
    <td width="140"><input id="yjccjzmj" name="yjccjzmj" type="text" /></td>
  </tr>
  <tr>
    <td height="38" colspan="2"><div align="center">应没收建筑面积</div></td>
    <td><input id="ymsjzmj" name="ymsjzmj" type="text" /></td>
    <td><div align="center">已没收建筑面积</div></td>
    <td><input id="yjmsjzmj" name="yjmsjzmj" type="text" /></td>
  </tr>
  <tr>
    <td height="38" colspan="2"><div align="center">应&nbsp;收&nbsp;罚&nbsp;款&nbsp;金&nbsp;额</div></td>
    <td><input id="ysfkje" name="ysfkje" type="text" /></td>
    <td><div align="center">已收缴罚款金额</div></td>
    <td><input id="yjsfkje" name="yjsfkje" type="text" /></td>
  </tr>
  <tr>
    <td height="28" colspan="3"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已追究土地违法责任人责任情况</div></td>
    <td colspan="2">
     <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="yjzjzrqk" id="yjzjzrqk" style="width: 98%"/>
   				        <%}else{ %>
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name='yjzjzrqk' id='yjzjzrqk' value="党纪政纪责任"/>党纪政纪责任&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="radio" name='yjzjzrqk' id='yjzjzrqk' value="刑事责任"/>刑事责任
							<%} %>
							</div>
    </td>
  </tr>
  <tr>
    <td width="68" rowspan="3"><div align="center">责任人</div></td>
    <td width="70" height="28"><div align="center">人数</div></td>
    <td><input id="yjzjzrrrs" name="yjzjzrrrs" type="text" /></td>
    <td><input type="button" id="add" value="增加" onclick="openAdd()"/></td>
    <td><input type="button" id="delete" value="删除" onclick="openDelete()"/></td>
  </tr>
  <tr>
    <td height="37"><div align="center">姓&nbsp;&nbsp;名</div></td>
    <td><div align="center">性&nbsp;&nbsp;别</div></td>
    <td ><div align="center">职&nbsp;&nbsp;务</div></td>
    <td><div align="center">级&nbsp;&nbsp;别</div></td>

  </tr>
   <tr style="height:80px;">
    <td>
    	<textarea id="lszrrxm" name="lszrrxm" style="width: 96%;height:80px;" ></textarea>
    </td>
    <td>		
    	<textarea  name="lszrrsex" id="lszrrsex" style="width: 96%;height:80px;" ></textarea>
    </td>
    <td>
    	<textarea id="lszrrzw" name="lszrrzw" style="width: 96%;height:80px;"></textarea>
    </td>
    <td>					
    	<textarea  name="lszrrjb" id="lszrrjb" style="width: 96%;height:80px;" ></textarea>
	</td>
  <tr>
    <td rowspan="2"><div align="center">责任类型</div></td>
    <td height="28" colspan="2"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是否申请法院强制执行</div></td>
    <td colspan="2">
           <div align="left">
     <%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="sqfyqzzx" id="sqfyqzzx" style="width: 98%"/>
   				        <%}else{ %>
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name='sqfyqzzx' id='sqfyqzzx' value="是"/>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="radio" name='sqfyqzzx' id='sqfyqzzx' value="否"/>否
							<%} %>
     </div>
    </td>
  </tr>
  <tr>
    <td height="47"><div align="center">文号</div></td>
    <td><input id="fyqzzxwh" name="fyqzzxwh" type="text" /></td>
    <td><div align="center">移送时间</div></td>
    <td>
    <input type="text" id="fyqzzxyssj" name="fyqzzxyssj" onClick="WdatePicker()" readonly="readonly" />
    </td>
  </tr>
  <tr>
    <td height="110"><div align="center">备注</div></td>
    <td colspan="4">
     <textarea style="width: 98%" rows="5"  name="zrlxbz" id="zrlxbz"></textarea></td>
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
