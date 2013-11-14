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
    background-color:#C0C0C0;
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 50px;
	margin-top: 3px;  
   }
   .tr02{
    background-color:#FFFF99;
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
    background-color:#CCFFFF;
  	text-align:center;
    font-weight:bold;
    line-height: 30px; 
   }
   .tr11{
    background-color:#99CC00;
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
   	float:left;position:relative;left:10px;
   }
   .div2{
   	float:left;margin-left:20px;position:relative;left:0px;
   }
   .div3{
   	float:left;margin-left:10px;position:relative;left:0px;
   }
   .div4{
   	float:left;margin-left:10px;position:relative;left:0px;
   }
	</style>
    <script type="text/javascript">
  		function print(){
			// var form=document.getElementById("attachfile");
			// form.action +="?reprotId=JBZR";
			// form.submit();
			    var curTbl = document.getElementById("report"); 
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
			    oSheet.Paste(); 
			    //粘贴到活动的EXCEL中       
			    oXL.Visible = true; 
			    //设置excel可见属性 
		}
  </script>
       <script type="text/javascript">
        Ext.onReady(function(){
           var f=new Ext.form.FormPanel({
              renderTo:"paraform",
              title:"购房常规涉及参数",
              height: 500,
              width: 300,
              labelWidth: 160,
              labelAlign: "center",
              frame: true,
              defaults:{
                 xtype:"textfield",
                 width:120
              },
              items: [
              	 {id: "SRKYYGFBL",fieldLabel:"收入可用于购房比例(50)"},
                 {id: "FWLX", fieldLabel: "房屋类型"},
                 {id: "GFLX", fieldLabel: "购房类型"},
                 {id: "SFGFK", fieldLabel: "首付购房款（%）"},
                 {id: "ZXJZWZJBL", fieldLabel: "装修及置物资金比例（%）"},
                 {id: "QSYHS", fieldLabel: "契税、印花税（%）"},
                 {id: "GJJDKZGED", fieldLabel: "公积金贷款最高额度（万元）"},
                 {id: "DKZGNX", fieldLabel: "贷款最高年限（年）"},
                 {id: "GJJJNBL", fieldLabel: "公积金缴纳比例（%）"},
                 {id: "GJJDKLL", fieldLabel: "公积金贷款利率（%）"},
                 {id: "SYDKJZLL", fieldLabel: "商业贷款基准利率（%）"},
                 {id: "SYDKLLFD", fieldLabel: "商业贷款利率浮动（%）"},
                 {id: "YCKSJ", fieldLabel: "已存款时间（月）"},
                 {id: "ZDCK", fieldLabel: "定最低存款（万元）"}
              ],
              buttons:[{
                 text:"试算",
                 handler: tryCol
              }, {
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
           Ext.getCmp("SRKYYGFBL").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("FWLX").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("GFLX").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("SFGFK").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("ZXJZWZJBL").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("QSYHS").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("GJJDKZGED").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("DKZGNX").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("GJJJNBL").on('keyup',function(field,e){ 
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
	            Ext.getCmp("YCKSJ").on('keyup',function(field,e){ 
                            tryCol();
	            });
	            Ext.getCmp("ZDCK").on('keyup',function(field,e){ 
                            tryCol();
	            });
           modifyForm();
           tryCol();
        });
        
        
        </script>
     </head>
  <body >
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="print()" >
	</div>
    <div id="form" style="float:left" ></div>
	<div>
	  <table width="1305" height="50" style="background-color: #FFFFFF">
	   <tr><td><h1>北京地区普通住宅房屋购买能力综合分析模型1</h1></td>
	  </table>
	</div>
	<div class="div1">
		<%=new CBDReportManager().getReport("PTZZGMLMX1CL")%>
	</div>
	<div class="div2">
		<%=new CBDReportManager().getReport("PTZZGMLMX1BL")%>
	</div>
	<div class="div3">
		<%=new CBDReportManager().getReport("PTZZGMLMX1BL")%>
	</div>
	<div class="div4">
		<%=new CBDReportManager().getReport("PTZZGMLMX1BL")%>
	</div>
  </body>
</html>
