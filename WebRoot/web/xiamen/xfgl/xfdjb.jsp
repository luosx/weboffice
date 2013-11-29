<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.web.xuzhouNW.xfjb.manager.XfAction"%>
<%@page import="java.text.DateFormatSymbols"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    String yw_guid = request.getParameter("yw_guid");
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    String wfInsId1 = "";
    IWorkflowOp workflow1 = null;
    String activityName1 ="";
    if(permission==null){
        permission = "no";
        wfInsId1 = request.getParameter("wfInsId");
		workflow1 = WorkflowOp.getInstance();
	    activityName1 = workflow1.getActivityNameByWfInsID(wfInsId1);
    }
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User)userprincipal).getUserID();
    String edit = request.getParameter("edit");
    String xzqh = ManagerFactory.getUserManager().getUserWithId(userid).getXzqh();
    String name = UtilFactory.getXzqhUtil().getBeanById(xzqh).getCatonname();
       SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd", new DateFormatSymbols());
 		String dateString = df.format(Calendar.getInstance().getTime());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<title>信访举报</title>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<style> 
		div{ display:inline}
		input {  BORDER-RIGHT: #ffffff 1px solid;
		         BORDER-TOP: #ffffff 1px solid;
		         FONT-SIZE: 14px;
		         BORDER-LEFT: #ffffff 1px solid;
		         COLOR: #ffffff ;
		         BORDER-BOTTOM: #ffffff 1px solid;
		         FONT-FAMILY:"宋体","Verdana"}
		 </style>
		<script>
		function initEdit(){
			init();
			butt();
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
			function refresh(){
				document.location.refresh();
			}
		</script>
		
	</head>
	
<body bgcolor="#FFFFFF">
<div id="butt" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
 <%if(fixed!=null){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%}%>
<div style="margin:20px" class="tablestyle1" align="center" /><br />
<div align="center"><font style="font: bold 16px '黑体','微软雅黑' ">厦门市国土资源与房产管理局12336违法举报登记处理表</font></div><br/><br />
<form method="post">
<div style="width: 600px">
<div align="left">登记号：厦国土房值班举<input class="noborder" name="bh" id="bh" style="width: 60px"/>号</div>&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div align="right">日期：<input  type="text" class="noborder" id="rq" name="rq" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly style="width: 100px"/></div>
</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
<tr><td width="70px">举报人</td>
<td width="140"><input class="noborder" name="jbr" id="jbr" style="width: 95%"/></td>
<td width="70px">性别</td>
<td width="120px"><input  type="radio" name="xb" value="男"  checked="checked"/>男<input  type="radio" name="xb" value="女"/>女</td>
<td width="70px">举报形式</td>
<td ><input  type="radio" name="jbxs" value="电话"  checked="checked"/>电话<input  type="radio" name="jbxs" value="传真"/>传真</td>
</tr>
<tr><td>联系地址</td><td colspan="3">
<input class="noborder" name="lxdz" id="lxdz" style="width: 95%"/></td>
<td>所在政区</td>
<td><select name="xzq" ><option selected="selected" value="厦门市" >市局</option>
							<option value="直属区">直属区</option>
							<option value="集美区">集美区</option>
							<option value="海沧区">海沧区</option>
							<option value="同安区">同安区</option>
							<option value="翔安区" >翔安区</option>
							</select></td>
</tr>
<tr>
<td>举报时间</td>
<td><input  type="text" class="noborder" id="jbsj" name="jbsj" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly style="width: 98%"/></td>
<td>联系电话</td>
<td><input class="noborder" name="lxdh" id="lxdh" style="width: 95%"/></td>
<td>来电次数</td>
<td><input class="noborder" name="ldcs" id="ldcs" style="width: 95%"/></td>
</tr>
<tr>
<td align="center">举<br />报<br />主<br />要<br />问<br />题</td>
<td colspan="5"><textarea rows="8" name="jbzywt" id="jbzywt" style="width: 99%"></textarea></td>
</tr>
<tr>
<td align="center">值班员<br />办理情<br />况</td>
<td colspan="5"><textarea rows="5" name="zbyblqk" id="zbyblqk" style="width: 99%"></textarea> </td>
</tr>
<tr>
<td>接收人</td>
<td colspan="2"><input class="noborder"  type="text"   name="jsr" id="jsr" style="width: 95%;"/></td>
<td>记录人</td>
<td colspan="2"><input class="noborder"  type="text"   name="jlr" id="jlr" style="width:95%;"/></td>
</tr>
</table>
</form>
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

function butt(){
	var butt = document.getElementById("butt");
		if(<%=fixed %>!= null){
	    	butt.innerHTML = '<img src="base/form/images/save.png" onclick="formSave()" style="cursor:hand" title="保存"/><br /><img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>';
	    }else{
	    	butt.innerHTML = '<img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>';
        }
}
</script>
</html>