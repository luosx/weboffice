<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>巡查日志</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/newformbase.jspf"%>
	<script type="text/javascript" src="web/jizeNW/dtxc/js/xcrz.js"></script>
	<link rel="stylesheet" href="/base/form/css/commonForm.css" type="text/css" />
  </head>
  <style type="text/css">
  		table{
			border-left-color:#000000;
			border-left-style:solid;
			border-left-width:1px;
			border-top-color:#000000;
			border-top-style:solid;
			border-top-width:1px;
			background-color:#FFFFFF;
			font-family:"宋体";
			font-size:14px;
			}
		td{
			border-bottom-color:#000000;
			border-bottom-style:solid;
			border-bottom-width:1px;
			border-right-color:#000000;
			border-right-style:solid;
			border-right-width:1px;
			margin-bottom:5px;
			margin-top:5px;
			height:25px;
			}
		select{
			background:#FFFFFF;
			border:none;
			font-family:"宋体";
			font-size:14px;
			}
		input{
			background:#FFFFFF;
			border:none;
			font-family:"宋体";
			font-size:14px;
			}
		.class{
			font-family:"宋体";
			font-size:14px;
		}
  </style>
  <script type="text/javascript">
  	var isInput = true;
  	
  	function save(){		
		document.forms[0].submit();
	}
	
	//页面加载初始化
	function onInit(){	
		init();
				
		var allnum = document.getElementById("allnum");
		var num = parseInt(allnum.value)/3;
		allnum.value = "3";
		for(var i = 1; i < num; i++){
			addcgd();
		}
		insertData(json);
	}
	
	//添加选项
	function Addopt(selectname, value, name){
		var selectname = document.getElementById(selectname);
		var opt = document.createElement('option');
		opt.text = name;
		opt.value = name;
		selectname.options.add(opt);
	}
	
	//导入巡查成果
	function drxccg(){
		var feature="dialogWidth:650px;dialogHeight:300px;status:no;help:no;scroll:no;location=no"; 
		//显示成果导入模态对话框，并将导入的成果的yw_guid返回 
		var simInfo =  window.showModalDialog("/domain/web/jizeNW/dtxc/dtxccg/dtxccg.jsp",null,feature); 
		//将导入的巡查成果的基本违法信息写到巡查日志当中
		putClientCommond("cgdrManager", "getSimInfo");
		putRestParameter("simInfo", simInfo);
		baseInformation = restRequest();
		
		//将导入的巡查成果写入违法项目当中
		for(var i = 0; i < baseInformation.length; i++){
				document.getElementById("jsdw_" + (i + 1)).value = baseInformation[i].YDDW;
				document.getElementById("dgsj_" + (i + 1)).value = baseInformation[i].YDSJ;
				document.getElementById("jsqk_" + (i + 1)).value = baseInformation[i].JSQK;
				document.getElementById("zdmj_" + (i + 1)).value = baseInformation[i].MJ;
				//document.getElementById("ywguid_" + (i + 1)).value = baseInformation[i].YW_GUID;	
				addcgd();
		/*
			}else{
				addcgd();
				var num = document.getElementById("allnum").value;
				num = String(parseInt(num)/3);
				document.getElementById("jsdw_" + num).value = baseInformation[i].YDDW;
				document.getElementById("dgsj_" + num).value = baseInformation[i].YDSJ;
				document.getElementById("jsqk_" + num).value = baseInformation[i].JSQK;
				document.getElementById("zdmj_" + num).value = baseInformation[i].MJ;
			}
		*/
		}		
	}

  </script>
  <body onLoad="onInit(); return false;">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<div align="center" style="margin-bottom:20px"><h1 style="font-size: 25">国土资源执法监察巡查日志</h1></div>
  	<form method="post">
  	    <table align="center" cellpadding="0" cellspacing="0" width="600px" id="xcrztable">
			<tr>
    			<td height="16" colspan="2"><div align="center">巡查单位</div></td>
    			<td width="166"><input type="text" class="noborder" name="xcdw" id="xcdw" style="width: 97%"/></td>
    			<td width="102"><div align="center">巡查日期</div></td>
    			<td width="211"><input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="xcrq" id="xcrq" readonly style="width: 97%"/></td>
  			</tr>
			<tr>
    			<td colspan="2"><div align="center">巡查区域</div></td>
    			<td colspan="3"><input type="text" class="noborder" name="xcqy" id="xcqy" style="width: 99%"/></td>
  			</tr>
			<tr>
    			<td colspan="2"><div align="center">巡查人员</div></td>
    			<td colspan="3"><input type="text" class="noborder" name="xcry" id="xcry" style="width: 99%"/></td>
  			</tr>
			<tr>
    			<td height="21" colspan="2"><div align="center">巡查路线</div></td>
    			<td colspan="3"><input type="text" class="noborder" name="xclx" id="xclx" style="width: 99%"/></td>
  			</tr>
			<tr>
				<td colspan="2"><div align="center">是否有违法</div></td>
				<td colspan="3">
					<input type="radio" name="sfywf" id="sfywf" value="是" />是
					<input type="radio" name="sfywf" id="sfywf" value="否" />
					否
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="button" id="add" value="增加" onClick="addcgd(); return false;" />
					<input type="button" class="button" id="delete" value="删除" onClick="deletecgd();return false;" />
					&nbsp;&nbsp;&nbsp;
					<input type="button" class="button" id="imp" value="导入巡查成果" onClick="drxccg();return false;" />
					<input type="text" id="allnum" name="allnum" value="3" style="display:none" />				</td>
			</tr>
			<tr>
				<td rowspan="3"><div align="center"><input type="checkbox" id="check_1" /> </td>
				<td><div align="center">建设项目</div></td>
				<td>
					<input type="text" class="noborder" name="jsxm_1" id="jsxm_1" style="width:97%" />				</td>
				<td>
					<div align="center">建设单位</div>				</td>
				<td>
					<input type="text" class="noborder" name="jsdw_1" id="jsdw_1" style="width:97%" />				</td>
			</tr>
			<tr>
				<td><div align="center">动工时间</div></td>
				<td>
					<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj_1" id="dgsj_1" readonly style="width: 97%"/>				
				</td>
				<td>
					<div align="center">建设情况</div>	
				</td>
				<td>
				  <input type="text" class="noborder" name="jsqk_1" id="jsqk_1" style="width: 97%"/>
				</td>
			</tr>
			<tr>
				<td><div align="center">占地面积</div></td>
				<td>
					<input type="text" class="noborder" name="zdmj_1" id="zdmj_1" style="width:97%" />
				</td>
				<td>
					<div align="center">占地位置</div>
				</td>
				<td>
					<input type="text" class="noborder" name="zdwz_1" id="zdwz_1" style="width:97%" />
					<input type="text" style="display:none" id="ywguid_1" name="ywguid_1" />
				</td>
			</tr>
			<tr>
				<td width="40" rowspan="2">
					<p align="center">巡</p>
					<p align="center">查</p>
					<p align="center">内</p>
					<p align="center">容</p>
				</td>
				<td width="82">
					<div align="center">项目<br/>
					建设<br/>
					及用<br/>
					地审<br/>
					批手<br/>
					续审<br/>
					批情<br/>
					况</div>
				</td>
				<td colspan="3">
					<textarea rows="15" name="spqk" id="spqk" style="width:99%"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<div align="center">
						对所<br/>
						建项<br/>
						目的<br/>
						处理<br/>
						意见
					</div>
				</td>
				<td colspan="3">
					<textarea rows="10" name="clyj" id="clyj" style="width:99%"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div align="center">备注</div>
				</td>
				<td colspan="3">
					<textarea rows="6" name="bz" id="bz" style="width:99%"></textarea>
				</td>
			</tr>
        </table>
  	</form>
  </body>
  <script type="text/javascript">
  	<%
		String msg = (String)request.getParameter("msg");
	%>
	if("<%=msg%>" == "success"){
		alert("表单保存成功");  
	}
  </script>
</html>
