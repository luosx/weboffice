<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.qyjc.QyjcManager"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String  list= QyjcManager.getInstcne().getList();
			String reportID = "oldTable";
			String keyIndex = "1";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<base href="<%=basePath%>">
	<title>lz</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="base/include/jquery-1.10.2.js"></script>
	<%@ include file="js/reportEdit.jspf"%>
	<%@ include file="/base/include/ext.jspf" %>
	<script src="web/cbd/qyjc/xzlzjjc/xzlxx/js/xzlxxRowEditor.js"></script>
	<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}
input{


}
td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align:center;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
	text-align:center;
}
  .tr01{
  	background-color: #C0C0C0;
  	font-weight:bold;
    line-height: 30px;
    text-align:center;
  }
  .tr02{
  	background-color: #FCFCFC;
  }
   .tr03{
  	background-color: #FCFCFC;
  }
</style>
</head>
<script type="text/javascript">
var selectedTr;
var newRow;
var preObjColor;
var bhs = "";	
	function save(){
		var bh=document.getElementById("bh").value;
		var xzlmc=document.getElementById("xzlmc").value;
		var kfs=document.getElementById("kfs").value;
		var wygs=document.getElementById("wygs").value;
		var tzf=document.getElementById("tzf").value;
		var sq=document.getElementById("sq").value;
		var cpdw=document.getElementById("cpdw").value;
		var cplx=document.getElementById("cplx").value;
		var cylx=document.getElementById("cylx").value;
		
		var rzqy=document.getElementById("rzqy").value;
		var kpsj=document.getElementById("kpsj").value;
		var ysxkz=document.getElementById("ysxkz").value;
		var cbcs=document.getElementById("cbcs").value;
		var lc=document.getElementById("lc").value;
		var bzcg=document.getElementById("bzcg").value;
		var wq=document.getElementById("wq").value;
		var cn=document.getElementById("cn").value;
		var gd=document.getElementById("gd").value;
		var gs=document.getElementById("gs").value;
		
		var dt=document.getElementById("dt").value;
		var gdcw=document.getElementById("gdcw").value;
		var tcwzj=document.getElementById("tcwzj").value;
		var syl=document.getElementById("syl").value;
		var qt=document.getElementById("qt").value;
		
		  bh=escape(escape(bh));
		  xzlmc=escape(escape(xzlmc));
		  kfs=escape(escape(kfs));
		  wygs=escape(escape(wygs));
		  tzf=escape(escape(tzf));
		  cpdw=escape(escape(cpdw));
		  cplx=escape(escape(cplx));
		  cylx=escape(escape(cylx));
		  
		  rzqy=escape(escape(rzqy));
		  kpsj=escape(escape(kpsj));
		  ysxkz=escape(escape(ysxkz));
		  cbcs=escape(escape(cbcs));
		  lc=escape(escape(lc));
		  bzcg=escape(escape(bzcg));
		  wq=escape(escape(wq));
		  cn=escape(escape(cn));
		  gd=escape(escape(gd));
		  gs=escape(escape(gs));
		  
		  dt=escape(escape(dt));
		  gdcw=escape(escape(gdcw));
		  tcwzj=escape(escape(tcwzj));
		  syl=escape(escape(syl));
		  qt=escape(escape(qt));
		  if(bh==null||bh==''){
			alert("请填写写字楼编号！！"); 
		  }else{
	    	putClientCommond("qyjcManager","saveZJXX");
			putRestParameter("bh",bh);
			putRestParameter("xzlmc",xzlmc);
			putRestParameter("kfs",kfs);
			putRestParameter("wygs",wygs);
			putRestParameter("tzf",tzf);
			putRestParameter("sq",sq);
			putRestParameter("cpdw",cpdw);
			putRestParameter("cplx",cplx);
			putRestParameter("cylx",cylx);
			
			putRestParameter("rzqy",rzqy);
			putRestParameter("kpsj",kpsj);
			putRestParameter("ysxkz",ysxkz);
			putRestParameter("cbcs",cbcs);
			putRestParameter("lc",lc);
			putRestParameter("bzcg",bzcg);
			putRestParameter("wq",wq);
			putRestParameter("cn",cn);
			putRestParameter("gd",gd);
			putRestParameter("gs",gs);
			
			putRestParameter("dt",dt);
			putRestParameter("gdcw",gdcw);
			putRestParameter("tcwzj",tcwzj);
			putRestParameter("syl",syl);
			putRestParameter("qt",qt);
			var msg=restRequest();
			if('success'==msg){
				alert("保存成功！");
				 window.parent.adding=false;
				document.location.reload();
			}else{
				alert("保存失败！");
			}
		}
	}
	function update(){
		var bh=bhs;
		var xzlmc=document.getElementById("xzlmc1").value;
		var kfs=document.getElementById("kfs1").value;
		var wygs=document.getElementById("wygs1").value;
		var tzf=document.getElementById("tzf1").value;
		var sq=document.getElementById("sq1").value;
		var cpdw=document.getElementById("cpdw1").value;
		var cplx=document.getElementById("cplx1").value;
		var cylx=document.getElementById("cylx1").value;
		alert();
		var rzqy=document.getElementById("rzqy1").value;
		var kpsj=document.getElementById("kpsj1").value;
		var ysxkz=document.getElementById("ysxkz1").value;
		var cbcs=document.getElementById("cbcs1").value;
		var lc=document.getElementById("lc1").value;
		var bzcg=document.getElementById("bzcg1").value;
		var wq=document.getElementById("wq1").value;
		var cn=document.getElementById("cn1").value;
		var gd=document.getElementById("gd1").value;
		var gs=document.getElementById("gs1").value;
		
		var dt=document.getElementById("dt1").value;
		var gdcw=document.getElementById("gdcw1").value;
		var tcwzj=document.getElementById("tcwzj1").value;
		var syl=document.getElementById("syl1").value;
		var qt=document.getElementById("qt1").value;
		  bh=escape(escape(bh));
		  xzlmc=escape(escape(xzlmc));
		  kfs=escape(escape(kfs));
		  wygs=escape(escape(wygs));
		  tzf=escape(escape(tzf));
		  cpdw=escape(escape(cpdw));
		  cplx=escape(escape(cplx));
		  cylx=escape(escape(cylx));
		  
		  rzqy=escape(escape(rzqy));
		  kpsj=escape(escape(kpsj));
		  ysxkz=escape(escape(ysxkz));
		  cbcs=escape(escape(cbcs));
		  lc=escape(escape(lc));
		  bzcg=escape(escape(bzcg));
		  wq=escape(escape(wq));
		  cn=escape(escape(cn));
		  gd=escape(escape(gd));
		  gs=escape(escape(gs));
		  
		  dt=escape(escape(dt));
		  gdcw=escape(escape(gdcw));
		  tcwzj=escape(escape(tcwzj));
		  syl=escape(escape(syl));
		  qt=escape(escape(qt));
		  if(bh==null||bh==''){
			alert("请填写写字楼编号！！"); 
			}else{
	    	putClientCommond("qyjcManager","updateZJXX");
			putRestParameter("bh",bh);
			putRestParameter("xzlmc",xzlmc);
			putRestParameter("kfs",kfs);
			putRestParameter("wygs",wygs);
			putRestParameter("tzf",tzf);
			putRestParameter("sq",sq);
			putRestParameter("cpdw",cpdw);
			putRestParameter("cplx",cplx);
			putRestParameter("cylx",cylx);
			
			putRestParameter("rzqy",rzqy);
			putRestParameter("kpsj",kpsj);
			putRestParameter("ysxkz",ysxkz);
			putRestParameter("cbcs",cbcs);
			putRestParameter("lc",lc);
			putRestParameter("bzcg",bzcg);
			putRestParameter("wq",wq);
			putRestParameter("cn",cn);
			putRestParameter("gd",gd);
			putRestParameter("gs",gs);
			
			putRestParameter("dt",dt);
			putRestParameter("gdcw",gdcw);
			putRestParameter("tcwzj",tcwzj);
			putRestParameter("syl",syl);
			putRestParameter("qt",qt);
			var msg=restRequest();
			if('success'==msg){
				alert("保存成功！");
				 window.parent.adding=false;
				document.location.reload();
			}else{
				alert("保存失败！");
			}
		}
	}
	function addRow() {

		document.getElementById("newRow").style.display = '';

	}
	
	function cancel() {
		document.getElementById("newRow").style.display = 'none';
	}
	
	//window.onload = function(){ 
	//document.getElementById("XZLZJ").oncontextmenu=addRow; 
	//}
	function modify(i) {
		if (selectedTr != null && newRow != null) {
			cancel1();
		}
		selectedTr = document.getElementById("row" + i);
		selectedTr.style.display = 'none';
		var tb = document.getElementById("XZLXX");
		newRow = tb.insertRow(i + 3);
		var c0 = newRow.insertCell(0);
		bhs=selectedTr.cells[0].childNodes[0].nodeValue;
		c0.innerHTML = "<font id='bh1' >"+bhs+"</font>";
		var c1 = newRow.insertCell(1);
		c1.innerHTML = "<input id='xzlmc1' size='10' value='"+selectedTr.cells[1].childNodes[0].nodeValue+"'/>";
		var c2 = newRow.insertCell(2);
		c2.innerHTML = "<input id='kfs1' size='10' value='"+selectedTr.cells[2].childNodes[0].nodeValue+"'/>";
		var c3 = newRow.insertCell(3);
		c3.innerHTML = "<input id='wygs1' size='10' value='"+selectedTr.cells[3].childNodes[0].nodeValue+"'/>";
		var c4 = newRow.insertCell(4);
		c4.innerHTML = "<input id='tzf1' size='10' value='"+selectedTr.cells[4].childNodes[0].nodeValue+"'/>";
		var c5 = newRow.insertCell(5);
		c5.innerHTML = "<input id='sq1' size='10' value='"+selectedTr.cells[5].childNodes[0].nodeValue+"'/>";
		var c6 = newRow.insertCell(6);
		c6.innerHTML = "<input id='cpdw1' size='10' value='"+selectedTr.cells[6].childNodes[0].nodeValue+"'/>";
		var c7 = newRow.insertCell(7);
		c7.innerHTML = "<input id='cplx1' size='10' value='"+selectedTr.cells[7].childNodes[0].nodeValue+"'/>";
		var c8 = newRow.insertCell(8);
		c8.innerHTML = "<input id='cylx1' size='10' value='"+selectedTr.cells[8].childNodes[0].nodeValue+"'/>";
		var c9 = newRow.insertCell(9);
		c9.innerHTML = "<input id='rzqy1' size='10' value='"+selectedTr.cells[9].childNodes[0].nodeValue+"'/>";
		var c10 = newRow.insertCell(10);
		c10.innerHTML = "<input id='kpsj1' size='10' value='"+selectedTr.cells[10].childNodes[0].nodeValue+"'/>";
		var c11 = newRow.insertCell(11);
		c11.innerHTML = "<input id='ysxkz1' size='10' value='"+selectedTr.cells[11].childNodes[0].nodeValue+"'/>";
		var c12 = newRow.insertCell(12);
		c12.innerHTML = "<input id='cbcs1' size='10' value='"+selectedTr.cells[12].childNodes[0].nodeValue+"'/>";
		var c13 = newRow.insertCell(13);
		c13.innerHTML = "<input id='lc1' size='10' value='"+selectedTr.cells[13].childNodes[0].nodeValue+"'/>";
		var c14 = newRow.insertCell(14);
		c14.innerHTML = "<input id='bzcg1' size='10' value='"+selectedTr.cells[14].childNodes[0].nodeValue+"'/>";
		var c15 = newRow.insertCell(15);
		c15.innerHTML = "<input id='wq1' size='10' value='"+selectedTr.cells[15].childNodes[0].nodeValue+"'/>";
		var c16 = newRow.insertCell(16);
		c16.innerHTML = "<input id='cn1' size='10' value='"+selectedTr.cells[16].childNodes[0].nodeValue+"'/>";
		var c17 = newRow.insertCell(17);
		c17.innerHTML = "<input id='gd1' size='10' value='"+selectedTr.cells[17].childNodes[0].nodeValue+"'/>";
		var c18 = newRow.insertCell(18);
		c18.innerHTML = "<input id='gs1' size='10' value='"+selectedTr.cells[18].childNodes[0].nodeValue+"'/>";
		var c19 = newRow.insertCell(19);
		c19.innerHTML = "<input id='dt1' size='10' value='"+selectedTr.cells[19].childNodes[0].nodeValue+"'/>";
		var c20 = newRow.insertCell(20);
		c20.innerHTML = "<input id='gdcw1' size='10' value='"+selectedTr.cells[20].childNodes[0].nodeValue+"'/>";
		var c21 = newRow.insertCell(21);
		c21.innerHTML = "<input id='tcwzj1' size='10' value='"+selectedTr.cells[21].childNodes[0].nodeValue+"'/>";
		var c22 = newRow.insertCell(22);
		c22.innerHTML = "<input id='syl1' size='10' value='"+selectedTr.cells[22].childNodes[0].nodeValue+"'/>";
		var c23 = newRow.insertCell(23);
		c23.innerHTML = "<input id='qt1'   size='45'value='"+selectedTr.cells[23].childNodes[0].nodeValue+"'/>";
		var c24 = newRow.insertCell(24);
		c24.innerHTML = "<a href='javascript:update()'>保存</a>&nbsp;&nbsp;<a href='javascript:cancel1()'>取消</a>"
	}
	function del(bh) {
		if (confirm("删除后无法恢复，确定要删除吗？")) {
			putClientCommond("qyjcManager", "del");
			putRestParameter("bh", bh);
			var reslut = restRequest();
			if (reslut == 'success') {
				alert('删除成功！');
				window.location.reload();
			}else{
			alert('删除失败！');
			}
		}

	}
	function cancel1() {
		selectedTr.style.display = '';
		newRow.parentNode.removeChild(newRow);
	}
	function exportExcel(){
		    var curTbl = document.getElementById("XZLXX"); 
 			try{
		    	var oXL = new ActiveXObject("Excel.Application");
		    }catch(err){
		    	Ext.Msg.alert('提示','Excel生成失败，请先确定系统已安装office，并在浏览器的\'工具\' - Internet选项 -安全 - 自定义级别 - ActiveX控件和插件 - 对未标记为可安全执行脚本的ActiveX控件.. 标记为\'启用\'');
		    	return;
		    } 
		    //创建AX对象excel 
		    var oWB = oXL.Workbooks.Add(); 
		    //获取workbook对象 
		    var oSheet = oWB.ActiveSheet; 
		    //激活当前sheet 
		    var sel = document.body.createTextRange(); 
		    sel.moveToElementText(curTbl); 
		    //把表格中的内容移到TextRange中 
		    sel.select(); 
		    //全选TextRange中内容 
		    sel.execCommand("Copy"); 
		    //复制TextRange中内容 
		    //oSheet.Paste(); 
		    oSheet.Paste(); 
		    //粘贴到活动的EXCEL中       
		    oXL.Visible = true; 
		    //设置excel可见属性 
		}

</script>
<script type="text/javascript">
$(document).ready(function () { 
		var width = document.body.clientWidth+10;
		var height = document.body.clientHeight-35;
       	FixTable("XZLXX", 2,2, width, height);
	});
</script>
<body>
<div id="fixed" style="position: fixed; top: 2px; left: 20px">
  		&nbsp;
  		
		<img src="base/form/images/exportexcel.png" width="20px" height="20px" title="导出Excel" onClick="javascript:exportExcel();"  />&nbsp;&nbsp;&nbsp;
		<img src="base/form/images/add.png" width="20px" height="20px" title="添加新写字楼信息" onClick="addRow();"  />&nbsp;&nbsp;&nbsp;
	</div><br/>
		<%=list%>

</body>
</html>
