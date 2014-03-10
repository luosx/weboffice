<%@page import="com.klspta.web.cbd.dtjc.kfgl.XmgljgManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.accessory.dzfj.*"%>
<%@page import="com.klspta.base.util.bean.ftputil.*"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String xmmc = request.getParameter("xmmc");
	String reportID = "XMKGZBBCX";
	String keyIndex = "1";
	String name = ProjectInfo.getInstance().PROJECT_NAME;
	String name1 = ProjectInfo.getInstance().getProjectLoginName1();
	String yw_guid = request.getParameter("yw_guid");
	if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	}
	List<Map<String,Object>> listpath = AccessoryOperation.getInstance().getList(yw_guid);
	String firstpath = "";
	String secondpath = "";
	String threepath = "";	
	if(listpath!=null){
		for(int i=0;i<listpath.size();i++){
			firstpath = listpath.get(0).toString();
			secondpath = listpath.get(1).toString();
			threepath = listpath.get(2).toString();
		}
	}
	List<Map<String,Object>> list = new XmgljgManager().getList();
	Map<String,Object> map = null;
	if(list!=null){
		map = list.get(0);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>一览表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<%@ include file="/base/include/ext.jspf"%>
<%@ include file="/base/include/restRequest.jspf"%>
<script src="DatePicker.js"></script>
<style>
.ab {
	border: 0 solid 1px;
	border-top: none;
	border-left: none;
	border-right: none;
	width: 100px;
	text-align:center;
}


.div1 {
	float: left;
	position: relative;
	left: 5px;
}

.div2 {
	float: left;
	margin-left: 10px;
	position: relative;
	left: 0px;
}

.div3 {
	float: left;
	margin-left: 5px;
	position: relative;
	left: 0px;
}

.div4 {
	float: left;
	margin-left: 5px;
	position: relative;
	left: 0px;
}
</style>
<script>
	function add() {
		var xmmc = escape(escape(document.getElementById("xmmc").value));
		var kfzt = escape(escape(document.getElementById("kfzt").value));
		var dz = escape(escape(document.getElementById("dz").value));
		var nz = escape(escape(document.getElementById("nz").value));
		var xz = escape(escape(document.getElementById("xz").value));
		var bz = escape(escape(document.getElementById("bz").value));
		var nameone = escape(escape(document.getElementById("nameone").value));
		var nametwo = escape(escape(document.getElementById("nametwo").value));
		var namethree = escape(escape(document.getElementById("namethree").value));
		var zdmj = document.getElementById("zdmj").value;
		var jsyd = document.getElementById("jsyd").value;
		var jzgm = document.getElementById("jzgm").value;
		var rjl = document.getElementById("rjl").value;
		var zzcq = document.getElementById("zzcq").value;
		var cqmj = document.getElementById("cqmj").value;
		var fzzcq = document.getElementById("fzzcq").value;
		var fcqmj = document.getElementById("fcqmj").value;
		var xgjz = escape(escape(document.getElementById("xgjz").value));
		putClientCommond("XmgljgManager", "insert");
		putRestParameter("xmmc", xmmc);
		putRestParameter("kfzt", kfzt);
		putRestParameter("dz", dz);
		putRestParameter("nz", nz);
		putRestParameter("xz", xz);
		putRestParameter("bz", bz);
		putRestParameter("zdmj", zdmj);
		putRestParameter("jsyd", jsyd);
		putRestParameter("jzgm", jzgm);
		putRestParameter("rjl", rjl);
		putRestParameter("zzcq", zzcq);
		putRestParameter("cqmj", cqmj);
		putRestParameter("fzzcq", fzzcq);
		putRestParameter("fcqmj", fcqmj);
		putRestParameter("xgjz", xgjz);
		putRestParameter("nameone", nameone);
		putRestParameter("nametwo", nametwo);
		putRestParameter("namethree", namethree);
		var reslut = restRequest();
			if (reslut == 'success') {
				alert('保存成功！');
				window.location.reload();
			}

	}
</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">

	<div align="center">

		<div>
			<h1><%=name1%></h1>
			<hr>
		</div>
			<div style="margin-left:auto;margin-right:auto;width:1000px;height:300px;" >
				<div class="div1">
					<div align="center">
						<input id="nameone" style='border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px' value="<%=map.get("nameone") %>">
					</div>
					<div>
						<img
							src='<%=basePath%>//model//accessory//dzfj//download//<%=firstpath%>'
							onerror="this.src='<%=basePath%>/web/cbd/framework/images/defult.jpg'"
							height='275px' width='475px'  style="border:5 solid #D0D0D0">
					</div>
				</div>
				<div class="div2" align="center">
					<div align="center">
						<input id="nametwo" style='border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px' value="<%=map.get("nametwo") %>">
					</div>
					<div>
						<img
							src='<%=basePath%>//model//accessory//dzfj//download//<%=secondpath%>'
							onerror="this.src='<%=basePath%>/web/cbd/framework/images/defult.jpg'"
							height='275px' width='475px'  style="border:5 solid #D0D0D0">
					</div>
				</div>
			</div>
		<div style="margin-left:auto;margin-right:auto;width:1000px;height:300px;" >
		<div class="div3" align="center">
			<div>
				<input id="namethree" style='border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px' value="<%=map.get("namethree") %>">
			</div>
			<div>
				<img
					src='<%=basePath%>//model//accessory//dzfj//download//<%=threepath%>'
					onerror="this.src='<%=basePath%>/web/cbd/framework/images/defult.jpg'"
					height='275px' width='475px'  style="border:5 solid #D0D0D0">
			</div>
		</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div class="div4">

			<table>

				<tr>
					<td>项目名称： <input type="text" id="xmmc" class="ab" value="<%=map.get("xmmc") %>"> 项目
					</td>
				</tr>
				<tr>
					<td>开发主体： <input type="text" id="kfzt" class="ab" value="<%=map.get("kfzt") %>"></td>
				</tr>
				<tr>
					<td>项目区位：东至 <input type="text" id="dz" class="ab" value="<%=map.get("dz") %>"> ;南至
						<input type="text" id="nz" class="ab" value="<%=map.get("nz") %>"> ;</td>
				</tr>
				<tr>
					<td>西至 <input type="text" id="xz" class="ab" value="<%=map.get("xz") %>"> ;北至 <input
						type="text" id="bz" class="ab" value="<%=map.get("bz") %>"> .</td>
				</tr>
				<tr>
					<td>规划情况：占地面积 <input type="text" id="zdmj" class="ab" value="<%=map.get("zdmj") %>">
						公顷; 建设用地 <input type="text" id="jsyd" class="ab" value="<%=map.get("jsyd") %>"> 公顷;</td>
				</tr>
				<tr>
					<td>建筑规模 <input type="text" id="jzgm" class="ab" value="<%=map.get("jzgm") %>"> 万㎡;
						容积率 <input type="text" id="rjl" class="ab" value="<%=map.get("rjl") %>"> .</td>
				</tr>
				<tr>
					<td>现状情况：住宅拆迁 <input type="text" id="zzcq" class="ab" value="<%=map.get("zzcq") %>">
						户, <input type="text" id="cqmj" class="ab" value="<%=map.get("cqmj") %>"> 万㎡;</td>
				</tr>
				<tr>
					<td>非住宅拆迁 <input type="text" id="fzzcq" class="ab" value="<%=map.get("fzzcq") %>"> 家,
						<input type="text" id="fcqmj" class="ab" value="<%=map.get("fcqmj") %>"> 万㎡;</td>
				</tr>
				<tr>
					<td>相关进展： <input type="text" id="xgjz" value="<%=map.get("xgjz") %>"
						style='border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px'>
					</td>
				</tr>
				<tr>
					<td><button onClick='add()'>保存</button>
					</td>
				</tr>
			</table>
		</div>
		</div>
	</div>
</body>
</html>