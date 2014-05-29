<%@page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察统计分析</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script type="text/javascript">
		
		 function post(URL, PARAMS) {      
			    var temp = document.createElement("form");      
			    temp.action = URL;      
			    temp.method = "post";      
			    temp.style.display = "none";      
			    for (var x in PARAMS) {      
			        var opt = document.createElement("textarea");      
			        opt.name = x;      
			        opt.value = PARAMS[x];      
			        // alert(opt.name)      
			        temp.appendChild(opt);      
			    }      
			    document.body.appendChild(temp);      
			    temp.submit();      
			    return temp;      
			}      
		 function init(){
			 	var url = "<%=basePath%>web/cbd/tjbb/chart.jsp";
			 	var lbxx = "世界城,新街大院,光辉里小区,东大桥东里,向军南里,温莎大道,建外SOHO,金地国际花园,延静西里,红庙北里社区,人民日报社家属区,华业国际公寓,延静里中街小区,金台里,呼家楼北里,呼家楼南里,呼家楼西里,华业国际公寓,华贸国际公寓,东区国际,水碓子东路,核桃园北里,秀水园,道家园";
			 	lbxx = encodeURI(lbxx);
			 	var params = "{xml:'esfzj.xml',lbxx:lbxx}"
			 	post(url,params);
				document.getElementById("east").src=''></iframe>";
			}
		</script>
	</head>
	
	<body  onload="init();">
	<div style="width: 100%;height: 100%;">
	<div id="divLeft" style="width: 20%; height:100%; overflow: hidden; float: left;">
		<iframe id="west" name="west" class="div1" style="height: 100%; overflow: auto; " src="<%=basePath%>web/cbd/qyjc/esfzj/esfzjqsfxFrame.jsp"></iframe>
	</div>
	<div id="divmain" style="width: 80%;height: 100%; border: none 0px;float: right;">
		<iframe id="east" name="east" class="div2" style="width:100%;height: 100%; overflow: auto; " src=''></iframe>
	</div>

		
		
	</div>
	</body>
	</body>
</html>










