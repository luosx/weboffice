<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String guid  = request.getParameter("guid");
 	String xmmc = request.getParameter("xmmc");
 	String yddw = request.getParameter("yddw");
	String ydsj = request.getParameter("ydsj");
	String ydwz = request.getParameter("ydwz");
	String ydxz = request.getParameter("ydxz");
	String jsqk = request.getParameter("jsqk");
	String xcr = request.getParameter("xcr");
	String xcrq = request.getParameter("xcrq");
	String bz = request.getParameter("bz");
	String imgname = request.getParameter("imgname");
%>
<html>
        <frameset rows="210,*">
 					<frame src="showBaseInfo.jsp?guid=<%=guid%>&xmmc=<%=xmmc%>&ydwz=<%=ydwz%>&yddw=<%=yddw%>&ydsj=<%=ydsj%>&jsqk=<%=jsqk%>&ydxz=<%=ydxz%>&xcr=<%=xcr%>&xcrq=<%=xcrq%>&bz=<%=bz%>&imgname=<%=imgname%>" noresize frameborder=0 scrolling="no"/>   
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