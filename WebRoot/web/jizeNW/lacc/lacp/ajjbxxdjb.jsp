<%@ page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    if(permission==null){
        permission = "no";
    }
    String edit = request.getParameter("edit");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<TITLE>案件基本信息登记表</TITLE>
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
		<%} %>
		<script type="text/javascript" src="<%=basePath%>/web/jizeNW/lacc/js/sign.js"></script>
		<script>
		
		function initEdit(){
			init();
		}
			function save(){			
				document.forms[0].submit();
			}
			function refresh(){
				document.location.refresh();
			}
		</script>
		<style type="text/css">
		fieldset {
			width:600px;
		}
		</style>
	</head>
<body bgcolor="#FFFFFF">
<% 
if(fixed!=null && fixed.equals("fixedPrint")){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%	
}else if(!"false".equals(edit)){%>
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<% } %>
<div style="margin:20px" class="tablestyle1" align="center" >
<div align="center"><h1>案件基本信息登记表</h1></div>
<form method="post">
  <fieldset>
    <legend>责令停止（改正）违法行为通知书</legend>
     编号：<input type="text" name="zltzwfxwtzs_bh" id="zltzwfxwtzs_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     下达日期：<input type="text" name="zltzwfxwtzs_xdrq" id="zltzwfxwtzs_xdrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset> 
  <fieldset>
    <legend>立案</legend>
    编号：<input type="text" name="la_bh" id="la_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    批准日期：<input type="text" name="la_pzrq" id="la_pzrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset>	
  <fieldset>
    <legend>处罚（听证）告知书</legend>
     编号：<input type="text" name="cftzgzs_bh" id="cftzgzs_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     下达日期：<input type="text" name="cftzgzs_xdrq" id="cftzgzs_xdrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset> 
  <fieldset>
    <legend>处罚决定书</legend>
    编号：<input type="text" name="cfjds_bh" id="cfjds_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    下达日期：<input type="text" name="cfjds_xdrq" id="cfjds_xdrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset>  
  <fieldset>
    <legend>责令履行法定义务通知书</legend>
     编号：<input type="text" name="zllxfdywtzs_bh" id="zllxfdywtzs_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     下达日期：<input type="text" name="zllxfdywtzs_xdrq" id="zllxfdywtzs_xdrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset> 
  <fieldset>
    <legend>党政纪处分建议书（纪检、监察部门）</legend>
    编号：<input type="text" name="dzjcfjys_bh" id="dzjcfjys_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    移送日期：<input type="text" name="dzjcfjys_ysrq" id="dzjcfjys_ysrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset>   
  <fieldset>
    <legend>涉嫌犯罪案件移送书（公安、检察机关）</legend>
     编号：<input type="text" name="sxfzajyss_bh" id="sxfzajyss_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     移送日期：<input type="text" name="sxfzajyss_ysrq" id="sxfzajyss_ysrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset>  
  <fieldset>
    <legend>强制执行申请书（法院）</legend>
    编号：<input type="text" name="qzzxsqs_bh" id="qzzxsqs_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    移送日期：<input type="text" name="qzzxsqs_ysrq" id="qzzxsqs_ysrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset>  	 
  <fieldset>
    <legend>非法财物移交书（国资、财政部门）</legend>
     编号：<input type="text" name="ffcwyjs_bh" id="ffcwyjs_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     移送日期：<input type="text" name="ffcwyjs_ysrq" id="ffcwyjs_ysrq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset> 
  <fieldset>
    <legend>结案呈批表</legend>
    编号：<input type="text" name="jacpb_bh" id="jacpb_bh" style="width:150px;border:1px #ccc solid;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    结案日期：<input type="text" name="jacpb_jarq" id="jacpb_jarq" style="width:150px;border:1px #ccc solid;background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
  </fieldset>   
  <fieldset>
  	<legend>未立案（结案）原因</legend>
  	<textarea rows="3" name="wlajayy" id="wlajayy" style="width: 99%;border:1px #ccc solid;font-size:14px;"></textarea>
  </fieldset>  
  <fieldset>
  	<legend>区域监管责任人</legend>
  	<input type="text" name="qyjgzrr" id="qyjgzrr" style="width:99%;border:1px #ccc solid;"/>
  </fieldset>   
  <fieldset>
  	<legend>备注</legend>
  	<textarea rows="3" name="bz" id="bz" style="width: 99%;border:1px #ccc solid;font-size:14px;"></textarea>
  </fieldset>  	
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
