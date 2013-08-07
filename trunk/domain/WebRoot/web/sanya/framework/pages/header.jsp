<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String resourcePath=basePath+"common/pages/homepage";
String name = ProjectInfo.getInstance().PROJECT_NAME;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
body{
    background-image: url(<%=basePath%>common/pages/homepage/images/izbft3.gif);
}
table {border-collapse:collapse;
background-color:#FFF;} 
td,th {border:1px solid black;text-align:center; height:26px;} 
a:link { color:#dd3409;text-decoration:none; font-size:13px; }/* 超链接的样式 */
a:visited { color:#9f301d;text-decoration:none; }
a:visited:hover { color:#9f301d;text-decoration:underline; }
a:hover { color:#dd3409;text-decoration:underline; }
a:active { color:#ff3300;text-decoration:underline; }

</style>
<script>
var url='<%=basePath%>model/report/wfxsclqk/chart.jsp?xml=wfxsclqk.xml';
var inner='统计表';
function openUrl(){
parent.content.location.href=url;
if(inner=='统计表'){
url='<%=basePath%>model/report/wfxsclqk/chart.jsp?xml=wfxsclqk2.xml';
inner='线索类型比例';
document.getElementById("pie").innerHTML=inner;
}else if(inner=='线索类型比例'){
url='<%=basePath%>model/report/wfxsclqk/chart.jsp?xml=wfxsclqk3.xml';
inner='地矿违法趋势';
document.getElementById("pie").innerHTML=inner;
}else if(inner=='地矿违法趋势'){
url='<%=basePath%>model/report/wfxsclqk/chart.jsp?xml=wfxsclqk4.xml';
inner='政区环比';
document.getElementById("pie").innerHTML=inner;
}else if(inner=='政区环比'){

url='<%=basePath%>web/<%=name%>/framework/pages/right.jsp';
inner='违法性质';
document.getElementById("pie").innerHTML=inner;
}
else if(inner=='违法性质'){
url='<%=basePath%>model/report/wfxsclqk/chart.jsp?xml=wfxsclqk.xml';
inner='统计表';
document.getElementById("pie").innerHTML=inner;
}
}
</script>
<body>
<font size="1"   style="color:#000000;font-size: 12px;"><strong>
<table height="28" width="100%"  border="0" cellpadding="0" cellspacing="0" background='../images/izbft2.gif'>
<tr> 
<td style='border:0;background-repeat:no-repeat;' width='180' background='../images/izbft.gif' height='28'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;违法线索处理情况</td>
<td style='border:0;' width='30%'>
</td>
<td style='border:0;' ><a href='#' onclick="alert('导出excel')"></a></td>
<td style='border:0'width='100'><a id='pie' href='#' onclick='openUrl();return false;'>统计表</a></td>
<td style='border:0;' width='20%'>
<input type="radio" name="month" value="thisMonth" checked="checked">本月
<input type="radio" name="month" value="preMonth" >上月
</td>
<td style='border:0;float:right;' width='28'><img src='../images/izbft4.gif'></td>
</tr>
</table>
</strong>
</font>

</body>
</html>
