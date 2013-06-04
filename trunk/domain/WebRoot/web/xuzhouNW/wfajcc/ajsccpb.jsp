<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.jinan.aydj.AydjManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String open = request.getParameter("open");
	String edit = request.getParameter("edit");
	Integer count = (Integer) session.getAttribute("count");
	if (count == null) {
		count = 1;
	} else {
		count++;
	}
	String permission = request.getParameter("permission");
	if (permission == null) {
		permission = "no";
	}
	String activityName = new String(request.getParameter(
			"activityName").getBytes("ISO-8859-1"), "gbk");
	String formname = "aydjb";
	String zfjcType = request.getParameter("zfjcType");
	String[] editfiles = new AydjManager().getAydjbEditfiles(
			activityName, formname, zfjcType);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>案件调查处理审批表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%
			if (permission.equals("yes")) {
		%>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/permissionForm.css" type="text/css" />
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		<%
			} else {
		%>
		<%@ include file="/base/include/formbase.jspf"%>
		<style type="text/css">
body {
	font: 14px;
}

td {
	font-size: 14px;
	text-align: center;
	height: 40px;
	border-bottom: 1px solid #000000;
	border-right: 1px solid #000000;
}

.left {
	width: 80px;
}

.divbk {
	margin-left: 200px;
}
.divbk1{
	margin-left: 130px;
}

textarea {
	overflow: hidden;
	border: none;
	background: #FFFFFF;
}

.divLeftFloat {
	float: left;
}

input {
	width: 95%;
	height: 16px;
	background-color: #FFFFFF;
	BORDER-TOP-STYLE: none;
	BORDER-RIGHT-STYLE: none;
	BORDER-LEFT-STYLE: none;
	BORDER-BOTTOM-STYLE: none;
}

textarea {
	width: 99%;
	background: none;
	border: none
}
</style>
		<%
			}
		%>
	</head>
	<script type="text/javascript">
	function initEdit(){
			init();
			var edit="<%=edit%>";
			if(edit=='false'){
				 var formlist = document.getElementById('form');
        		 for(var i=0;i<formlist.length;i++)
         		 {
             			if(formlist[i].type=='text'||formlist[i].type=='textarea'||formlist[i].type=='select-one')
             				formlist[i].disabled=true;
         		 }		
			}
			
		
		}
	function save(){
			
			  parent.parent.flags='1';
			  document.forms[0].submit();
			}

	function res(){
			document.location.reload();
	}
	function clo(){
		if("<%=open%>"=="open"){
     	var url="<%=basePath%>web/default/dtxc/xcrw/taskList.jsp";//要刷新的窗口URL   
     	opener.document.location=url;//注意这里通过子窗口刷新父窗口的方法   
     }
     window.close();
	}
	
	function textChange(num){
		    parent.parent.change=num;
		}
  	</script>
	<body bgcolor="#FFFFFF">
		<div id="fixed" class="Noprn"
			style="position: fixed; top: 5px; left: 0px"></div>
		<div style="margin:20px">
		<div id="container">
			<div align="center">
			<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					案件调查处理审批表
			</div>
				<form method="post" id="form" name="yyx">
					<table cellspacing="0" cellpadding="0" border="0" width="600" bgcolor="#ffffff"
					style="border-top: 1px solid #000000;border-left: 1px solid #000000;bgcolor;">
					<tr>
							<td class="left" rowspan="11" >
								案
								<br />
								件
								<br />
								基
								<br />
								本
								<br />
								情
								<br />
								况
							</td>
							<td >
								案由
							</td>
							<td colspan="7">
								<input id="ay" style="font-size: 1em;" type="text" name="ay"
									value="" onChange="textChange('0');">
							</td>
							<td >
								案件来源
							</td>
							<td colspan="2" >
								<input id="ajly" type="text" name="ajly"
									value="" onChange="textChange('0');">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								违法单位及法人<br>（个人）名称
							</td>
							<td colspan="7" style="border-right: 0px;">
								<div  class="divLeftFloat">
									<input type="text" id="wfdw1" name="wfdw1" value=""
										onChange="textChange('0');">
								</div>
							</td>
							<td style="border-right: 0px;text-align: right;">
								法人:
							</td>
							<td colspan="1" >
								<input id="frmc1" style="font-size: 1em;" type="text"
									name="frmc1" value="" onChange="textChange('0');">
							</td>
						</tr>
						<tr>
							<td colspan="2" >
								违法单位及法人<br>（个人）名称
							</td>
							<td colspan="7" style="border-right: 0px;">
								<div style="width: 100%" class="divLeftFloat">
									<input type="text" id="wfdw2" name="wfdw2" value=""
										onChange="textChange('0');">
								</div>
							</td>
							<td
								style="border-right: 0px; text-align: right;">
								法人:
							</td>
							<td colspan="1" >
								<input id="frmc2" style="font-size: 1em;" type="text"
									name="frmc2" value="" onChange="textChange('0');">
							</td>
						</tr>
						<tr>
							<td>
								宗地<br>位置
							</td>
							<td colspan="8">
								<input id='zdwz' name='zdwz' style="font-size: 1em;"
									onChange="textChange('0');">
							</td>
							<td >
								违法时间
							</td>
							<td width="120" >
								<input type="text" class="rq" onClick="WdatePicker()"
									onChange="textChange('0');" name="wfsj" id="wfsj" readonly
									 />
							</td>
						</tr>
						<tr>
							<td rowspan="5">
								土地<br>性质
							</td>
							<td rowspan="5">
								集体<br>土地
							</td>
							<td rowspan="5" >
								占地<br>类型<br>及<br>面积<br>（m²）
							</td>
							<td  rowspan="3" >
								农<br>用<br>地
							</td>
							<td >
								基本农田
							</td>
							<td colspan="4">
								<input type="text" id='jbnt' name="jbnt" value=""
									style="width: 90%" onChange="textChange('0');" />
							</td>
							<td rowspan="5">
								占地<br>面积<br>合计<br>（m²）
							</td>
							<td rowspan="5" width="100" >
								<input type="text" id='zdmjhj' name='zdmjhj' value=""
									onChange="textChange('0');" />
							</td>
						</tr>
						<tr>
							<td >
								耕地
							</td>
							<td colspan="4">
								<input type="text" id="gd" name="gd" value="" style="width: 90%"
									onChange="textChange('0');" />
							</td>
						</tr>
						<tr>
							<td >
								其他农用地
							</td>
							<td colspan="4">
								<input type="text" id="qtnyd" name="qtnyd" value=""
									style="width: 90%" onChange="textChange('0');" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								建设用地
							</td>
							<td colspan="4">
								<input type="text" id="jsyd" name="jsyd" value=""
									onChange="textChange('0');">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								未利用地
							</td>
							<td colspan="4">
								<input type="text" id="wlyd" name="wlyd" value=""
									onChange="textChange('0');">
							</td>
						</tr>
						<tr>
							<td rowspan="2">
								建筑<br>面积<br>(m²)
							</td>
							<td rowspan="2">
								<input type="text" id="jzmj" name="jzmj" value=""
									style="width: 90%" onChange="textChange('0');" />
							</td>
							<td colspan="7"> 
								符合土地利用总体规划面积（m²） 
							</td>
							<td colspan="2" >
								<input type="text" id="fhztghmj" name="fhztghmj" value=""
									style="width: 90%" onChange="textChange('0');" />
							</td>
						</tr>
						<tr>
							<td colspan="7" >
								不符合土地利用总体规划面积（m²）
							</td>
							<td colspan="2" >
								<input type="text" id="bfhztghmj" name="bfhztghmj" value=""
									style="width: 90%" onChange="textChange('0');" />
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								主
								<br>
								要
								<br>
								违
								<br>
								法
								<br>
								事
								<br>
								实
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="7" style="font-size: 1em;" name="zywfss"
									id="zywfss" onChange="textChange('0');"></textarea>
							</td>
						</tr>
						<tr>
							<td height="89">
								<br>
								<br>
								分局案
								<br>
								件承办
								<br>
								人调查
								<br>
								情况及
								<br>
								处理意
								<br>
								见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="7" style="font-size: 1em;" name="fjajcbrdcqk"
									id="fjajcbrdcqk"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="fjajcbr" onchange="textChange('0');"
											onfocus="underwrite(this)" id="fjajcbr" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="fjajcbrsj" id="fjajcbrsj"
											readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<p>
									<br>
									<br>
									分局执法
									<br>
									监察大队
									<br>
									长审核意
									<br>
									见
									<br>
								</p>
							</td>
							<td colspan="11" >
								<textarea rows="2" name="fjzfjcddzscyj" id="fjzfjcddzscyj"
									onChange="textChange('0');"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="fjzfjcddz" id="fjzfjcddz" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="fjzfjcddzsj"
											id="fjzfjcddzsj" readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								分局分管
								<br>
								局长审核
								<br>
								意见
								<br>
								<br>
							</td>
							<td colspan="11" > 
								<textarea rows="2" name="fjfgjzshyj" id="fjfgjzshyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">签名： 
										<input type="text" style="font-size: 1em;"
											onchange="textChange('0');" onfocus="underwrite(this)"
											class="underline" name="fjfgjz" id="fjfgjz"
											style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="fjfgjzsj" id="fjfgjzsj"
											readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								分局
								<br>
								局长
								<br>
								意见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="2" name="fjjzyj" id="fjjzyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk"><br>
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="fjjz" id="fjjz" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="fjjzsj" id="fjjzsj"
											readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								支队区域<br>监管负责<br>人调查处
								<br>理意见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="8" name="zdqyjgzrrdcclyj" id="zdqyjgzrrdcclyj"
									style="font-size: 1em;"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="zdqyjgzrr" id="zdqyjgzrr" style="width: 50px"
											onchange="textChange('0');" onfocus="underwrite(this)" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="zdqyjgzrrsj"
											id="zdqyjgzrrsj" readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left" >
								<br>
								<br>
								支队分
								<br>
								管大队
								<br>
								长审理
								<br>
								意见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="3" name="zdfgddzslyj" id="zdfgddzslyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="zdfgddz" id="zdfgddz" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="zdfgddzsj" id="zdfgddzsj"
											readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								执法监察<br>案件审查<br>意见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="3" name="zfjccajslyj" id="zfjccajslyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk1">
									<div class="divLeftFloat">
										案件审查人签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="ajscr" id="ajscr" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="ajscrsj" id="ajscrsj"
											readonly style="width: 80px" />
									</div>
									
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								支队长
								<br>
								审核意
								<br>
								见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="2" name="zdzshyj" id="zdzshyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="zdz" id="zdz" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="zdzsj" id="zdzsj" readonly
											style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								政策法<br>规处意见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="2" name="zcfgcyj" id="zcfgcyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="zcfgc" id="zcfgc" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="zcfgcsj" id="zcfgcsj"
											readonly style="width: 80px" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="left">
								<br>
								<br>
								市局分管<br>局长签批<br>意见
								<br>
								<br>
							</td>
							<td colspan="11" >
								<textarea rows="2" name="sjfgjzqpyj" id="sjfgjzqpyj"
									style="font-size: 1em;" onChange="textChange('0');"></textarea>
								<div class="divbk">
									<div class="divLeftFloat">
										签名：
										<input type="text" style="font-size: 1em;" class="underline"
											name="sjfgjz" id="sjfgjz" onchange="textChange('0');"
											onfocus="underwrite(this)" style="width: 50px" />
									</div>
									<div class="rqdiv">
										日期：
										<input type="text" class="rq" onClick="WdatePicker()"
											onChange="textChange('0');" name="sjfgjzsj" id="sjfgjzsj"
											readonly style="width: 80px" />
									</div>
							</td>
						</tr>
					</table>
					<%
						if (!permission.equals("yes")) {
					%>
					<!--  
					<input type="button" value="保 存" onClick="save()" />
					&nbsp;&nbsp;&nbsp;
					<input type="button" value="刷 新" onClick="res()" />
					-->
					<%
						} else {
					%>
					<input type="button" value="保 存" onClick="save123()" />
					<%
						}
					%>
				</form>
			</div>
	</body>
	<script>
<%
if(!permission.equals("yes")){%>
	document.body.onload = initEdit;
<%}else if(permission.equals("yes")){%>
	addBorders();
<%}%>
<%
	String msg = (String)request.getParameter("msg");
%>
if("<%=msg%>" == "success"&&"<%=permission%>"=="yes"){
	alert("表单权限保存成功");
}else if("<%=msg%>" == "success"){
	alert("表单保存成功");  
}
</script>
</html>
