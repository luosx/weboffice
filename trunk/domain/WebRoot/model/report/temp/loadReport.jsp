<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Map.Entry"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";

    //取出查询条件的检索信息
    StringBuffer sb = new StringBuffer();
    Map map = request.getParameterMap();
    Iterator it = map.entrySet().iterator();
    while (it.hasNext()) {
        Entry entry = (Entry) (it.next());
        String id = entry.getKey().toString().trim();
        String value = new String(request.getParameter(id).trim().getBytes("ISO-8859-1"), "utf-8");
        int i = value.indexOf("\"");
        if (i != -1) {
            int a = value.indexOf("\"", i + 1);
            value = value.substring(i + 1, a);
        }
        sb.append(id + "=" + value);
        if (it.hasNext()) {
            sb.append("&");
        }
    }
%>
<html>
	<frameset id="main" name="main" rows="10,70,20" frameborder="no"
		border="1" framespacing="0">
		<frame id="report" name="report" scrolling="no" noresize />
		<frame id="report" name="report" scrolling="no" noresize
			src="<%=basePath%>model/report/result.jsp?<%=sb.toString()%>" />
		<frame id="export" name="export" scrolling="no" noresize
			src="<%=basePath%>model/report/filedownload.jsp?<%=sb.toString()%>" />
	</frameset>
</html>
