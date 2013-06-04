<%@ page language="java" pageEncoding="utf-8"%>

<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Iterator"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	StringBuffer sb = new StringBuffer();
	Map maps = request.getParameterMap();
	Iterator its = maps.entrySet().iterator();
	while (its.hasNext()) {
		Entry entry = (Entry) (its.next());
		String key = entry.getKey().toString().trim();
		String value = new String(request.getParameter(key).trim().getBytes("ISO-8859-1"), "utf-8");
		int i = value.indexOf("\"");
		if (i != -1) {
			int a = value.indexOf("\"", i + 1);
			value = value.substring(i + 1, a);
		}
		sb.append(key + "=" + value);
		if (its.hasNext()) {
			sb.append("&");
		}
	}

	String yw_guid = request.getParameter("yw_guid");
	String returnPath = request.getParameter("returnPath");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>待办任务处理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<script>
			function la(){
			    var parameter="zfjcType=7&yw_guid=<%=yw_guid%>&flag=1&lyType='DTXC'&returnPath=<%=returnPath%>";
			    var result=window.showModalDialog("<%=basePath%>web/jinan/dtxc/xccg/laccORfgb.jsp?"+parameter,window,"dialogWidth=300px;dialogHeight=200px;status=no;scroll=no"); 
	            if(result[0]=="1")//选择的是“法规办”
	            {
		        	 location.href="<%=returnPath%>";
		     	}
		     	if(result[0]=="3")//选择的是"立案查处"
		     	{  
		     	 var path=result[1];
		     	 	location.href="<%=basePath%>"+path+"&returnPath=<%=returnPath%>";
		     	}
			}
</script>
	</head>
	<frameset id="main" rows="30,*" frameborder="no" border="0"
		framespacing="0">
		<frame id="upper" name="upper" scrolling="NO" noresize
			src="<%=basePath%>web/jinan/dtxc/xccg/la.jsp?<%=sb.toString()%>" />
		<frame id="lower" name="lower" scrolling="NO" noresize
			src="<%=basePath%>model/resourcetree/resourceTree.jsp?<%=sb.toString()%>" />
	</frameset>
</html>
