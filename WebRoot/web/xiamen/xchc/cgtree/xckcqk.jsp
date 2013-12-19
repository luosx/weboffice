<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.PADDataManager"%>
<%@page import="com.klspta.web.jizeNW.xfjb.XfjbManager"%>
<%@page import="com.klspta.web.xiamen.xchc.XchcData"%>
<%
    String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";

String yw_guid = request.getParameter("yw_guid");
String returnPath = request.getParameter("returnPath");
Object principal1 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String userid = ((User)principal1).getUserID();
if(yw_guid == null || yw_guid.equals("")){
	//yw_guid不存在时，创建一个新的yw_guid
	yw_guid = new XchcData().SetNewRecord(userid);
}
Map<String, Object> map = new PADDataManager().getXckcqkData(yw_guid);
String host = UtilFactory.getConfigUtil().getConfig("ftp.host");
int port = Integer.parseInt(UtilFactory.getConfigUtil().getConfig("ftp.port"));
String username = UtilFactory.getConfigUtil().getConfig("ftp.username");
String password = UtilFactory.getConfigUtil().getConfig("ftp.password");
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>现场巡查情况</title>
		<script src="SlideTrans.js"></script>
		<%@ include file="/base/include/newformbase.jspf"%>
		<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
			
				<style type="text/css">
body {
	height: 700px;
}
input{
	height:25px;
	background:none;
	
}

.container,.container img {
	width: 600px;
	height: 400px;
	border: 0;
	vertical-align: top;
}

.container ul,.container li {
	list-style: none;
	margin: 0;
	padding: 0;
}

</style>
			
		<script language="javascript">
	  function back(){
	   this.parent.location.href="<%=returnPath%>";
	  }
	    	//保存表单方法
	function save(){
			document.forms[0].submit(); 
	}

</script>
	</head>
	<body onLoad="init(); return false;" style="text-align: left;">&nbsp; 
 	<div align="left" id="fixed" class="Noprn" style="position: fixed; top: 5px; left:0px"></div>	
	<div align="center" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
					实地巡查情况表
			</div>
			<br>
	<form method="post">
		<table width="600px" cellspacing="0" cellpadding="0"
			 align='center' border='1'
			style="text-align: center; border-left:1px solid #2C2B29; border-top:1px solid #2C2B29; border-bottom:none; background:#ffffff">
			<tr>
				<td width="15%">
					任务编号
				</td>
				<td  align="left">
					<input type="text" class="noborder" readonly
						value="<%=yw_guid%>">
				</td>
				<td width="16%">
					巡查时间
				</td>
				<td width="32%" style="border-right:none;">
					<input type="text" class="noborder" id="begindate" name="begindate"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"    readonly style="width: 98%" />
				</td>
			</tr>
			<tr>
				<td>
					用地单位
				</td>
				<td  align="left">
					<input type="text" class="noborder" id="yddw" name="yddw" >
				</td>
				<td>
					用地时间
				</td>
				<td style="border-right:none;">
					<input type="text" class="noborder" id="ydsj" name="ydsj"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"    readonly style="width: 98%" />
				</td>
			</tr>
			<tr>
				<td>
					土地用途
				</td>
				<td   align="left">
					<select style="width:80%" id="tdyt" name="tdyt">
						<option selected="selected" value="商服用地">商服用地</option>
						<option  value="工矿仓储用地">工矿仓储用地</option>
						<option  value="住宅用地">住宅用地</option>
						<option  value="公共管理与公共服务用地">公共管理与公共服务用地</option>
						<option  value="水域及水利设施用地">水域及水利设施用地</option>
						<option  value="交通运输用地">交通运输用地</option>
						<option  value="特殊用地">特殊用地</option>
					</select>
				</td>
				<td>
					建设情况
				</td>
				<td align="left" style="border-right:none;">
					<select style="width:80%" id="jsqk" name="jsqk">
						<option selected="selected" value="平场">平场</option>
						<option value="在建">在建</option>
						<option value="建成">建成</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					用地情况
				</td>
				<td align="left">
					<select style="width:80%" id="ydqk" name="ydqk">
						<option selected="selected" value="合法">合法</option>
						<option value="违法违规">违法违规</option>
						<option value="伪变化">伪变化</option>
					</select>
				</td>
				<td>
					地方查处情况
				</td>
				<td align="left" style="border-right:none;">
					<select style="width:80%" id="dfccqk" name="dfccqk">
						<option selected="selected" value="未立案">未立案</option>
						<option value="已立案未结案">已立案未结案</option>
						<option value="已结案">已结案</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					违法违规类型
				</td>
				<td colspan="3" style="border-right:none;" align="left">
					<select  id="wfwglx" name="wfwglx" >
						<option selected="selected" value="非法批地">非法批地</option>
						<option value="未报即用">未报即用</option>
						<option value="边报边用">边报边用</option>
						<option value="未供先用">未供先用</option>
						<option value="批而未征">批而未征</option>
						<option value="闲置">闲置</option>	
						<option value="违反产业政策">违反产业政策</option>
						<option value="违反招拍挂">违反招拍挂</option>
						<option value="补偿不到位">补偿不到位</option>
						<option value="其他">其他</option>
					</select>
				</td>
			</tr>
			<tr style="border-bottom:none;">
				<td>
					现场情况描述
				</td>
				<td colspan="3" style=" border-right:none;">
					<textarea rows="5" cols="70" name="xcqkms" id="xcqkms" style="width: 99%"></textarea>
				</td>
			</tr>
		</table>
		</form>
		<% 
			if (map != null) { 
		%>
		<center>
			<div class="container" id="idContainer2" align="center" >
				<ul id="idSlider2">
					<%
						String[] images = map.get("ZPBH") == null ? null : map.get(
									"ZPBH").toString().split(",");
							if (images != null) {
								for (int i = 0; i < images.length; i++) {
					%>
					
						<img 
							src="ftp://<%=username%>:<%=password%>@<%=host%>:<%=port%>/<%=images[i]%>.jpg"
							alt="图片上传预览" />
					<br/>

					<%
						}
					%>
				</ul>
				<ul class="num" id="idNum">
				</ul>
			</div>
			<br />
			<%
				}
			%>
		</center>
		<%
			}
		%>
	</body>
<script>
<%
	String msg = (String)request.getParameter("msg");
%>
if("<%=msg%>" == "success"){
	alert("表单保存成功");  
}
</script>	
</html>
