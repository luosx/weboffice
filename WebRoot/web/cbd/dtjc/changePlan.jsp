<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.hxxm.jdjh.JhHandler" %>
<%@page import="com.klspta.web.cbd.hxxm.jdjh.DataManager"%>
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
			border-bottom:1px #000000 solid;
			border-right:1px #000000 solid;
			border-color:#E2EAF3;
			cursor:hand;
			}
		.no{
			background-color:#ffffff;
			width:50px;
		}
		.yes{
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
		
		//添加ctrl + "z"回退事件
		document.onkeydown = function(ev){
			var oevent = ev || event;
			if(oevent.ctrlKey && oevent.keyCode == 90){
				callback();
			}
		}

 		//document.onmousedown = mouseMove;
  </script>
  <body>
  	<div id="showDiv" class="divstyle" style="display:none;">
  	  <table border="0px;" style="width:80px; height:30px;" cellpadding="0px" cellspacing="0px" >
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
	<div>
		<table id='planTable' border=1 style="text-align: center; font: normal 13px verdana;" cellpadding="0" cellspacing="0"  >
				<thead>
					<tr  style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
						<td colspan='1' width="140" >
							<label>项目名称</label>				
						</td>
						<td colspan=4 width="200">
							<label>2012</label>	
						</td>
						<td colspan="4" width="200">
							<label>2013</label>
						</td>
						<td colspan="4" width="200">
							<label>2014</label>
						</td>
						<td colspan="4" width="200">
							<label>2015</label>
						</td>
					</tr>
				</thead>
				<tbody id='kftl'>
					<tr>
						<td><label>公交总公司项目</label></td>
						<td class="no"  onMouseOver="hiddleDiv(); return false;" ></td>
						<td class="no"  onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no"  onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onClick="changePlan(this, 1); return false;" >1</td>
						<td class="yes" onClick="changePlan(this, 1); return false;" >2</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >3</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >4</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >5</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >6</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >7</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
					</tr>
					<tr>
						<td><label>国华热电厂项目二期</label></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;">8</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;">9</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >10</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >11</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOut="changePlan(this, 1); return false;" >12</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >13</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >14</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
					</tr>
					<tr>
						<td><label>首经贸大学项目</label></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >15</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;">16</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >16</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >18</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >19</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >20</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >21</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
					</tr>
										<tr>
						<td><label>国华热电厂项目二期</label></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >22</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;">23</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >24</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >25</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >26</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >27</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >28</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
					</tr>
										<tr>
						<td><label>国华热电厂项目三期</label></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >30</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;">31</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >32</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >33</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >34</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >35</td>
						<td class="yes" onMouseOver="changePlan(this, 1); return false;" >36</td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
						<td class="no" onMouseOver="hiddleDiv(); return false;"></td>
					</tr>
				</tbody>
		</table>
	</div>
	<div id="planDetail" class="planDetail">
	
	
	</div>
	 <div id="showDetail" class="showDetail" style="display:none;"> 

		<table align="center" style="font-size:12px; width:300px; display:none;">
			<tr align="center">
				<td colspan="4">
					<label>开发时序</label>
				</td>
			</tr>
			<tr>
			  <td width="38">年度</td>
				<td class="inputstyle" width="120">
					<input type="text" id="nd" name="nd" width="38" />
			  </td>
				<td width="41" ><label>季度</label></td>
				<td width="81">
					<input type="text" id="jd" name="jd" width="50px" />
			  </td>
			</tr>
		</table>
		<table align="center" style="font-size:12px; width:300px;">
			<tr>
				<td width="80px;"><label>户数</label></td>
				<td>
					<input type="text" id="hs" name="hs" width="40px" />
				</td>
				<td>
					<input type="text" id="hsz" name="hsz" width="40px" />
					<label>%</label>
				</td>
			</tr>
			<tr>
				<td><label>地量</label></td>
				<td>
					<input type="text" id="dl" name="dl" width="80px" />
				</td>
				<td>
					<input type="text" id="dlz" name="dlz" width="80px" />
					<label>%</label>
				</td>
			</tr>
			<tr>
				<td><label>规模</label></td>
				<td>
					<input type="text" id="gm" name="gm" width="80px" />
				</td>
				<td>
					<input type="text" id="gmz" name="gm" width="80px" />
					<label>%</label>
				</td>
			</tr>
			<tr>
				<td><label>投资</label></td>
				<td>
					<input type="text" id="tz" name="tz" width="80px" />
				</td>
				<td>
					<input type="text" id="tzz" name="tzz" width="80px" />
					<label>%</label>
				</td>
			</tr>
			<tr>
				<td><label>住</label></td>
				<td>
					<input type="text" id="zhu" name="zhu" width="80px" />
				</td>
				<td>
					<input type="text" id="zhuz" name="zhuz" width="80px" />
					<label>%</label>
				</td>
			</tr>
			<tr>
				<td><label>企</label></td>
				<td>
					<input type="text" id="qi" name="qi" width="80px" />
				</td>
				<td>
					<input type="text" id="qiz" name="qiz" width="80px" />
					<label>%</label>
				</td>
			</tr>
			<tr>
				<td><label>楼面价</label></td>
				<td colspan="2">
					<input type="text" id="lm" name="lm" width="80" />
				</td>
			</tr>
			<tr>
				<td><label>成交价</label></td>
				<td colspan="2">
					<input type="text" id="cj" name="cj" width="80" />
				</td>
			</tr>
		</table>
	 </div>
  </body>
</html>
