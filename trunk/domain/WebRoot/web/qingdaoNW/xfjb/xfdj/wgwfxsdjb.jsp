<%@page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.qingdaoNW.xfjb.XfjbManager"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    
    //得到yw_guid
    String yw_guid = request.getParameter("yw_guid");
    //用于生成表单创建时间和表单登记时间        
	String strDate = UtilFactory.getDateUtil().getFormatDate("yyyy-MM-dd HH:mm:ss",new Date());
	
	XfjbManager xfjbManager = new XfjbManager();
	
	//当newForm为"true"时，表示表单是新建表单；当newForm为"false"时表示是保存之后的表单
	String newForm = xfjbManager.checkGuid(yw_guid);
	
	//生成信访编号
	String strXSH = "";
	if("true".equals(newForm)){
		strXSH = xfjbManager.buildXSH();
	}
	
	//用来标志表单是从新增信访、待办信访、已办信访中打开；其中新增信访为null、其他两个为flag
	String enterFlag = request.getParameter("enterFlag");
	String keyWord = request.getParameter("keyWord");
	if(keyWord != null){
		keyWord = new String(keyWord.getBytes("ISO8859-1"),"UTF-8");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>" />

		<TITLE>违规违法线索登记表</TITLE>

		<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/newformbase.jspf"%>

		<script>
			var trelements = document.getElementsByTagName("tr");
			var var_enterFlag = "<%=enterFlag%>";
			
			function initEdit(){
				init();
				initTable();
			}
				
			function save(){
				//当在待办信访中保存修改状态标志
				var var_status = document.getElementById("status").value;
				if(var_status == 0 && var_enterFlag == "flag"){
					document.getElementById("status").value = 1;
				}
				document.forms[0].submit();
			}
			
			//办理方式是交办
			function jbchecked(){
				var changetd = document.getElementById("changetd");
				if(changetd.rowSpan == 11){
					
				}else{
					changetd.rowSpan = 11;
					for(var i = 0; i < trelements.length ; i++){
						if(trelements[i].name == "jbcheck"){
							trelements[i].style.display = "block";
						}
					}
				}
			}
			
			//办理方式不是交办
			function jbnotchecked(){
				var changetd = document.getElementById("changetd");
				if(changetd.rowSpan == 8){
					
				}else{
					changetd.rowSpan = 8;
					for(var i = 0; i < trelements.length ; i++){
						if(trelements[i].name == "jbcheck"){
							trelements[i].style.display = "none";
						}
					}
				}
				document.getElementById("jbdw").value = "";
				document.getElementById("jiaobsj").value = "";
				document.getElementById("jblxdh").value = "";
				document.getElementById("bjsj").value = "";
				document.getElementById("cbdw").value = "";
				document.getElementById("jiaobr").value = "";
			}
			
			//初始化表单table
			function initTable(){
				//交办
				var varradio = document.getElementById("jbradio");
				if(varradio.checked && varradio.value == "交办"){
					jbchecked();
				}else{
				}
				//反馈
				if(var_enterFlag == "null"){
					
				}else{
					fkchecked();
				}
			}
			
			//显示反馈信息表格
			function fkchecked(){
				for(var i = 0; i < trelements.length ; i++){
					if(trelements[i].name == "fkcheck"){
						trelements[i].style.display = "block";
					}
				}
			}
			
			//下一条
			function toNext(){
				var var_status = document.getElementById("status").value;
				putClientCommond("xfjbManager","getPreOrNext");
				putRestParameter("preOrNext","next");
				putRestParameter("yw_guid","<%=yw_guid%>");
				putRestParameter("keyWord","<%=keyWord%>");
				putRestParameter("status",var_status);
				var result = restRequest();
				if(result == "error"){
					alert("当前页已是最后一条");
					return ; 
				}
				document.location.href="<%=basePath%>/web/qingdaoNW/xfjb/xfdj/wgwfxsdjb.jsp?enterFlag=<%=enterFlag%>&yw_guid=" + result +"&keyWord=<%=keyWord%>"; 
			}
			
			//上一条
			function toPre(){
				var var_status = document.getElementById("status").value;
				putClientCommond("xfjbManager","getPreOrNext");
				putRestParameter("preOrNext","pre");
				putRestParameter("yw_guid","<%=yw_guid%>");
				putRestParameter("keyWord","<%=keyWord%>");
				putRestParameter("status",var_status);
				var result = restRequest();
				if(result == "error"){
					alert("当前页已是第一条");
					return ; 
				}
				document.location.href="<%=basePath%>/web/qingdaoNW/xfjb/xfdj/wgwfxsdjb.jsp?enterFlag=<%=enterFlag%>&yw_guid=" + result +"&keyWord=<%=keyWord%>"; 
			}
		</script>
	</head>

	<body bgcolor="#FFFFFF">
		<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
		<%if("flag".equals(enterFlag)){ %>
			<div align="right" style="margin-top:15px;margin-right:20px;">
				<input type="button" value="上一条" onclick="toPre();return false;"/>&nbsp;&nbsp;&nbsp;
				<input type="button" value="下一条" onclick="toNext();return false;"/>
			</div>
		<% }%>
		<div style="margin: 20px" class="tablestyle1" align="center">
			<div align="center">
				<font size="6">
					<b>违规违法线索登记表</b>
				</font>
			</div>
			<form method="post">
				<div style="width: 100%;">
					<span style="margin-left: 330px;">
						<%
							if(newForm.equals("true")){
						%>
							线索号：<input type="text" name="xsh" id="xsh" value="<%=strXSH %>" style="width: 190px; background-color: transparent; border: 0px;">
						<%
							}else{
						%>
							线索号：<input type="text" name="xsh" id="xsh" style="width: 190px; background-color: transparent; border: 0px;">
						<%
							}
						%>
					</span>
				</div>
				<table class="lefttopborder1" cellspacing="0" cellpadding="0" border="1" bgcolor="#FFFFFF" bordercolor="#000000" width="600">
					<tr>
						<td colspan="6">
							<div align="left">
								&nbsp;调查处理中务必做到保护举报人。
							</div>
						</td>
					</tr>
					<tr>
						<td width="35" rowspan="8" id="changetd">
							<p align="center">
								基
								<br />
								<br />
								本
								<br />
								<br />
								信
								<br />
								<br />
								息
							</p>
						</td>
						<td width="95">
							<div align="center">
								线索类型
							</div>
						</td>
						<td colspan="4">
							<div align="left">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name='xslx' id='xslx' value="一般违法线索" checked />
								一般违法线索&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name='xslx' id='xslx' value="重大违法线索" />
								重大违法线索
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								办理方式
							</div>
						</td>
						<td colspan="4">
							<div align="left">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name='blfs' id='blfs' value="转办" onclick="jbnotchecked()" checked/>
								转办&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name='blfs' id='jbradio' value="交办" onclick="jbchecked()"/>
								交办&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name='blfs' id='blfs' value="挂牌督办" onclick="jbnotchecked()"/>
								挂牌督办&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name='blfs' id='blfs' value="派人直查" onclick="jbnotchecked()"/>
								派人直查
							</div>
						</td>
					</tr>
					<tr name="jbcheck" style="display:none;">
						<td>
							<div align="center">
								交办单位
							</div>
						</td>
						<td colspan="2">
							<input type="text" class="textcls" name="jbdw" id="jbdw" style="width: 95%;" />
						</td>
						<td width="75">
							<div align="center">
								交办时间
							</div>
						</td>
						<td>
							<input type="text" class="noborder" id="jiaobsj" name="jiaobsj"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly
								style="width: 95%" />
						</td>
					</tr>
					<tr name="jbcheck" style="display:none;">
						<td>
							<div align="center">
								联系电话
							</div>
						</td>
						<td colspan="2">
							<input type="text" class="textcls" name="jblxdh" id="jblxdh" style="width: 95%;" />
						</td>
						<td>
							<div align="center">
								办结时间
							</div>
						</td>
						<td>
							<input type="text" class="noborder" id="bjsj" name="bjsj"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly
								style="width: 95%" />
						</td>
					</tr>
					<tr name="jbcheck" style="display:none;">
						<td>
							<div align="center">
								承办单位
							</div>
						</td>
						<td colspan="2">
							<input type="text" class="textcls" name="cbdw" id="cbdw" style="width: 95%;" />
						</td>
						<td width="80">
							<div align="center">
								交办人
							</div>
						</td>
						<td>
							<input type="text" class="textcls" name="jiaobr" id="jiaobr" style="width: 95%;" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								举报人
							</div>
						</td>
						<td colspan="2">
							<input type="text" class="textcls" name="jbr" id="jbr" style="width: 95%;" />
						</td>
						<td>
							<div align="center">
								举报方式
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jbfs" id="jbfs" style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td rowspan="2">
							<div align="center">
								举报联系方式
							</div>
						</td>
						<td width="85">
							<div align="center">
								联系地址
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="lxdz" id="lxdz" style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								邮政编码
							</div>
						</td>
						<td width="155">
							<input type="text" class="noborder" name="yzbm" id="yzbm" style="width: 95%" />
						</td>
						<td width="75">
							<div align="center">
								联系电话
							</div>
						</td>
						<td width="130">
							<input type="text" class="noborder" name="lxdh" id="lxdh" style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								被举报单位
							</div>
						</td>
						<td colspan="4">
							<input type="text" class="noborder" name="bjbdw" id="bjbdw" style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								问题发生地
							</div>
						</td>
						<td colspan="4">
							<input type="text" class="noborder" name="wtfsd" id="wtfsd" style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								问题发生时间
							</div>
						</td>
						<td colspan="2">
							<input type="text" class="noborder" id="wtfssj" name="wtfssj"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly
								style="width: 98%" />
						</td>
						<td>
							<div align="center">
								登记时间
							</div>
						</td>
						<td>
							<%
								if(newForm.equals("true")){
							%>
								<input type="text" class="noborder" id="djsj" name="djsj"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly
									style="width: 95%" value="<%= strDate.substring(0,10)%>"/>
							<%
								}else{
							%>
								<input type="text" class="noborder" id="djsj" name="djsj"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly
									style="width: 95%" />
							<%
								}
							%>
						</td>
					</tr>
					<tr>
						<td>
							<p align="center">
								线
								<br />
								<br />
								索
								<br />
								<br />
								摘
								<br />
								<br />
								要
							</p>
						</td>
						<td colspan="5">
							<textarea rows="10" name="xszy" id="xszy" style="width: 99%"></textarea>
						</td>
					</tr>
					<tr name="fkcheck" style="display:none;">
						<td rowspan="3">
							<div align="center">
								反
								<br />
								<br />
								馈
								<br />
								<br />
								信
								<br />
								<br />
								息
							</div>
						</td>
						<td height="29">
							<div align="center">
								反馈单位
							</div>
						</td>
						<td colspan="4">
							<input type="text" class="noborder" name="fkdw" id="fkdw"
								style="width: 98%" />
						</td>
					</tr>
					<tr name="fkcheck" style="display:none;">
						<td height="29" colspan="3">
							<div align="left">
								&nbsp;&nbsp;&nbsp;
								<input type="radio" name='ssqk' id='ssqk' value="基本属实" />
								基本属实&nbsp;&nbsp;
								<input type="radio" name='ssqk' id='ssqk' value="部分属实" />
								部分属实&nbsp;&nbsp;
								<input type="radio" name='ssqk' id='ssqk' value="基本不属实" />
								基本不属实
							</div>
						</td>
						<td>
							<div align="center">
								是否立案
							</div>
						</td>
						<td>
							<div align="left">
								&nbsp;
								<input type="radio" name='sfla' id='sfla1' value="是" />
								是&nbsp;&nbsp;&nbsp;
								<input type="radio" name='sfla' id='sfla1' value="否" />
								否
							</div>
						</td>
					</tr>
					<tr name="fkcheck" style="display:none;">
						<td height="89">
							<div align="center">
								线索情况说明
							</div>
						</td>
						<td colspan="4">
							<textarea rows="8" name="xsqksm" id="xsqksm" style="width: 99%"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<div align="center">
								备
								<br />
								<br />
								注
							</div>
						</td>
						<td colspan="5">
							<textarea rows="8" name="bz" id="bz" style="width: 99%"></textarea>
						</td>
					</tr>
				</table>
				<%
					if(newForm.equals("true")){
				%>
					<input type="text" value="0" id="status" name="status" style="display: none" />
					<input type="text" value="<%= strDate%>" id="buildyear" name="buildyear" style="display: none" />
				<%
					}else{
				%>
					<input type="text" id="status" name="status" style="display: none" />
					<input type="text" id="buildyear" name="buildyear" style="display: none" />
				<%
					}
				%>
			</form>
	</body>
	<script>
		document.body.onload = initEdit;
	</script>
</html>