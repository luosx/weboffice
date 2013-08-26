<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>cbd区域储备项目基础数据一览表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/base/include/restRequest.jspf"%>
<style>
input,img {
	vertical-align: middle;
}

html,body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font: normal 13px verdana;
}

table {
	border-collapse: collapse;
	border: none;
}

td {
	border: solid #000 1px;
	font-size:12px;
	height:30px;
}
#leftright, #topdown{
position:absolute;
left:0;
top:0;
width:1px;
height:1px;
layer-background-color:#FF6905;
background-color:#FF6905;
z-index:0;
font-size:0px;
}


</style>
</head>
<script type="text/javascript">
	//显示十字标尺
	function showCross(){
		if (document.getElementById('table5').checked) {
			document.getElementById('leftright').style.display = '';
			document.getElementById('topdown').style.display = '';
		}else{
			document.getElementById('leftright').style.display = 'none';
			document.getElementById('topdown').style.display = 'none';
		}
	}
	
	//页面初始化
	function onInit(){
		//获取基础数据
		putClientCommond("jcsjHandler", "getjcsjList");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		
		//将基础数据写到列表中
		var hang = 2;
		var lie = 0;
		var baseTable = document.getElementById("planTable");
		for(var i = 0; i < baseInformation.length; i++){
			baseTable.insertRow(hang); 
			baseTable.rows[hang].insertCell(lie++).innerHTML = i + 1;
			// baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].XMNAME);
			//baseTable.rows[hang].insertCell(lie++).innerHTML = "<label onClick=\"changeXM(\""+ format(baseInformation[i].XMNAME) +"\")\">" + format(baseInformation[i].XMNAME) + "</label>";
			baseTable.rows[hang].insertCell(lie++).innerHTML = "<label id='"+ format(baseInformation[i].XMNAME) +"' onClick='changeXM(this);return false;'>"+ format(baseInformation[i].XMNAME) +"</label>";
			baseTable.rows[hang].cells[lie - 1].bgColor = "#C0C0C0";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].ZD);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFCC99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].GM);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFCC99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].HS);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFCC99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].CB);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFCC99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].ZZCQFY);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFFF";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].QYCQFY);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFFF";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].QTFY);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFFF";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].AZFTZCB);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFFF99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].ZZHBTZCB);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFFF99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].CQHBTZ);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFFF99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].QTFYZB);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#FFFF99";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].LMCB);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFCC";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].LMCJJ);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFCC";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].FWSJ);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFCC";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].ZJ);
			baseTable.rows[hang].cells[lie - 1].bgColor = "#CCFFCC";
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].PGTDJZ);
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].TYL);
			baseTable.rows[hang].insertCell(lie++).innerHTML = format(baseInformation[i].RZSS);
			hang++;
			lie = 0;
		}
		
		//计算数据总和
		for(var i = 2; i < 12; i++){
			var count = 0;
			for(var j = 0; j < baseInformation.length; j++){
				count += parseFloat(baseTable.rows[j + 2].cells[i].innerHTML);
			}
			baseTable.rows[1].cells[i-1].innerHTML = count;
		}
		//计算其他费用占比
		baseTable.rows[1].cells[11].innerHTML = toDecimal((parseFloat(baseTable.rows[1].cells[7].innerHTML)/parseFloat(baseTable.rows[1].cells[4].innerHTML)) * 100) + "%";
		
		//计算楼面成本
		baseTable.rows[1].cells[12].innerHTML = toDecimal((parseFloat(baseTable.rows[1].cells[4].innerHTML)/parseFloat(baseTable.rows[1].cells[2].innerHTML)));
	}
	
	//数据格式化
	function format(value){
		if(value == null || value == ""){
			return 0;
		}else{
			return value;
		}
	}
			
	//添加一笔基础数据
	function add(){
		// window.showModalDialog (, "600", "no"); 
		//window.open("/domain/web/cbd/cbxmjbsj/jbxmxxlr.jsp");
		//window.showModalDialog ("/domain/web/cbd/cbxmjbsj/jbxmxxlr.jsp","10000", "8000", "no");
		//var feature="dialogWidth:800px;dialogHeight:560px;status:no;help:no";  
		//window.showModalDialog("/domain/web/cbd/cbxmjbsj/jbxmxxlr.jsp",null,feature); 
		//window.location.reload();
		window.open("/domain/web/cbd/cbxmjbsj/jbxmxxlr.jsp");
		window.locaiton.reload();
	}
	
	function changeXM(check){
		var xmmc = check.id;
		putClientCommond("projectManager", "getYw_guidbymc");
		putRestParameter("xmmc", xmmc);
		yw_guid = restRequest();
		yw_guid = eval(yw_guid);
		yw_guid = yw_guid[0].YW_GUID;
		var url = "/domain/web/cbd/cbxmjbsj/jbxmxxlr.jsp?yw_guid=" + yw_guid;
		//var feature="dialogWidth:800px;dialogHeight:560px;status:no;help:no";  
		//window.showModalDialog(url,null,feature); 
		window.open(url);
		window.location.reload();
	}
	
	//去两位有效数字
	     function toDecimal(x) {    
            var f = parseFloat(x);    
            if (isNaN(f)) {    
                return;    
            }    
            f = Math.round(x*100)/100;    
            return f;    
        } 
	
