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
	text-align: center;
	border: 0;
}

textarea {
	border: none;
}


.tr01 {
	background-color: #969696;
	font-weight: bold;
	font-size: 15px;
	text-align: center;
	line-height: 30px;
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
	line-height: 25px;
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
	line-height: 25px;
}

.tr17 {
	background-color: #CCFFFF;
	text-align: center;
	line-height: 25px;
}

.table1 {
	width: 33%;
	float: left;
	position: relative;
	left: 5px;
	top: 5px;
	font-size: 15px;
	
}

.table2 {
	width: 30%;
	float: left;
	margin-left: 30px;
	position: relative;
	left: 0px;
	top: 5px;
	font-size: 15px;
}

.table3 {
	width: 30%;
	float: left;
	margin-left: 5px;
	position: relative;
	left: 0px;
	top: 5px;
	font-size: 15px;
}
.text{
	border-color:#6933F2;
	line-height: 15px;
   		width:80px;height:25px;border-width: 1px;text-align: center;
   }
</style>
<script type="text/javascript">
function print(){	  
			    var excel = new ReportExcel();
			    excel.Init();
			    excel.setCells(50);
			    excel.setRows(20);
			    excel.buildTable("zcsj", "2", "1");
                excel.buildTable("ssxg", "7", "1");
			    var sheet = excel.getSheet();
			    excel.setSheet(sheet);
			    excel.showTable();			    
		    }
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

Ext.onReady(function(){
          init();
    });

function textChange(){
	init();
}

function init(){
	var pgjkone = document.getElementById("bcdj").value*20/10000;
	var pgjktwo = document.getElementById("bcdj").value*40/10000;
	var pgjkthree = document.getElementById("bcdj").value*60/10000;
	var pgjkfour = document.getElementById("bcdj").value*80/10000;
	var pgjkfive = document.getElementById("bcdj").value*50/10000;
	var ybbzf = document.getElementById("ybbzf").value*1;
	var jlbzf = document.getElementById("jlbzf").value*1;
	var tsrqbzf = document.getElementById("tsrqbzf").value*1;
	var gfbt = document.getElementById("gfbt").value*1;
	var jlgfzb = document.getElementById("jlgfzb").value*1;
	var djxs = document.getElementById("djxs").value*1;
	var azfsj = document.getElementById("azfsj").value*1;
	var asfshij = document.getElementById("asfshij").value*1;
	set(pgjkone,pgjktwo,pgjkthree,pgjkfour,pgjkfive,ybbzf,jlbzf,tsrqbzf,gfbt,jlgfzb,djxs,azfsj,asfshij);
}

