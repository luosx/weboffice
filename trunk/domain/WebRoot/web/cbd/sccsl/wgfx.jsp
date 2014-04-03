<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.web.cbd.qyjc.WgfxManager"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Map<String, Object>> list = null;
	Map<String,Object> map = null;
	list = WgfxManager.getInstcne().getList();
	if(list.size()>0){
		map = list.get(0);
	}
	List<Map<String, Object>> pgjklist = null;
	Map<String,Object> pgjkmap = null;
	pgjklist = WgfxManager.getInstcne().getPgjkList();
	if(pgjklist.size()>0){
		pgjkmap = pgjklist.get(0);
	}
	List<Map<String, Object>> hbbclist = null;
	Map<String,Object> hbbcmap = null;
	hbbclist = WgfxManager.getInstcne().getHbbcList();
	if(hbbclist.size()>0){
		hbbcmap = hbbclist.get(0);
	}
	List<Map<String, Object>> bcbzlist = null;
	Map<String,Object> bcbzmap = null;
	bcbzlist = WgfxManager.getInstcne().getBcbzList();
	if(bcbzlist.size()>0){
		bcbzmap = bcbzlist.get(0);
	}
	List<Map<String, Object>> kgmazflist = null;
	Map<String,Object> kgmazfmap = null;
	kgmazflist = WgfxManager.getInstcne().getKgmazfList();
	if(kgmazflist.size()>0){
		kgmazfmap = kgmazflist.get(0);
	}
	List<Map<String, Object>> k1list = null;
	Map<String,Object> k1map = null;
	k1list = WgfxManager.getInstcne().getK1List();
	if(k1list.size()>0){
		k1map = k1list.get(0);
	}
	List<Map<String, Object>> gfklist = null;
	Map<String,Object> gfkmap = null;
	gfklist = WgfxManager.getInstcne().getGfkList();
	if(gfklist.size()>0){
		gfkmap = gfklist.get(0);
	}
	List<Map<String, Object>> zsjylist = null;
	Map<String,Object> zsjymap = null;
	zsjylist = WgfxManager.getInstcne().getZsjyList();
	if(zsjylist.size()>0){
		zsjymap = zsjylist.get(0);
	}
	List<Map<String, Object>> bclist = null;
	Map<String,Object> bcmap = null;
	bclist = WgfxManager.getInstcne().getBcList();
	if(bclist.size()>0){
		bcmap = bclist.get(0);
	}
	List<Map<String, Object>> szlist = null;
	Map<String,Object> szmap = null;
	szlist = WgfxManager.getInstcne().getSzList();
	if(szlist.size()>0){
		szmap = szlist.get(0);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>微观效果分析</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script type="text/javascript" src="base/form/reportExcel.js"></script>
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
	width: 70px;
}
.tr01 {
	background-color: #C0C0C0;
	text-align: center;
}
</style>
<script type="text/javascript">
function save(){
	var bcdj = document.getElementById("bcdj").value;
	var jlgfzb = document.getElementById("jlgfzb").value;
	var djxs = document.getElementById("djxs").value;
	var azfsj = document.getElementById("azfsj").value;
	var asfshij = document.getElementById("asfshij").value;
	var zsbzf = document.getElementById("zsbzf").value;
	var ybbzf = document.getElementById("ybbzf").value;
	var jlbzf = document.getElementById("jlbzf").value;
	var tsrqbzf = document.getElementById("tsrqbzf").value;
	var gfbt = document.getElementById("gfbt").value;
	putClientCommond("wgfxmanager", "save");
	putRestParameter("bcdj", bcdj);
	putRestParameter("jlgfzb", jlgfzb);
	putRestParameter("djxs", djxs);
	putRestParameter("azfsj", azfsj);
	putRestParameter("asfshij", asfshij);
	putRestParameter("zsbzf", zsbzf);
	putRestParameter("ybbzf", ybbzf);
	putRestParameter("jlbzf", jlbzf);
	putRestParameter("tsrqbzf", tsrqbzf);
	putRestParameter("gfbt", gfbt);
	var result = restRequest();
		if(result){
			alert("保存成功");
		}else {
			alert("保存失败");
		}
	
}
</script>
	</head>
	<body>
	<div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="print();"  />&nbsp;&nbsp;&nbsp;
		<img src="web/cbd/framework/images/save.png" width="20px" height="20px" title="保存常量" onClick="save();"  />&nbsp;&nbsp;&nbsp;
	</div>
	<div align="center">
	<h1>住宅搬迁安置补偿政策设计</h1>
	</div>
	<table align="center" id="zcsj">
		<tr class="tr01">
			<td align="center">类别</td>
			<td colspan="2" align="center">补偿单价</td>
			<td colspan="2" align="center">奖励购房指标</td>
			<td colspan="2" align="center">对接系数(K)</td>
			<td colspan="2" align="center">安置房售价</td>
			<td colspan="2" align="center">安置房市价</td>
		</tr>
		<tr>
			<td>补偿类别</td>
			<td><input id="bcdj" value="<%=map.get("bcdj") %>"></td>
			<td>元/平方米</td>
			<td><input id="jlgfzb" value="<%=map.get("jlgfzb") %>"></input></td>
			<td>平方米/户</td>
			<td><input id="djxs" value="<%=map.get("djxs") %>"></input></td>
			<td>--</td>
			<td><input id="azfsj" value="<%=map.get("azfsj") %>"></input></td>
			<td>元/平方米</td>
			<td><input id="asfshij" value="<%=map.get("asfshij") %>"></input></td>
			<td>元/平方米</td>
		</tr>
		<tr class="tr01">
			<td align="center">类别</td>
			<td colspan="2" align="center">征收补助费</td>
			<td colspan="2" align="center">一般补助费</td>
			<td colspan="2" align="center">激励补助费</td>
			<td colspan="2" align="center">特殊人群补助费</td>
			<td colspan="2" align="center">购房补贴</td>
		</tr>
		<tr>
			<td>补偿类别</td>
			<td><input id="zsbzf" value="<%=map.get("zsbzf") %>"></input></td>
			<td>万元/户</td>
			<td><input id="ybbzf" value="<%=map.get("ybbzf") %>"></input></td>
			<td>万元/户</td>
			<td><input id="jlbzf" value="<%=map.get("jlbzf") %>"></input></td>
			<td>万元/户</td>
			<td><input id="tsrqbzf" value="<%=map.get("tsrqbzf") %>"></input></td>
			<td>万元/户</td>
			<td><input id="gfbt" value="<%=map.get("gfbt") %>"></input></td>
			<td>万元/户</td>
		</tr>
	</table>
	<div align="center"><h2>住宅搬迁安置补偿微观实施效果</h2></div>
	<table align="center" id="ssxg">
		<tr class="tr01">
			<td rowspan="3">序号</td>
			<td rowspan="3">类别</td>
			<td rowspan="3">科目</td>
			<td colspan="4">房屋建筑面积（平方米）</td>
			<td>平均</td>
		</tr>
		<tr class="tr01">
			<td>20</td>
			<td>40</td>
			<td>60</td>
			<td>80</td>
			<td>50</td>
		</tr>
		<tr align="center">
			<td>20%</td>
			<td>20%</td>
			<td>50%</td>
			<td>10%</td>
			<td>100%</td>
		</tr>
		<tr align="center">
			<td>1</td>
			<td rowspan="9">实施效果</td>
			<td>评估价款</td>
			<td><%=pgjkmap.get("pgjkone") %>万元</td>
			<td><%=pgjkmap.get("pgjktwo") %>万元</td>
			<td><%=pgjkmap.get("pgjkthree") %>万元</td>
			<td><%=pgjkmap.get("pgjkfour") %>万元</td>
			<td><%=pgjkmap.get("pgjkfive") %>万元</td>
		</tr>
		<tr align="center">
			<td rowspan="2">2</td>
			<td rowspan="2">征收补偿补助款（货币补偿）</td>
			<td bgcolor="#FFDC35"><%=hbbcmap.get("hbbcone") %>万元</td>
			<td bgcolor="#FFDC35"><%=hbbcmap.get("hbbctwo") %>万元</td>
			<td bgcolor="#FFDC35"><%=hbbcmap.get("hbbcthree") %>万元</td>
			<td bgcolor="#FFDC35"><%=hbbcmap.get("hbbcfour") %>万元</td>
			<td bgcolor="#FFDC35"><%=hbbcmap.get("hbbcfive") %>万元</td>
		</tr>
		<tr align="center">
			<td><%=bcbzmap.get("bcbzone") %>万元/平方米</td>
			<td><%=bcbzmap.get("bcbztwo") %>万元/平方米</td>
			<td><%=bcbzmap.get("bcbzthree") %>万元/平方米</td>
			<td><%=bcbzmap.get("bcbzfour") %>万元/平方米</td>
			<td><%=bcbzmap.get("bcbzfive") %>万元/平方米</td>
		</tr>
		<tr align="center">
			<td>3</td>
			<td>可购买安置房</td>
			<td bgcolor="#80FFFF"><%=kgmazfmap.get("kgmazfone") %>平方米</td>
			<td bgcolor="#80FFFF"><%=kgmazfmap.get("kgmazftwo") %>平方米</td>
			<td bgcolor="#80FFFF"><%=kgmazfmap.get("kgmazfthree") %>平方米</td>
			<td bgcolor="#80FFFF"><%=kgmazfmap.get("kgmazffour") %>平方米</td>
			<td bgcolor="#80FFFF"><%=kgmazfmap.get("kgmazffive") %>平方米</td>
		</tr>
		<tr align="center">
			<td>4</td>
			<td>实际对接系数(k1)</td>
			<td><%=k1map.get("k1one") %>——</td>
			<td><%=k1map.get("k1two") %>——</td>
			<td><%=k1map.get("k1three") %>——</td>
			<td><%=k1map.get("k1four") %>——</td>
			<td><%=k1map.get("k1five") %>——</td>
		</tr>
		<tr align="center">
			<td>5</td>
			<td>安置房购房款</td>
			<td><%=gfkmap.get("gfkone") %>万元</td>
			<td><%=gfkmap.get("gfktwo") %>万元</td>
			<td><%=gfkmap.get("gfkthree") %>万元</td>
			<td><%=gfkmap.get("gfkfour") %>万元</td>
			<td><%=gfkmap.get("gfkfive") %>万元</td>
		</tr>
		<tr align="center">
			<td>6</td>
			<td>征收结余款</td>
			<td bgcolor="#FFCBB3"><%=zsjymap.get("zsjyone") %>万元</td>
			<td bgcolor="#FFCBB3"><%=zsjymap.get("zsjytwo") %>万元</td>
			<td bgcolor="#FFCBB3"><%=zsjymap.get("zsjythree") %>万元</td>
			<td bgcolor="#FFCBB3"><%=zsjymap.get("zsjyfour") %>万元</td>
			<td bgcolor="#FFCBB3"><%=zsjymap.get("zsjyfive") %>万元</td>
		</tr>
		<tr align="center">
			<td rowspan="2">7</td>
			<td rowspan="2">安置补偿市值</td>
			<td><%=bcmap.get("bcone") %>万元</td>
			<td><%=bcmap.get("bctwo") %>万元</td>
			<td><%=bcmap.get("bcthree") %>万元</td>
			<td><%=bcmap.get("bcfour") %>万元</td>
			<td><%=bcmap.get("bcfive") %>万元</td>
		</tr>
		<tr align="center">
			<td><%=szmap.get("bcone") %>万元/平方米</td>
			<td><%=szmap.get("bctwo") %>万元/平方米</td>
			<td><%=szmap.get("bcthree") %>万元/平方米</td>
			<td><%=szmap.get("bcfour") %>万元/平方米</td>
			<td><%=szmap.get("bcfive") %>万元/平方米</td>
		</tr>
	</table>
	</body>
</html>
