<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.common.security.User"%>
<%@page import="com.klspta.common.menu.MenuBean"%>
<%@page import="com.klspta.common.organization.MemoListUtils"%>
<%@ taglib uri="/WEB-INF/taglib/mainmenu.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userId=null;
    String fullName="";
    if (principal instanceof User) {
    	 userId = ((User)principal).getUserID();
    	 fullName = ((User)principal).getFullName();
    } else {
    	 userId =null;
    	fullName = principal.toString();
    }
    List<MenuBean> menuBeanList=MemoListUtils.getInstance().getMemoMenuBeanListByUserId(userId);
    int count=0;
    for(int i=0;i<menuBeanList.size();i++){
    	MenuBean mb=menuBeanList.get(i);
    	if((mb.getMenuType()).equals("1")){
	       count++;
    	}
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察系统</title>	
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/common/include/ext.jspf" %>
		<script src="<%=basePath%>/gisapp/js/menuOperation.js" type="text/javascript"></script>
   <style>	
		.menu {background:url(<%=basePath%>/gisapp/pages/images/back.jpg) repeat-x; height:29px; padding-left:10px;font-size:12px;}
		.menu ul {margin:0px; padding:0px; list-style:none; text-align:left;width:1024px;}
		.menu li {
		display:inline; 
		line-height:29px;
		width:71px;
		 }
		li.li_separator{
			width:2px;
			height:29px;
			background-image:url(<%=basePath%>/gisapp/pages/images/back_split.PNG);
			background-repeat:no-repeat;
		}
		.menu li a {color:#ffffff; text-decoration:none; font-weight:bold; padding:0px 0px 0px 0px; border:0px solid red;width:71px;
				text-align:center;}
		.menu li a.tabactive { color:#DD6F00; 
		height:29px;
		background:url(<%=basePath%>/gisapp/pages/images/back_active.PNG)  no-repeat ;align:center;
		padding:0px 0px 1px 0px; 
		font-weight:bold;font-size:12px;}
		.divclass{height:20px;  
		 background:url(<%=basePath%>/gisapp/pages/images/back1.PNG) repeat-x;
		 padding-top:3px; font-size:12px;
		 }
		a{
			color:#00509F; 
			text-decoration:none;
		 }
		a:hover{
			color:#DD6F00;
		}
</style>
<script language="javascript" type="text/javascript">
		function getid(id){
		    return document.getElementById(id);
		}		
		var tablink_id = "tablink"
		var tabcontent_id = "tabcontent" 
		function easytabs(active){ 
		   for (i=0; i <= <%=count%>; i++){
			   document.getElementById(tablink_id+i).className='tab'+i;
			   document.getElementById(tabcontent_id+i).style.display = 'none';
		   }
		   document.getElementById(tablink_id+active).className='tab'+active+' tabactive';   
		   document.getElementById(tabcontent_id+active).style.display = 'block';
		 }
		 
		window.onload=function(){
		     easytabs('0','<%=count%>');
		}
	    function changeLocation(id,name,east,center){
           top.lower.execute(id,name,center,east);
        }
        function logout(){
          top.location.href='<%=basePath %>j_spring_security_logout';
        }
</script>
 </head>
	<body>
		 <common:mainMenu/>
	</body>
</html>
