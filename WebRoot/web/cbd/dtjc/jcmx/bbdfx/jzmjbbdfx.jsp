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
	</style>
  </head>
    <script type="text/javascript">
        Ext.onReady(function(){
           var f=new Ext.form.FormPanel({
              renderTo:"paraform",
              title:"保本点基础参数",
              height: 500,
              width: 300,
              labelWidth: 140,
              labelAlign: "center",
              frame: true,
              defaults:{
                 xtype:"textfield",
                 enableKeyEvents : true,
                 width:140
              },            

              items: [
                 {id: "JSQ", fieldLabel: "建设期(年)"},
                 {id: "JSQLL", fieldLabel: "建设期利率（%）"},
                 {id: "JSQSFL", fieldLabel: "建设期税费率（%）"},
                 {id: "JSCBD", fieldLabel: "建设成本（元/平方米）"},
                 {id: "MDJ", fieldLabel: "毛地价（元/平方米）"},
                 {id: "YYQLL", fieldLabel: "运营期利率（%）"},
                 {id: "ZHYYFL", fieldLabel: "综合运营费率（%）"},
                 {id: "ZYZJBL", fieldLabel: "自有资金比率（%）"},
                 {id: "GLFYBFB", fieldLabel: "管理费用百分比（%）"},
                 {id: "XSFYBFB", fieldLabel: "销售费用百分比（%）"},
                 {id: "QTFYBFB", fieldLabel: "其他费用百分比（%）"},
                 {id: "DZXSJGXS", fieldLabel: "定制销售价格系数"},
                 {id: "ZYZJDYXBFB", fieldLabel: "自有资金的影像（%）"},
                 {id: "ZSYSBL", fieldLabel: "招商预售比例（%）"},
                 {id: "CZL", fieldLabel: "出租率（%）"}
              ],
              buttons:[{
                 text:"保存",
                 handler: function(){
                      var res=modifyForm();
                      if(res){
                        alert("保存成功");
                        window.location.reload();
                      }else{
                        alert("保存失败");
                      }
                 }
              }, {
                 text:"导出EXCEL",
                 handler: function(){
                       print();
                 }
              }]
           });
                Ext.getCmp("JSQ").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("JSQLL").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("JSQSFL").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("JSCBD").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("MDJ").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("YYQLL").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("ZHYYFL").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("ZYZJBL").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("GLFYBFB").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("XSFYBFB").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("QTFYBFB").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("DZXSJGXS").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("ZYZJDYXBFB").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("ZSYSBL").on('keyup',function(field,e){ 
                            test();
	            });
	            Ext.getCmp("CZL").on('keyup',function(field,e){ 
                            test();
	            });
	            
              putClientCommond("jzmjbbdfx","getBBDpara");
	          var formData= restRequest();
	          if(formData[0]!=null){
	  		    Ext.getCmp("JSQ").setValue(formData[0].JSQ);
			    Ext.getCmp("JSQLL").setValue(formData[0].JSQLL);
			    Ext.getCmp("JSQSFL").setValue(formData[0].JSQSFL);
			    Ext.getCmp("JSCBD").setValue(formData[0].JSCBD);
			    Ext.getCmp("MDJ").setValue(formData[0].MDJ);
			    Ext.getCmp("YYQLL").setValue(formData[0].YYQLL);
			    Ext.getCmp("ZHYYFL").setValue(formData[0].ZHYYFL);
			    Ext.getCmp("ZYZJBL").setValue(formData[0].ZYZJBL);
			    Ext.getCmp("GLFYBFB").setValue(formData[0].GLFYBFB);
			    Ext.getCmp("XSFYBFB").setValue(formData[0].XSFYBFB);
			    Ext.getCmp("QTFYBFB").setValue(formData[0].QTFYBFB);
			    Ext.getCmp("DZXSJGXS").setValue(formData[0].DZXSJGXS);
			    Ext.getCmp("ZYZJDYXBFB").setValue(formData[0].ZYZJDYXBFB);
			    Ext.getCmp("ZSYSBL").setValue(formData[0].ZSYSBL);
			    Ext.getCmp("CZL").setValue(formData[0].CZL);
	         }
	              test();
        });
        
        function modifyForm(){
        	  putClientCommond("jzmjbbdfx","saveBBDpara");
        	  putRestParameter("JSQ",Ext.getCmp("JSQ").getValue());
			  putRestParameter("JSQLL",Ext.getCmp("JSQLL").getValue());
			  putRestParameter("JSQSFL",Ext.getCmp("JSQSFL").getValue());
			  putRestParameter("JSCBD",Ext.getCmp("JSCBD").getValue());
			  putRestParameter("MDJ",Ext.getCmp("MDJ").getValue());
			  putRestParameter("YYQLL",Ext.getCmp("YYQLL").getValue());
			  putRestParameter("ZHYYFL",Ext.getCmp("ZHYYFL").getValue());
			  putRestParameter("ZYZJBL",Ext.getCmp("ZYZJBL").getValue());
			  putRestParameter("GLFYBFB",Ext.getCmp("GLFYBFB").getValue());
			  putRestParameter("XSFYBFB",Ext.getCmp("XSFYBFB").getValue());
			  putRestParameter("QTFYBFB",Ext.getCmp("QTFYBFB").getValue());
			  putRestParameter("DZXSJGXS",Ext.getCmp("DZXSJGXS").getValue());
			  putRestParameter("ZYZJDYXBFB",Ext.getCmp("ZYZJDYXBFB").getValue());
			  putRestParameter("ZSYSBL",Ext.getCmp("ZSYSBL").getValue());
			  putRestParameter("CZL",Ext.getCmp("CZL").getValue());
	          return restRequest();
            }
        
        function test(){
              var tb=document.getElementById("JZMJBBDFX");
              for(var i=1;i<tb.rows.length;i++){
                 for(var j=1;j<tb.rows[0].cells.length-1;j++){
                    var year=tb.rows[0].cells[j].innerHTML;
                    var cbcb=tb.rows[i].cells[0].innerHTML;
                    tb.rows[i].cells[j].innerHTML=rent(year,cbcb);
                    if(i==Math.round(tb.rows.length/2)||j==Math.round((tb.rows[0].cells.length-1)/2)){
                     tb.rows[i].cells[j].style.backgroundColor="green"; 
                    }else{
                     tb.rows[i].cells[j].style.backgroundColor="white"; 
                    }              
                 }            
              }  
        }
        
        function rent(year,cbkfcb){
            var year = parseInt(year);
            var cbkfcb = parseInt(cbkfcb);
            var mdj=Number(Ext.getCmp('MDJ').getValue());
			var jscbd=Number(Ext.getCmp('JSCBD').getValue());
			var glfybfb=Number(Ext.getCmp('GLFYBFB').getValue());
			var xsfybfb=Number(Ext.getCmp('XSFYBFB').getValue());
			var qtfybfb=Number(Ext.getCmp('QTFYBFB').getValue());
			var jsqsfl=Number(Ext.getCmp('JSQSFL').getValue());
			var dzxsjgxs=Number(Ext.getCmp('DZXSJGXS').getValue());
			var zyzjbl=Number(Ext.getCmp('ZYZJBL').getValue());
			var zsysbl=Number(Ext.getCmp('ZSYSBL').getValue());
			var zhyyfl=Number(Ext.getCmp('ZHYYFL').getValue());
			var yyqll=Number(Ext.getCmp('YYQLL').getValue());
			var czl=Number(Ext.getCmp('CZL').getValue());
			var zyzjdyxbfb=Number(Ext.getCmp('ZYZJDYXBFB').getValue());
			var jsqll=Number(Ext.getCmp('JSQLL').getValue());
			var jsq=Number(Ext.getCmp('JSQ').getValue());
			var a=0;
			var rent=0;
				if(zyzjdyxbfb+dzxsjgxs*zsysbl<1){
			        	if(cbkfcb+mdj-(cbkfcb+mdj+jscbd)*(zyzjdyxbfb+dzxsjgxs*zsysbl)>0){
			        		a=(cbkfcb+mdj-(cbkfcb+mdj+jscbd)*(zyzjdyxbfb+dzxsjgxs*zsysbl))*
			        		jsqll*jsq+jscbd*jsqll*(1+jsq)/2;
			        	}else{
			        		if(cbkfcb+mdj-(cbkfcb+mdj+jscbd)*(zyzjdyxbfb+dzxsjgxs*zsysbl)<0){
			        			a=(cbkfcb+mdj+jscbd)*(1-zyzjdyxbfb-dzxsjgxs*zsysbl)*jsqll*(1+jsq)/2;
			        		}else{
			        			a=jscbd*jsqll*(1+jsq)/2;
			        		}	
			        	}
			        }else{
			        	a=0;
			        }  
			        rent=((cbkfcb+mdj+jscbd+a+jscbd*(glfybfb+xsfybfb+qtfybfb))*(1+jsqsfl/(1-jsqsfl))-(cbkfcb+mdj+jscbd)*(dzxsjgxs*zsysbl+zyzjbl)+
					jscbd*zhyyfl)*yyqll/4*(Math.pow((1+yyqll/4), (year-3)*4)/(Math.pow((1+yyqll/4), (year-3)*4)-1)/90)/czl/(1-zsysbl);
			        rent=Math.round(rent*10)/10;
			    	return rent;
         }
      </script>
  
  
    <script type="text/javascript">
  		function print(){
			    var curTbl = document.getElementById("JZMJBBDFX"); 
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
  <body>
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
		<img src="base/form/images/print.png" width="20px" height="20px" onClick="print()" >
	</div>
	<div id="paraform" style="float:left" ></div>
  	<%=new CBDReportManager().getReport("JZMJBBDFX")%>
  </body>
</html>
