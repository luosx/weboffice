<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<title>信访举报</title>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<script>
		function initEdit(){
			init();
			if(edit=='false'){
				 var formlist = document.getElementById('form');
        		 for(var i=0;i<formlist.length;i++)
         		 {
             			if(formlist[i].type=='text'||formlist[i].type=='textarea'||formlist[i].type=='select-one')
             				formlist[i].disabled=true;
         		 }		
			}
			document.getElementById('bh2').value=document.getElementById('bh').value;
			//当流程节点是支队审核，表单是否立案选择是的时候，启动立案查处流程
			startLaccWorkflow();
		}
				
			function save(){
				document.forms[0].submit();
			}
			function refresh(){
				document.location.refresh();
			}
		//添加、查看地图标注
		function createbz(){
			window.open("<%=basePath%>web/xuzhouNW/xfaj/xfbz/xfbz.jsp?yw_guid=12",'','width='+(window.screen.availWidth-10)+',height='+(window.screen.availHeight-30));
		}
		</script>
		<style> div{ display:inline} </style>
	</head>
	
<body bgcolor="#FFFFFF">
<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 5px"><img src="base/form/images/save.png" onclick="formSave()" style="cursor:hand" title="保存"/></div>
<div id="fixedPrint" class="Noprn" style="position: fixed; top: 30px; left: 5px"><img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/></div>
<div style="margin:20px" class="tablestyle1" align="center" />
<div align="center"><h4>厦门市国土资源与房产管理局12336违法举报登记处理表</h4></div><br/>
<form method="post">
<div style="width: 300px">登记号：厦国土房值班举【2013】<input class="noborder" name="bh" id="bh" style="width: 20px"/>号</div>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div style="width: 300px">20<input class="noborder" name="n" id="n" style="width: 20px"/>年
       <input class="noborder" name="y" id="y" style="width: 20px"/>月
       <input class="noborder" name="r" id="r" style="width: 20px"/>日</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
<tr><td width="60px">举报人</td>
<td width="140"><input class="noborder" name="jbr" id="jbr" style="width: 95%"/></td>
<td width="60px">性别</td>
<td width="120px"><input  type="radio" name="xb" value="男"  checked="checked"/>男<input  type="radio" name="xb" value="女"/>女</td>
<td width="60px">举报形式</td>
<td width="160"><input  type="radio" name="jbxs" value="电话"  checked="checked"/>电话<input  type="radio" name="jbxs" value="传真"/>传真</td>
</tr>
<tr><td>联系地址</td><td colspan="5"><input class="noborder" name="lxdz" id="lxdz" style="width: 95%"/></td>
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
<td>举<br />报<br />主<br />要<br />问<br />题</td>
<td colspan="5"><textarea rows="8" name="jbzywt" id="jbzywt" style="width: 99%"></textarea></td>
</tr>
<tr>
<td>值班员<br />办理情<br />况</td>
<td colspan="5"><textarea rows="5" name="zbyblqk" id="zbyblqk" style="width: 99%"></textarea> </td>
</tr>
</table>
<div style="width: 290px" align="left">接收人：<input class="underline" type="text"  onfocus="underwrite(this)" name="jsr" id="jsr" style="width: 150px;"/></div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div style="width: 290px" align="right">记录人：<input class="underline" type="text"  onfocus="underwrite(this)" name="jlr" id="jlr" style="width:150px;"/></div>
</form>
</body>
</html>