<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.hxxm.jdjh.JhHandler" %>
<%@page import="com.klspta.web.cbd.hxxm.jdjh.DataManager"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbManager"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbBuild"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbData"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Map planYear = DataManager.getInstance().getPlanYear();
int width = Integer.parseInt(String.valueOf(planYear.get("maxyear"))) - Integer.parseInt(String.valueOf(planYear.get("minyear")));
	width = width * 1200 + 490;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>实施计划编辑页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script type="text/javascript" src="web/cbd/dtjc/js/modify.js"></script>
	<script type="text/javascript" src="web/cbd/dtjc/js/changePlan.js"></script>
	<script type="text/javascript" src="web/cbd/dtjc/js/planStack.js"></script>
	<script type="text/javascript" src="web/cbd/dtjc/js/movePlan.js"></script>
	<style type="text/css">
		table{
			border-left:1px #000000 solid;
			border-top:1px #000000 solid;
			border-color:#E2EAF3;
		}
		td{
			border-right:1px #000000 solid;
			border-color:#E2EAF3;
			cursor:hand;
			}
		tr{
			height:30px;
			
		}
		.no{
			border-right:0px #000000 solid;
			width:50px;
		}
		.yes{
			border-right:0px #000000 solid;
			background-color:#66FF00;
			width:50px;
		}
		.divstyle{
			width:80px;
			height:30px;
			left:0px;
			top:0px;
			position:absolute;
			background-color:#E2EAF3;
			filter:alpha(opacity=90);
		}
		.showDetail{
			font-size:12px;
			width:300px;
			height:200px;
			left:100px;
			top:100px;
			position:absolute;
			background-color:#E2EAF3;
			filter:alpha(opacity=90);
		}
		.planDetail{
			width:300px;
			height:200px;
			right:5px;
			top:5px;
			position:absolute;
			background-color:#E2EAF3;
		}
		.spring{
			background-color:#0BF72C;
		}
		.summer{
			background-color:#F3FB1E;
		}
		.fall{
			background-color:#231EFB
		}
		.winter{
			background-color:#5B0985
		}
		.kftltr{
			border-bottom:1px #0C1289 solid;
		}
	</style>
  </head>
  <script type="text/javascript" >
  		

	  		//记录位置
		var row = 0;
		var cell = 0;
		var step = 1;
		var positionX = 0;
		var positionY = 0;
		var divName = "showDiv";
		var minyear = "<%=TjbbBuild.MIN_YEAR%>";		
		var kftlNum = "<%=new TjbbData().getKFTLProject().size()%>";
		
		
		//添加ctrl + "z"回退事件
		document.onkeydown = function(ev){
			var oevent = ev || event;
			if(oevent.ctrlKey && oevent.keyCode == 90){
				callback();
			}
		}

  </script>
  <body>
  	<div id="showDiv" class="divstyle" style="display:none;" onDblClick="showDetail(); return false;">
  	  <table  style="width:80px; height:30px;" cellpadding="0px" cellspacing="0px" >
	  	<!--
	  	<tr>
			<td colspan="2" align="right">
				<label style="color:#FF0000" onClick="hiddleDiv(); return false;"> X </label>&nbsp;&nbsp;
			</td>
		</tr>
	  	<tr>
			<td colspan="2" align="center">
				<input type="button" value="查看详细" onClick="showDetail(); return false;">
			</td>
		</tr>
		-->
		<tr>
			<td align="center" bordercolor="">
				<label onClick="moveLeft(); return false;"><</label>
			</td>
			<td align="center">
				<label onClick="moveRight(); return false;">></label>
			</td>
		</tr>
	  </table>
  	</div>
	<div style="width:150%;">
		 <table id='planTable'  style="text-align: center; font: normal 14px verdana; border:none;" cellpadding="0" cellspacing="0"   >
			<%=TjbbManager.getKFTLPlan()%>
		</table>
	</div>
		 	<div id="addWin" class="x-hidden">
		</div>
				 	<div id="addWin2" class="x-hidden">
		</div>
  </body>
</html>