function set(pgjkone,pgjktwo,pgjkthree,pgjkfour,pgjkfive,ybbzf,jlbzf,tsrqbzf,gfbt,jlgfzb,djxs,azfsj,asfshij){
	document.getElementById("pgjkone").innerHTML = pgjkone+'万元';
	document.getElementById("pgjktwo").innerHTML = pgjktwo+'万元';
	document.getElementById("pgjkthree").innerHTML = pgjkthree+'万元';
	document.getElementById("pgjkfour").innerHTML = pgjkfour+'万元';
	document.getElementById("pgjkfive").innerHTML = pgjkfive+'万元';
	var zsbzf = ybbzf+jlbzf+tsrqbzf+gfbt;
	document.getElementById("zsbzf").innerHTML = zsbzf;
	var hbbcone = pgjkone+zsbzf;
	document.getElementById("hbbcone").innerHTML =  hbbcone+'万元';
	var hbbctwo = pgjktwo+zsbzf;
	document.getElementById("hbbctwo").innerHTML =  hbbctwo+'万元';
	var hbbcthree = pgjkthree+zsbzf;
	document.getElementById("hbbcthree").innerHTML =  hbbcthree+'万元';
	var hbbcfour = pgjkfour+zsbzf;
	document.getElementById("hbbcfour").innerHTML =  hbbcfour+'万元';
	var hbbcfive = pgjkfive+zsbzf;
	document.getElementById("hbbcfive").innerHTML =  hbbcfive+'万元';
	var bcbzone = (hbbcone/20).toFixed(1);
	document.getElementById("bcbzone").innerHTML =  bcbzone+'万元/平方米';
	var bcbztwo = (hbbctwo/40).toFixed(1);
	document.getElementById("bcbztwo").innerHTML =  bcbztwo+'万元/平方米';
	var bcbzthree = (hbbcthree/60).toFixed(1);
	document.getElementById("bcbzthree").innerHTML =  bcbzthree+'万元/平方米';
	var bcbzfour = (hbbcfour/80).toFixed(1);
	document.getElementById("bcbzfour").innerHTML =  bcbzfour+'万元/平方米';
	var bcbzfive = (hbbcfive/50).toFixed(1);
	document.getElementById("bcbzfive").innerHTML =  bcbzfive+'万元/平方米';
	var kgmazfone = djxs*20+jlgfzb;
	document.getElementById("kgmazfone").innerHTML =  kgmazfone+'平方米';
	var kgmazftwo = djxs*40+jlgfzb;
	document.getElementById("kgmazftwo").innerHTML =  kgmazftwo+'平方米';
	var kgmazfthree = djxs*60+jlgfzb;
	document.getElementById("kgmazfthree").innerHTML =  kgmazfthree+'平方米';
	var kgmazffour = djxs*80+jlgfzb;
	document.getElementById("kgmazffour").innerHTML =  kgmazffour+'平方米';
	var kgmazffive = djxs*50+jlgfzb;
	document.getElementById("kgmazffive").innerHTML =  kgmazffive+'平方米';
	var k1one = (kgmazfone/20).toFixed(2);
	document.getElementById("k1one").innerHTML =  k1one+'- -';
	var k1two = (kgmazftwo/40).toFixed(2);
	document.getElementById("k1two").innerHTML =  k1two+'- -';
	var k1three = (kgmazfthree/60).toFixed(2);
	document.getElementById("k1three").innerHTML =  k1three+'- -';
	var k1four = (kgmazffour/80).toFixed(2);
	document.getElementById("k1four").innerHTML =  k1four+'- -';
	var k1five = (kgmazffive/50).toFixed(2);
	document.getElementById("k1five").innerHTML =  k1five+'- -';
	var gfkone = kgmazfone*azfsj/10000;
	document.getElementById("gfkone").innerHTML =  gfkone+'万元';
	var gfktwo = kgmazftwo*azfsj/10000;
	document.getElementById("gfktwo").innerHTML =  gfktwo+'万元';
	var gfkthree = kgmazfthree*azfsj/10000;
	document.getElementById("gfkthree").innerHTML =  gfkthree+'万元';
	var gfkfour = kgmazffour*azfsj/10000;
	document.getElementById("gfkfour").innerHTML =  gfkfour+'万元';
	var gfkfive = kgmazffive*azfsj/10000;
	document.getElementById("gfkfive").innerHTML =  gfkfive+'万元';
	var zsjyone = hbbcone-gfkone;
	document.getElementById("zsjyone").innerHTML =  zsjyone+'万元';
	var zsjytwo = hbbctwo-gfktwo;
	document.getElementById("zsjytwo").innerHTML =  zsjytwo+'万元';
	var zsjythree = hbbcthree-gfkthree;
	document.getElementById("zsjythree").innerHTML =  zsjythree+'万元';
	var zsjyfour = hbbcfour-gfkfour;
	document.getElementById("zsjyfour").innerHTML =  zsjyfour+'万元';
	var zsjyfive = hbbcfive-gfkfive;
	document.getElementById("zsjyfive").innerHTML =  zsjyfive+'万元';
	var bcone = kgmazfone*asfshij/10000+zsjyone;
	document.getElementById("bcone").innerHTML =  bcone+'万元';
	var bctwo = kgmazftwo*asfshij/10000+zsjytwo;
	document.getElementById("bctwo").innerHTML =  bctwo+'万元';
	var bcthree = kgmazfthree*asfshij/10000+zsjythree;
	document.getElementById("bcthree").innerHTML =  bcthree+'万元';
	var bcfour = kgmazffour*asfshij/10000+zsjyfour;
	document.getElementById("bcfour").innerHTML =  bcfour+'万元';
	var bcfive = kgmazffive*asfshij/10000+zsjyfive;
	document.getElementById("bcfive").innerHTML =  bcfive+'万元';
	var bcsone = (bcone/20).toFixed(1);
	document.getElementById("bcsone").innerHTML =  bcsone+'万元/平方米';
	var bcstwo = (bctwo/40).toFixed(1);
	document.getElementById("bcstwo").innerHTML =  bcstwo+'万元/平方米';
	var bcsthree = (bcthree/60).toFixed(1);
	document.getElementById("bcsthree").innerHTML =  bcsthree+'万元/平方米';
	var bcsfour = (bcfour/80).toFixed(1);
	document.getElementById("bcsfour").innerHTML =  bcsfour+'万元/平方米';
	var bcsfive = (bcfive/50).toFixed(1);
	document.getElementById("bcsfive").innerHTML =  bcsfive+'万元/平方米';
}
</script>
	</head>
	<body>
	<div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="print();"  />&nbsp;&nbsp;&nbsp;
		<img src="web/cbd/framework/images/save.png" width="20px" height="20px" title="保存常量" onClick="save();"  />&nbsp;&nbsp;&nbsp;
	</div>
	<div align="center"  style="font-size: 25px;">
	<h1>住宅搬迁安置补偿政策设计</h1>
	</div>
	<br>
	<table align="center" id="zcsj"  cellpadding="0" cellspacing="0" width="90%"> 
		<tr class="tr01">
			<td align="center">类别</td>
			<td colspan="2" align="center">补偿单价</td>
			<td colspan="2" align="center">奖励购房指标</td>
			<td colspan="2" align="center">对接系数(K)</td>
			<td colspan="2" align="center">安置房售价</td>
			<td colspan="2" align="center">安置房市价</td>
		</tr>
		<tr class="tr06">
			<td>补偿类别</td>
			<td><input id="bcdj" value="<%=map.get("bcdj") %>" onkeyup="textChange();"></td>
			<td>元/平方米</td>
			<td><input id="jlgfzb" value="<%=map.get("jlgfzb") %>" onkeyup="textChange();"></input></td>
			<td>平方米/户</td>
			<td><input id="djxs" value="<%=map.get("djxs") %>" onkeyup="textChange();"></input></td>
			<td>--</td>
			<td><input id="azfsj" value="<%=map.get("azfsj") %>" onkeyup="textChange();"></input></td>
			<td>元/平方米</td>
			<td><input id="asfshij" value="<%=map.get("asfshij") %>" onkeyup="textChange();"></input></td>
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
		<tr class="tr06">
			<td>补偿类别</td>
			<td id="zsbzf"></td>
			<td>万元/户</td>
			<td><input id="ybbzf" value="<%=map.get("ybbzf") %>" onkeyup="textChange();"></input></td>
			<td>万元/户</td>
			<td><input id="jlbzf" value="<%=map.get("jlbzf") %>" onkeyup="textChange();"></input></td>
			<td>万元/户</td>
			<td><input id="tsrqbzf" value="<%=map.get("tsrqbzf") %>" onkeyup="textChange();"></input></td>
			<td>万元/户</td>
			<td><input id="gfbt" value="<%=map.get("gfbt") %>" onkeyup="textChange();"></input></td>
			<td>万元/户</td>
		</tr>
	</table>
	<div align="center" style="font-size: 25px;"><h2>住宅搬迁安置补偿微观实施效果</h2></div>
	<table align="center" id="ssxg"  cellpadding="0" cellspacing="0" width="90%">
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
		<tr class="tr01">
			<td>20%</td>
			<td>20%</td>
			<td>50%</td>
			<td>10%</td>
			<td>100%</td>
		</tr>
		<tr class="tr06">
			<td>1</td>
			<td rowspan="9">实<br>施<br>效<br>果</td>
			<td>评估价款</td>
			<td id="pgjkone"></td>
			<td id="pgjktwo"></td>
			<td id="pgjkthree"></td>
			<td id="pgjkfour"></td>
			<td id="pgjkfive"></td>
		</tr>
		<tr class="tr06">
			<td rowspan="2">2</td>
			<td rowspan="2">征收补偿补助款<br>（货币补偿）</td>
			<td bgcolor="#FFDC35" id="hbbcone"></td>
			<td bgcolor="#FFDC35" id="hbbctwo"></td>
			<td bgcolor="#FFDC35" id="hbbcthree"></td>
			<td bgcolor="#FFDC35" id="hbbcfour"></td>
			<td bgcolor="#FFDC35" id="hbbcfive"></td>
		</tr>
		<tr class="tr06">
			<td id="bcbzone"></td>
			<td id="bcbztwo"></td>
			<td id="bcbzthree"></td>
			<td id="bcbzfour"></td>
			<td id="bcbzfive"></td>
		</tr>
		<tr class="tr06">
			<td>3</td>
			<td>可购买安置房</td>
			<td bgcolor="#80FFFF" id="kgmazfone"></td>
			<td bgcolor="#80FFFF" id="kgmazftwo"></td>
			<td bgcolor="#80FFFF" id="kgmazfthree"></td>
			<td bgcolor="#80FFFF" id="kgmazffour"></td>
			<td bgcolor="#80FFFF" id="kgmazffive"></td>
		</tr>
		<tr class="tr06">
			<td>4</td>
			<td>实际对接系数(k1)</td>
			<td id="k1one"></td>
			<td id="k1two"></td>
			<td id="k1three"></td>
			<td id="k1four"></td>
			<td id="k1five"></td>
		</tr>
		<tr class="tr06">
			<td>5</td>
			<td>安置房购房款</td>
			<td id="gfkone"></td>
			<td id="gfktwo"></td>
			<td id="gfkthree"></td>
			<td id="gfkfour"></td>
			<td id="gfkfive"></td>
		</tr>
		<tr class="tr06">
			<td>6</td>
			<td>征收结余款</td>
			<td bgcolor="#FFCBB3" id="zsjyone"></td>
			<td bgcolor="#FFCBB3" id="zsjytwo"></td>
			<td bgcolor="#FFCBB3" id="zsjythree"></td>
			<td bgcolor="#FFCBB3" id="zsjyfour"></td>
			<td bgcolor="#FFCBB3" id="zsjyfive"></td>
		</tr>
		<tr class="tr06">
			<td rowspan="2">7</td>
			<td rowspan="2">安置补偿市值</td>
			<td id="bcone"></td>
			<td id="bctwo"></td>
			<td id="bcthree"></td>
			<td id="bcfour"></td>
			<td id="bcfive"></td>
		</tr>
		<tr class="tr06">
			<td id="bcsone"></td>
			<td id="bcstwo"></td>
			<td id="bcsthree"></td>
			<td id="bcsfour"></td>
			<td id="bcsfive"></td>
		</tr>
	</table>
	</body>
</html>
