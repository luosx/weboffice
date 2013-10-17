<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>自然斑列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  <style type="text/css">
  	.list_title_c{ height:36px; text-align:center; margin-top:3px;border-bottom:1px solid #bddafe;}
	.list_title_l{ height:36px; text-align:center; margin-top:3px;}
	.tableheader{color:#48afbe;font-size: 14px;height:35px;width:100%;background-color:#e6f0fd;font-weight:bold;margin-bottom:0px;border-bottom:1px solid #C2D6F0;}
  	.searchinput{ border:1px solid #C2D6F0;}
  </style>
  <script type="text/javascript">
  		function searchValue(){
		
		}
		function checkValue(){
		
		}
		
		function search(){
		
		}
		
		function add(){
		
		}
  		
		//鼠标移动到按钮上时，修改鼠标形状
		function changeHand(check){
			check.style.cursor="hand";
		}
		
		//鼠标形状恢复默认
		function changeDefault(check){
			check.style.cursor="default";
		}
		
		//显示细节
		function showDetail(check){
		
		}
		
		//删除当前项目
		function deleteTB(check){
			alert("delete");
			document.getElementById("body").innerHTML = null;
			document.getElementById("body").outerHTML = "<tbody id='body'></tbody>";
			//document.getElementById
		}
		
		
  </script>
  <body>
  	<div style="height:30px;" align="left">
		<input type="text" id="keyWord" class="searchinput" onClick="searchValue(); return false;" onBlur="checkValue(); return false;" style="width:40%;border:1px solid #C2D6F0; line-height:18px; height:25px; margin-top:10px; margin-bottom:5px" value="请输入关键字..."/>&nbsp;&nbsp;
		<input type="button" onclick='search(); return false;' onMouseOver="changeHand(this); return false;" style="margin-bottom:5px; height:25px; background:#e6f0fd; width:60px; border:1px solid #bddafe " value="搜索" />&nbsp;&nbsp;
		<input type="button" onclick='add(); return false;' onMouseOver="changeHand(this); return false;" style="margin-bottom:5px; height:25px ; background:#e6f0fd; width:60px; border:1px solid #bddafe" value="增加" />&nbsp;&nbsp;	
	</div>
  	<div>
		<table  cellpadding="0" cellspacing="0" style="border-top: 2px #2d8ade solid;" align="center" width="100%" >
			<tr class="tableheader" >
				<td rowspan="2"  class="list_title_c" style="border-left:1px solid #bddafe; border-right:1px solid #bddafe;"><label>序号</label></td>
				<td rowspan="2" class="list_title_c" style="border-right:1px solid #bddafe;"><label>编号</label></td>
				<td rowspan="2" class="list_title_c" style="border-right:1px solid #bddafe;"><label>占地<br/>面积</label></td>
				<td colspan="2" class="list_title_c" style="border-right:1px solid #bddafe; border-bottom:1px solid #bddafe;"><label>总计</label></td>
				<td colspan="3" class="list_title_c" style="border-right:1px solid #bddafe; border-bottom:1px solid #bddafe;"><label>住宅拆迁(户、人、㎡)</label></td>
				<td colspan="2" class="list_title_c" style="border-right:1px solid #bddafe; border-bottom:1px solid #bddafe;"><label>非住宅拆迁(㎡)</label></td>
				<td rowspan="2" class="list_title_c" style="border-right:1px solid #bddafe; width:200px;"><label>备注</label></td>
				<td rowspan="2" class="list_title_c" style="border-right:1px solid #bddafe;"><label>删除</label></td>
			</tr>
			<tr class="tableheader" >
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>楼座面积</label></td>
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>拆迁规模</label></td>
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>住宅楼座<br/>面积</label></td>
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>住宅拆迁<br/>规模</label></td>
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>预计户数</label></td>
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>非住宅<br/>楼座面积</label></td>
				<td class="list_title_c" style="border-right:1px solid #bddafe; "><label>非住宅<br/>拆迁规模</label></td>
			</tr>
			<tbody id="body">
			<tr align="center" style="height:25px; font-family:'宋体','Verdana'; " onDblClick="showDetail(this);return false;" >
				<td><label>1</label></td>
				<td><label>A-101小计</label></td>
				<td><label>3520</label></td>
				<td><label>2000</label></td>
				<td><label>28405</label></td>
				<td><label>1889</label></td>
				<td><label>28294</label></td>
				<td><label>472</label></td>
				<td><label>111</label></td>
				<td><label>111</label></td>
				<td><label>a<br/>a<br/>a</label></td>
				<td><img src="web/cbd/yzt/images/delete.jpg" style="width:20px; height:20px" onMouseOver="changeHand(this); return false;" onClick="deleteTB(this); return false;"></td>
			</tr>
			<tr align="center" style=" background-color:#e6f0fd; height:25px; font-family:'宋体','Verdana';" onDblClick="showDetail(this); return false;">
				<td><label>2</label></td>
				<td><label>A-102小计</label></td>
				<td><label>1571</label></td>
				<td><label>963</label></td>
				<td><label>14508</label></td>
				<td><label>903</label></td>
				<td><label>144448</label></td>
				<td><label>241</label></td>
				<td><label>60</label></td>
				<td><label>60</label></td>
				<td></td>
				<td><img src="web/cbd/yzt/images/delete.jpg" style="width:20px; height:20px" onMouseOver="changeHand(this); return false;" onClick="deleteTB(this); return false;"></td>
			</tr>
			</tbody>
		</table>
	</div>
	
	
  
  </body>
</html>
