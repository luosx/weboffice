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
		//用来计数抄告单,0表示抄告单隐藏，1表示抄告单显示
		var count = new Array(0,0,0,0,0);
		
		//全部tr标签元素
		var arr = document.getElementsByTagName("tr");
		
		//是否违法按钮的选择
		function selectwf(sele){
			var add = document.getElementById("add");
			var del = document.getElementById("del");
			if(sele.value == '是'){
				add.style.display = "";
				del.style.display = "";
			}
			if(sele.value == '否'){
				add.style.display = "none";
				del.style.display = "none";
			}
		}
		
		//添加抄告单
		function addcgd(){
			//第一个抄告单
			if(count[0] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check1"){
						arr[i].style.display = "block";
					}
				}
				count[0] = 1;
				return;
			}
			//第二个抄告单
			if(count[1] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check2"){
						arr[i].style.display = "block";
					}
				}
				count[1] = 1;
				return;
			}
			//第三个抄告单
			if(count[2] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check3"){
						arr[i].style.display = "block";
					}
				}
				count[2] = 1;
				return;
			}
			//第四个抄告单
			if(count[3] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check4"){
						arr[i].style.display = "block";
					}
				}
				count[3] = 1;
				return;
			}
			//第五个抄告单
			if(count[4] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check5"){
						arr[i].style.display = "block";
					}
				}
				count[4] = 1;
				return;
			}
		}
		
		//删除抄告单
		function deletecgd(){
			var checkbox = document.getElementsByName("checkbox");
			for(var i = 0; i < checkbox.length ; i++){
				if(checkbox[i].checked == true){
					var temp = checkbox[i].id;
					for(var j = 0; j < arr.length ; j++){
						if(arr[j].name == temp){
							arr[j].style.display = "none";
							//截取到表示抄告单位置的数字
							var tempNum = new Number(temp.charAt(5));
							//将相应位置修改状态
							count[tempNum-1] = 0;
						}
					}
				}
			}
		}
		
		//保存表单方法
		function save(){
			document.forms[0].submit();
		}
		</script>
	</head>

	<body bgcolor="#FFFFFF">
		<!-- 用来放置保存、打印按钮图标 -->
		<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
		<div style="margin: 20px" align="center">
			<div align="center">
				<h1>
					国土资源执法监察巡查日志
				</h1>
			</div>
			<form method="post">
				<div style="width: 100%;">
					<span style="margin-left: 330px;">巡查编号：<input type="text" name="xcbh" id="xcbh" readonly="readonly"
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
								<input type="radio" name="sfywf" id="sfywf" value="是" onclick="selectwf(this)"/>
								是&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="sfywf" id="sfywf" value="否" onclick="selectwf(this)"/>
								否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="add" value="增加" onclick="addcgd()" style="display:none;"/>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="del" value="删除" onclick="deletecgd()" style="display:none;"/>
							</div>
						</td>
					</tr>
					
					<!-- 
						五个抄告单
					 -->
					<!-- 第一个 -->
					<tr name="check1" style="display:none;">
						<td rowspan="4">
							<div align="center">
								<input type="checkbox" id="check1" name="checkbox"/>
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
					<tr name="check1" style="display:none;">
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
					<tr name="check1" style="display:none;">
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
					<tr name="check1" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div><span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" style="text-decoration:none">生成抄告单</a></div>
						</td>
					</tr>
					
					<!-- 第二个 -->
					
					<tr name="check2" style="display:none;">
						<td rowspan="4">
							<div align="center">
								<input type="checkbox" id="check2" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm2" id="jsxm2" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw2" id="jsdw2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj2"
								id="dgsj2" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk2" id="jsqk2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj2" id="zdmj2" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz2" id="zdwz2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div><span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" style="text-decoration:none">生成抄告单</a></div>
						</td>
					</tr>
					
					<!-- 第三个 -->
					
					<tr name="check3" style="display:none;">
						<td rowspan="4">
							<div align="center">
								<input type="checkbox" id="check3" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm3" id="jsxm3" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw3" id="jsdw3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj3"
								id="dgsj3" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk3" id="jsqk3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj3" id="zdmj3" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz3" id="zdwz3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div><span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" style="text-decoration:none">生成抄告单</a></div>
						</td>
					</tr>
					
					<!-- 第四个 -->
					
					<tr name="check4" style="display:none;">
						<td rowspan="4">
							<div align="center">
								<input type="checkbox" id="check4" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm4" id="jsxm4" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw4" id="jsdw4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj4"
								id="dgsj4" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk4" id="jsqk4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj4" id="zdmj4" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz4" id="zdwz4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div><span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" style="text-decoration:none">生成抄告单</a></div>
						</td>
					</tr>
					
					<!-- 第五个 -->
					
					<tr name="check5" style="display:none;">
						<td rowspan="4">
							<div align="center">
								<input type="checkbox" id="check5" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm5" id="jsxm5" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw5" id="jsdw5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj5"
								id="dgsj5" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk5" id="jsqk5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj5" id="zdmj5" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz5" id="zdwz5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div><span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" style="text-decoration:none">生成抄告单</a></div>
						</td>
					</tr>
					
					<!-- 抄告单部分结束 -->
					
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
				<input type="text" value="" id="writerxzqh" name="writerxzqh" style="display: none" />
			</form>
		</div>
	</body>
	<script>
		document.body.onload = init;
		<%
		String msg = (String)request.getParameter("msg");
		%>
		if("<%=msg%>" == "success"){
			alert("表单保存成功");  
		}
	</script>
</html>