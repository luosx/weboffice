<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="com.klspta.web.cbd.jtfx.ztt.ZttDeal"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String zttId=request.getParameter("zttbh");
String url=basePath+ZttDeal.getInstance().getMapURL(zttId);

%>
<script type="text/javascript">
document.location.href='<%=url%>'
</script>
