<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.web.cbd.qyjc.QyjcManager"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Map<String, Object>> list = null;
	Map<String,Object> map = null;
	QyjcManager qyjc = new QyjcManager();
	list = qyjc.getGZZCYJ();
	if(list.size()>0){
		map = list.get(0);
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
			    excel.setRows(42);
			    excel.buildTable("bqcl", "3", "1");
                excel.buildTable("zjcbl", "3", "5");
			    excel.buildTable("mybc", "3", "9");
                excel.buildTable("zgzc", "13", "1");
                excel.buildTable("dhtz", "9", "5");
                excel.buildTable("szbc", "9", "9");
                excel.buildTable("zztzsp", "15", "5");
                
                excel.buildTable("fzzbqcl", "21", "1");
                excel.buildTable("fzgzc", "26", "1");
                excel.buildTable("fzztzsp", "21", "5");
                
                excel.buildTable("ztghsj", "30", "1");
                excel.buildTable("zyjkfcbqk", "30", "5");
                excel.buildTable("ztcrqk", "30", "9");
                excel.buildTable("yjcjqk", "37", "1");
                
			    var sheet = excel.getSheet();
			    excel.setSheet(sheet);
			    excel.showTable();			    
		    }
       </script>
<script type="text/javascript">
	function sava(){
		var bqhs = document.getElementById("bqhs").value;
    	var bbqfwhjmj = document.getElementById("bbqfwhjmj").value;
    	var bqgm = document.getElementById("bqgm").value;
    	var kxccrgm = document.getElementById("kxccrgm").value;
    	var zhbzf = document.getElementById("zhbzf").value;
    	var azfscdj = document.getElementById("azfscdj").value;
    	var azfzhjadj = document.getElementById("azfzhjadj").value;
    	var azfgddj = document.getElementById("azfgddj").value;
    	var bqpgdj = document.getElementById("bqpgdj").value;
    	var azfsj = document.getElementById("azfsj").value;
    	var azfdjxs = document.getElementById("azfdjxs").value;
    	var fzzbqgm = document.getElementById("fzzbqgm").value;
    	var fkxccrgm = document.getElementById("fkxccrgm").value;
    	var fzzfwbqdj = document.getElementById("fzzfwbqdj").value;
    	var zzd = document.getElementById("zzd").value;
    	var jsydtjxs = document.getElementById("jsydtjxs").value;
    	var zkcrjsyd = document.getElementById("zkcrjsyd").value;
    	var rjl = document.getElementById("rjl").value;
    	var zkcrjzgm = document.getElementById("zkcrjzgm").value;
    	var mdj = document.getElementById("mdj").value;
    	var yjcjj = document.getElementById("yjcjj").value;
    	putClientCommond("qyjcManager", "updateGZZYJ");
    	putRestParameter("bqhs", bqhs);
    	putRestParameter("bbqfwhjmj", bbqfwhjmj);
    	putRestParameter("bqgm", bqgm);
    	putRestParameter("kxccrgm", kxccrgm);
    	putRestParameter("zhbzf", zhbzf);
    	putRestParameter("azfscdj", azfscdj);
    	putRestParameter("azfzhjadj", azfzhjadj);
    	putRestParameter("azfgddj", azfgddj);
    	putRestParameter("bqpgdj", bqpgdj);
    	putRestParameter("azfsj", azfsj);
    	putRestParameter("azfdjxs", azfdjxs);
    	putRestParameter("fzzbqgm", fzzbqgm);
    	putRestParameter("fkxccrgm", fkxccrgm);
    	putRestParameter("fzzfwbqdj", fzzfwbqdj);
    	putRestParameter("zzd", zzd);
    	putRestParameter("jsydtjxs", jsydtjxs);
    	putRestParameter("zkcrjsyd", zkcrjsyd);
    	putRestParameter("rjl", rjl);
    	putRestParameter("zkcrjzgm", zkcrjzgm);
    	putRestParameter("mdj", mdj);
    	putRestParameter("yjcjj", yjcjj);
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
    	initZZ();
    	initFZZ();
    	initZL();
    }
    
    
    function initZZ(){
    	var bqhs = document.getElementById("bqhs").value*1;
    	var bbqfwhjmj = document.getElementById("bbqfwhjmj").value*1;
    	var bqgm = document.getElementById("bqgm").value*1;
    	var kxccrgm = document.getElementById("kxccrgm").value*1;
    	var zhbzf = document.getElementById("zhbzf").value*1;
    	var azfscdj = document.getElementById("azfscdj").value*1;
    	var azfzhjadj = document.getElementById("azfzhjadj").value*1;
    	var azfgddj = document.getElementById("azfgddj").value*1;
    	var bqpgdj = document.getElementById("bqpgdj").value*1;
    	var azfsj = document.getElementById("azfsj").value*1;
    	var azfdjxs = document.getElementById("azfdjxs").value*1;
    	setZZ(bqhs,bbqfwhjmj,bqgm,kxccrgm,zhbzf,azfscdj,azfzhjadj,azfgddj,bqpgdj,azfsj,azfdjxs);
    }
    
    var bqtz;
    function setZZ(bqhs,bbqfwhjmj,bqgm,kxccrgm,zhbzf,azfscdj,azfzhjadj,azfgddj,bqpgdj,azfsj,azfdjxs){
    	var chbbck = bbqfwhjmj*bqpgdj+zhbzf;
    	document.getElementById("chbbck").innerHTML = chbbck;
    	
    	var azfjzcb = azfgddj + azfzhjadj;
    	document.getElementById("azfjzcb").innerHTML = azfjzcb;
    	var ab ;
    	if(azfsj<=azfjzcb){
    		ab = azfjzcb - azfsj;
    	}else {
    		ab = 0;
    	}
    	document.getElementById("ab").innerHTML = ab;
    	var bj = (bqpgdj/azfsj).toFixed(2);
    	document.getElementById("bj").innerHTML = bj;
    	var azfdjmj = (bbqfwhjmj*azfdjxs).toFixed(0);
    	document.getElementById("azfdjmj").innerHTML = azfdjmj;
    	document.getElementById("zdrlkj").innerHTML = (azfscdj-azfjzcb)*azfdjmj;
    	var dhazfgfhk;
    	if(azfsj<=azfjzcb){
    		dhazfgfhk = 0;
    	}else {
    		dhazfgfhk = (azfdjmj * (azfsj - azfjzcb)).toFixed(2);
    	}
    	document.getElementById("dhazfgfhk").innerHTML = dhazfgfhk;
    	var dhtzcb ;
    	if(azfsj<=azfjzcb){
    		dhtzcb = chbbck + ab;
    	}else {
    		dhtzcb = chbbck - dhazfgfhk;
    	}
    	document.getElementById("dhtzcb").innerHTML = dhtzcb;
    	var dhazfjzcb = (azfjzcb*azfdjmj).toFixed(0);
    	document.getElementById("dhazfjzcb").innerHTML = dhazfjzcb;
    	document.getElementById("dhtzdj").innerHTML = (dhtzcb/bbqfwhjmj).toFixed(2);
    	bqtz = (dhtzcb / 10000 * bqhs).toFixed(0);
    	document.getElementById("bqtz").innerHTML = bqtz;
    	var azfgfk = (azfsj * azfdjmj).toFixed(0);
    	document.getElementById("azfgfk").innerHTML = azfgfk;
    	var mybcbqjyk = chbbck - azfgfk ;
    	document.getElementById("mybcbqjyk").innerHTML = mybcbqjyk;
    	document.getElementById("zdhbzbj").innerHTML = (mybcbqjyk / 10000 * bqhs).toFixed(0);
    	document.getElementById("zztzspazfjzcb").innerHTML = (dhazfjzcb / 10000 * bqhs).toFixed(0);
    	document.getElementById("zzbqcblmdj").innerHTML = (bqtz/kxccrgm).toFixed(2);
    	document.getElementById("pjmybcdj").innerHTML = (chbbck/bbqfwhjmj).toFixed(2);
    	var dhzscbck = (bbqfwhjmj *(bqpgdj + azfdjxs*(azfscdj-azfsj)) + zhbzf).toFixed(0);
    	document.getElementById("dhzscbck").innerHTML = dhzscbck;
    	document.getElementById("azfscjz").innerHTML = (azfdjmj * azfscdj).toFixed(0);
    	document.getElementById("scbcbqjyk").innerHTML = mybcbqjyk;
    	document.getElementById("pjscbcdj").innerHTML = (dhzscbck / bbqfwhjmj).toFixed(2);
    	var rl ;
    	if(azfsj >= azfzhjadj + azfgddj){
    		rl = ((azfscdj - azfsj) * bbqfwhjmj * azfdjxs).toFixed(0);
    	}else {
    		rl = ((azfscdj - azfzhjadj - azfgddj) * bbqfwhjmj * azfdjxs).toFixed(0);
    	}
    	document.getElementById("rl").innerHTML = rl;
    	document.getElementById("yl").innerHTML = rl*1 + ab;
    }
    
    
    
    function initFZZ(){
    	var fzzbqgm = document.getElementById("fzzbqgm").value*1;
    	var fkxccrgm = document.getElementById("fkxccrgm").value*1;
    	var fzzfwbqdj = document.getElementById("fzzfwbqdj").value*1;
    	setFZZ(fzzbqgm,fkxccrgm,fzzfwbqdj);
    }
    var fzztzcb ;
    function setFZZ(fzzbqgm,fkxccrgm,fzzfwbqdj){
    	fzztzcb = (fzzfwbqdj * fzzbqgm).toFixed(0);
    	document.getElementById("fzztzcb").innerHTML = fzztzcb;
    	document.getElementById("fzzbqcblmdj").innerHTML = (fzztzcb/fkxccrgm).toFixed(2);
    }
    
    function initZL(){
    	var zzd = document.getElementById("zzd").value*1;
    	var jsydtjxs = document.getElementById("jsydtjxs").value*1;
    	var zkcrjsyd = document.getElementById("zkcrjsyd").value*1;
    	var rjl = document.getElementById("rjl").value*1;
    	var zkcrjzgm = document.getElementById("zkcrjzgm").value*1;
    	var mdj = document.getElementById("mdj").value*1;
    	var yjcjj = document.getElementById("yjcjj").value*1;
    	setZL(zzd,jsydtjxs,zkcrjsyd,rjl,zkcrjzgm,mdj,yjcjj);
    }
    
    function setZL(zzd,jsydtjxs,zkcrjsyd,rjl,zkcrjzgm,mdj,yjcjj){
    	var qqfy = (zkcrjzgm *30 / 10000).toFixed(2);
    	document.getElementById("qqfy").innerHTML = qqfy;
    	var szfy = (zkcrjzgm *450 / 10000).toFixed(2);
    	document.getElementById("szfy").innerHTML = szfy;
    	var qqkffy = qqfy*1 + szfy*1 ;
    	document.getElementById("qqkffy").innerHTML = qqkffy;
    	var bqbck = ((bqtz*1 + fzztzcb*1)*1.02).toFixed(2);
    	document.getElementById("bqbck").innerHTML = bqbck;
    	var bkyjf = (bqbck * 0.1).toFixed(2);
    	document.getElementById("bkyjf").innerHTML = bkyjf;
    	var bqsgfy = bqbck*1 + bkyjf*1 ;
    	document.getElementById("bqsgfy").innerHTML = bqsgfy;
    	var cwfy = ((qqfy *1 + szfy*1 + bqbck*1 + bkyjf*1) * 0.067 * 2).toFixed(2);
    	document.getElementById("cwfy").innerHTML = cwfy;
    	var tzhb = ((qqfy*1 + szfy*1 + bqbck*1 + bkyjf*1 + cwfy*1) * 0.08).toFixed(2);
    	document.getElementById("tzhb").innerHTML = tzhb;
    	var jjfy = (cwfy*1 + tzhb*1 ).toFixed(2);
    	document.getElementById("jjfy").innerHTML = jjfy;
    	var yjkfzcb = (qqkffy*1 + bqsgfy*1 + jjfy*1).toFixed(0) ;
    	document.getElementById("yjkfzcb").innerHTML = yjkfzcb;
    	var lmcb = (yjkfzcb / zkcrjzgm).toFixed(2);
    	document.getElementById("lmcb").innerHTML = lmcb;
    	var yjcrdj = (lmcb*1 + mdj*1).toFixed(2);
    	document.getElementById("yjcrdj").innerHTML = yjcrdj;
    	document.getElementById("yjzftdsy").innerHTML = (yjcjj * zkcrjzgm - yjkfzcb).toFixed(0);
    }
