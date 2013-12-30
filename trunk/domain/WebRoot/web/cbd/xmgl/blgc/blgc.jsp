<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String xmmc = request.getParameter("xmmc");
	if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	} else {
		xmmc = "";
	}
	List<Map<String, Object>> list = null;
	if (!yw_guid.equals("") && !yw_guid.equals("null")) {
		Xmmanager hxzm = Xmmanager.getXmmanager();
		list = hxzm.getBLGC(yw_guid);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>办理过程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=basePath%>/base/form/DatePicker/WdatePicker.js"></script>
		<style type="text/css">
table {
	border-right: 1px solid #000000;
	border-bottom: 1px solid #000000;
}

table td {
	border-left: 1px solid #000000;
	border-top: 1px solid #000000;
}

input {
	border: none;
	width: 70px;
}

textarea {
	border: none;
}

.tr01 {
	background-color: #969696;
	font-weight: bold;
	font-size: 15px;
	text-align: center;
	line-height: 50px;
	margin-top: 3px;
}

.tr02 {
	background-color: #FFFFCC;
	text-align: center;
	line-height: 30px;
}

.tr03 {
	background-color: #CCFFCC;
	text-align: center;
	line-height: 30px;
}

.tr04 {
	background-color: #969696;
	font-weight: bold;
	text-align: center;
	line-height: 30px;
}

.tr06 {
	background-color: #FFFFFF;
	text-align: center;
	line-height: 30px;
}

.tr07 {
	background-color: #CCCCFF;
	text-align: center;
	line-height: 30px;
}

.tr11 {
	background-color: #C0C0C0;
	text-align: center;
	line-height: 25px;
}

.tr16 {
	background-color: #FFCC99;
	text-align: center;
	font-weight: bold;
	line-height: 30px;
}
</style>
		<script type="text/javascript">
		var BS='';
	function save(){
	var xh=document.getElementById("xh").value;
	var sj=document.getElementById("sj").value;
	var sjbl=document.getElementById("sjbl").value;
	var bmjbr=document.getElementById("bmjbr").value;
	var bz=document.getElementById("bz").value;
	if(xh==null||xh==''||sj==null||sj==''||sjbl==null||sjbl==''||bmjbr==null||bmjbr==''||bz==null||bz==''){
	 alert("请填写完整之后再保存！！"); 
	}else{
	sjbl=escape(escape(sjbl));
	bmjbr=escape(escape(bmjbr));
	bz=escape(escape(bz));
	putClientCommond("xmmanager","saveBLGC");
	putRestParameter("yw_guid","<%=yw_guid%>");
	putRestParameter("xh",xh);
	putRestParameter("sj",sj);
	putRestParameter("sjbl",sjbl);
	putRestParameter("bmjbr",bmjbr);
	putRestParameter("bz",bz);
	putRestParameter("BS",BS);
	BS='';
	var msg=restRequest();
	if('success'==msg){
	alert("保存成功！");
	document.location.reload();
	}else{
	alert("保存失败！");
	}
	}
	}
	
	function smb(bs){
	putClientCommond("xmmanager","smbBLGC");
	putRestParameter("bs",bs);
	putRestParameter("yw_guid","<%=yw_guid%>");
	var dat=restRequest();
	dat=eval(dat);
	var xh=dat[0].XH;
	var sj=dat[0].SJ;
	var sjbl=dat[0].SJBL;
	var bmjbr=dat[0].BMJBR;
	var bz=dat[0].BZ;
	BS=dat[0].BS;
document.getElementById("xh").value=xh;
document.getElementById("sj").value=sj;
document.getElementById("sjbl").value=sjbl;
document.getElementById("bmjbr").value=bmjbr;
document.getElementById("bz").value=bz;
	}
	function del(bs){
	putClientCommond("xmmanager","delBLGC");
	putRestParameter("bs",bs);
	putRestParameter("yw_guid","<%=yw_guid%>");
	var msg=restRequest();
	if('success'==msg){
	alert("删除成功！");
	document.location.reload();
	}else{
	alert("删除失败！");
	}
	}
</script>
	</head>
	<body bgcolor="#FFFFFF" style="overflow: scroll;">
		<div align="center" style="width:100%">
			<div align="center" style="width: 95%; height: 20px">
				<h3><%=(xmmc == null || xmmc == "" ? "" : xmmc)%>大事记
				</h3>
			</div>
			<table width="95%" cellpadding="0" cellspacing="0">
				<tr class="tr11">
					<td align="center" width="80px" height="50px">
						<h3>
							序号
						</h3>
					</td>
					<td align="center" width="90px">
					<h3>
						时间
						</h3>
					</td>
					<td align="center" width="500px">
					<h3>
						事件
						</h3>
					</td>
					<td align="center" width="120px">
					    <h3>
						部门/经办人
						</h3>
					</td>
					<td align="center" width="200px">
					 <h3>
						备注
						</h3>
					</td>
					<td align="center" width="100px">
					 <h3>
					操作
						</h3>
					</td>
				</tr>
				<%
					if (list != null) {
						for (int i = 0; i < list.size(); i++) {
				%>
				<tr align="center">
					<td align="center" width="80px">
						<%=list.get(i).get("xh").toString()%></td>
					<td align="center" width="80px"><%=list.get(i).get("sj").toString()%></td>
					<td align="center" width="500px"><%=list.get(i).get("sjbl").toString()%></td>
					<td align="center" width="80px"><%=list.get(i).get("bmjbr").toString()%></td>
					<td align="center" width="200px"><%=list.get(i).get("bz").toString()%></td>
					<td align="center" width="200px"><button onclick="smb(<%=list.get(i).get("bs").toString()%>)">修改</button>
					<button onclick="del(<%=list.get(i).get("bs").toString()%>)">删除</button></td>
				</tr>
				<%
					}
					}
				%>
				<tr>
					<td align="center">
						<input id='xh' type="text" />
					</td>
					<td align="center">
						<input id='sj' type="text" onfocus="WdatePicker()" />
					</td>
					<td align="center">
						<textarea id='sjbl' rows="4" cols="10"
							style="width: 370px; overflow:auto"></textarea>
					</td>
					<td align="center">
						<input id='bmjbr' type="text" />
					</td>
					<td align="center">
						<textarea id='bz' rows="4" cols="20"
							style="width: 200px; overflow: auto"></textarea>
					</td>
					<td align="center">
						<button onclick="save()">保存</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
