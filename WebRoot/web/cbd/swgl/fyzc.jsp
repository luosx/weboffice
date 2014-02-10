<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@ page import="com.klspta.web.cbd.swkgl.Fyzcmanager" %>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.cbd.swkgl.Fyzcmanager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String list = Fyzcmanager.getInstcne().getList();



String [] start=list.split("</table>");
String add="<tr ><td align='center' height='10' width='10'><input id='mc1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='gzfy1' type='text'/></td>"+
			"<td align='center' height='10' width='10'><input id='gzgm1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='cbzj1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='gzdj1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lyfy1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lygm1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='qmfy1' type='text'/></td>"+
			"<td align='center' height='10' width='10'><input id='jzmj1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='zyzj1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='ftlx1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='fymc1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='ze1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='pmft1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='lyft1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='jzft1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='jkzj1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='dj1' type='text' /></td>"+
			"<td align='center' height='10' width='10'><input id='bz1' type='text' /></td>"+
			"<td></td>"+
		"</tr>";
String all=start[0]+add+"</table>";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 

  <head>
    <base href="<%=basePath%>" >
    <title>My JSP 'JbbZrb.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
	table-layout: fixed;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align: center;
	
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.tr01 {
	background-color: #C0C0C0;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
  input{
  text-align: center;
  width: 85px;
  }
}
</style>
  </head>
  <script type="text/javascript">
	var yw_guid_xh_value = "";

	function save(){
	var sj = yw_guid_xh_value;
	var jzrq =document.getElementById("jzrq").value;
	jzrq=escape(escape(jzrq));
	sj=escape(escape(sj));
	putClientCommond("fyzcHandle","saveFyzc");
	putRestParameter("sj",sj);
	putRestParameter("jzrq",jzrq);
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	
	}
	
	function add(){
	var mc=document.getElementById("mc1").value;
	var gzfy=document.getElementById("gzfy1").value;
	var gzgm=document.getElementById("gzgm1").value;
	var cbzj=document.getElementById("cbzj1").value;
	var gzdj=document.getElementById("gzdj1").value;
	var lyfy=document.getElementById("lyfy1").value;
	var lygm=document.getElementById("lygm1").value;
	var qmfy=document.getElementById("qmfy1").value;
	var jzmj=document.getElementById("jzmj1").value;
	var zyzj=document.getElementById("zyzj1").value;
	var ftlx=document.getElementById("ftlx1").value;
	var fymc=document.getElementById("fymc1").value;
	var ze=document.getElementById("ze1").value;
	var pmft=document.getElementById("pmft1").value;
	var lyft=document.getElementById("lyft1").value;
	var jzft=document.getElementById("jzft1").value;
	var jkzj =document.getElementById("jkzj1").value;
	var dj=document.getElementById("dj1").value;
	var bz=document.getElementById("bz1").value;
	var jzrq =document.getElementById("jzrq").value;
	mc=escape(escape(mc));
	jzrq=escape(escape(jzrq));
	bz=escape(escape(bz));
	putClientCommond("fyzcHandle","addFyzc");
	
	putRestParameter("mc",mc);
	putRestParameter("gzfy",gzfy);
	putRestParameter("gzgm",gzgm);
	putRestParameter("cbzj",cbzj);
	putRestParameter("gzdj",gzdj);
	putRestParameter("lyfy",lyfy);
	putRestParameter("lygm",lygm);
	putRestParameter("qmfy",qmfy);
	putRestParameter("jzmj",jzmj);
	putRestParameter("zyzj",zyzj);
	putRestParameter("ftlx",ftlx);
	putRestParameter("fymc",fymc);
	putRestParameter("ze",ze);
	putRestParameter("pmft",pmft);
	putRestParameter("lyft",lyft);
	putRestParameter("jzft",jzft);
	putRestParameter("jkzj",jkzj);
	putRestParameter("dj",dj);
	putRestParameter("bz",bz);
	putRestParameter("jzrq",jzrq);
	
	var msg=restRequest();
	if('success'==msg){
	alert("添加成功！");
	document.location.reload();
	}else{
	alert("添加失败！");
	}
	}
	
	function chang(yw){
	
	if (yw_guid_xh_value != null && yw_guid_xh_value != "") {
			yw_guid_xh_value = yw_guid_xh_value+"@"+yw.id + "_" + yw.value
		} else {
			yw_guid_xh_value = yw.id + "_" + yw.value
		}
	
	}
	
	function del(yw_guid) {
		if (confirm("确定要删除当前记录吗？")) {
			putClientCommond("fyzcHandle", "delByYwGuid");
			putRestParameter("yw_guid", yw_guid);
			var reslut = restRequest();
			if (reslut == 'success') {
				alert('删除成功！');
				window.location.reload();
			}
		}

	}
	

			
  </script>
  <body>
  <div id="fixed" style="position: fixed; top: 1px; left: 3px">
  		&nbsp;
  		<img src="base/form/images/save-file.png" width="20px" height="20px" title="保存" onClick="save()"  />&nbsp;&nbsp;&nbsp;
		<img src="base/form/images/add.png" width="20px" height="20px" title="添加" onClick="add();"  />&nbsp;&nbsp;&nbsp;
	</div><br/>
		<%=all%>
  </body>
</html>
