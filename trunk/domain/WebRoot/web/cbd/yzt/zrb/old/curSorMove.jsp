<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'curSorMove.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
		.moveLeft{
		cursor:url("http://img2.cache.netease.com/utf8/gallery/img/cursor_left.cur");
		}
		
		.moveRight{
		cursor:url("http://img2.cache.netease.com/utf8/gallery/img/cursor_right.cur");
		}
	
	
	</style>

  </head>
  <script type="text/javascript">
  		function moveLeft(check, step){
  			
			var table = document.getElementById("table");
			var cell = check.cellIndex;
			var row = check.parentElement.rowIndex;
			//将fieldvalue前一以为
			if(cell >= step){
				var newcell = table.rows[row].cells[cell - step];
				newcell.innerHTML = check.innerHTML;
				check.innerHTML = "";
				newcell.onclick = function(){
					moveLeft(this, 1);
				};
				check.onclick = function(){
				}
				var oldclass = newcell.className;
				newcell.className = check.className;
				check.className	= oldclass;
			}else{
				alert("已在最前，无法前移动");
			}
		
		}
		
		function moveRight(check, step){
			var table = document.getElementById("table");
			var cell = check.cellIndex;
			var row = check.parentElement.rowIndex;
			//将fieldvalue前一以为
			if(cell >= step){
				var newcell = table.rows[row].cells[cell - step];
				newcell.innerHTML = check.innerHTML;
				check.innerHTML = "";
				newcell.onclick = function(){
					moveLeft(this, 1);
				};
				check.onclick = function(){
				}
				var oldclass = newcell.className;
				newcell.className = check.className;
				check.className	= oldclass;
			}else{
				alert("已在最后，无法向后移动");
			}
		
		
		}
		  
  </script>
  <body>
  <table width="200" border="1" id="table">
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td >&nbsp;</td>
      <td class="moveLeft" onClick="moveLeft(this, 1)"><label>前移一位</label></td>
      <td class="moveRight" onClick="moveRight(this, 1)"><label>后移一位</label></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <br>
  </body>
</html>
