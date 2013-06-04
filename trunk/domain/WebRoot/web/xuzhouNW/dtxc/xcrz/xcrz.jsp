<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.ManagerFactory"%>

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
    Object principal1 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String writeXzqh = ManagerFactory.getRoleManager().getRoleWithUserID(((User)principal1).getUserID()).get(0).getXzqh();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	    <base href="<%=basePath%>"/>
		<TITLE>巡查日志</TITLE>
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
			show();
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
			var name = new Array("jsmj", "jsdw", "dgsj", "jsqk", "zdmj", "zdwz");
			var allnum = document.getElementById("allnum");
			var num = allnum.value;
			num = String(parseInt(num)/3);
			for(var i = 0; i < name.length; i++){
				var nameValue = document.getElementById(name[i]);
				nameValue.value = "";
				for(var j = 0; j < num; j++){
					var sunValue = document.getElementById(name[i] + (j + 1));
					var saveValue = sunValue.value;
					if(saveValue == "" || saveValue == null){
						saveValue = "isnull";
					}
					if(nameValue.value == ""){
						nameValue.value = saveValue;
					}else{
						nameValue.value += "##" + saveValue;
					}
					
				}
			}
			document.forms[0].submit();
		}
		
		function show(){
			var name = new Array("jsmj", "jsdw", "dgsj", "jsqk", "zdmj", "zdwz");
			var allnum = document.getElementById("allnum");
			var num = allnum.value;
			num = String(parseInt(num)/3 + 1);
			for(var i = 1; i < document.getElementById("jsmj").value.split("##").length; i++){
				addcgd();
			}
			for(var i = 0; i < name.length; i++){
				var nameValue = document.getElementById(name[i]);
				var valueArray = nameValue.value.split("##");
				for(var j = 0; j < num; j++){
					var sunValue = document.getElementById(name[i] + (j + 1));
					if(valueArray[j] != "isnull" && valueArray[j] != "" && valueArray[j] != null){
						sunValue.value = valueArray[j];
					}
				}
			}
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
<div align="center"><h1>国土资源执法监察巡查日志</h1></div>
<form method="post">
 <div style="width:100%;"><span style="margin-left: 330px;">巡查编号：<input type="text" name="xcbh" id="xcbh" style="width:150px;background-color:transparent;border:0px;"></span></div>
<table id="xcrztable" class="lefttopborder1" cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
   <tr>
    <td height="16" colspan="2"><div align="center">巡查单位</div></td>
    <td width="166"><input type="text" class="noborder" name="xcdw" id="xcdw" style="width: 97%"/></td>
    <td width="102"><div align="center">巡查日期</div></td>
    <td width="211"><input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="xcrq" id="xcrq" readonly style="width: 97%"/></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">巡查区域</div></td>
    <td colspan="3"><input type="text" class="noborder" name="xcqy" id="xcqy" style="width: 99%"/></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">巡查人员</div></td>
    <td colspan="3"><input type="text" class="noborder" name="xcry" id="xcry" style="width: 99%"/></td>
  </tr>
  <tr>
    <td height="21" colspan="2"><div align="center">巡查路线</div></td>
    <td colspan="3"><input type="text" class="noborder" name="xclx" id="xclx" style="width: 99%"/></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">是否有违法</div></td>
    <td colspan="3">  
     <%if(permission.equals("yes")){ %>					
    	<input class="noborder" name="sfywf" id="sfywf" style="width: 98%"/>
   	 <%}else{ %>
   	  <div align="left">
   	 &nbsp;&nbsp;<input type="radio" name="sfywf" id="sfywf" value="是"/>是&nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="radio" name="sfywf" id="sfywf" value="否"/>否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button" id="add" value="增加" onclick="addcgd()"/>&nbsp;&nbsp;&nbsp;&nbsp;
   	 <input type="button" id="delete" value="删除" onclick="deletecgd()"/>
   	 <input type="text" id="allnum" value="3" style="display:none;" />
	<%} %>
	</div></td>
  </tr>
  <tr>
    <td rowspan="3"><div align="center"><input type="checkbox" id="check1"/></div></td>
    <td><div align="center">建设项目</div></td>
    <td><input type="text" class="noborder" name="jsmj1" id="jsmj1" style="width: 97%"/>
    	<input type="text" name="jsmj" id="jsmj" style="display:none" />
    </td>
    <td><div align="center">建设单位</div></td>
    <td><input type="text" class="noborder" name="jsdw1" id="jsdw1" style="width: 97%"/>
    	<input type="text" name="jsdw" id="jsdw" style="display:none" />
    </td>
  </tr>
  <tr>
    <td><div align="center">动工时间</div></td>
    <td><input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj1" id="dgsj1" readonly style="width: 97%"/>
    	<input type="text" name="dgsj" id="dgsj" style="display:none" />
    </td>
    <td><div align="center">建设情况</div></td>
    <td><input type="text" class="noborder" name="jsqk1" id="jsqk1" style="width: 97%"/>
    	<input type="text" name="jsqk" id="jsqk" style="display:none" />
    </td>
  </tr>
  <tr>
    <td><div align="center">占地面积</div></td>
    <td><input type="text" class="noborder" name="zdmj1" id="zdmj1" style="width: 97%"/>
    	<input type="text" name="zdmj" id="zdmj" style="display:none" />
    </td>
    <td><div align="center">占地位置</div></td>
    <td><input type="text" class="noborder" name="zdwz1" id="zdwz1" style="width: 97%"/>
    	<input type="text" name="zdwz" id="zdwz" style="display:none" />
    </td>
  </tr>
  <tr>
    <td width="40" rowspan="2"><p align="center">巡</p>
    <p align="center">查</p>
    <p align="center">内</p>
    <p align="center">容</p></td>
    <td width="82"><div align="center">项目<br/>
      建设<br/>
      及用<br/>
      地手<br/>
      续审<br/>
      批情<br/>
    况</div></td>
    <td colspan="3"><textarea rows="15" name="psqk" id="psqk" style="width: 99%"></textarea></td>
  </tr>
    
    <tr>
    <td><div align="center">对所<br/>
      建项<br/>
      目的<br/>
      处理<br/>
      意见<br/>
     </div></td>
    <td colspan="3"><textarea rows="10" name="clyj" id="clyj" style="width: 99%"></textarea></td>
    </tr>
   <tr>
    <td colspan="2"><div align="center">备注</div></td>
    <td colspan="3"><textarea rows="6" name="bz" id="bz" style="width: 99%"></textarea></td>
  </tr>
</table>
	<input type="text" value="<%=writeXzqh%>" id="writexzqh" name="writexzqh" style="display:none" />
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
