<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%

	request.setCharacterEncoding("utf-8");

	String guid  = request.getParameter("guid");
 	String xmmc=new String(request.getParameter("xmmc").getBytes("ISO8859-1"),"UTF-8"); 	
 	String yddw=new String(request.getParameter("yddw").getBytes("ISO8859-1"),"UTF-8");
	String ydsj= request.getParameter("ydsj");
	String ydwz=new String(request.getParameter("ydwz").getBytes("ISO8859-1"),"UTF-8");
	String ydxz=new String(request.getParameter("ydxz").getBytes("ISO8859-1"),"UTF-8");
	String jsqk=new String(request.getParameter("jsqk").getBytes("ISO8859-1"),"UTF-8");
	String xcr=new String(request.getParameter("xcr").getBytes("ISO8859-1"),"UTF-8");
    String bz=new String(request.getParameter("bz").getBytes("ISO8859-1"),"UTF-8");
	String xcrq= request.getParameter("xcrq");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%@ include file="/base/include/restRequest.jspf" %>
    <%@ include file="/base/include/ext.jspf" %>
<script language="javascript">
window.onload=function(){
	document.getElementById("guid").value="<%=guid%>"; 
	document.getElementById("xmmc").value="<%=xmmc%>";
	document.getElementById("yddw").value="<%=yddw%>"; 
	document.getElementById("ydsj").value="<%=ydsj%>";
    document.getElementById("ydxz").value="<%=ydxz%>";
	document.getElementById("jsqk").value="<%=jsqk%>"; 
	document.getElementById("xcr").value="<%=xcr%>";
	document.getElementById("xcrq").value="<%=xcrq%>";
	document.getElementById("bz").value="<%=bz%>";
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
			<td colspan="4">任务编号：<input type="text"  id="guid" readonly="readonly"/></td>
		</tr>
		<tr>
			<td align="right">项目名称：</td>
			<td width=35%> <input type="text" id="xmmc" style="width:100%;"> </td>
			<td align="right">用地单位：</td>
			<td width=35%> <input type="text" id="yddw" style="width:100%;"> </td>
		</tr>
		<tr>
			<td align="right">用地时间：</td>
			<td width=30%> <input type="text"  id="ydsj" style="width:100%;"/></td>
			<td align="right">用地性质：</td>
			<td width=30%><input type="text"  id="ydxz" style="width:30px;"/></td>
		</tr>
		<tr>
			<td align="right">巡查人：</td>
			<td width=30%><input type="text"  id="xcr" readonly="readonly"/></td>
			<td align="right">巡查日期：</td>
			<td width=30%><input type="text"  id="xcrq" readonly="readonly"/></td>
		</tr>
		<tr>
			<td align="right">建设情况：</td>
			<td width=30%  colspan="3"><input type="text"  id="jsqk" /></td>
		</tr>
		<tr>
			<td align="right">备注：</td>
			<td colspan="3"><input type="text"  id="bz" style="width:100%;"/></td> 
		</tr>
	 </table>
   </center>
</body>
</html>