<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.xiamen.xchc.XchcData"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String flag = request.getParameter("flag");
	String zfjcType = request.getParameter("zfjcType");
	String edit = "true";
	edit = request.getParameter("edit");
	StringBuffer sb = new StringBuffer();
	Map maps = request.getParameterMap();
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userid = ((User)principal).getUserID();
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
	if(!maps.containsKey("yw_guid")){
		//yw_guid不存在时，创建一个新的yw_guid
		String yw_guid = new XchcData().SetNewRecord(userid);
		sb.append("&yw_guid=").append(yw_guid);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>动态巡查成果</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script>
</script>
	</head>
	<frameset id="main" frameborder="no" border="0"
		framespacing="0">
		<frame id="lower" name="lower" scrolling="NO" noresize
			src="<%=basePath%>model/resourcetree/resourceTree.jsp?<%=sb.toString()%>&edit=<%=edit%>&zfjcType=<%=zfjcType %>"/>
	</frameset>
</html>
