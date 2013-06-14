<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//获取当前登录用户
	Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	User userBean = (User) user;
	//获取市级行政区划
    String jnXsq = UtilFactory.getXzqhUtil().generateOptionByList(UtilFactory.getXzqhUtil().getChildListByParentId("370100"));
	String userName = userBean.getFullName();
    String edit = request.getParameter("edit");
	String permission = request.getParameter("permission");
	if (permission == null) {
		permission = "no";
	}
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
   String lwsjData= df.format(new Date());
    System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>
 		<base href="<%=basePath%>"/>
		<title>信访事项登记表</title>
		<%if(permission.equals("yes")){ %>
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<link rel="stylesheet"
			href="<%=basePath%>web/default/ajgl/css/lacpb.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<script src="<%=basePath%>web/jinan/xfaj/xzxfaj/js/WdatePicker.js"></script>
		<%} %>
<style>
table
{
background-color:#ffffff;
margin-bottom:10px;
}

</style>
<script type="text/javascript">
	//初始化
function initEdit(){
			init();
			loadXsq();
			xianShiYCX();//加载页面时显示隐藏项
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
	document.forms[0].submit(); 
}  

function lwlxChange(level){
  
    var path = "<%=basePath%>";
	var actionName = "xfaj";
	var actionMethod = "getLWJG";
	var lwlx=level.value;
	lwlx=escape(escape(lwlx));
	var parameter = "code=" + lwlx;
	var myData = ajaxRequest(path, actionName, actionMethod, parameter);
   if(myData!=""){
   var selectPlace=document.getElementById("lwjg");
	selectPlace.options.length = 0; 
    var obj = eval('(' + myData + ')');
	for(var i = 0; i < obj.length; i++){
		var opt = document.createElement('option');
		opt.text = obj[i].name;
		opt.value = obj[i].code;
		selectPlace.options.add(opt, 0);
	  }
   }
}
//加载 济南市 县（市）区
function loadXsq(){
  var obj = eval('(<%=jnXsq%>)');
	select = document.getElementById("xsq");
	if(obj != ""){ 
		for(var i = 0; i < obj.length; i++){
			var opt = document.createElement('option');
			opt.text = obj[i].name;
			opt.value = obj[i].name;
			select.options.add(opt);
		}
	}
}
//来文机关
function lwjgChange(level){
  if(level.value=='其他部门'){
      document.getElementById("qtbm").style.display='inline';
   }
   else{
     document.getElementById("qtbm").style.display='none';
   }
}
//举报类型
function jblxRadio(){
   var jblxradio=document.getElementsByName("jblx");
   for(var i=0;i<jblxradio.length;i++){
      if(jblxradio[i].checked==true){
      	var selectValue=jblxradio[i].value;
      	if(selectValue=="土地"){
      	  document.getElementById("fzdzscyjTR").style.display='block';//"副支队长审查意见"可见
      	  document.getElementById("sjyjTR").style.display='none';//"书记意见"不可见
      	}
      	//选择"矿产"时
      	else{
      	  document.getElementById("fzdzscyjTR").style.display='none';
      	  document.getElementById("sjyjTR").style.display='block';
      	}
      }
   }
}
//显示隐藏项
function xianShiYCX(){
  var tform=document.getElementById("form");
  for(var i=0;i<tform.length;i++){
  	if(tform[i].type=="radio"){
  	   if(tform[i].checked && tform[i].value=="土地"){
  	  	 document.getElementById("fzdzscyjTR").style.display='block';//"副支队长审查意见"可见
      	 document.getElementById("sjyjTR").style.display='none';//"书记意见"不可见
  	   }
  	   if(tform[i].checked && tform[i].value=="矿产") {
  	  	document.getElementById("fzdzscyjTR").style.display='none';
      	document.getElementById("sjyjTR").style.display='block';
  	   }
  	}
  	 //来文机关为其他部门
  	if(document.getElementById("lwjg").value=="其他部门"){
  	    document.getElementById("qtbm").style.display='inline';
  	}
  }
}
</script>
</head>
<body bgcolor="#FFFFFF">
<div id="fixed" class="Noprn"
			style="position: fixed; top: 5px; left: 0px"></div>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">  
					信访事项登记表</div><br/>
<form id="form" method="post">

