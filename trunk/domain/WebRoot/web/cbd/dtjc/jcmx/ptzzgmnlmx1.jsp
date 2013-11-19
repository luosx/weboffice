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
    font-weight:bold;
    line-height: 30px;
   }
    .tr06{
    background-color:#FFFFFF;
  	text-align:center;
    font-weight:bold;
    line-height: 30px; 
   }
   .tr07{
    background-color:#CCCCFF;
  	text-align:center;
    font-weight:bold;
    line-height: 30px; 
   }
   .tr11{
    background-color:#C0C0C0;
  	text-align:center;
    font-weight:bold;
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
			    excel.buildTable("PTZZGMLMX1YBL1", "3", "1");
                excel.buildTable("PTZZGMLMX1YBL2", "3", "4");
			    var sheet = excel.getSheet();
			    excel.setSheet(sheet);
			    excel.showTable();			    
		    }
       </script>
       <script type="text/javascript">
        Ext.onReady(function(){
           var f=new Ext.form.FormPanel({
              renderTo:"clparaform",
              title:"购房常规涉及参数（常量）",
              height: 500,
              width: 240,
              labelWidth: 160,
              labelAlign: "center",
              frame: true,
              defaults:{
                 xtype:"textfield",
                 width:60
              },
              items: [
              	 {id: "ZXJZWBL",fieldLabel:"装修及置物比例（%）"},
                 {id: "QSYHS", fieldLabel: "契税、印花税（%）"},
                 {id: "YYS", fieldLabel: "营业税（%）"},
                 {id: "SXF", fieldLabel: "手续费（%）"},
                 {id: "ZJF", fieldLabel: "中介费（%）"},
                 {id: "JKHKQX", fieldLabel: "借款还款期限"},
                 {id: "GJJDKZGED", fieldLabel: "公积金贷款最高额度（万元）"},
                 {id: "DKNXNLYQSX", fieldLabel: "贷款年限年龄要求上限（岁）"},
                 {id: "YJCGJJBL", fieldLabel: "月缴存公积金比例（%）"},
                 {id: "DKZGNX", fieldLabel: "贷款最高年限（年）"},
                 {id: "GJJDKLL",fieldLabel: "公积金贷款利率（%）"},
                 {id: "SYDKJZLL", fieldLabel: "商业贷款基准利率（%）"},
                 {id: "SYDKLLFD", fieldLabel: "商业贷款利率浮动（%）"}
              ],
              buttons:[{
                 text:"保存",
                 handler: function(){
                      var res=save();
                      if(res){
                        alert("保存成功");
                        window.location.reload();
                      }else{
                        alert("保存失败");
                      }
                 }
              }]
           });
           Ext.getCmp("ZXJZWBL").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("QSYHS").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("YYS").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("SXF").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("ZJF").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("JKHKQX").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("GJJDKZGED").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("DKNXNLYQSX").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("YJCGJJBL").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("DKZGNX").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("GJJDKLL").on('keyup',function(field,e){ 
                tryCol();
	        });
	         Ext.getCmp("SYDKJZLL").on('keyup',function(field,e){ 
                tryCol();
	        });
	         Ext.getCmp("SYDKLLFD").on('keyup',function(field,e){ 
                tryCol();
	        });
           putClientCommond("ptzzgmlCL","getCL");
	       var formData= restRequest();
	       if(formData[0]!=null){
	            Ext.getCmp("ZXJZWBL").setValue(formData[0].ZXJZWBL);
	  		    Ext.getCmp("QSYHS").setValue(formData[0].QSYHS);
			    Ext.getCmp("YYS").setValue(formData[0].YYS);
			    Ext.getCmp("SXF").setValue(formData[0].SXF);
			    Ext.getCmp("ZJF").setValue(formData[0].ZJF);
			    Ext.getCmp("JKHKQX").setValue(formData[0].JKHKQX);
			    Ext.getCmp("GJJDKZGED").setValue(formData[0].GJJDKZGED);
			    Ext.getCmp("DKNXNLYQSX").setValue(formData[0].DKNXNLYQSX);
			    Ext.getCmp("YJCGJJBL").setValue(formData[0].YJCGJJBL);
			    Ext.getCmp("DKZGNX").setValue(formData[0].DKZGNX);
			    Ext.getCmp("GJJDKLL").setValue(formData[0].GJJDKLL);
			    Ext.getCmp("SYDKJZLL").setValue(formData[0].SYDKJZLL);
			    Ext.getCmp("SYDKLLFD").setValue(formData[0].SYDKLLFD);
	        }
	        
            var f2=new Ext.form.FormPanel({
              renderTo:"bl1paraform",
              title:"拟购住宅房屋情况模块（自变量1）",
              height: 500,
              width: 240,
              labelWidth: 160,
              labelAlign: "center",
              frame: true,
              defaults:{
                 xtype:"textfield",
                 width:60
              },
              items: [
              	 {id: "NGFWMJ",fieldLabel:"拟购房屋面积（㎡）"},
                 {id: "NGFWDJ", fieldLabel: "拟购房屋单价（万元/㎡）"},
                 {id: "FWLX", fieldLabel: "房屋类型"},
                 {id: "ESFSYNS", fieldLabel: "二手房使用年数（年）"},
                 {id: "FL", fieldLabel: "房龄（年）"},
                 {id: "GFLX", fieldLabel: "购房类型"},
                 {id: "JTYKZPSR",fieldLabel:"家庭月可支配收入（万元/月）"},
                 {id: "YYYHDZJBL", fieldLabel: "月用于还贷资金比例（%）"},
                 {id: "DQCK", fieldLabel: "当前存款（万元）"},
                 {id: "WXXQJK", fieldLabel: "无息限期借款（万元）"},
                 {id: "GJJLXJNNS", fieldLabel: "公积金连续缴纳年数（月）"},
                 {id: "GFRNL", fieldLabel: "购房人年龄(岁)"}
              ],
              buttons:[{
                 text:"保存",
                 handler: function(){
                      var res=save();
                      if(res){
                        alert("保存成功");
                        window.location.reload();
                      }else{
                        alert("保存失败");
                      }
                 }
              }]
           });
           Ext.getCmp("NGFWMJ").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("NGFWDJ").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("FWLX").on('keyup',function(field,e){ 
                tryCol();
	        });
	         Ext.getCmp("ESFSYNS").on('keyup',function(field,e){ 
                tryCol();
	        });
	         Ext.getCmp("FL").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("GFLX").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("JTYKZPSR").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("YYYHDZJBL").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("WXXQJK").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("GJJLXJNNS").on('keyup',function(field,e){ 
                tryCol();
	        });
	        Ext.getCmp("GFRNL").on('keyup',function(field,e){ 
                tryCol();
	        });
         	putClientCommond("ptzzgmlCL","getBL");
	          var formData= restRequest();
	          if(formData[0]!=null){
	           Ext.getCmp("NGFWMJ").setValue(formData[0].NGFWMJ);
	  		    Ext.getCmp("NGFWDJ").setValue(formData[0].NGFWDJ);
			    Ext.getCmp("FWLX").setValue(formData[0].FWLX);
			    Ext.getCmp("ESFSYNS").setValue(formData[0].ESFSYNS);
			    Ext.getCmp("FL").setValue(formData[0].FL);
			    Ext.getCmp("GFLX").setValue(formData[0].GFLX);
			    Ext.getCmp("JTYKZPSR").setValue(formData[0].JTYKZPSR);
			    Ext.getCmp("YYYHDZJBL").setValue(formData[0].YYYHDZJBL);
			    Ext.getCmp("WXXQJK").setValue(formData[0].WXXQJK);
			    Ext.getCmp("GJJLXJNNS").setValue(formData[0].GJJLXJNNS);
			    Ext.getCmp("GFRNL").setValue(formData[0].GFRNL);
	        }
	        
	        tryCol();
        });
        
        function tryCol(){
        	var tbybl1=document.getElementById("PTZZGMLMX1YBL1");
        	var tbybl2= document.getElementById("PTZZGMLMX1YBL2");
        	var jtykzpsr = Ext.getCmp("JTYKZPSR").getValue();
        	var yyyhdzjbl = Ext.getCmp("YYYHDZJBL").getValue();
        	var dqck = fillDQCK(jtykzpsr,yyyhdzjbl);
        	Ext.getCmp("DQCK").setValue(dqck.toFixed(0));        	
        	var ngfwmj = Ext.getCmp("NGFWMJ").getValue();
	  		var ngfwdj = Ext.getCmp("NGFWDJ").getValue();
	  		var fwzjk = getFWZJK(ngfwmj,ngfwdj);
	  		tbybl1.rows[2].cells[1].innerHTML=fwzjk.toFixed(0);
	  		var zxjzwbl = Ext.getCmp("ZXJZWBL").getValue();
	  		var zxjzwk = getZXJZWK(fwzjk,zxjzwbl);
	  		tbybl1.rows[3].cells[1].innerHTML=zxjzwk.toFixed(2);
	  		var fwlx = Ext.getCmp("FWLX").getValue();
	  		var qsyhs = Ext.getCmp("QSYHS").getValue();
	  		var esfsynx = Ext.getCmp("ESFSYNS").getValue();
	  		var yys = Ext.getCmp("YYS").getValue();
	  		var gfxgfs = getGFXGFS(fwlx,fwzjk,qsyhs,esfsynx,yys);
	  		tbybl1.rows[4].cells[1].innerHTML=gfxgfs.toFixed(2);
	  		var sxf = Ext.getCmp("SXF").getValue();
			var zjf = Ext.getCmp("ZJF").getValue();
	  		var gfxgfy = getGFXGFY(fwlx,fwzjk,sxf,zjf);
	  		tbybl1.rows[5].cells[1].innerHTML=gfxgfy.toFixed(2);
	  		tbybl1.rows[1].cells[1].innerHTML=getGFZFY(fwzjk,zxjzwk,gfxgfs,gfxgfy).toFixed(0);
	  		var gflx = Ext.getCmp("GFLX").getValue();
	  		var zdgfsf = getZDGFSF(gflx,fwzjk,ngfwmj);
	  		tbybl1.rows[6].cells[1].innerHTML=zdgfsf.toFixed(0);
	  		var zdzcfgked = getZDZCGFKED(zxjzwk,gfxgfs,gfxgfy,zdgfsf);
	  		tbybl1.rows[7].cells[1].innerHTML=zdzcfgked.toFixed(0);
	  		var yjcgjjbl = Ext.getCmp("YJCGJJBL").getValue();
	  		var yjcgjjed = getYJCGJJED(yjcgjjbl,jtykzpsr);
	  		tbybl1.rows[8].cells[1].innerHTML=yjcgjjed.toFixed(2);
	  		var wxxqjk = Ext.getCmp("WXXQJK").getValue();
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
	  		var fl = Ext.getCmp("FL").getValue();
	  		var gfrnl = Ext.getCmp("GFRNL").getValue();
	  		var gjjdkyjnx = getGJJDKYJNX(fl,gfrnl);
	  		tbybl2.rows[4].cells[1].innerHTML=gjjdkyjnx;
	  		var sydkyjnx = getSYDKYJNX(fl);
	  		tbybl2.rows[5].cells[1].innerHTML=sydkyjnx;
	  		var gjjdkll = Ext.getCmp("GJJDKLL").getValue();
	  		var gjjzdyg = getGJJZDYG(gjjdkll,gjjdkje,gjjdkyjnx);
	  		tbybl2.rows[4].cells[3].innerHTML=gjjzdyg.toFixed(4);
	  		var sydkjzll = Ext.getCmp("SYDKJZLL").getValue()*1;
			var sydkllfd = Ext.getCmp("SYDKLLFD").getValue()*1;
	  		var sydkzdyg = getSYDKZDYG(sydkje,sydkjzll,sydkllfd,sydkyjnx);
	  		tbybl2.rows[5].cells[3].innerHTML=sydkzdyg.toFixed(4);
	  		var jkhkqx = Ext.getCmp("JKHKQX").getValue();
	  		var myylcjk = getMYYLCHK(wxxqjk,jkhkqx);
	  		tbybl2.rows[6].cells[2].innerHTML=myylcjk.toFixed(4);
	  		var result1 = getResult1(kcsgfsfed,zdgfsf);
	  		tbybl2.rows[1].cells[0].innerHTML=result1;
	  		var yhkzjhj = getYHKZJHJ(gjjzdyg,sydkzdyg,myylcjk);
	  		tbybl2.rows[3].cells[3].innerHTML=yhkzjhj.toFixed(4);
	  		tbybl2.rows[2].cells[0].innerHTML=getResult2(yyygfzj,yhkzjhj);
	  		var sfje = tbybl2.rows[8].cells[1].innerHTML;
	  	    var gjjlxjnns = Ext.getCmp("GJJLXJNNS").getValue();
	  		var gjjdkje2 = getGJJDKJE2(gjjlxjnns,fwzjk,sfje);
	  		tbybl1.rows[14].cells[1].innerHTML=gjjdkje2;
	  		var gjjdknx = tbybl2.rows[8].cells[3].innerHTML;
	  		var mychgjjbx = getMYCHGJJBX(gjjdkje2,gjjdkll,gjjdknx);
	  		tbybl2.rows[11].cells[1].innerHTML=mychgjjbx.toFixed(4);
	  		var sydkje2 = getSYDKJE2(fwzjk,sfje,gjjdkje2);
	  		tbybl1.rows[15].cells[1].innerHTML=sydkje2;
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
        			return fwzjk*(qsyhs+yys);
        		}
        	}
        }
        
        function getGFXGFY(fwlx,fwzjk,sxf,zjf){
        	if(fwlx=="新房"){
        		return fwzjk*sxf;
        	}else{
        		return fxwjk*(sxf+zjf);
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
        </script>
     </head>
  <body >
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="print()" >
	</div>
    <div id="form" style="float:left" ></div>
	<div>
	  <table width="1305" height="60" style="background-color: #FFFFFF;font-size: 30px">
	   <tr><td><h1>北京地区普通住宅房屋购买能力综合分析模型1</h1></td></tr>
	  </table>
	</div>
	<div class="div1" id="clparaform"></div>
	<div class="div2" id="bl1paraform"></div>
	<div class="div3">
		<%=new CBDReportManager().getReport("PTZZGMLMX1YBL1")%>
	</div>
	<div class="div4">
		<%=new CBDReportManager().getReport("PTZZGMLMX1YBL2")%>
	</div>
  </body>
</html>
