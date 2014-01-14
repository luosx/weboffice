<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
  </script>
  <body>
  <div align="center">
		年度： <select id='year'
			onchange="change(this.options[this.options.selectedIndex].value)">
			<option value=2010>2010</option>
			<option value=2011>2011</option>
			<option value=2012>2012</option>
			<option value=2013>2013</option>
			<option value=2014 selected='selected'>2014</option>
			<option value=2015>2015</option>
			<option value=2016>2016</option>
			<option value=2017>2017</option>
			<option value=2018>2018</option>
			<option value=2019>2019</option>
			<option value=2020>2020</option>
		</select> 月份： <select id='month'
			onchange="change(this.options[this.options.selectedIndex].value)">
			<option value=1 >1</option>
			<option value=2 selected="selected">2</option>
			<option value=3>3</option>
			<option value=4>4</option>
			<option value=5>5</option>
			<option value=6>6</option>
			<option value=7>7</option>
			<option value=8>8</option>
			<option value=9>9</option>
			<option value=10>10</option>
			<option value=11>11</option>
			<option value=12>12</option>
		</select>
	</div>
  	 <div id='show'>
  		<%=new CBDReportManager().getReport("ESFQK",new Object[] {"2014","2"},"1000px")%>
  	</div>
  	<div id="news"></div>
  	
  </body>
</html>
