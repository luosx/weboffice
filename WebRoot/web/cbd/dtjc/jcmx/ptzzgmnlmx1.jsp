<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>年度计划</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script type="text/javascript" src="base/form/reportExcel.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		  table{
    font-size: 14px;
    background-color: #A8CEFF;
    border-color:#000000;
    /**
    border-left:1dp #000000 solid;
    border-top:1dp #000000 solid;
    **/
    color:#000000;
    border-collapse: collapse;
  }
  tr{
    border-width: 0px;
    text-align:center;
  }
  td{
    text-align:center;
    border-color:#000000;
    /**
    border-bottom:1dp #000000 solid;
    border-right:1dp #000000 solid;
    **/
  }
  .title{
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 50px;
	margin-top: 3px;
  }
  .trtotal{
  	text-align:center;
    font-weight:bold;
    line-height: 30px;
   }
  .trsingle{
    background-color: #D1E5FB;
    line-height: 20px;
    text-align:center;
   }
  .tr01{
    background-color:#969696;
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 50px;
	margin-top: 3px;  
   }
   .tr02{
    background-color:#FFFFCC;
  	text-align:center;
    line-height: 30px;
   }
   .tr03{
   	background-color:#CCFFCC;
  	text-align:center;
    line-height: 30px;
   }
   .tr04{
   	background-color:#969696;
    font-weight:bold;
    text-align:center;
    line-height: 30px;
   }
    .tr06{
    background-color:#FFFFFF;
  	text-align:center;
    line-height: 30px; 
   }
   .tr07{
    background-color:#CCCCFF;
  	text-align:center;
    line-height: 30px; 
   }
   .tr11{
    background-color:#C0C0C0;
  	text-align:center;
    line-height: 30px; 
   }
   
    .tr16{
    background-color:#FFCC99;
  	text-align:center;
    font-weight:bold;
    line-height: 30px; 
   }
  
   .div1{
   	float:left;position:relative;left:5px;
   }
   .div2{
   	float:left;margin-left:10px;position:relative;left:0px;
   }
   .div3{
   	float:left;margin-left:5px;position:relative;left:0px;
   }
   .div4{
   	float:left;margin-left:5px;position:relative;left:0px;
   }
   .text{
   		width:80px;height:25px;background-color: #C0C0C0;border: none;text-align: center;
   }
   .text02{
   		width:80px;height:25px;border: none;text-align: center;
   }
	</style>
    <script type="text/javascript">
  		function print(){
		    //    var curTbl = document.getElementById("report"); 
			 //   try{
			   // 	var oXL = new ActiveXObject("Excel.Application");
			    //}catch(err){
			   // 	Ext.Msg.alert('提示','Excel生成失败，请先确定系统已安装office，并在浏览器的\'工具\' - Internet选项 -安全 - 自定义级别 - ActiveX控件和插件 - 对未标记为可安全执行脚本的ActiveX控件.. 标记为\'启用\'');
			   // 	return;
			    //} 
			    //创建AX对象excel 
			    //var oWB = oXL.Workbooks.Add(); 
			    //获取workbook对象 
			    //    var oSheet = oWB.ActiveSheet; 
			    //激活当前sheet 
			    //var sel = document.body.createTextRange(); 
			    //sel.moveToElementText(curTbl); 
			    //把表格中的内容移到TextRange中 
			    //sel.select(); 
			    //全选TextRange中内容 
			    //sel.execCommand("Copy"); 
			    //复制TextRange中内容  
			    //oSheet.Paste(); 
			    //粘贴到活动的EXCEL中       
			    //oXL.Visible = true; 
			    //设置excel可见属性 
			    var excel = new ReportExcel();
			    excel.Init();
			    excel.setCells(50);
			    excel.setRows(20);
			    excel.buildTable("tbcl", "3", "1");
                excel.buildTable("tbbl", "3", "4");
			    excel.buildTable("PTZZGMLMX1YBL1", "3", "7");
                excel.buildTable("PTZZGMLMX1YBL2", "3", "10");
			    var sheet = excel.getSheet();
			    excel.setSheet(sheet);
			    excel.showTable();			    
		    }
       </script>
       <script type="text/javascript">
       var tbcl;
       var tbbl;
       var tbybl1;
       var tbybl2;
        Ext.onReady(function(){
           tbcl = document.getElementById("tbcl");
           tbbl = document.getElementById("tbbl"); 
           putClientCommond("ptzzgmlCL","getCL");
	       var formData= restRequest();
	       if(formData[0]!=null){
	       		document.getElementById("zxjzwbl").value=formData[0].ZXJZWBL;
	       		document.getElementById("QSYHS").value=formData[0].QSYHS;
	       		document.getElementById("yys").value=formData[0].YYS;
	       		document.getElementById("sxf").value=formData[0].SXF;
	       		document.getElementById("zjf").value=formData[0].ZJF;
	       		document.getElementById("jkhkqx").value=formData[0].JKHKQX;
	       		document.getElementById("gjjdkzged").value=formData[0].GJJDKZGED;
	       		document.getElementById("dknxnlyqsx").value=formData[0].DKNXNLYQSX;
	       		document.getElementById("yjcgjjbl").value=formData[0].YJCGJJBL;
	       		document.getElementById("dkzgnx").value=formData[0].DKZGNX;
	       		document.getElementById("gjjdkll").value=formData[0].GJJDKLL;
	       		document.getElementById("sydkjzll").value=formData[0].SYDKJZLL;
	       		document.getElementById("sydkllfd").value=formData[0].SYDKLLFD;
	        }
         	putClientCommond("ptzzgmlCL","getBL");
	          formData= restRequest();
	          if(formData[0]!=null){
	          document.getElementById("ngfwmj").value=formData[0].NGFWMJ;
	          document.getElementById("ngfwdj").value=formData[0].NGFWDJ;
	          document.getElementById("fwlx").value=formData[0].FWLX;
	          document.getElementById("esfsyns").value=formData[0].ESFSYNS;
	          document.getElementById("fl").value=formData[0].FL;
	          document.getElementById("gflx").value=formData[0].GFLX;
              document.getElementById("jtykzpsr").value=formData[0].JTYKZPSR;
              document.getElementById("yyyhdzjbl").value=formData[0].YYYHDZJBL;
              document.getElementById("wxxqjk").value=formData[0].WXXQJK;
              document.getElementById("gjjlxjnns").value=formData[0].GJJLXJNNS;
              document.getElementById("gfrnl").value=formData[0].GFRNL;
	        }
	        
	        tryCol();
        });
        
        function tryCol(){
        	tbybl1=document.getElementById("PTZZGMLMX1YBL1");
            tbybl2= document.getElementById("PTZZGMLMX1YBL2");
        	var jtykzpsr = document.getElementById("jtykzpsr").value;
        	var yyyhdzjbl = document.getElementById("yyyhdzjbl").value;
        	var dqck = fillDQCK(jtykzpsr,yyyhdzjbl);
        	document.getElementById("dqck").value=dqck.toFixed(0);        	
        	var ngfwmj = document.getElementById("ngfwmj").value;
	  		var ngfwdj = document.getElementById("ngfwdj").value;
	  		var fwzjk = getFWZJK(ngfwmj,ngfwdj);
	  		tbybl1.rows[2].cells[1].innerHTML=fwzjk.toFixed(0);
	  		var zxjzwbl = document.getElementById("zxjzwbl").value;
	  		var zxjzwk = getZXJZWK(fwzjk,zxjzwbl);
	  		tbybl1.rows[3].cells[1].innerHTML=zxjzwk.toFixed(2);
	  		var fwlx = document.getElementById("fwlx").value.trim();
	  		var qsyhs = document.getElementById("qsyhs").value;
	  		var esfsynx = document.getElementById("esfsyns").value;
	  		var yys = document.getElementById("yys").value;
	  		var gfxgfs = getGFXGFS(fwlx,fwzjk,qsyhs,esfsynx,yys);
	  		tbybl1.rows[4].cells[1].innerHTML=gfxgfs.toFixed(2);
	  		var sxf = document.getElementById("sxf").value;
			var zjf = document.getElementById("zjf").value;
	  		var gfxgfy = getGFXGFY(fwlx,fwzjk,sxf,zjf);
	  		tbybl1.rows[5].cells[1].innerHTML=gfxgfy.toFixed(2);
	  		tbybl1.rows[1].cells[1].innerHTML=getGFZFY(fwzjk,zxjzwk,gfxgfs,gfxgfy).toFixed(0);
	  		var gflx = document.getElementById("gflx").value;
	  		var zdgfsf = getZDGFSF(gflx,fwzjk,ngfwmj);
	  		tbybl1.rows[6].cells[1].innerHTML=zdgfsf.toFixed(0);
	  		var zdzcfgked = getZDZCGFKED(zxjzwk,gfxgfs,gfxgfy,zdgfsf);
	  		tbybl1.rows[7].cells[1].innerHTML=zdzcfgked.toFixed(0);
	  		var yjcgjjbl = document.getElementById("yjcgjjbl").value;
	  		var yjcgjjed = getYJCGJJED(yjcgjjbl,jtykzpsr);
	  		tbybl1.rows[8].cells[1].innerHTML=yjcgjjed.toFixed(2);
	  		var wxxqjk = document.getElementById("wxxqjk").value;
	  		var kcsgfsfed = getKCSGFSFED(dqck,wxxqjk,zxjzwk,gfxgfs,gfxgfy);
	  		tbybl1.rows[9].cells[1].innerHTML=kcsgfsfed.toFixed(0);
	  		var yyygfzj = getYYYGFZJ(jtykzpsr,yyyhdzjbl,yjcgjjed);
	  		tbybl2.rows[3].cells[1].innerHTML = yyygfzj.toFixed(2);
	  		var gjjdkje = getGJJDKJE(fwzjk,kcsgfsfed,yyygfzj);
	  		tbybl1.rows[10].cells[1].innerHTML=gjjdkje.toFixed(0);
	  		var gjjkkzdkb = getDKB(gjjdkje,fwzjk,kcsgfsfed);
	  		tbybl1.rows[11].cells[1].innerHTML=gjjkkzdkb.toFixed(2)*100+"%";
	  		var sydkje = getSYDKJE(fwzjk,kcsgfsfed,gjjdkje);
	  		tbybl1.rows[12].cells[1].innerHTML=sydkje.toFixed(0);
	  		var sydkyld = getSYDKYLD(fwzjk,kcsgfsfed,sydkje);
	  		tbybl1.rows[13].cells[1].innerHTML=(sydkyld*100).toFixed(0)+"%";
	  		var fl = document.getElementById("fl").value;
	  		var gfrnl = document.getElementById("gfrnl").value;
	  		var gjjdkyjnx = getGJJDKYJNX(fl,gfrnl);
	  		tbybl2.rows[4].cells[1].innerHTML=gjjdkyjnx;
	  		var sydkyjnx = getSYDKYJNX(fl);
	  		tbybl2.rows[5].cells[1].innerHTML=sydkyjnx;
	  		var gjjdkll = document.getElementById("gjjdkll").value;
	  		var gjjzdyg = getGJJZDYG(gjjdkll,gjjdkje,gjjdkyjnx);
	  		tbybl2.rows[4].cells[3].innerHTML=gjjzdyg.toFixed(4);
	  		var sydkjzll = document.getElementById("sydkjzll").value*1;
			var sydkllfd = document.getElementById("sydkllfd").value*1;
	  		var sydkzdyg = getSYDKZDYG(sydkje,sydkjzll,sydkllfd,sydkyjnx);
	  		tbybl2.rows[5].cells[3].innerHTML=sydkzdyg.toFixed(4);
	  		var jkhkqx = document.getElementById("jkhkqx").value;
	  		var myylcjk = getMYYLCHK(wxxqjk,jkhkqx);
	  		tbybl2.rows[6].cells[2].innerHTML=myylcjk.toFixed(4);
	  		var result1 = getResult1(kcsgfsfed,zdgfsf);
	  		tbybl2.rows[1].cells[0].innerHTML=result1;
	  		var yhkzjhj = getYHKZJHJ(gjjzdyg,sydkzdyg,myylcjk);
	  		tbybl2.rows[3].cells[3].innerHTML=yhkzjhj.toFixed(4);
	  		tbybl2.rows[2].cells[0].innerHTML=getResult2(yyygfzj,yhkzjhj);
	  		var sfje = tbybl2.rows[8].cells[1].innerHTML;
	  	    var gjjlxjnns = document.getElementById("gjjlxjnns").value;
	  		var gjjdkje2 = getGJJDKJE2(gjjlxjnns,fwzjk,sfje);
	  		//tbybl1.rows[14].cells[1].innerHTML=gjjdkje2;
	  		var gjjdknx = tbybl2.rows[8].cells[3].innerHTML;
	  		var mychgjjbx = getMYCHGJJBX(gjjdkje2,gjjdkll,gjjdknx);
	  		tbybl2.rows[11].cells[1].innerHTML=mychgjjbx.toFixed(4);
	  		var sydkje2 = getSYDKJE2(fwzjk,sfje,gjjdkje2).toFixed(0);
	  		//tbybl1.rows[15].cells[1].innerHTML=sydkje2;
	  		var sydknx = tbybl2.rows[9].cells[1].innerHTML;
	  		var mychsydkbx = getMYCHSYDKBX(sydkjzll,sydkllfd,sydkje2,sydknx);
	  		tbybl2.rows[12].cells[1].innerHTML=mychsydkbx.toFixed(4);
	  		var chjknx = tbybl2.rows[9].cells[3].innerHTML;
	  		var myylchqyjk = getMYYLCHQYJK(wxxqjk,chjknx);
	  		tbybl2.rows[13].cells[1].innerHTML=myylchqyjk.toFixed(4);
	  		tbybl2.rows[10].cells[1].innerHTML=getMYHKZJHJ(mychgjjbx,mychsydkbx,myylchqyjk).toFixed(4);
        }
        function getMYHKZJHJ(mychgjjbx,mychsydkbx,myylchqyjk){
        	return mychgjjbx+mychsydkbx+myylchqyjk;
        }
        function getMYYLCHQYJK(wxxqjk,chjknx){
        	return wxxqjk/(chjknx*12);
        }
        function getMYCHSYDKBX(sydkjzll,sydkllfd,sydkje2,sydknx){
        	return (sydkje2*sydkjzll*sydkllfd/12*Math.pow(1+sydkjzll*sydkllfd/12,sydknx*12))/(Math.pow(1+sydkjzll*sydkllfd/12,sydknx*12)-1)
        }
        function getSYDKJE2(fwzjk,sfje,gjjdkje2){
        	return fwzjk-sfje-gjjdkje2;
        }
        function getMYCHGJJBX(gjjdkje2,gjjdkll,gjjdknx){
        	return (gjjdkje2*gjjdkll/12*Math.pow(1+gjjdkll/12,gjjdknx*12))/(Math.pow(1+gjjdkll/12,gjjdknx*12)-1);
        }
        function getGJJDKJE2(gjjlxjnns,fwzjk,sfje){
        	if(gjjlxjnns<12){
        		return 0;
        	}else{
        		if(fwzjk-sfje<80){
        			return fwzjk-sfje;
        		}else{
        			return 80;
        		}
        	}
        }
        function getResult2(kyygfzj,yhkzjhj){
        	if(kyygfzj>=yhkzjhj){
        		return "具备按照约定年期偿还各项借款的能力。";
        	}else{
        		return "不具备按照约定年限还款的能力。";
        	}
        }
        function getYHKZJHJ(gjjzdyg,sydkzdyg,myylchjk){
        	return gjjzdyg+sydkzdyg+myylchjk;
        }
        function getResult1(kcsgfsfed,zdgfsf){
        	if(kcsgfsfed>=zdgfsf){
	  			return "经分析，购房人基本具备支付首付能力；";
	  		}else{
	  			return "经分析，购房人暂不具备支付首付能力；";
	  		}
        }
        function getMYYLCHK(wxxqjk,jkhkqx){
        	return wxxqjk/(jkhkqx*12);
        }
        function getGJJZDYG(gjjdkll,gjjdkje,gjjdkyjnx){
        	return (gjjdkll*gjjdkje/12*Math.pow(1+gjjdkll/12,gjjdkyjnx*12))/(Math.pow(1+gjjdkll/12,gjjdkyjnx*12)-1);
        }
        function getSYDKZDYG(sydkje,sydkjzll,sydkllfd,sydkyjnx){
        	return (sydkje*sydkjzll*sydkllfd/12*Math.pow(1+sydkjzll*sydkllfd/12,sydkyjnx*12))/(Math.pow(1+sydkjzll*sydkllfd/12,sydkyjnx*12)-1);
        }
        function getGJJDKYJNX(fl,gfrnl){
        	if(fl*1+30<=50){
        		if(70-gfrnl>30){
        			return 30;
        		}else{
        			return 70-gfrnl;
        		}
        	}else{
        		if(70-gfrnl<50-fl){
        			return 70-gfrnl;
        		}else{
        			return 50-fl;
        		}
        	}
        }
        function getSYDKYJNX(fl){
        	if(fl*1+30<=50){
        		return 30;
        	}else{
        		return 50-fl;
        	}
        }
        function getSYDKYLD(fwzjk,kcsgfsfed,sydkje){
        	return sydkje/(fwzjk-kcsgfsfed);
        }
        function getSYDKJE(fwzjk,kcsgfsfed,gjjdkje){
        	return fwzjk-kcsgfsfed-gjjdkje;
        }
        function getDKB(gjjdkje,fwzjk,kcsgfsfed){
        	return gjjdkje/(fwzjk-kcsgfsfed);
        }
        function getGJJDKJE(fwzjk,kcsgfsfed,yyygfzj){
        	var num = 0;
        	if(yyygfzj*10000/51.86<=80){
        		num = yyygfzj*10000/51.86;
        	}else{
        		num = 80;
        	}
        	if(fwzjk-kcsgfsfed<num){
        		return fwzjk-kcsgfsfed;
        	}
        	return num;
        }
        
        function getYYYGFZJ(jtykzpsr,yyyhdzjbl,yjcgjjed){
        	return jtykzpsr*yyyhdzjbl+yjcgjjed;
        }
        
        function getGFZFY(fwzjk,zxjzwk,gfxgfs,gfxgfy){
        	return fwzjk+zxjzwk+gfxgfy+gfxgfs;
        }
        
        function getFWZJK(ngfwmj,ngfwdj){
         return ngfwmj*ngfwdj;
        }
        function getZXJZWK(fwzjk,zxjzwbl){
        	return fwzjk*zxjzwbl;
        }
        
        function getGFXGFS(fwlx,fwzjk,qsyhs,esfsynx,yys){
        	if(fwlx=="新房"){
        		return fwzjk*qsyhs;
        	}else{
        		if(esfsynx>=5){
        			return fwzjk*qsyhs;
        		}else{
        			return fwzjk*(qsyhs*1+yys*1);
        		}
        	}
        }
        
        function getGFXGFY(fwlx,fwzjk,sxf,zjf){
        	if(fwlx=="新房"){
        		return fwzjk*sxf;
        	}else{
        		return fwzjk*(sxf*1+zjf*1);
        	}
        }
        
        function getZDGFSF(gflx,fwzjk,ngfwmj){
        	if(gflx=="首套"){
        		if(ngfwmj<=90){
        			return fwzjk*0.2;
        		}else{
        			return fwzjk*0.3;
        		}
        	}else{
        		return fwzjk*0.6;
        	}
        }
        
        function fillDQCK(jtykzpsr,yyyhdzjbl){
        	return jtykzpsr*84*yyyhdzjbl;
        }
        
        function getZDZCGFKED(zxjzwk,gfxgfs,gfxgfy,zdgfsf){
        	return zxjzwk*1+gfxgfs*1+gfxgfy*1+zdgfsf*1;
        }
        
        function getYJCGJJED(yjcgjjbl,jtykzpsr){
        	return yjcgjjbl*jtykzpsr;
        }
        
        function getKCSGFSFED(dqck,wxxqjk,zxjzwk,gfxgfs,gfxgfy){
        	return dqck+wxxqjk-zxjzwk-gfxgfs-gfxgfy;
        }
        function CheckClick(check){
        	if(check=="checkcl"){
        		if(tbcl.style.display==""){
        			tbcl.style.display="none"; 
        		}else{
        			tbcl.style.display=""; 
        		}
        	}else if(check=="checkbl"){
        		if(tbbl.style.display==""){
        			tbbl.style.display="none"; 
        		}else{
        			tbbl.style.display=""; 
        		}
        	}else if(check=="checkybl1"){
        		if(tbybl1.style.display==""){
        			tbybl1.style.display="none"; 
        		}else{
        			tbybl1.style.display=""; 
        		}
        	}else {
        		if(tbybl2.style.display==""){
        			tbybl2.style.display="none"; 
        		}else{
        			tbybl2.style.display=""; 
        		}
        	}
        }
        function textChange(value){
        	if(isNaN(value)){
				alert("数字格式错误");
				return ;
			}
        	tryCol();
        }
        
        function textChange1(value){
        	tryCol();
        }
        
        function sava(){
        	Sava_CL();
        	var res=Sava_BL();
                      if(res){
                        alert("保存成功");
                        window.location.reload();
                      }else{
                        alert("保存失败");
                      }
        }
        function Sava_CL(){
        	putClientCommond("ptzzgmlCL","Sava_CL");
        	putRestParameter("ZXJZWBL",document.getElementById("zxjzwbl").value);
	       	putRestParameter("QSYHS",document.getElementById("QSYHS").value);
	       	putRestParameter("YYS",document.getElementById("yys").value);
	       	putRestParameter("SXF",document.getElementById("sxf").value);
	       	putRestParameter("ZJF",document.getElementById("zjf").value);
	       	putRestParameter("JKHKQX",document.getElementById("jkhkqx").value);
	       	putRestParameter("GJJDKZGED",document.getElementById("gjjdkzged").value);
	       	putRestParameter("DKNXNLYQSX",document.getElementById("dknxnlyqsx").value);
	       	putRestParameter("YJCGJJBL",document.getElementById("yjcgjjbl").value);
	       	putRestParameter("DKZGNX",document.getElementById("dkzgnx").value);
	       	putRestParameter("GJJDKLL",document.getElementById("gjjdkll").value);
	       	putRestParameter("SYDKJZLL",document.getElementById("sydkjzll").value);
	       	putRestParameter("SYDKLLFD",document.getElementById("sydkllfd").value);
        	return restRequest();
        }
        
        function Sava_BL(){
        	putClientCommond("ptzzgmlCL","Sava_BL");
        	putRestParameter("NGFWMJ",document.getElementById("ngfwmj").value);
	          putRestParameter("NGFWDJ",document.getElementById("ngfwdj").value);
	          putRestParameter("FWLX",document.getElementById("fwlx").value);
	          putRestParameter("ESFSYNS",document.getElementById("esfsyns").value);
	          putRestParameter("FL",document.getElementById("fl").value);
	          putRestParameter("GFLX",document.getElementById("gflx").value);
              putRestParameter("JTYKZPSR",document.getElementById("jtykzpsr").value);
              putRestParameter("YYYHDZJBL",document.getElementById("yyyhdzjbl").value);
              putRestParameter("WXXQJK",document.getElementById("wxxqjk").value);
              putRestParameter("GJJLXJNNS",document.getElementById("gjjlxjnns").value);
              putRestParameter("GFRNL",document.getElementById("gfrnl").value);
        	return restRequest();
        }
        </script>
     </head>
  <body>
  <div style="min-width: 1370px;width: 1300px;height: 500px;">
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="print()" title="导出Excel" >
		<input type="checkbox" name="checkcl" checked="checked" onclick="CheckClick('checkcl');"/>常量
		<input type="checkbox" name="checkbl" checked="checked" onclick="CheckClick('checkbl');"/>自变量
		<input type="checkbox" name="checkybl1" checked="checked" onclick="CheckClick('checkybl1');"/>因变量1
		<input type="checkbox" name="checkybl2" checked="checked" onclick="CheckClick('checkybl2');"/>因变量2
	<div>
    	<img src="web/cbd/framework/images/save.png" onClick="sava()" width="20px"  height="20px"  title="保存">
    	</div>
	</div>
    
	<div>
	  <table width="1305" height="60" style="background-color: #FFFFFF;font-size: 30px">
	   <tr><td><h1>北京地区普通住宅房屋购买能力综合分析（个体购买力模型）</h1></td></tr>
	  </table>
	</div>
	<!--<div class="div1" id="clparaform"></div>-->
	<div class="div1">
		<table width="240" border="1" id="tbcl">
			<tr class="tr01"><td colspan="2">购房常规涉及参数（常量）</td></tr>
			<tr class="tr11"><td width="180">装修及置物比例</td><td><input name="zxjzwbl" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">契税、印花税</td><td><input name="qsyhs" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">营业税</td><td><input name="yys" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">手续费</td><td><input name="sxf" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">中介费</td><td><input name="zjf" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">借款还款期限</td><td><input name="jkhkqx" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">公积金贷款最高额度</td><td><input name="gjjdkzged" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">贷款年限年龄要求上限</td><td><input name="dknxnlyqsx" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">月缴存公积金比例</td><td><input name="yjcgjjbl" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">贷款最高年限</td><td><input name="dkzgnx" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">公积金贷款利率</td><td><input name="gjjdkll" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">商业贷款基准利率</td><td><input name="sydkjzll" class="text" onkeyup="textChange(this.value);"/></td></tr>
			<tr class="tr11"><td width="180">商业贷款利率浮动</td><td><input name="sydkllfd" class="text" onkeyup="textChange(this.value);"/></td></tr>
		</table>
	</div>
	<div class="div2">
		<table width="240" border="1" id="tbbl">
			<tr class="tr01"><td colspan="2">拟购住宅房屋情况（自变量1）</td></tr>
			<tr><td width="180" class="tr02">拟购房屋面积</td><td class="tr06"><input name="ngfwmj" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">拟购房屋单价</td><td class="tr06"><input name="ngfwdj" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">房屋类型</td><td class="tr06"><select name="fwlx" id="fwlx" onchange="textChange1(this.value);"><option value="新房" selected="selected">新房</option><option value="二手房">二手房</option></select> </td></tr>
			<tr><td width="180" class="tr02">二手房使用年数</td><td class="tr06"><input name="esfsyns" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">房龄</td><td class="tr06"><input name="fl" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">购房类型</td><td class="tr06"><select name="gflx" id="gflx" onchange="textChange1(this.value);"><option value="首套" selected="selected">首套</option><option value="二套及以上">二套及以上</option></select> </td></tr>
			<tr class="tr04"><td colspan="2">购房人基本情况模块（自变量2）</td></tr>
			<tr><td width="180" class="tr02">家庭月可支配收入</td><td class="tr06"><input name="jtykzpsr" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">月用于还贷资金比例</td><td class="tr06"><input name="yyyhdzjbl" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">当前存款</td><td class="tr06"><input name="dqck" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">无息限期借款</td><td class="tr06"><input name="wxxqjk" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">公积金连续缴纳年数</td><td class="tr06"><input name="gjjlxjnns" class="text02" onkeyup="textChange(this.value);"/></td></tr>
			<tr><td width="180" class="tr02">购房人年龄</td><td class="tr06"><input name="gfrnl" class="text02" onkeyup="textChange(this.value);"/></td></tr>
		</table>
	</div>
	<!-- 
	<div class="div2" id="bl1paraform"></div>
	 -->
	<div class="div3">
		<%=new CBDReportManager().getReport("PTZZGMLMX1YBL1")%>
	</div>
	<div class="div4">
		<%=new CBDReportManager().getReport("PTZZGMLMX1YBL2")%>
	</div>
	</div>
  </body>
</html>
