<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.jtfx.scjc.ScjcManager"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String list = ScjcManager.getInstcne().getList2();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<base href="<%=basePath%>">
<title>二手房租售情况录入</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/base/include/restRequest.jspf"%>
</head>
<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.tr01 {
	background-color: #C0C0C0;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
</style>
<script type="text/javascript">
var yw_guid_xh_value="";


	function insert() {
	  var sj=yw_guid_xh_value;
		putClientCommond("scjcManager", "insert");
		putRestParameter("sj",sj);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
			
		}

	}
	function chang(yw){
	if(yw_guid_xh_value!=null&&yw_guid_xh_value!=""){
		 yw_guid_xh_value=yw_guid_xh_value+"@"+yw.id+"_"+yw.value
	}else{
	 yw_guid_xh_value=yw.id+"_"+yw.value}
	
	}
</script>
<body>
	<div align="center">
		年度： <select>
			<option value=2010>2010年</option>
			<option value=2010>2011年</option>
			<option value=2010>2012年</option>
			<option value=2010>2013年</option>
			<option value=2010>2014年</option>
			<option value=2010>2015年</option>
			<option value=2010>2016年</option>
			<option value=2010>2017年</option>
			<option value=2010>2018年</option>
			<option value=2010>2019年</option>
			<option value=2010>2020年</option>
		</select> 月份： <select>
			<option value=1>1月</option>
			<option value=2>2月</option>
			<option value=3>3月</option>
			<option value=4>4月</option>
			<option value=5>5月</option>
			<option value=6>6月</option>
			<option value=7>7月</option>
			<option value=8>8月</option>
			<option value=9>9月</option>
			<option value=10>10月</option>
			<option value=11>11月</option>
			<option value=12>12月</option>
		</select>
		<button onClick='insert()'>保存</button>
		<button onClick="javascript:window.location.href='esfscjcxxwh.jsp'">返回</button>
		<%=list%>
</body>
</html>
