<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "oldTable";
String keyIndex = "1";
ITableStyle its = new TableStyleEditRow();
String year = Calendar.getInstance().get(Calendar.YEAR)+"";		
String month = Calendar.getInstance().get(Calendar.MONTH)+1+"";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="web/cbd/qyjc/esfzj/js/esfRowEditor.js"></script>
	<%@ include file="js/reportEdit.jspf"%>
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
			background-color: #969696;
		    font-weight:bold;
		    font-size: 15px;
		    text-align:center;
		    line-height: 30px;
			margin-top: 3px;
		  }
	  	.trtotal{
	  		background-color: #C0C0C0;
		  	text-align:center;
		    font-weight:bold;
		    line-height: 30px;
		   }
	  	.trsingle{
		    background-color: #D1E5FB;
		    line-height: 20px;
		    text-align:center;
		   }
		
	</style>
  </head>
  <script type="text/javascript">
  function change(day) {

		var yearObj = document.getElementById("year");
		var year = yearObj.options[yearObj.selectedIndex].text;
		var monthObj = document.getElementById("month");
		var month = monthObj.options[monthObj.selectedIndex].text;
		var news=document.getElementById("news");
		var table=document.getElementById("ESFQK");
		putClientCommond("scjcManager", "query_year_month");
		putRestParameter("year", year);
		putRestParameter("month", month);
		var reslut = restRequest();
		deleteDiv();
		news.innerHTML=reslut;
		
	}
	
	function deleteDiv() {
		var my = document.getElementById("ESFQK");
		if (my != null)
			my.parentNode.removeChild(my);
	}
	
	function init(){
		var year = "<%=year%>";
		var my = document.getElementById(year);
		my.selected = true;
		my.text = year;
		var month = "<%=month%>";
		document.getElementById(month).selected=true;
		
	}
  </script>
  <body onload="init();">
  <div align="center">
		年度： <select id='year'
			onchange="change(this.options[this.options.selectedIndex].value)">
			<option id="2010" value=2010>2010</option>
			<option id="2011" value=2011>2011</option>
			<option id="2012" value=2012>2012</option>
			<option id="2013" value=2013>2013</option>
			<option id="2014" value=2014>2014</option>
			<option id="2015" value=2015>2015</option>
			<option id="2016" value=2016>2016</option>
			<option id="2017" value=2017>2017</option>
			<option id="2018" value=2018>2018</option>
			<option id="2019" value=2019>2019</option>
			<option id="2020" value=2020>2020</option>
			<option id="2021" value=2021>2021</option>
			<option id="2022" value=2022>2022</option>
			<option id="2023" value=2023>2023</option>
			<option id="2023" value=2024>2024</option>
			<option id="2025" value=2025>2025</option>
			<option id="2026" value=2026>2026</option>
			<option id="2027" value=2027>2027</option>
			<option id="2028" value=2028>2028</option>
			<option id="2029" value=2029>2029</option>
			<option id="2030" value=2030>2030</option>
		</select> 月份： <select id='month'
			onchange="change(this.options[this.options.selectedIndex].value)">
			<option id="1" value=1 >1</option>
			<option id="2" value=2 >2</option>
			<option id="3" value=3>3</option>
			<option id="4" value=4>4</option>
			<option id="5" value=5>5</option>
			<option id="6" value=6>6</option>
			<option id="7" value=7>7</option>
			<option id="8" value=8>8</option>
			<option id="9" value=9>9</option>
			<option id="10" value=10>10</option>
			<option id="11" value=11>11</option>
			<option id="12" value=12>12</option>
		</select>
	</div>
  	 <div id='show'>
  		<%=new CBDReportManager().getReport("ESFQK",new Object[] {year,month,"false"},its,"1000px")%>
  	</div>
  	<div id="news"></div>
  	
  </body>
</html>