<table class="" width="600" cellspacing="0" cellpadding="0" align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29">
  <tr>
    <td  width="100">来文号</td>
	<td  align="left" colspan="2">
		<input id="wh" name="wh" type="text" class="noborder" />
	</td>
	<td width="80">来文时间</td>
	<td align="left" >
		<input id="lwsj" name="lwsj" type="text" class="noborder" value="<%=lwsjData %>" onclick="WdatePicker()" readonly="readonly"  />
	</td>
  </tr>
  <tr>
    <td >办理期限</td>
    <td colspan="2"><input id="blqx" name="blqx" type="text" onclick="WdatePicker()" readonly="readonly"/></td>
    <td >承办部门</tb>
    <td ><input id="cbbm_1" name="cbbm_1" type="text"  /></td>
  </tr>
  <tr>
    <td>来文类型</td>
    <td colspan="2" align="left">
      <%if(permission.equals("yes")){
      %>	<input class="noborder" name="lwlx" id="lwlx" style="width: 80%;height:80% "/>
      <%}else{%>
      <select id="lwlx" name="lwlx" onchange="lwlxChange(this)">
      	<option value="请选择">请选择 </option>
      	<option value="上级交办">上级交办</option>
      	<option value="转办">转办</option>
      	<option value="群众上访">群众上访</option>
      	<option value="其他">其他</option>
      </select>
     <%} %>
    </td>
    <td>来文机关</td>
    <td align="left">
       <%if(permission.equals("yes")){
       %>	
       <input class="noborder" name="lwjg" id="lwjg" style="width: 80px;height:20px "/>
       <input class="noborder" id="qtbm" name="qtbm" style="width: 80px;height:20px "/>
      <%}else{%>
           <select id="lwjg" name="lwjg" onchange="lwjgChange(this);">
           </select>
           <input type="text" id="qtbm" name="qtbm"  style="display:none;border-bottom:1px solid black;width:100px;"/>
      <%} %>
    </td>
  </tr>
  <tr>
    <td>转办时间</td>
    <td colspan="2"><input id="zbsj_1" name="zbsj_1" type="text" onclick="WdatePicker()" readonly="readonly" /></td>
    <td>转办部门</td>
    <td ><input id="zbbm" name="zbbm" type="text" /></td>
  </tr>
  <tr>
      <td><div align="center">
			事项主<br/>
			要内容
	      </div>
	   </td>
      <td colspan="4" >
       	 <table >
       	 	<tr>
       	 		<td style="border: 0;" >
       	 		     <%if(permission.equals("yes")){
       	 		     %><input class="noborder" name="xsq" id="xsq" style="width:30;height:80% "/>
                     <%}else{%>
       	 		     <select id="xsq" name="xsq"></select>
       	 		     <%} %>
       	 		 </td>
       	 		<td style="border: 0;" width="80">县（市）区</td>
       	 		<td style="border: 0;">
       	 		     <input id="xz" name="xz" type="text" style="border-bottom:1px solid black;"/></td>
       	 		<td style="border: 0;" width="80">乡镇（办）</td>
       	 		<td style="border: 0;">
       	 		     <input id="c" name="c" type="text" style="border-bottom:1px solid black;"/></td>
       	 	    <td style="border: 0;" width="70">村（居）</td>
       	 	</tr>
       	 	<tr>
       	 		<td colspan="1" style="border: 0;">举报人 ：</td>
       	 		<td style="border: 0;" align="right">
       	 		     <input id="jbr" name="jbr" type="text" style="border-bottom:1px solid black;"/></td>
       	 		<%if(permission.equals("yes")){ %>					
    		    <td colspan="3" style="border: 0;">举报类型：<input class="noborder" name="jblx" id="jblx" /></td>
   				<%}else{ %>
   				<td style="border: 0;" colspan="4">举报类型：
       	 		<input type="radio" name="jblx" value="土地" onclick="jblxRadio();"/> 土地
       	 		<input type="radio" name="jblx" value="矿产" onclick="jblxRadio();"/> 矿产</td>
       	 		<%} %>
       	 	</tr>
       	 </table>
       </td>
   </tr>
   <tr>
   	 <td rowspan="2">办理情况</td>
     <td width="80">承办部门</td>
     <td> <input id="cbbm_2" name="cbbm_2" type="text" /></td>
     <td>承办人员</td>
     <td colspan="2">
       <input id="cbry" name="cbry" type="text" /></td>
   </tr>
   <tr>
   	 <td >办结情况</td>
   	 <td  colspan="3">
   	 <textarea id="bjqk" name="bjqk" cols="60" rows="4"></textarea></td>
   </tr>
   <tr>
	<td>
	  <div align="center">
		<p>
		大队长
		<br/>
		意&nbsp;&nbsp;&nbsp;见 
		</p>
		</div>
	</td>
	<td colspan="4" >
		<textarea rows="5" cols="70" name="ddzyj" id="ddzyj"></textarea>
			<div class="div80">
				<div class="divLeftFloat">
					签名：
					<input type="text" class="underline" name="ddzyj_qz" id="ddzyj_qz"
						onfocus="underwrite(this)" style="width: 50px" />
				</div>
				<div class="divLeft200">
					日期：
					<input type="text" class="underline" onClick="WdatePicker()"
									name=ddzyj_rq id="ddzyj_rq" readonly style="width: 80px" />
				</div>
			</div>
	</td>
 </tr>
 <tr>
	<td>
	  <div align="center">
		<p>
		承办人
		<br/>
		意&nbsp;&nbsp;&nbsp;见 
		</p>
		</div>
	</td>
	<td colspan="4" >
		<textarea rows="5" cols="70" name="cbryj" id="cbryj"></textarea>
			<div class="div80">
				<div class="divLeftFloat">
					签名：
					<input type="text" class="underline" name="cbr_qz" id="cbr_qz"
						onfocus="underwrite(this)" style="width: 50px" />
				</div>
				<div class="divLeft200">
					日期：
					<input type="text" class="underline" onClick="WdatePicker()"
									name=cbr_qr id="cbr_qr" readonly style="width: 80px" />
				</div>
			</div>
	</td>
 </tr> 
   <tr>
	<td>
	  <div align="center">
		<p>
		大队长审
		<br/>
		核&nbsp;&nbsp;意&nbsp;&nbsp;见 
		</p>
		</div>
	</td>
	<td colspan="4" >
		<textarea rows="5" cols="70" name="ddzshyj" id="ddzshyj"></textarea>
			<div class="div80">
				<div class="divLeftFloat">
					签名：
					<input type="text" class="underline" name="ddzsh_qz" id="ddzsh_qz"
						onfocus="underwrite(this)" style="width: 50px" />
				</div>
				<div class="divLeft200">
					日期：
					<input type="text" class="underline" onClick="WdatePicker()"
									name="ddzsh_rq" id="ddzsh_rq" readonly style="width: 80px" />
				</div>
			</div>
	</td>
 </tr>  
  <tr style="display: none" id="fzdzscyjTR">
	<td>
	  <div align="center" >
		<p>
		副支队长
		<br/>
		审查意见 
		</p>
		</div>
	</td>
	<td colspan="4" >
		<textarea rows="5" cols="70" name="fzdzscyj" id="fzdzscyj"></textarea>
			<div class="div80">
				<div class="divLeftFloat">
					签名：
					<input type="text" class="underline" name="fzdzscyj_qz" id="fzdzscyj_qz"
						onfocus="underwrite(this)" style="width: 50px" />
				</div>
				<div class="divLeft200">
					日期：
					<input type="text" class="underline" onClick="WdatePicker()"
									name="fzdzscyj_rq" id="fzdzscyj_rq" readonly style="width: 80px" />
				</div>
			</div>
	</td>
 </tr>  
 <tr style="display: none" id="sjyjTR">
	<td>
	  <div align="center">
		<p>
		书记意见 
		</p>
		</div>
	</td>
	<td colspan="4" >
		<textarea rows="5" cols="70" name="sjyj" id="sjyj"></textarea>
			<div class="div80">
				<div class="divLeftFloat">
					签名：
					<input type="text" class="underline" name="sjyj_qz" id="sjyj_qz"
						onfocus="underwrite(this)" style="width: 50px" />
				</div>
				<div class="divLeft200">
					日期：
					<input type="text" class="underline" onClick="WdatePicker()"
									name="fzdzscyj_rq" id="fzdzscyj_rq" readonly style="width: 80px" />
				</div>
			</div>
	</td>
 </tr>  
 <tr>
	<td>
	  <div align="center">
		<p>
		支队长	
		<br/>
		意&nbsp;&nbsp;&nbsp;见 
		</p>
		</div>
	</td>
	<td colspan="4" >
		<textarea rows="5" cols="70" name="zdzyj" id="zdzyj"></textarea>
			<div class="div80">
				<div class="divLeftFloat">
					签名：
					<input type="text" class="underline" name="zdzyj_qz" id="zdzyj_qz"
						onfocus="underwrite(this)" style="width: 50px" />
				</div>
				<div class="divLeft200">
					日期：
					<input type="text" class="underline" onClick="WdatePicker()"
									name="zdzyj_rq" id="zdzyj_rq" readonly style="width: 80px" />
				</div>
			</div>
	</td>
 </tr>  
 <tr>
   	  <td>
	   	  <div align="center">
	   	  备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注
	   	  </td>
   	  <td colspan="4">
   	   <textarea id="bz" name="bz" crows="5" cols="70"></textarea>
   	   	<div class="div80">
				<div class="divLeftFloat">&nbsp;
				</div>
				<div class="divLeft200">&nbsp;
				</div>
			</div>
   	  </td>
   </tr>  
   
 </table>
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
</form>
</div>
</body>
</html>