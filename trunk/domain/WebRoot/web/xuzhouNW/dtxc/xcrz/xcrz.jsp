<%@page language="java" pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Object principalUser = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>" />
		<TITLE>巡查日志</TITLE>
		<%@ include file="/base/include/restRequest.jspf"%>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<script>
		
		</script>
	</head>

	<body bgcolor="#FFFFFF">
		<div style="margin: 20px" align="center">
			<div align="center">
				<h1>
					国土资源执法监察巡查日志
				</h1>
			</div>
			<form method="post">
				<div style="width: 100%;">
					<span style="margin-left: 330px;">巡查编号：<input type="text" name="xcbh" id="xcbh"
							style="width: 150px; background-color: transparent; border: 0px;">
					</span>
				</div>
				<table id="xcrztable" class="lefttopborder1" cellspacing="0"
					cellpadding="0" border="1" bgcolor="#FFFFFF" bordercolor="#000000"
					width="600">
					<tr>
						<td height="16" colspan="2">
							<div align="center">
								巡查单位
							</div>
						</td>
						<td width="166">
							<input type="text" class="noborder" name="xcdw" id="xcdw" style="width: 97%" />
						</td>
						<td width="102">
							<div align="center">
								巡查日期
							</div>
						</td>
						<td width="211">
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="xcrq"
								id="xcrq" readonly="readonly" style="width: 97%" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								巡查区域
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="xcqy" id="xcqy" style="width: 99%" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								巡查人员
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="xcry" id="xcry" style="width: 99%" />
						</td>
					</tr>
					<tr>
						<td height="21" colspan="2">
							<div align="center">
								巡查路线
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="xclx" id="xclx" style="width: 99%" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								是否有违法
							</div>
						</td>
						<td colspan="3">
							<div align="left">
								&nbsp;&nbsp;
								<input type="radio" name="sfywf" id="sfywf" value="是" />
								是&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="sfywf" id="sfywf" value="否" />
								否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="add" value="增加" onclick="addcgd()" />
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="delete" value="删除" onclick="deletecgd()" />
							</div>
						</td>
					</tr>
					
					
					<tr>
						<td rowspan="4">
							<div align="center">
								<input type="checkbox" id="check1" />
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm1" id="jsxm1" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw1" id="jsdw1" style="width: 97%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj1"
								id="dgsj1" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk1" id="jsqk1" style="width: 97%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj1" id="zdmj1" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz1" id="zdwz1" style="width: 97%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<a href="javascript:void(0);">抄告单未生成</a>
						</td>
					</tr>
					
					
					<tr>
						<td width="40" rowspan="2">
							<p align="center">
								巡
							</p>
							<p align="center">
								查
							</p>
							<p align="center">
								内
							</p>
							<p align="center">
								容
							</p>
						</td>
						<td width="82">
							<div align="center">
								项目
								<br />
								建设
								<br />
								及用
								<br />
								地手
								<br />
								续审
								<br />
								批情
								<br />
								况
							</div>
						</td>
						<td colspan="3">
							<textarea rows="15" name="spqk" id="spqk" style="width: 99%"></textarea>
						</td>
					</tr>

					<tr>
						<td>
							<div align="center">
								对所
								<br />
								建项
								<br />
								目的
								<br />
								处理
								<br />
								意见
								<br />
							</div>
						</td>
						<td colspan="3">
							<textarea rows="10" name="clyj" id="clyj" style="width: 99%"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								备注
							</div>
						</td>
						<td colspan="3">
							<textarea rows="6" name="bz" id="bz" style="width: 99%"></textarea>
						</td>
					</tr>
				</table>
				<input type="text" value="" id="writexzqh" name="writexzqh" style="display: none" />
			</form>
		</div>
	</body>
	<script>
	
	</script>
</html>