<%@ page language="java" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String edit = request.getParameter("edit");
	String permission = request.getParameter("permission");
	if (permission == null) {
		permission = "no";
	}
	String activityName="";
	//String formname = "aydjb";
	//String zfjcType=request.getParameter("zfjcType");
	//String[] editfiles = new AydjManager().getAydjbEditfiles(activityName,formname,zfjcType);
	String isFirst = request.getParameter("isFirst");

	String fixed=request.getParameter("fixed");
	String message=request.getParameter("msg");
	if("success".equals(message)){
		activityName=new String(request.getParameter("activityName").getBytes("ISO-8859-1"), "utf-8");	
	}else{
		activityName=new String(request.getParameter("activityName").getBytes("ISO-8859-1"), "gbk");	
	}
	String yw_guid=request.getParameter("yw_guid");
	String type=request.getParameter("type");
	String labh="";//济国土立字2012-05-003
	if("立案审批".equals(activityName)){
		labh=new AydjManager().getLabh(yw_guid,type);
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<TITLE>立案呈批表</TITLE>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>	
		<%}else{ %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
				<link rel="stylesheet"
			href="<%=basePath%>web/xuzhouNW/ajgl/css/lacpb.css" type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/include/formbase.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script> 			
		
	
		
		<script type="text/javascript">
		function initEdit(){
			init();	
			//checkLabh();
			//bindChecked();
			//checkBz();
		/*		
			var edit="<%=edit%>";
			if(edit=='false'){
				 var formlist = document.getElementById('form');
        		 for(var i=0;i<formlist.length;i++)
         		 {
             			if(formlist[i].type=='text'||formlist[i].type=='textarea'||formlist[i].type=='select-one')
             				formlist[i].disabled=true;
         		 }		
			}

		*/
		}
		function checkLabh(){
			var labh=document.getElementById('labh').value;
			if(!labh){
				document.getElementById('labh').value="<%=labh%>";
			}
		
		}
		function bindChecked(){
			var yyx=document.getElementById('form');
			for(var i=0;i<yyx.length;i++){
				if(yyx[i].type=='checkbox'){
					if(yyx[i].checked&&yyx[i].value=='卫片执法'){
						showBZ1(yyx[i]);
					}
					if(yyx[i].checked&&yyx[i].value=='信访事项'){
						showBZ2(yyx[i]);
					}
				}
				if(yyx[i].type=='radio'){
					if(yyx[i].checked){
					    showDiv(yyx[i]);
					}
				}				
			}
		}
		
		function checkBz(){
			var yyx=document.getElementById('form');
			if("<%=isFirst%>"!="yes"){
				for(var i=0;i<yyx.length;i++){
					if(yyx[i].type=='radio'){
						yyx[i].disabled=true;
					}
				}
			}
		}

		function save(){
				var ay = document.getElementById("ay");  	  
				var yw_guid='<%=yw_guid%>';  
				//var path = "<%=basePath%>";  
			   // var actionName = "anjianManager";  
			   // var actionMethod = "saveAy";   
			   // var parameter="yw_guid="+yw_guid+"&ay="+escape(escape(ay.value));   
				//var result = ajaxRequest(path,actionName,actionMethod,parameter);  
				putClientCommond("anjianManager","saveAy");
   			    putRestParameter("yw_guid",yw_guid);
				putRestParameter("ay",escape(escape(ay.value)));
				var res=restRequest();
		  //if(checkNeed()){
		  	document.forms[0].submit(); 
		  //} 
		}
			
			function refresh(){
				document.location.refresh();
			}

		function checkNeed(){
			var ajly1=document.getElementById('ajly1').checked;
			var ajly2=document.getElementById('ajly2').checked;
			var ajly3=document.getElementById('ajly3').checked;
		
			if(!ajly1 && !ajly2 && !ajly3){
				alert("请选择案件来源！");
				return false;
			}
			//////////////
			//////////////
			//当事人：单位或个人都未输入信息时，出现输入信息提示框
			//ksmc,fddbr,ksdz,ksdh,grxm,grxb,grnl,grks,grzw,grdz,grdh
			var ksmc=document.getElementById('ksmc').value;
			var fddbr=document.getElementById('fddbr').value;
			var ksdz=document.getElementById('ksdz').value;
			var ksdh=document.getElementById('ksdh').value;
			var grxm=document.getElementById('grxm').value;
			var grxb=document.getElementById('grxb').value;
			var grnl=document.getElementById('grnl').value;
			var grks=document.getElementById('grks').value;
			var grzw=document.getElementById('grzw').value;
			var grdz=document.getElementById('grdz').value;
			var grdh=document.getElementById('grdh').value;
			//当事人：单位或个人都未输入信息时
			if((ksmc==''||ksmc==null) && (fddbr==''||fddbr==null) && (ksdz==''||ksdz==null)&& (ksdh==''||ksdh==null)&& (grxm==''||grxm==null) && (grnl==''||grnl==null)&& (grks==''||grks==null)&& (grzw==''||grzw==null)&& (grdz==''||grdz==null)&& (grdh==''||grdh==null))
			{
				alert("请输入当事人单位或个人信息");
				return false;
			}
			//当事人：单位一栏全输入，个人一栏未输入信息时
			if(ksmc!='' || fddbr!='' || ksdz!='' || ksdh!='')
			{  
			  if(grxm!='' && grxb!='' && grnl!='' && grks!='' && grzw!='' && grdz!='' && grdh!=''){
			    	return true;
			    }
				else if(ksmc==''||ksmc==null){
					alert("请输入当事人单位名称!!");
					return false;
				}
				else if(fddbr==''||fddbr==null){
					alert("请输入当事人单位法定代表人!!");
					return false;
				}
				else if(ksdz==''||ksdz==null){
					alert("请输入当事人单位地址 !!");
					return false;
				}
			    else if(ksdh==''||ksdh==null){
					alert("请输入当事人单位电话 !!");
					return false;
				}
			 }
			//当事人：个人一栏全输入，单位一栏未输入信息时 grxm,grxb,grnl,grks,grzw,grdz,grdh
			if(grxm!='' || grxb!='' || grnl!='' || grks!='' || grzw!='' || grdz!='' || grdh!='')
			{
			    if(ksmc!='' && fddbr!='' && ksdz!='' && ksdh!=''){
			    	return true;
			    }
				else if(grxm==''||grxm==null){
					alert("请输入当事人个人姓名!!");
					return false;
				}
				else if(grnl==''||grnl==null){
					alert("请输入当事人个人年龄!!");
					return false;
				}
			    else if(grks==''||grks==null){
					alert("请输入当事人个人单位 !!");
					return false;
				}
				 else if(grzw==''||grzw==null){
					alert("请输入当事人个人职务 !!");
					return false;
				}
				 else if(grdz==''||grdz==null){
					alert("请输入当事人个人地址 !!");
					return false;
				}
				 else if(grdh==''||grdh==null){
					alert("请输入当事人个人电话  !!");
					return false;
				}
			}
			//////////////
			//////////////
			return true;
		}
		</script>
	<%} %>
	</head>

	<body bgcolor="#FFFFFF" align="center">
