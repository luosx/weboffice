<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%
	request.setCharacterEncoding("utf-8");
	String yw_guid  = request.getParameter("yw_guid");
 	String xmmc=new String(request.getParameter("xmmc").getBytes("ISO8859-1"),"UTF-8"); 	
 	String xzqmc=new String(request.getParameter("xzqmc").getBytes("ISO8859-1"),"UTF-8");
	String rwlx=new String(request.getParameter("rwlx").getBytes("ISO8859-1"),"UTF-8");
	String sfwf=new String(request.getParameter("sfwf").getBytes("ISO8859-1"),"UTF-8");;
	String xcr=new String(request.getParameter("xcr").getBytes("ISO8859-1"),"UTF-8");
	String xcrq = request.getParameter("xcrq");
	String zmj = request.getParameter("zmj");
	String xcqkms=new String(request.getParameter("xcqkms").getBytes("ISO8859-1"),"UTF-8");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%@ include file="/base/include/restRequest.jspf" %>
    <%@ include file="/base/include/ext.jspf" %>
<script language="javascript">
window.onload=function(){
	document.getElementById("taskid").value="<%=yw_guid%>"; 
	document.getElementById("taskname").value="<%=xmmc%>";
	document.getElementById("code").value="<%=xzqmc%>"; 
	document.getElementById("taskclass").value="<%=rwlx%>";
	//document.getElementById("isillagel").value="< %=sfwf%>";
	var illagelType = document.getElementById("isillagel");
	for(var i=0;i<illagelType.options.length;i++){
         if(illagelType.options[i].text == "<%=sfwf%>"){ 
             illagelType.options[i].selected = true;
             break;
         }
     }
	document.getElementById("tasker").value="<%=xcr%>"; 
	document.getElementById("date").value="<%=xcrq%>";
	document.getElementById("zmj").value="<%=zmj%>";
	document.getElementById("xcqkms").value="<%=xcqkms%>";
}
</script>

<style type="text/css">
	body{height:600px;} 
	.container, .container img{width:600px; height:400px;border:0;vertical-align:top;}
	.container ul, .container li{list-style:none;margin:0;padding:0;}
	.num{ position:absolute; right:5px; bottom:5px; font:12px/1.5 tahoma, arial; height:18px;}
	.num li{
	    float: left;
	    color: #d94b01;
	    text-align: center;
	    line-height: 16px;
	    width: 16px;
	    height: 16px;
	    font-family: Arial;
	    font-size: 11px;
	    cursor: pointer;
	    margin-left: 3px;
	    border: 1px solid #f47500;
	    background-color: #fcf2cf;
	}
	.num li.on{
	    line-height: 18px;
	    width: 18px;
	    height: 18px;
	    font-size: 14px;
	    margin-top:-2px;
	    background-color: #ff9415;
	    font-weight: bold;
	    color:#FFF;
	}
	
	td{border-right:1px solid  #8470FF; border-bottom:1px solid  #8470FF; border-left:0; border-top:0; font-size:12px;
		padding:3px 3px 3px 3px;
	
	
	}
	.tableBorder{
			border-top:1px solid #8470FF;
			border-left:1px solid #8470FF;
	}
    input{
     border:0px;

    }
    textarea{
     border:0px;
    } 
</style>
<script type="text/javascript">
	function saveInfo(){
		var rwbh = document.getElementById("taskid").value;
		var xmmc  = document.getElementById("taskname").value;  
		var xzqmc  = document.getElementById("code").value; 
		var rwlx  = document.getElementById("taskclass").value; 
		var sfwf  = document.getElementById("isillagel").value;  
		var xcr  = document.getElementById("tasker").value; 
		var xcrq  = document.getElementById("date").value; 
		var zmj  = document.getElementById("zmj").value; 
		var xcqkms  = document.getElementById("xcqkms").value; 
		var actionName = "savePadDataAC";  
		var actionMethod = "savePadData";  
		var parameter="rwbh="+rwbh+"&xmmc="+encodeURI(unescape(xmmc))+"&xzqmc="+encodeURI(unescape(xzqmc))+"&rwlx="+encodeURI(unescape(rwlx))+"&sfwf="+encodeURI(unescape(sfwf))+"&xcr="+encodeURI(unescape(xcr))+"&xcrq="+xcrq+"&xcqkms="+encodeURI(unescape(xcqkms))+"&zmj="+encodeURI(unescape(zmj));       
		var result = ajaxRequest('<%=basePath%>',actionName,actionMethod,parameter); 
		alert(result);
	}
</script>

<body >
<center>
	<div align="left" style="height:30px; font-weight:bold; font-size:14pt; font-family:黑体">
		<table cellpadding="0" cellspacing="0" width="670">
			<tr style="border: 0px;"><td style="border: 0px;width: 300px;">&nbsp;</td><td style="border: 0px;width: 350px;font-size: 16">现场核查情况</td><td style="border: 0px;"><br></td></tr>
		</table>
	</div>
	<table align="center" class="tableBorder" cellpadding="0" cellspacing="0" style="BACKGRsOUND-COLOR: white" width="670">
		<tr>
			<td colspan="4">任务编号：<input type="text"  id="taskid" readonly="readonly"/></td>
		</tr>
		<tr>
			<td align="right">项目名称：</td>
			<td width=35%> <input type="text" id="taskname" style="width:100%;"> </td>
			<td align="right">所在政区：</td>
			<td width=35%> <input type="text" id="code" style="width:100%;"> </td>
		</tr>
		<tr>
			<td align="right">任务类型：</td>
			<td width=30%> <input type="text"  id="taskclass" style="width:100%;"/></td>
			<td align="right">是否违法：</td>
			<td width=30%>
				<!--  <input type="text"  id="isillagel2" style="width:30px;"/> -->
				<select name="isillagel" id="isillagel" style="width: 100px;">  
			    	<option value="违法">违法</option> 
			    	<option value="合法">合法</option>
			    	<option value="不确定">不确定</option>
			    </select>  
			</td>
		</tr>
		<tr>
			<td align="right">巡查人：</td>
			<td width=30%><input type="text"  id="tasker" readonly="readonly"/></td>
			<td align="right">巡查日期：</td>
			<td width=30%><input type="text"  id="date" readonly="readonly"/></td>
		</tr>
		<tr>
			<td align="right">总面积：</td>
			<td width=30%  colspan="3"><input type="text"  id="zmj" /></td>
		</tr>
		<tr>
			<td align="right">备注：</td>
			<td colspan="3"><input type="text"  id="xcqkms" style="width:100%;"/></td> 
		</tr>
	 </table>
   </center>
</body>
</html>