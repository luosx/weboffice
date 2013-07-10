<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="com.klspta.web.xuzhouWW.carmonitor.GpsDeviceManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = ProjectInfo.PROJECT_NAME;

String puid=request.getParameter("puid");
String carname=request.getParameter("carname");
if(carname!=null){
   carname=new String(carname.getBytes("ISO-8859-1"), "gbk");
   List<Map<String,Object>> rs=new GpsDeviceManager().getCarInfoByCarName(carname);
   puid=rs.get(0).get("CAR_FLAG").toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>视频监控</title>
</head>
  <frameset cols="0.5,0.5" frameborder="no" border="0" framespacing="0">
    <frame src="<%=basePath%>web/<%=name%>/videoMonitor/popIn.html?puid=<%=puid%>&ivIndex=1" scrolling="auto" noresize="noresize" />
    <frame src="<%=basePath%>web/<%=name%>/videoMonitor/popOut.html?puid=<%=puid%>&ivIndex=0"  scrolling="no" noresize="noresize" />
  </frameset>
</html>