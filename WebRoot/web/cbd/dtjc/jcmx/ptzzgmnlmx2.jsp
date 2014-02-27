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
   .td00{
   	background-image: url("<%=basePath%>/web/cbd/framework/images/titlegmlmx2.jpg");
   	background-repeat: repeat -xy;
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
	</style>
    <script type="text/javascript">
  		function print(){
			// var form=document.getElementById("attachfile");
			// form.action +="?reprotId=JBZR";
			// form.submit();
			    var curTbl = document.getElementById("PTZZGMNL"); 
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
        var tb;
        Ext.onReady(function(){
           var f=new Ext.form.FormPanel({
              renderTo:"paraform",
              title:"购房常规涉及参数",
              height: 500,
              width: 260,
              labelWidth: 160,
              labelAlign: "center",
              frame: true,
              defaults:{
                 xtype:"textfield",
                 enableKeyEvents : true,
                 width:80
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
        
      
        
        function rent(srkyygfbl,ycksj,zsjzwzjbl,qsyhs,gjjjnbl,fwlx,gflx,gjjdkzged,gjjdkll,sydkjzll,
                  sydkllfd,zdck,dkzgnx, jtykzpsr,gfmj){
			var money = srkyygfbl*jtykzpsr*ycksj;
			if(money < zdck){
				money = zdck;
			}
			var shui ;
			if(gfmj<=90){
				shui = 0.2 + zsjzwzjbl+qsyhs;
			}else{
				shui = 0.3 + zsjzwzjbl+qsyhs;
			}
			var min1 = money / shui * (1+zsjzwzjbl+qsyhs);
			var a1= srkyygfbl * jtykzpsr+jtykzpsr*gjjjnbl;
			var a2 = (Math.pow(1+gjjdkll/12,12*dkzgnx)-1)/(gjjdkll/12*Math.pow(1+gjjdkll/12,12*dkzgnx));
			var b1 = a1*a2<gjjdkzged?a1*a2:gjjdkzged*1;
			var c1 = gjjdkll/12*Math.pow(1+gjjdkll/12,12*dkzgnx)/(Math.pow(1+gjjdkll/12,12*dkzgnx)-1);
			var c2 = Math.pow(1+(sydkjzll*sydkllfd)/12,12*dkzgnx)-1;
			var c3 = (sydkjzll*sydkllfd)/12*Math.pow(1+(sydkjzll*sydkllfd)/12,12*dkzgnx);
			var min2 = money + b1+ (a1-b1*c1)*c2/c3;
			var min = min1<min2?min1:min2;
			var result = min/(1+zsjzwzjbl+qsyhs)/gfmj; 
			return result.toFixed(2)
         }
         
         function modifyForm(){
        	  putClientCommond("ptzzgml","getGMLData_CL");
	          var formData= restRequest();
	          if(formData[0]!=null){
	           Ext.getCmp("SRKYYGFBL").setValue(formData[0].SRKYYGFBL);
	  		    Ext.getCmp("FWLX").setValue(formData[0].FWLX);
			    Ext.getCmp("GFLX").setValue(formData[0].GFLX);
			    Ext.getCmp("SFGFK").setValue(formData[0].SFGFK);
			    Ext.getCmp("ZXJZWZJBL").setValue(formData[0].ZXJZWZJBL);
			    Ext.getCmp("QSYHS").setValue(formData[0].QSYHS);
			    Ext.getCmp("GJJDKZGED").setValue(formData[0].GJJDKZGED);
			    Ext.getCmp("DKZGNX").setValue(formData[0].DKZGNX);
			    Ext.getCmp("GJJJNBL").setValue(formData[0].GJJJNBL);
			    Ext.getCmp("GJJDKLL").setValue(formData[0].GJJDKLL);
			    Ext.getCmp("SYDKJZLL").setValue(formData[0].SYDKJZLL);
			    Ext.getCmp("SYDKLLFD").setValue(formData[0].SYDKLLFD);
			    Ext.getCmp("YCKSJ").setValue(formData[0].YCKSJ);
			    Ext.getCmp("ZDCK").setValue(formData[0].ZDCK);
	        }
        }
         
         function fill(srkyygfbl,ycksj,zsjzwzjbl,qsyhs,gjjjnbl,fwlx,gflx,gjjdkzged,gjjdkll,sydkjzll,
                  sydkllfd,zdck,dkzgnx){
         	tb=document.getElementById("PTZZGMNL");
         	var rows = tb.rows;
         	for(var i = 1;i<rows.length;i++){
         		var cells = rows[i].cells;
         		for(var j=1;j<cells.length;j++){
         			var fillresult = rent(srkyygfbl,ycksj,zsjzwzjbl,qsyhs,gjjjnbl,fwlx,gflx,gjjdkzged,gjjdkll,sydkjzll,
                  sydkllfd,zdck,dkzgnx,tb.rows[i].cells[0].childNodes[0].nodeValue,tb.rows[0].cells[j].childNodes[0].nodeValue);
            		if(fillresult > 4){
            			tb.rows[i].cells[j].style.backgroundColor="#FF99CC"; 
            		}
            		else if(fillresult > 2){
            			tb.rows[i].cells[j].style.backgroundColor="#FFCC99"; 
            		}else if(fillresult > 1){
            			tb.rows[i].cells[j].style.backgroundColor="#CCFFCC"; 
            		}else{
            			tb.rows[i].cells[j].style.backgroundColor="#FFFF99"; 
            		}
            		tb.rows[i].cells[j].innerHTML=fillresult;
            	}
            }
         }
         function tryCol(){
                     var srkyygfbl =  Ext.getCmp("SRKYYGFBL").getValue()/100;
                     if(isNaN(srkyygfbl)){
						alert("数字格式错误");
						return ;
					 }
                     var ycksj = Ext.getCmp("YCKSJ").getValue();
                     if(isNaN(ycksj)){
						alert("数字格式错误");
						return ;
					 }
                     var zsjzwzjbl = Ext.getCmp("ZXJZWZJBL").getValue()/100;
                     if(isNaN(zsjzwzjbl)){
						alert("数字格式错误");
						return ;
					 }
                     var qsyhs = Ext.getCmp("QSYHS").getValue()/100;
                     if(isNaN(qsyhs)){
						alert("数字格式错误");
						return ;
					 }
                     var gjjjnbl = Ext.getCmp("GJJJNBL").getValue()/100;
                     if(isNaN(gjjjnbl)){
						alert("数字格式错误");
						return ;
					 }
                     var fwlx = Ext.getCmp("FWLX").getValue();
                     var gflx = Ext.getCmp("GFLX").getValue();
                     var gjjdkzged = Ext.getCmp("GJJDKZGED").getValue();
                     if(isNaN(gjjdkzged)){
						alert("数字格式错误");
						return ;
					 }
                     var gjjdkll = Ext.getCmp("GJJDKLL").getValue()/100;
                     if(isNaN(gjjdkll)){
						alert("数字格式错误");
						return ;
					 }
                     var sydkjzll = Ext.getCmp("SYDKJZLL").getValue()/100;
                     if(isNaN(sydkjzll)){
						alert("数字格式错误");
						return ;
					 }
                     var sydkllfd = Ext.getCmp("SYDKLLFD").getValue()/100;
                     if(isNaN(sydkllfd)){
						alert("数字格式错误");
						return ;
					 }
                     var zdck = Ext.getCmp("ZDCK").getValue();
                     if(isNaN(zdck)){
						alert("数字格式错误");
						return ;
					 }
                     var dkzgnx = Ext.getCmp("DKZGNX").getValue();
                     if(isNaN(dkzgnx)){
						alert("数字格式错误");
						return ;
					 }
                     
                     fill(srkyygfbl,ycksj,zsjzwzjbl,qsyhs,gjjjnbl,fwlx,gflx,gjjdkzged,gjjdkll,sydkjzll,
                  sydkllfd,zdck,dkzgnx);
         }
         
         function save(){
         	putClientCommond("ptzzgml","Sava_GMLPA");
         	putRestParameter("SRKYYGFBL",Ext.getCmp("SRKYYGFBL").getValue());
	  		    putRestParameter("FWLX",Ext.getCmp("FWLX").getValue());
			    putRestParameter("GFLX",Ext.getCmp("GFLX").getValue());
			    putRestParameter("SFGFK",Ext.getCmp("SFGFK").getValue());
			    putRestParameter("ZXJZWZJBL",Ext.getCmp("ZXJZWZJBL").getValue());
			    putRestParameter("QSYHS",Ext.getCmp("QSYHS").getValue());
			    putRestParameter("GJJDKZGED",Ext.getCmp("GJJDKZGED").getValue());
			    putRestParameter("DKZGNX",Ext.getCmp("DKZGNX").getValue());
			    putRestParameter("GJJJNBL",Ext.getCmp("GJJJNBL").getValue());
			    putRestParameter("GJJDKLL",Ext.getCmp("GJJDKLL").getValue());
			    putRestParameter("SYDKJZLL",Ext.getCmp("SYDKJZLL").getValue());
			    putRestParameter("SYDKLLFD",Ext.getCmp("SYDKLLFD").getValue());
			    putRestParameter("YCKSJ",Ext.getCmp("YCKSJ").getValue());
			    putRestParameter("ZDCK",Ext.getCmp("ZDCK").getValue());
			    return restRequest();
         }
        </script>
     </head>
  <body >
  <div style="min-width: 1370px;width: 1300px;height: 500px;">
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="print()" title="导出Excel">
	</div>
	<div>
	  <table width="1305" height="50" style="background-color: #FFFFFF;font-size: 30px">
	   <tr><td ><h1>北京地区普通住宅房屋购买能力综合分析（群体购买力模型）</h1></td>
	   </tr>
	   <tr><td style="text-align:right;">单位：万元，平方米，万元/平方米</td></tr>
	  </table>
	 </div>
	<div id="paraform" style="float:left" ></div>
	<div>
	 
  	<%=new CBDReportManager().getReport("PTZZGMNL")%>
  	</div>
  	</div>
  </body>
</html>
