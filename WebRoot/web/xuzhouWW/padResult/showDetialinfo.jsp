<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String yw_guid  = request.getParameter("yw_guid");
 	String xmmc = request.getParameter("xmmc");
 	String xzqmc = request.getParameter("xzqmc");
	String rwlx = request.getParameter("rwlx");
	String sfwf = request.getParameter("sfwf");
	String xcr = request.getParameter("xcr");
	String xcrq = request.getParameter("xcrq");
	String xz = request.getParameter("xz");
	String zmj = request.getParameter("zmj");
	String imgname = request.getParameter("imgname");
	String xcqkms = request.getParameter("xcqkms");
%>
<html>
        <frameset rows="210,*">
 					<frame src="showBaseInfo.jsp?yw_guid=<%=yw_guid %>&xmmc=<%=xmmc%>&xzqmc=<%=xzqmc%>&rwlx=<%=rwlx%>&sfwf=<%=sfwf%>&xcr=<%=xcr%>&xcrq=<%=xcrq%>&xz=<%=xz%>&zmj=<%=zmj%>&xcqkms=<%=xcqkms %>" noresize frameborder=0 scrolling="no"/>   
                	<% if(imgname == null || imgname.equals("")){
                	%>
                		<frame src="showImage.jsp?image=no_picture" scrolling="NO" noresize frameborder=0/>
                	<%
                		}else{
                	%>
                		<frame src="showImage.jsp?image=<%=imgname%>"  noresize frameborder=0/>
                	<%	
                		}
					%>          
        </frameset>
</html>