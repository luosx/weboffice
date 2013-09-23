<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String type = request.getParameter("type");
	String yw_guid = request.getParameter("yw_guid");
	String keyWord = request.getParameter("keyWord");
	if(keyWord != null){
		keyWord = new String(keyWord.getBytes("ISO8859-1"),"UTF-8");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>信访案件</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
	<frameset id="main" rows="30,*" frameborder="no" border="0" framespacing="0">
		<frame id="upper" name="upper" scrolling="NO" noresize
			src="web/jizeNW/xfjb/xfdj/back.jsp?type=<%=type%>" />
		<frame id="lower" name="lower" scrolling="NO" noresize
			src="web/jizeNW/xfjb/xfdj/xfajTab.jsp?enterFlag=flag&yw_guid=<%=yw_guid%>&keyWord=<%=keyWord%>" /><!-- 这里添加的enterFlag=flag是为了标识表单是从待办或已办中进入，不是从新增中进入 -->
	</frameset>
</html>