<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="<%=basePath%>/base/include/ajax.js"></script>
</head>

<script>
	function buildExc(){
		var checked = document.getElementsByTagName("input");
		var form = document.forms[0];
		form.action = "<%=basePath%>/service/rest/mxbaction/report"
		form.submit();
	}
 
</script>

<body>
<form action="" methoid="post" >
	<div align="center">
		<label>信 息 统 计 </label>
	</div>
	<table align="center">
		<tbody>
			<tr>
				<td align="left">
					<input type="checkbox" id="ajblr" value="1" name="ajblr" checked />
					<label for="ajblr">案件办理人 </label>
				</td>
				
				<td align="left">
					<input type="checkbox" id="yddw" value="1" name="yddw" checked />
					<label for="yddw">用地单位</label>
				</td>
				
				<td align="left">
					<input type="checkbox" id="byddw" value="1" name = "zdwz" checked  />
					<label for="byddw">宗地位置</label>
				</td>
			</tr>
			
			<tr>
				<td align="left">
					<input type="checkbox" id="jsxm" value="1" name="jsxm" checked />
					<label for="jsxm">建设项目</label>
				</td>
				<td align="left">
					<input type="checkbox" id="wfydsj" value="1" name="wfydsj" checked />
					<label for="wfydsj">违法用地时间</label> 				
				</td>
				<td align="left">
					<input type="checkbox" id="wfydxz" value="1" name="wfydxz" checked />
					<label for="wfydxz">违法用地性质</label>
				</td>
			</tr>
			
			<tr>
				<td align="left">
					<input type="checkbox" id="tdxz" value="1" name="tdxz" checked />
					<label for="tdxz">土地性质</label>
				</td>
				<td align="left">
					<input type="checkbox" id="zmj" value="1" checked />
					<label for="zmj">总面积</label>
				</td>
				<td align="left">
					<input type="checkbox" id="fhtdlyztgh" value="1" name="fhtdlyztgh" checked />
					<label for="fhtdlyztgh">符合土地利用总体规划</label>
				</td>
			</tr>
		
			<tr>
				<td align="left" >
					<input type="checkbox" id="zdlx" name="zdlx" value="1" checked />
					<label for="zdlx">占地类型</label>
				</td>
				<td align="left">
					<input type="checkbox" id="jzmj" value="1" checked />
					<label for="jzmj">建筑面积</label>
				</td>
				<td align="left">
					<input type="checkbox" id="fxsj" value="1" checked />
					<label for="fxsj">发现时间</label>
				</td>	
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="tgtzbh" value="1" checked />
					<label for="tgtzbh">停工通知编号</label>	
				</td>
				<td>
					<input type="checkbox" id="lasj" value="1" checked />
					<label for="lasj">立案时间</label>
				</td>
				<td>
					<input type="checkbox" id="labh" value="1" checked />
					<label for="labh">立案编号</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="cfgzbh" value="1" checked />
					<label for="cfgzbh">处罚告知编号</label>
				</td>
				<td>
					<input type="checkbox" id="tzsj" value="1" checked />
					<label for="tzsj">听证时间 </label>
				</td>
				<td>
					<input type="checkbox" id="xdcfsj" value="1" checked />
					<label for="xdcfsj">下达处罚时间</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="jyzjzrrqk" value="1" checked />
					<label for="jyzjzrrqk">建议追究责任人情况</label>
				</td>
				<td>
					<input type="checkbox" id="cdbqk" value="1" checked />
					<label for="cdbqk">催(督)办情况</label>
				</td>
				<td>
					<input type="checkbox" id="cfjdlsqk" value="1" checked />
					<label for="cfjdlsjk">处罚决定落实情况</label>
				</td>
			</tr>
			
			<tr>
				<td>
					<input type="checkbox" id="zrrzjqk" value="1" checked />
					<label for="zrrzjqk">责任人追究情况</label>
				</td>
				<td>
					<input type="checkbox" id="sqfyqzzxqk" value="1" checked />
					<label for="sqfyqzzxqk">申请法院强制执行情况</label>
				</td>
				<td>
					<input type="checkbox" id="zygbmwssxqk" value="1" checked />
					<label for="zygbmwssxqk">转有关部门完善手续情况</label>
				</td>
			</tr>
			
			
		</tbody>
	</table>
</form>

<table align="center">
	<tbody>
		<tr >
			<td align="center">
				<input class=button type="button" onClick="buildExc();" value="确定"  />
			</td>
		</tr>
	</tbody>
</table>

</body>
</html>