<% if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixedPrint" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	}else{%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
		<div style="margin:20px" class="tablestyle1" align="center" >
			<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体"> 
					立案呈批表
			</div>
			<form method="post" id="form" name="yyx">
			   <br/>
				<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
					<tr class="row1">
						<td colspan="2" align="center" >
							<div align="center" class="">
								案&nbsp;&nbsp;&nbsp;由
							</div>
						</td>
						<td colspan="6" border="1" >
							<input class="noborder"  style="width: 99%" align="left"    cols="65" name="ay" id="ay" />
						</td>
					</tr>
					<tr>
						<td rowspan="5"  width="40px">
							<div align="center">
								
									当
									<br/>
									事
									<br/>
									人
								
							</div>
						</td>
						<td width="50px" rowspan="2" align="center">
							单位
						</td>
						<td width="50" align="center"  height="28px">
							名称
						</td>
						<td colspan="3" >
							<input class="noborder" width="20px"  style="width: 98%" name="ksmc"    id="ksmc">
						</td>
						<td colspan="1" >
							<div align="center">
								法定代表人
							</div>
						</td>
						<td width="100" >
							<input  class="noborder" style="width: 95%"    name="fddbr"
								id="fddbr" />
						</td>
					</tr>
					<tr>
						<td align="center"  height="28px">
							地址
						</td>
						<td colspan="3" >
							<input class="noborder" name="ksdz"    id="ksdz" style="width: 98%" />
						</td>
						<td width="80" >
							<div align="center">
								电话
							</div>
						</td>
						<td  width="100">
							<input class="noborder" name="ksdh" id="ksdh"    style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td rowspan="3" >
							<div align="center">
								个人
							</div>
						</td>
						<td align="center"  height="28px">
							姓名
						</td>
						<td width="140" >
							<input class="noborder" name="grxm" id="grxm"    style="width: 97%" />
						</td>
						<td width="40" >
							<div align="center">
								性别
							</div>
						</td>
						<td width="65" >
						<%if(permission.equals("yes")){ %>					
    						<input class="noborder" name="grxb" id="grxb" style="width: 98%"/>
   				        <%}else{ %>
							<select style="width: 90%" id="grxb"    name="grxb">
								<option  value="男"  selected="selected">
									男
								</option>
								<option  value="女" >
									女
								</option>
							</select>
							<%} %>
						</td>
						<td align="center" >
							年龄
						</td>
						<td  width="100">
							<input class="noborder" name="grnl"    id="grnl" style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td align="center"  height="28px">
							单位
						</td>
						<td colspan="3" >
							<input class="noborder" name="grks"    id="grks" style="width: 98%" />
						</td>
						<td >
							<div align="center">
								职务
							</div>
						</td>
						<td width="100">
							<input class="noborder" name="grzw" id="grzw"    style="width: 95%" />
						</td>
					</tr>
					<tr>
						<td align="center"  height="28px">
							地址
						</td>
						<td colspan="3" >
							<input class="noborder" name="grdz"    id="grdz" style="width: 98%" />
						</td>
						<td >
							<div align="center">
								电话
							</div>
						</td>
						<td   width="100">
							<input class="noborder" name="grdh"    id="grdh" style="width: 95%" />
						</td>
					</tr>
					<tr height="28px">
						<td colspan="2" >
							<div align="center">
								案件来源
							</div>
						</td>
						<td colspan="6" align="left">
							<input class="noborder" id="ajly" name="ajly" style="width: 98%" />
						</td>
					</tr>
					<tr height="28px">
						<td colspan="2" >
							<div align="center">
								受理日期
							</div>
						</td>
						<td colspan="6" >
							<input type="text" class="noborder" id="slrq" name="slrq"
								onClick="WdatePicker()"    readonly style="width: 98%" />
						</td>
					</tr>
					<tr>
						<td height="80" colspan="2" >
							<div align="center">
								<p>
									主要违法
									<br/>
									<br/>
										事&nbsp;&nbsp;&nbsp;&nbsp;实 
								</p>
							</div>
						</td>
						<td colspan="6" >
							<textarea rows="10" cols="70" name="wfss"    id="wfss"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" >
							<div align="center">
								<p>
									承&nbsp;办&nbsp;人
									<br/>
										&nbsp;&nbsp;建&nbsp;&nbsp;&nbsp;&nbsp;议&nbsp;&nbsp; 
								</p>
							</div>
						</td>
						<td colspan="6" >
							<textarea rows="5" cols="70" name="cbryj" id="cbryj"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input type="text" class="underline" name="cbrqm" id="cbrqm"
										onfocus="underwrite(this)"    style="width:50px" />
								</div>
								<div >
									日期：
									<input type="text" class="underline" onClick="WdatePicker()"
										name="cbrqmrq" id="cbrqmrq"  readonly style="width:80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" >
							<div align="center">
								<p>
									承办单位
									<br/>
										&nbsp;&nbsp;意&nbsp;&nbsp;&nbsp;&nbsp;见&nbsp;&nbsp;
								</p>
							</div>
						</td>
						<td colspan="6" >
							<textarea rows="5" cols="70" name="cbksyj"    id="cbksyj"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input type="text" class="underline" name="cbksqm" id="cbksqm"
										onfocus="underwrite(this)"    style="width: 50px" />
								</div>
								<div>
									日期：
									<input type="text" class="underline" onClick="WdatePicker()"
										name="cbksrq" id="cbksrq"    readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" >
							<div align="center">
								<p>
									&nbsp;&nbsp;审&nbsp;&nbsp;&nbsp;&nbsp;查&nbsp;&nbsp;
									<br/>
										&nbsp;&nbsp;意&nbsp;&nbsp;&nbsp;&nbsp;见&nbsp;&nbsp; 
								</p>
							</div>
						</td>
						<td colspan="6" >
							<textarea rows="5" cols="70" name="scdwyj"    id="scdwyj"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input type="text" class="underline" name="scdwqm" id="scdwqm"
										onfocus="underwrite(this)"    style="width: 50px" />
								</div>
								<div>
									日期：
									<input type="text" class="underline"    onClick="WdatePicker()"
										name="scdwrq" id="scdwrq" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" >
							<div align="center">
								<p>
									主管领导
									<br/>
										&nbsp;&nbsp;意&nbsp;&nbsp;&nbsp;&nbsp;见&nbsp;&nbsp; 
								</p>
							</div>
						</td>
						<td colspan="6" >
							<textarea rows="5" cols="70"    name="zgldyj" id="zgldyj"></textarea>
							<div class="div80">
								<div class="divLeftFloat">
									签名：
									<input type="text" class="underline" name="zgldqm" id="zgldqm"
										onfocus="underwrite(this)"    style="width: 50px" />
								</div>
								<div>
									日期：
									<input type="text" class="underline" onClick="WdatePicker()"
										name="zgldrq"    id="zgldrq" readonly style="width: 80px" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" >
							<div align="center">
								&nbsp;&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;
							</div>
						</td>
						<td colspan="6" >
							<div id="wpzf" style="display:none;" align="left">&nbsp;&nbsp;&nbsp;图斑编号：<input type="text" name="tbbh" id="tbbh" style="width:150px;">&nbsp;&nbsp;&nbsp;图斑监测面积：<input type="text" name="jcmj" id="jcmj" style="width:150px;"><br/>&nbsp;&nbsp;&nbsp;地块编号：<input type="text" name="dkbh" id="dkbh" style="width:150px;"></div>
							
							<%if(permission.equals("yes")){ %>	
							<hr>
							<div id="xfsxDiv2" style="display:none;" align="left">
								&nbsp;&nbsp;&nbsp;
								信访事项：<input type="text" name="xfsx" id="xfsx" onchange="textChange('0')" />
								上级交办：<input type="text" name="sjjb" id="sjjb" onchange="textChange('0')" /><br>
								&nbsp;&nbsp;&nbsp;
								转办：<input type="text" name="zb" id="zb" onchange="textChange('0')" />
							</div>							
							<%}else{ %>
							<div id="xfsxDiv" style="display:none;" align="left">
								&nbsp;&nbsp;&nbsp;
								<input type="radio" name="xfsx" id="xfsx1" onclick="showDiv(this)" value="上级交办"/>上级交办
								<input type="radio" name="xfsx" id="xfsx2" onclick="showDiv(this)" value="转办"/>转办
								<input type="radio" name="xfsx" id="xfsx3" onclick="showDiv(this)" value="群众上访"/>群众上访 
								<input type="radio" name="xfsx" id="xfsx4" onclick="showDiv(this)" value="其他"/>其他
									<div id="sjjbDiv" style="display:none"> 
									&nbsp;&nbsp;&nbsp;
										<input type="radio" name="sjjb" id="sjjb1" value="国土资源部"/>国土资源部
										<input type="radio" name="sjjb" id="sjjb2" value="土地督察局"/>土地督察局
										<input type="radio" name="sjjb" id="sjjb3" value="国土资源厅"/>国土资源厅
										<input type="radio" name="sjjb" id="sjjb4" value="市政府"/>市政府
									</div>
									<div id="zbDiv" style="display:none">
									&nbsp;&nbsp;&nbsp;
										<input type="radio" name="zb" id="zb1" value="12345"/>12345
										<input type="radio" name="zb" id="zb2" value="新闻媒体"/>新闻媒体
									</div>							
							</div>
							<%} %>
							<textarea rows="5" cols="70"    name="bz" id="bz">
								
							</textarea>
						</td>
					</tr>
				</table>
			</form>
			<br />
		</div>
	</body>
	<script>