</script>
<body bgcolor="#CCE8CF" topmargin="0" leftmargin="0" onLoad="onInit(); return false;">
	<p align="left" style="font-size:12px">
		显示内容： 
			 <input type="checkbox"
			name="content" id="table5" checked='true' onClick="showCross()" style="font-size:12px;">十字标尺
			&nbsp;&nbsp; 
			<button onClick="add(); return false;" style="margin-top:5px; font-size:12px; ">增加</button>
	</p>
	<table id='planTable' border=1
		style="text-align: center; font: normal 13px verdana;" width='130%' >
		<tr
			style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
			<td style="width:30px; font-size:14px;">序号</td>
			<td style="width:150px;font-size:14px;">项目名称</td>
			<td style="width:60px;font-size:14px;">占地<br>(公顷)</td>
			<td style="width:60px;font-size:14px;">规模<br>(万㎡)</td>
			<td style="width:50px;font-size:14px;">户数(户)</td>
			<td style="width:50px;font-size:14px;">成本<br>(亿元)</td>
			<td style="width:100px;font-size:14px;">住宅拆迁<br>费用(亿元)</td>
			<td style="width:100px;font-size:14px;">企业拆迁<br>费用(亿元)</td>
			<td style="width:80px;font-size:14px;">其他费用<br>(亿元)</td>
			<td style="width:100px;font-size:14px;">安置房投资<br>成本(亿元)</td>
			<td style="width:120px;font-size:14px;">住宅货币投资<br>成本(亿元)</td>
			<td style="width:120px;font-size:14px;">拆迁货币投资<br>(亿元)</td>
			<td style="width:50px;font-size:14px;">其他费用占比</td>
			<td style="width:90px;font-size:14px;">楼面成本<br>(万元/㎡)</td>
			<td style="width:100px;font-size:14px;">楼面成交价<br>(万元/㎡)</td>
			<td style="width:90px;font-size:14px;">房屋售价<br>(万元/㎡)</td>
			<td style="width:90px;font-size:14px;">租金<br>(元/㎡/天)</td>
			<td style="width:60px;font-size:14px;">评估土地价值</td>
			<td style="width:80px;font-size:14px;">抵押率</td>
			<td style="width:90px;font-size:14px;">融资损失</td>
		</tr>
		
		<tr align="center" style='background: #C0C0C0;' id='kftl4'>
			<td colspan="2"> 合&nbsp;&nbsp;计 </td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		
	</table>
	<div id="leftright" style="width:expression(document.body.clientWidth)"></div>
<div id="topdown" style="height:expression(document.body.clientHeight)"></div>
</body>
</html>
<script>
if (document.all&&!window.print){
	leftright.style.width=document.body.clientWidth-6
	topdown.style.height=document.body.clientHeight-1
	}
	else if (document.layers){
	document.leftright.clip.width=window.innerWidth
	document.leftright.clip.height=5
	document.topdown.clip.width=5
	document.topdown.clip.height=window.innerHeight
	}
	function followmouse1(){
	//move cross engine for IE 4+
	leftright.style.pixelTop=document.body.scrollTop+event.clientY+1
	topdown.style.pixelTop=document.body.scrollTop
	if (event.clientX<document.body.clientWidth-2)
	topdown.style.pixelLeft=document.body.scrollLeft+event.clientX+1
	else
	topdown.style.pixelLeft=document.body.clientWidth-2
	}
	function followmouse2(e){
	//move cross engine for NS 4+
	document.leftright.top=e.y+6
	document.topdown.top=pageYOffset
	document.topdown.left=e.x+6
	}
	if (document.all)
	document.onmousemove=followmouse1
	else if (document.layers){
	window.captureEvents(Event.MOUSEMOVE)
	window.onmousemove=followmouse2
	}
	function regenerate(){
	window.location.reload()
	}
	function regenerate2(){
	setTimeout("window.onresize=regenerate",400)
	}
	if ((document.all&&!window.print)||document.layers)
	//if the user is using IE 4 or NS 4, both NOT IE 5+
	window.onload=regenerate2

</script>