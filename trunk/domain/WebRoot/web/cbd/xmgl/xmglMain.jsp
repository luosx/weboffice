<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String type=request.getParameter("type");
String editor=request.getParameter("editor");
Xmmanager hxzm=Xmmanager.getXmmanager();
List<Map<String, Object>> list=hxzm.getHXXM();
String yw_guid="";
String xmmc="";
if(list.size()>0){
yw_guid=list.get(0).get("yw_guid").toString();
xmmc=list.get(0).get("xmname").toString();

}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>content</title>
</head>
	<frameset id="zzjg" name="zzjg" cols="200,*" frameborder="no" border="0" framespacing="0" >
		<frame id="left" name="left" scrolling="NO" noresize
			src="<%=basePath%>web/cbd/xmgl/hxxmList.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>&type=<%=type%>&editor=<%=editor %>" />
		<frame id="right" name="right" scrolling="NO" noresize
			src="<%=basePath%>web/cbd/xmgl/contentTab.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>&type=<%=type%>&editor=<%=editor %>" />		
	</frameset>
</html>