</script>
	</head>
	<body>
	<div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="print();"  />&nbsp;&nbsp;&nbsp;
		<img src="web/cbd/framework/images/save.png" width="20px" height="20px" title="保存常量" onClick="sava();"  />&nbsp;&nbsp;&nbsp;
	</div><br/>
	<div align="center">
				<h6>
					微观政策试算
				</h6>
			</div>
		<div align="center" style="width: 100%;height: 70%;border-style:dashed;border-width: 1px;">
			<div>
				<h1>
					住宅搬迁
				</h1>
			</div>
			<div class="table1">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="bqcl">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								搬迁常量
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								搬迁户数
							</td>
							<td width="30%">
								<input type="text" name="bqhs" id="bqhs" class="text" onkeyup="textChange();" value="<%=map.get("bqhs").toString() %>"/>
							</td>
							<td width="20%">
								户
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								被搬迁房屋户均面积
							</td>
							<td width="30%">
								<input type="text" name="bbqfwhjmj" id="bbqfwhjmj" class="text" onkeyup="textChange();" value="<%=map.get("bbqfwhjmj").toString() %>"/>
							</td>
							<td width="20%">
								㎡
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								搬迁规模
							</td>
							<td width="30%">
								<input type="text" name="bqgm" id="bqgm" onkeyup="textChange();" class="text" value="<%=map.get("bqgm").toString() %>"/>
							</td>
							<td width="20%">
								万㎡
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								可形成出让规模
							</td>
							<td width="30%">
								<input type="text" name="kxccrgm" id="kxccrgm" class="text" onkeyup="textChange();" value="<%=map.get("kxccrgm").toString() %>"/>
							</td>
							<td width="20%">
								万㎡
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								综合补助费
							</td>
							<td width="30%">
								<input type="text" name="zhbzf" id="zhbzf" class="text" onkeyup="textChange();" value="<%=map.get("zhbzf").toString() %>"/>
							</td>
							<td width="20%">
								万元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								安置房市场单价
							</td>
							<td width="30%">
								<input type="text" name="azfscdj" id="azfscdj" class="text" onkeyup="textChange();" value="<%=map.get("azfscdj").toString() %>"/>
							</td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								安置房综合建安单价
							</td>
							<td width="30%">
								<input type="text" name="azfzhjadj" id="azfzhjadj" class="text" onkeyup="textChange();" value="<%=map.get("azfzhjadj").toString() %>"/>
							</td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								安置房购地单价
							</td>
							<td width="30%">
								<input type="text" name="azfgddj" id="azfgddj" class="text" onkeyup="textChange();" value="<%=map.get("azfgddj").toString() %>"/>
							</td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
					</table>
				</div>
				<div style="top: 10px">
					<table width="100%" cellpadding="0" cellspacing="0" id="zgzc">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								中观政策
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								搬迁评估单价（x）
							</td>
							<td width="30%"><input type="text" name="bqpgdj" id="bqpgdj" class="text" onkeyup="textChange();" value="<%=map.get("bqpgdj").toString() %>"/></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								安置房售价（y）
							</td>
							<td width="30%"><input type="text" name="azfsj" id="azfsj" class="text" onkeyup="textChange();" value="<%=map.get("azfsj").toString() %>"/></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								安置房对接系数（k）
							</td>
							<td width="30%"><input type="text" name="azfdjxs" id="azfdjxs" class="text" onkeyup="textChange();" value="<%=map.get("azfdjxs").toString() %>"/></td>
							<td width="20%">
								————
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="table2">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="zjcbl">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								中间参变量
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr17">
								安置房建造成本
							</td>
							<td width="30%" id="azfjzcb"></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								比价
							</td>
							<td width="30%" id="bj"></td>
							<td width="20%">
								————
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								安置房对接面积
							</td>
							<td width="30%" id="azfdjmj"></td>
							<td width="20%">
								㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								最大让利空间
							</td>
							<td width="30%" id="zdrlkj"></td>
							<td width="20%">
								万元
							</td>
						</tr>
					</table>
					<div>
						<table width="100%" cellpadding="0" cellspacing="0" id="dhtz">
							<tr class="tr11">
								<td align="center" width="75%" height="35px" colspan="3">
									单户投资
								</td>
							</tr>
							<tr align="center">
								<td width="50%" class="tr17">
									单户投资成本
								</td>
								<td width="30%" id="dhtzcb"></td>
								<td width="20%">
									万元
								</td>
							</tr>
							<tr align="center">
								<td width="45%" class="tr17">
									单户安置房建造成本
								</td>
								<td width="30%" id="dhazfjzcb"></td>
								<td width="20%">
									万元
								</td>
							</tr>
							<tr align="center">
								<td width="45%" class="tr17">
									单户安置房购房回款
								</td>
								<td width="30%" id="dhazfgfhk"></td>
								<td width="20%">
									万元
								</td>
							</tr>
							<tr align="center">
								<td width="45%" class="tr17">
									单户投资单价
								</td>
								<td width="30%" id="dhtzdj"></td>
								<td width="20%">
									万元/㎡
								</td>
							</tr>
						</table>
					</div>
					<div>
						<table width="100%" cellpadding="0" cellspacing="0" id="zztzsp">
							<tr class="tr11">
								<td align="center" width="75%" height="35px" colspan="3">
									住宅投资水平
								</td>
							</tr>
							<tr align="center">
								<td width="50%" class="tr17">
									搬迁投资
								</td>
								<td width="30%" id="bqtz"></td>
								<td width="20%">
									亿元
								</td>
							</tr>
							<tr align="center">
								<td width="50%" class="tr17">
									最低货币准备金
								</td>
								<td width="30%" id="zdhbzbj"></td>
								<td width="20%">
									亿元
								</td>
							</tr>
							<tr align="center">
								<td width="45%" class="tr17">
									安置房建造成本
								</td>
								<td width="30%" id="zztzspazfjzcb"></td>
								<td width="20%">
									亿元
								</td>
							</tr>
							<tr align="center">
								<td width="45%" class="tr17">
									住宅搬迁成本楼面单价
								</td>
								<td width="30%" id="zzbqcblmdj"></td>
								<td width="20%">
									万元/㎡
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="table3">
				<table width="100%" cellpadding="0" cellspacing="0" id="mybc">
					<tr class="tr11">
						<td align="center" width="75%" height="35px" colspan="3">
							名义补偿
						</td>
					</tr>
					<tr align="center">
						<td width="50%" class="tr03">
							纯货币补偿款
						</td>
						<td width="30%" id="chbbck"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							安置房购房款
						</td>
						<td width="30%" id="azfgfk"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							搬迁结余款
						</td>
						<td width="30%" id="mybcbqjyk"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							平均名义补偿单价
						</td>
						<td width="30%" id="pjmybcdj"></td>
						<td width="20%">
							万元
						</td>
					</tr>
				</table>
			</div>

			<div class="table3">
				<table width="100%" cellpadding="0" cellspacing="0" id="szbc">
					<tr class="tr11">
						<td align="center" width="75%" height="35px" colspan="3">
							市场补偿
						</td>
					</tr>
					<tr align="center">
						<td width="50%" class="tr03">
							单户总市场补偿款
						</td>
						<td width="30%" id="dhzscbck"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							安置房市场价值
						</td>
						<td width="30%" id="azfscjz"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							搬迁结余款
						</td>
						<td width="30%" id="scbcbqjyk"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							平均市场补偿单价
						</td>
						<td width="30%" id="pjscbcdj"></td>
						<td width="20%">
							万元/㎡
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							诱利
						</td>
						<td width="30%" id="yl"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							让利
						</td>
						<td width="30%" id="rl"></td>
						<td width="20%">
							万元
						</td>
					</tr>
					<tr align="center">
						<td width="45%" class="tr03">
							暗补
						</td>
						<td width="30%" id="ab"></td>
						<td width="20%">
							万元
						</td>
					</tr>
				</table>
			</div>
		</div>
		<br />
		<div align="center" style="width: 100%;border-style:dashed;border-width: 1px;height: 35%">
			<div>
				<h1>
					非住宅搬迁
				</h1>
			</div>
			<div class="table1">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="fzzbqcl">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								搬迁常量
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								非住宅搬迁规模
							</td>
							<td width="30%">
								<input type="text" name="fzzbqgm" id="fzzbqgm" class="text" onkeyup="textChange();" value="<%=map.get("fzzbqgm").toString() %>"/>
							</td>
							<td width="20%">
								万㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								企业家数
							</td>
							<td width="30%">
								<input type="text" name="qyjs" id="qyjs" class="text" onkeyup="textChange();" value="<%=map.get("qyjs").toString() %>"/>
							</td>
							<td width="20%">
								家
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								可形成出让规模
							</td>
							<td width="30%">
								<input type="text" name="fkxccrgm" id="fkxccrgm" class="text" onkeyup="textChange();" value="<%=map.get("fkxccrgm").toString() %>"/>
							</td>
							<td width="20%">
								万㎡
							</td>
						</tr>

					</table>
				</div>
				<div style="top: 10px">
					<table width="100%" cellpadding="0" cellspacing="0" id="fzgzc">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								中观政策
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								非住宅房屋搬迁单价
							</td>
							<td width="30%"><input type="text" name="fzzfwbqdj" class="text" id="fzzfwbqdj" onkeyup="textChange();" value="<%=map.get("fzzfwbqdj").toString() %>"/></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="table2">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="fzztzsp">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								非住宅投资水平
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr17">
								非住宅投资成本
							</td>
							<td width="30%" id="fzztzcb"></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								非住宅搬迁成本楼面单价
							</td>
							<td width="30%" id="fzzbqcblmdj"></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>

					</table>
				</div>
			</div>
		</div>
		<br/>
		<div align="center" style="width: 100%;border-style:dashed;border-width: 1px;height: 50%;">
			<div>
				<h1>
					总体成本情况
				</h1>
			</div>
			<div class="table1">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="ztghsj">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								总体规划数据
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								总占地
							</td>
							<td width="30%">
								<input type="text" name="zzd" id="zzd" class="text" onkeyup="textChange();" value="<%=map.get("zzd").toString() %>"/>
							</td>
							<td width="20%">
								公顷
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								建设用地调节系数
							</td>
							<td width="30%">
								<input type="text" name="jsydtjxs" id="jsydtjxs" class="text" onkeyup="textChange();" value="<%=map.get("jsydtjxs").toString() %>"/>
							</td>
							<td width="20%">
								————
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								总可出让建设用地
							</td>
							<td width="30%">
								<input type="text" name="zkcrjsyd" id="zkcrjsyd" class="text" onkeyup="textChange();" value="<%=map.get("zkcrjsyd").toString() %>"/>
							</td>
							<td width="20%">
								公顷
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								容积率
							</td>
							<td width="30%">
								<input type="text" name="rjl" id="rjl" class="text" onkeyup="textChange();" value="<%=map.get("rjl").toString() %>"/>
							</td>
							<td width="20%">
								————
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								总可出让建筑规模
							</td>
							<td width="30%">
								<input type="text" name="zkcrjzgm" id="rjl" class="text" onkeyup="textChange();" value="<%=map.get("zkcrjzgm").toString() %>"/>
							</td>
							<td width="20%">
								万㎡
							</td>
						</tr>
					</table>
				</div>
				<div style="top: 10px">
					<table width="100%" cellpadding="0" cellspacing="0" id="yjcjqk">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								预计成交情况
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr16">
								毛低价
							</td>
							<td width="30%"><input type="text" name="mdj" id="mdj" class="text" onkeyup="textChange();" value="<%=map.get("mdj").toString() %>"/></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr16">
								预计成交价
							</td>
							<td width="30%"><input type="text" name="yjcjj" id="yjcjj" class="text" onkeyup="textChange();" value="<%=map.get("yjcjj").toString() %>"/></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="table2">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="zyjkfcbqk">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								总一级开发成本情况
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr17">
								一级开发总成本
							</td>
							<td width="30%" id="yjkfzcb"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								前期开发费用
							</td>
							<td width="30%" id="qqkffy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								前期费用
							</td>
							<td width="30%" id="qqfy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								市政费用
							</td>
							<td width="30%" id="szfy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								搬迁收购费用
							</td>
							<td width="30%" id="bqsgfy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								搬迁补偿款
							</td>
							<td width="30%" id="bqbck"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								不可预见费
							</td>
							<td width="30%" id="bkyjf"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								间接费用
							</td>
							<td width="30%" id="jjfy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								财务费用
							</td>
							<td width="30%" id="cwfy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr17">
								投资回报
							</td>
							<td width="30%" id="tzhb"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="table3">
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" id="ztcrqk">
						<tr class="tr11">
							<td align="center" width="75%" height="35px" colspan="3">
								总体出让情况
							</td>
						</tr>
						<tr align="center">
							<td width="50%" class="tr03">
								预计出让底价
							</td>
							<td width="30%" id="yjcrdj"></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr03">
								楼面成本
							</td>
							<td width="30%" id="lmcb"></td>
							<td width="20%">
								万元/㎡
							</td>
						</tr>
						<tr align="center">
							<td width="45%" class="tr03">
								预计政府土地收益
							</td>
							<td width="30%" id="yjzftdsy"></td>
							<td width="20%">
								亿元
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>
