<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>统计数据</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/formbase.jspf"%>
	<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
	<style type="text/css">
		table{
			text-align: center;
		}
		table tr td{
			height:25px;
		}
		.kftl{
			background-color: #FFFF99;
		}
		.azfjs{
			background-color: #CCFFFF;
		}
		.gdtl{
			background-color: #99CC00;
		}
		#trzqk{
		    background-color: #FFCC99;
		}
	</style>
  </head>
  <script type="text/javascript">
  	function init(){
		initComponent();
		bindData();
  	}
  	
  	//初始化控件
  	function initComponent(){
  		var inputs = document.getElementsByTagName('input');
  		for(var i=0;i<inputs.length;i++){
  			if(inputs[i].type=='checkbox'){
  				inputs[i].checked=true;
  			} 			
  		}
  		if(document.getElementById('kf').checked){
  			document.getElementById('kftl').style.display='block';
  		}
  		if(document.getElementById('az').checked){
  			document.getElementById('azfjs').style.display='block';
  		}
  		if(document.getElementById('gd').checked){
  			document.getElementById('gdtl').style.display='block';
  		}
  		if(document.getElementById('tr').checked){
  			document.getElementById('trzqk').style.display='block';
  		}  	
  	
  	}
  	//绑定数据
  	function bindData(){
  		putClientCommond("staticData","bindData");
  		var res = restRequest();
 		if(res){
 			//开发体量
 			for(var i=1;i<=9;i++){
 				document.getElementById('hs'+i).innerHTML=filterNull(filterFixed(res[i-1][0].HS));
 				document.getElementById('kz'+i).innerHTML=filterNull(filterFixed(res[i-1][0].KZ));
 				document.getElementById('dl'+i).innerHTML=filterNull(filterFixed(res[i-1][0].DL));
 				document.getElementById('gm'+i).innerHTML=filterNull(filterFixed(res[i-1][0].GM));
 			}
 			//安置房建设
 			for(var i=10;i<=18;i++){
 				document.getElementById('kgl'+(i-9)).innerHTML=filterNull(filterFixed(res[i-1][0].KGL));
 				document.getElementById('touz'+(i-9)).innerHTML=filterNull(filterFixed(res[i-1][0].TOUZ));
 				document.getElementById('ksygm'+(i-9)).innerHTML=filterNull(filterFixed(res[i-1][0].KSYGM));
 				document.getElementById('syl'+(i-9)).innerHTML=filterNull(filterFixed(res[i-1][0].SYL)); 
 				document.getElementById('azfcl'+(i-9)).innerHTML=filterNull(filterFixed(res[i-1][0].AZFCL)); 				
 			}
 			//供地体量
 			for(var i=19;i<=27;i++){
 				document.getElementById('jdkcrgm'+(i-18)).innerHTML=filterNull(filterFixed(res[i-1][0].JDKCRGM));
 				document.getElementById('gygm'+(i-18)).innerHTML=filterNull(filterFixed(res[i-1][0].GYGM));
 				document.getElementById('cbkc'+(i-18)).innerHTML=filterNull(filterFixed(res[i-1][0].CBKC));
 				document.getElementById('cbkrznl'+(i-18)).innerHTML=filterNull(filterFixed(res[i-1][0].CBKRZNL)); 
 				//document.getElementById('cbkzrznl'+(i-18)).innerHTML=filterNull(res[i-1][0].AZFCL);  				
 			}
 			//投融资情况
 			for(var i=28;i<=36;i++){
 				document.getElementById('ndzc'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDZC));
 				document.getElementById('ndsr'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDSR));
 				//document.getElementById('cbkc'+(i-27)).innerHTML=filterNull(res[i-1][0].CBKC);
 				document.getElementById('ndtzxq'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDTZXQ)); 
 				document.getElementById('ndhlcb'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDHLCB));   			
 				document.getElementById('zftdsy'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].ZFTDSY));
 				document.getElementById('ndrzxq'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDRZXQ));
 				document.getElementById('ndhkxq'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDHKXQ));
 				document.getElementById('zwzjsygm'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].ZWZJSYGM)); 
 				document.getElementById('zyzjsygm'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].ZYZJSYGM));  
 				document.getElementById('qyxzjzr'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].QYXZJZR));
 				document.getElementById('fzye'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].FZYE));
 				//document.getElementById('cbkc'+(i-27)).innerHTML=filterNull(res[i-1][0].CBKC);
 				document.getElementById('ndzmye'+(i-27)).innerHTML=filterNull(filterFixed(res[i-1][0].NDZMYE));   				 			
 			}
 			
 			for(var i=1;i<=9;i++){
 				//另算 储备库再融资能力=储备库融资能力-负债余额（投融资情况） 储备库融资缺口=储备库融资能力（供地体量）-负债余额 
 				document.getElementById('cbkzrznl'+i).innerHTML = filterNull(filterFixed(parseFloat(document.getElementById('cbkrznl'+i).innerHTML)-parseFloat(document.getElementById('fzye'+i).innerHTML)));
 				document.getElementById('cbkrzqk'+i).innerHTML = document.getElementById('cbkzrznl'+i).innerHTML;
 				
 				//权益性资金规模=年度回笼成本+权益性资金注入+年度账面余额（上一年）
 				if(i==1){
 					document.getElementById('qyxzjgm1').innerHTML = filterNull(filterFixed(parseFloat(document.getElementById('ndhlcb1').innerHTML)+ parseFloat(document.getElementById('qyxzjzr1').innerHTML)));
 				}else{
 					document.getElementById('qyxzjgm'+i).innerHTML = filterNull(filterFixed(parseFloat(document.getElementById('ndhlcb'+i).innerHTML)+ parseFloat(document.getElementById('qyxzjzr'+i).innerHTML)+ parseFloat(document.getElementById('ndzmye'+(i-1)).innerHTML)));
 				}	
 			}		
			//合计
			var array = new Array('hs','kz','dl','gm','kgl','touz','ksygm','syl','azfcl','jdkcrgm','gygm','cbkc','cbkrznl','cbkzrznl','ndzc','ndsr','qyxzjgm','ndtzxq','ndhlcb','zftdsy','ndrzxq','ndhkxq','zwzjsygm','zyzjsygm','qyxzjzr','fzye','cbkrzqk','ndzmye');			
			for(var i=1;i<=array.length;i++){
			    var hj=0;
				for(var j=1;j<=9;j++){			
					hj += filterNull(parseFloat(document.getElementById(array[i-1]+j).innerHTML));	
					document.getElementById(array[i-1]+'hj').innerHTML = filterNull(parseFloat(hj).toFixed(2));				
				}			
			}
 		} 		
  	}
  	
  	//过滤NULL值
  	function filterNull(text){
  		if(text=='0'){
  			return '0';
  		}
  		if(text=="null"||!text){
  			return "&nbsp;";
  		}
		return text;	   		
  	}
  	
  	function filterFixed(value){
		var reg = new RegExp("^([0-9]*[.0-9])$");
		if(reg.test(value))
		  return value.toFixed(2);
		else
		  return value;
  	}
  	
  	function hideInfo(obj){
  	  if(obj.id=='kf' && obj.checked){
  	  	document.getElementById('kftl').style.display='block';
  	  }else if(obj.id=='kf' && !obj.checked){
  	  	document.getElementById('kftl').style.display='none';
  	  }
  	  if(obj.id=='az' && obj.checked){
  	  	document.getElementById('azfjs').style.display='block';
  	  }else if(obj.id=='az' && !obj.checked){
  	  	document.getElementById('azfjs').style.display='none';
  	  }
  	  if(obj.id=='gd' && obj.checked){
  	  	document.getElementById('gdtl').style.display='block';
  	  }else if(obj.id=='gd' && !obj.checked){
  	  	document.getElementById('gdtl').style.display='none';
  	  }  		
  	  if(obj.id=='tr' && obj.checked){
  	  	document.getElementById('trzqk').style.display='block';
  	  }else if(obj.id=='tr' && !obj.checked){
  	  	document.getElementById('trzqk').style.display='none';
  	  }  	
  	}
  </script>
  <body onload="init();">
  	 <div style="font-size:14px;cursor: hand;">显示内容：<label><input type="checkbox" id="kf" name="info" onclick="hideInfo(this)"/>开发体量</label>&nbsp;&nbsp;&nbsp; <label><input type="checkbox" id="az" name="info" onclick="hideInfo(this)"/>安置房建设</label>&nbsp;&nbsp;&nbsp;  <label><input type="checkbox" id="gd" name="info" onclick="hideInfo(this)"/>供地体量</label>&nbsp;&nbsp;&nbsp; <label><input type="checkbox" id="tr" name="info" onclick="hideInfo(this)"/>投融资情况</label></div>
     <table width="100%" cellpadding="0" cellspacing="0" border="1">
     	<thead style="background-color:#C0C0C0;font-weight:bold;height:30px;">
     		<tr>
	     		<td colspan="2">序号</td>
	     		<td>时序（年）</td>
	     		<td>2013年</td>
	     		<td>2014年</td>
	     		<td>2015年</td>
	     		<td>2016年</td>
	     		<td>2017年</td>
	     		<td>2018年</td>
	     		<td>2019年</td>
	     		<td>2020年</td>
	     		<td>2021年</td>
	     		<td>合&nbsp;&nbsp;计</td>
     		</tr>     		     		
     	</thead>
     	<tbody id="kftl" style="display: none;">
     	<tr class="kftl">
     		<td rowspan="4">开<br>发<br>体<br>量</td>
     		<td>1</td>
     		<td>征收户数</td>
     		<td id="hs1">&nbsp;</td>
     		<td id="hs2">&nbsp;</td>
     		<td id="hs3">&nbsp;</td>
     		<td id="hs4">&nbsp;</td>
     		<td id="hs5">&nbsp;</td>
     		<td id="hs6">&nbsp;</td>
     		<td id="hs7">&nbsp;</td>
     		<td id="hs8">&nbsp;</td> 
     		<td id="hs9">&nbsp;</td>
     		<td id="hshj">&nbsp;</td>       		    		
     	</tr>
     	<tr class="kftl">
     		<td>2</td>
     		<td>征收控制</td>
     		<td id="kz1">&nbsp;</td>
     		<td id="kz2">&nbsp;</td>
     		<td id="kz3">&nbsp;</td>
     		<td id="kz4">&nbsp;</td>
     		<td id="kz5">&nbsp;</td>
     		<td id="kz6">&nbsp;</td>
     		<td id="kz7">&nbsp;</td>
     		<td id="kz8">&nbsp;</td> 
     		<td id="kz9">&nbsp;</td>
     		<td id="kzhj">&nbsp;</td>      	
     	</tr>
     	<tr class="kftl">
     		<td>3</td>
     		<td>完成开发地量(公顷)</td>
     		<td id="dl1">&nbsp;</td>
     		<td id="dl2">&nbsp;</td>
     		<td id="dl3">&nbsp;</td>
     		<td id="dl4">&nbsp;</td>
     		<td id="dl5">&nbsp;</td>
     		<td id="dl6">&nbsp;</td>
     		<td id="dl7">&nbsp;</td>
     		<td id="dl8">&nbsp;</td> 
     		<td id="dl9">&nbsp;</td>
     		<td id="dlhj">&nbsp;</td>      	
     	</tr>
     	<tr class="kftl">
     		<td>4</td>
     		<td>完成开发规模(万m^2)</td>
     		<td id="gm1">&nbsp;</td>
     		<td id="gm2">&nbsp;</td>
     		<td id="gm3">&nbsp;</td>
     		<td id="gm4">&nbsp;</td>
     		<td id="gm5">&nbsp;</td>
     		<td id="gm6">&nbsp;</td>
     		<td id="gm7">&nbsp;</td>
     		<td id="gm8">&nbsp;</td> 
     		<td id="gm9">&nbsp;</td>
     		<td id="gmhj">&nbsp;</td>       	
     	</tr> 
     	</tbody>
     	<tbody id="azfjs" style="display: none;">
     	<tr class="azfjs">
     		<td rowspan="5">安<br>置<br>房<br>建<br>设</td>
     		<td>5</td>
     		<td>开工量(万m^2)</td>
     		<td id="kgl1">&nbsp;</td>
     		<td id="kgl2">&nbsp;</td>
     		<td id="kgl3">&nbsp;</td>
     		<td id="kgl4">&nbsp;</td>
     		<td id="kgl5">&nbsp;</td>
     		<td id="kgl6">&nbsp;</td>
     		<td id="kgl7">&nbsp;</td>
     		<td id="kgl8">&nbsp;</td> 
     		<td id="kgl9">&nbsp;</td>
     		<td id="kglhj">&nbsp;</td>         		
     	</tr>
     	<tr class="azfjs">
     		<td>6</td>
     		<td>投资(亿元)</td>
     		<td id="touz1">&nbsp;</td>
     		<td id="touz2">&nbsp;</td>
     		<td id="touz3">&nbsp;</td>
     		<td id="touz4">&nbsp;</td>
     		<td id="touz5">&nbsp;</td>
     		<td id="touz6">&nbsp;</td>
     		<td id="touz7">&nbsp;</td>
     		<td id="touz8">&nbsp;</td> 
     		<td id="touz9">&nbsp;</td>
     		<td id="touzhj">&nbsp;</td>       	
     	</tr>
     	<tr class="azfjs">
      		<td>7</td>
     		<td>安置房可使用规模(万m^2)</td>
     		<td id="ksygm1">&nbsp;</td>
     		<td id="ksygm2">&nbsp;</td>
     		<td id="ksygm3">&nbsp;</td>
     		<td id="ksygm4">&nbsp;</td>
     		<td id="ksygm5">&nbsp;</td>
     		<td id="ksygm6">&nbsp;</td>
     		<td id="ksygm7">&nbsp;</td>
     		<td id="ksygm8">&nbsp;</td> 
     		<td id="ksygm9">&nbsp;</td>
     		<td id="ksygmhj">&nbsp;</td>       	
     	</tr> 
     	<tr class="azfjs">
      		<td>8</td>
     		<td>使用量(万m^2)</td>
     		<td id="syl1">&nbsp;</td>
     		<td id="syl2">&nbsp;</td>
     		<td id="syl3">&nbsp;</td>
     		<td id="syl4">&nbsp;</td>
     		<td id="syl5">&nbsp;</td>
     		<td id="syl6">&nbsp;</td>
     		<td id="syl7">&nbsp;</td>
     		<td id="syl8">&nbsp;</td> 
     		<td id="syl9">&nbsp;</td>
     		<td id="sylhj">&nbsp;</td>       	
     	</tr>
     	<tr class="azfjs">
      		<td>9</td>
     		<td>安置房存量(万m^2)</td> 
     		<td id="azfcl1">&nbsp;</td>
     		<td id="azfcl2">&nbsp;</td>
     		<td id="azfcl3">&nbsp;</td>
     		<td id="azfcl4">&nbsp;</td>
     		<td id="azfcl5">&nbsp;</td>
     		<td id="azfcl6">&nbsp;</td>
     		<td id="azfcl7">&nbsp;</td>
     		<td id="azfcl8">&nbsp;</td> 
     		<td id="azfcl9">&nbsp;</td>
     		<td id="azfclhj">&nbsp;</td>           		     	
     	</tr>
     	</tbody>
     	<tbody id="gdtl" style="display: none;">
     	<tr class="gdtl">
     		<td rowspan="5">供<br>地<br>体<br>量</td>
     		<td>10</td>
     		<td>净地可出让规模(万m^2)</td>
     		<td id="jdkcrgm1">&nbsp;</td>
     		<td id="jdkcrgm2">&nbsp;</td>
     		<td id="jdkcrgm3">&nbsp;</td>
     		<td id="jdkcrgm4">&nbsp;</td>
     		<td id="jdkcrgm5">&nbsp;</td>
     		<td id="jdkcrgm6">&nbsp;</td>
     		<td id="jdkcrgm7">&nbsp;</td>
     		<td id="jdkcrgm8">&nbsp;</td> 
     		<td id="jdkcrgm9">&nbsp;</td>
     		<td id="jdkcrgmhj">&nbsp;</td>        		
     	</tr>
     	<tr class="gdtl"> 
     		<td>11</td>
     		<td>供应规模(万m^2)</td>
     		<td id="gygm1">&nbsp;</td>
     		<td id="gygm2">&nbsp;</td>
     		<td id="gygm3">&nbsp;</td>
     		<td id="gygm4">&nbsp;</td>
     		<td id="gygm5">&nbsp;</td>
     		<td id="gygm6">&nbsp;</td>
     		<td id="gygm7">&nbsp;</td>
     		<td id="gygm8">&nbsp;</td> 
     		<td id="gygm9">&nbsp;</td>
     		<td id="gygmhj">&nbsp;</td>        	
     	</tr>
     	<tr class="gdtl">
     		<td>12</td>
     		<td>储备库库存(万m^2)</td>
     		<td id="cbkc1">&nbsp;</td>
     		<td id="cbkc2">&nbsp;</td>
     		<td id="cbkc3">&nbsp;</td>
     		<td id="cbkc4">&nbsp;</td>
     		<td id="cbkc5">&nbsp;</td>
     		<td id="cbkc6">&nbsp;</td>
     		<td id="cbkc7">&nbsp;</td>
     		<td id="cbkc8">&nbsp;</td> 
     		<td id="cbkc9">&nbsp;</td>
     		<td id="cbkchj">&nbsp;</td>       	
     	</tr> 
     	<tr class="gdtl">
     		<td>13</td>
     		<td>储备库融资能力(亿元)</td>
     		<td id="cbkrznl1">&nbsp;</td>
     		<td id="cbkrznl2">&nbsp;</td>
     		<td id="cbkrznl3">&nbsp;</td>
     		<td id="cbkrznl4">&nbsp;</td>
     		<td id="cbkrznl5">&nbsp;</td>
     		<td id="cbkrznl6">&nbsp;</td>
     		<td id="cbkrznl7">&nbsp;</td>
     		<td id="cbkrznl8">&nbsp;</td> 
     		<td id="cbkrznl9">&nbsp;</td>
     		<td id="cbkrznlhj">&nbsp;</td>        	
     	</tr>
     	<tr class="gdtl">
     		<td>14</td>
     		<td>储备库再融资能力(亿元)</td>
     		<td id="cbkzrznl1">&nbsp;</td>
     		<td id="cbkzrznl2">&nbsp;</td>
     		<td id="cbkzrznl3">&nbsp;</td>
     		<td id="cbkzrznl4">&nbsp;</td>
     		<td id="cbkzrznl5">&nbsp;</td>
     		<td id="cbkzrznl6">&nbsp;</td>
     		<td id="cbkzrznl7">&nbsp;</td>
     		<td id="cbkzrznl8">&nbsp;</td> 
     		<td id="cbkzrznl9">&nbsp;</td>
     		<td id="cbkzrznlhj">&nbsp;</td>        	
     	</tr>
     	</tbody>
     	<tbody id="trzqk" style="display: none;">
     	<tr>
     		<td rowspan="14">投<br>融<br>资<br>情<br>况</td>
     		<td>15</td>
     		<td>年度支出(亿元)</td>
     		<td id="ndzc1">&nbsp;</td>
     		<td id="ndzc2">&nbsp;</td>
     		<td id="ndzc3">&nbsp;</td>
     		<td id="ndzc4">&nbsp;</td>
     		<td id="ndzc5">&nbsp;</td>
     		<td id="ndzc6">&nbsp;</td>
     		<td id="ndzc7">&nbsp;</td>
     		<td id="ndzc8">&nbsp;</td> 
     		<td id="ndzc9">&nbsp;</td>
     		<td id="ndzchj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>16</td>
     		<td>年度收入(亿元)</td>
     		<td id="ndsr1">&nbsp;</td>
     		<td id="ndsr2">&nbsp;</td>
     		<td id="ndsr3">&nbsp;</td>
     		<td id="ndsr4">&nbsp;</td>
     		<td id="ndsr5">&nbsp;</td>
     		<td id="ndsr6">&nbsp;</td>
     		<td id="ndsr7">&nbsp;</td>
     		<td id="ndsr8">&nbsp;</td> 
     		<td id="ndsr9">&nbsp;</td>
     		<td id="ndsrhj">&nbsp;</td>        	
     	</tr> 
     	<tr>
     		<td>17</td>
     		<td>权益性资金规模(亿元)</td>
     		<td id="qyxzjgm1">&nbsp;</td>
     		<td id="qyxzjgm2">&nbsp;</td>
     		<td id="qyxzjgm3">&nbsp;</td>
     		<td id="qyxzjgm4">&nbsp;</td>
     		<td id="qyxzjgm5">&nbsp;</td>
     		<td id="qyxzjgm6">&nbsp;</td>
     		<td id="qyxzjgm7">&nbsp;</td>
     		<td id="qyxzjgm8">&nbsp;</td> 
     		<td id="qyxzjgm9">&nbsp;</td>
     		<td id="qyxzjgmhj">&nbsp;</td>        	
     	</tr>
     	<tr>
     		<td>18</td>
     		<td>年度投资需求(亿元)</td>
     		<td id="ndtzxq1">&nbsp;</td>
     		<td id="ndtzxq2">&nbsp;</td>
     		<td id="ndtzxq3">&nbsp;</td>
     		<td id="ndtzxq4">&nbsp;</td>
     		<td id="ndtzxq5">&nbsp;</td>
     		<td id="ndtzxq6">&nbsp;</td>
     		<td id="ndtzxq7">&nbsp;</td>
     		<td id="ndtzxq8">&nbsp;</td> 
     		<td id="ndtzxq9">&nbsp;</td>
     		<td id="ndtzxqhj">&nbsp;</td>        	
     	</tr>
     	<tr>
     		<td>19</td>
     		<td>年度回笼成本(亿元)</td>
     		<td id="ndhlcb1">&nbsp;</td>
     		<td id="ndhlcb2">&nbsp;</td>
     		<td id="ndhlcb3">&nbsp;</td>
     		<td id="ndhlcb4">&nbsp;</td>
     		<td id="ndhlcb5">&nbsp;</td>
     		<td id="ndhlcb6">&nbsp;</td>
     		<td id="ndhlcb7">&nbsp;</td>
     		<td id="ndhlcb8">&nbsp;</td> 
     		<td id="ndhlcb9">&nbsp;</td>
     		<td id="ndhlcbhj">&nbsp;</td>        	
     	</tr>
     	<tr>
     		<td>20</td>
     		<td>政府土地收益(亿元)</td>
     		<td id="zftdsy1">&nbsp;</td>
     		<td id="zftdsy2">&nbsp;</td>
     		<td id="zftdsy3">&nbsp;</td>
     		<td id="zftdsy4">&nbsp;</td>
     		<td id="zftdsy5">&nbsp;</td>
     		<td id="zftdsy6">&nbsp;</td>
     		<td id="zftdsy7">&nbsp;</td>
     		<td id="zftdsy8">&nbsp;</td> 
     		<td id="zftdsy9">&nbsp;</td>
     		<td id="zftdsyhj">&nbsp;</td>          	
     	</tr> 
     	<tr>
     		<td>21</td>
     		<td>年度融资需求(亿元)</td>
     		<td id="ndrzxq1">&nbsp;</td>
     		<td id="ndrzxq2">&nbsp;</td>
     		<td id="ndrzxq3">&nbsp;</td>
     		<td id="ndrzxq4">&nbsp;</td>
     		<td id="ndrzxq5">&nbsp;</td>
     		<td id="ndrzxq6">&nbsp;</td>
     		<td id="ndrzxq7">&nbsp;</td>
     		<td id="ndrzxq8">&nbsp;</td> 
     		<td id="ndrzxq9">&nbsp;</td>
     		<td id="ndrzxqhj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>22</td>
     		<td>年度还款需求(亿元)</td>
     		<td id="ndhkxq1">&nbsp;</td>
     		<td id="ndhkxq2">&nbsp;</td>
     		<td id="ndhkxq3">&nbsp;</td>
     		<td id="ndhkxq4">&nbsp;</td>
     		<td id="ndhkxq5">&nbsp;</td>
     		<td id="ndhkxq6">&nbsp;</td>
     		<td id="ndhkxq7">&nbsp;</td>
     		<td id="ndhkxq8">&nbsp;</td> 
     		<td id="ndhkxq9">&nbsp;</td>
     		<td id="ndhkxqhj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>23</td>
     		<td>债务资金使用规模</td>
     		<td id="zwzjsygm1">&nbsp;</td>
     		<td id="zwzjsygm2">&nbsp;</td>
     		<td id="zwzjsygm3">&nbsp;</td>
     		<td id="zwzjsygm4">&nbsp;</td>
     		<td id="zwzjsygm5">&nbsp;</td>
     		<td id="zwzjsygm6">&nbsp;</td>
     		<td id="zwzjsygm7">&nbsp;</td>
     		<td id="zwzjsygm8">&nbsp;</td> 
     		<td id="zwzjsygm9">&nbsp;</td>
     		<td id="zwzjsygmhj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>24</td>
     		<td>自有资金使用规模</td>
     		<td id="zyzjsygm1">&nbsp;</td>
     		<td id="zyzjsygm2">&nbsp;</td>
     		<td id="zyzjsygm3">&nbsp;</td>
     		<td id="zyzjsygm4">&nbsp;</td>
     		<td id="zyzjsygm5">&nbsp;</td>
     		<td id="zyzjsygm6">&nbsp;</td>
     		<td id="zyzjsygm7">&nbsp;</td>
     		<td id="zyzjsygm8">&nbsp;</td> 
     		<td id="zyzjsygm9">&nbsp;</td>
     		<td id="zyzjsygmhj">&nbsp;</td>          	
     	</tr> 
     	
     	<tr>
     		<td>25</td>
     		<td>权益性资金注入(亿元)</td>
     		<td id="qyxzjzr1">&nbsp;</td>
     		<td id="qyxzjzr2">&nbsp;</td>
     		<td id="qyxzjzr3">&nbsp;</td>
     		<td id="qyxzjzr4">&nbsp;</td>
     		<td id="qyxzjzr5">&nbsp;</td>
     		<td id="qyxzjzr6">&nbsp;</td>
     		<td id="qyxzjzr7">&nbsp;</td>
     		<td id="qyxzjzr8">&nbsp;</td> 
     		<td id="qyxzjzr9">&nbsp;</td>
     		<td id="qyxzjzrhj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>26</td>
     		<td>负债余额(亿元)</td>
     		<td id="fzye1">&nbsp;</td>
     		<td id="fzye2">&nbsp;</td>
     		<td id="fzye3">&nbsp;</td>
     		<td id="fzye4">&nbsp;</td>
     		<td id="fzye5">&nbsp;</td>
     		<td id="fzye6">&nbsp;</td>
     		<td id="fzye7">&nbsp;</td>
     		<td id="fzye8">&nbsp;</td> 
     		<td id="fzye9">&nbsp;</td>
     		<td id="fzyehj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>27</td>
     		<td>储备库融资缺口(亿元)</td>
     		<td id="cbkrzqk1">&nbsp;</td>
     		<td id="cbkrzqk2">&nbsp;</td>
     		<td id="cbkrzqk3">&nbsp;</td>
     		<td id="cbkrzqk4">&nbsp;</td>
     		<td id="cbkrzqk5">&nbsp;</td>
     		<td id="cbkrzqk6">&nbsp;</td>
     		<td id="cbkrzqk7">&nbsp;</td>
     		<td id="cbkrzqk8">&nbsp;</td> 
     		<td id="cbkrzqk9">&nbsp;</td>
     		<td id="cbkrzqkhj">&nbsp;</td>          	
     	</tr>
     	<tr>
     		<td>28</td>
     		<td>年度账面余额(亿元)</td>
     		<td id="ndzmye1">&nbsp;</td>
     		<td id="ndzmye2">&nbsp;</td>
     		<td id="ndzmye3">&nbsp;</td>
     		<td id="ndzmye4">&nbsp;</td>
     		<td id="ndzmye5">&nbsp;</td>
     		<td id="ndzmye6">&nbsp;</td>
     		<td id="ndzmye7">&nbsp;</td>
     		<td id="ndzmye8">&nbsp;</td> 
     		<td id="ndzmye9">&nbsp;</td>
     		<td id="ndzmyehj">&nbsp;</td>          	
     	</tr>  
     	</tbody>   	    	     	     	    	     	     	
     </table>
  </body>
</html>