<%
if(!permission.equals("yes")){%>
	document.body.onload = initEdit;
<%}else if(permission.equals("yes")){%>
	addBorders();
	document.getElementById('wpzf').style.display='block';
	document.getElementById('xfsxDiv2').style.display='block';
<%}%>
<%
	String msg = (String)request.getParameter("msg");
%>

if("<%=msg%>" == "success"&&"<%=permission%>"=="yes"){
	alert("表单权限保存成功");
}else if("<%=msg%>" == "success"){
	alert("表单保存成功");  
}

function showBZ1(text){
if(text.checked){
	document.getElementById('wpzf').style.display='block';
}else{
	document.getElementById('wpzf').style.display='none';
}

}

function showBZ2(text){
if(text.checked){
	document.getElementById('xfsxDiv').style.display='block';
}else{
	document.getElementById('xfsxDiv').style.display='none';
}	
}

function showDiv(text){
	if(text.checked){
		if(text.value=='上级交办'){
			document.getElementById('sjjbDiv').style.display='block';
			document.getElementById('zbDiv').style.display='none';
		}
		if(text.value=='转办'){
			document.getElementById('sjjbDiv').style.display='none';
			document.getElementById('zbDiv').style.display='block';
		}
		if(text.value=='群众上访'){
			document.getElementById('sjjbDiv').style.display='none';
			document.getElementById('zbDiv').style.display='none';
		}
		if(text.value=='其他'){
			document.getElementById('sjjbDiv').style.display='none';
			document.getElementById('zbDiv').style.display='none';
		}
	}
}

</script>
</html>
