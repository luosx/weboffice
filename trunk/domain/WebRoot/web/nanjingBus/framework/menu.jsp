<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/web/nanjingBus/framework/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>南京智能公交监察系统</title>
	
    <script src="<%=basePath %>/js/jquery-1.8.1.js" type="text/javascript"></script>
	<script src="<%=basePath %>/js/Telerik.Web.UI.WebResource.js" type="text/javascript"></script>
	<link href="<%=basePath %>/css/default.css" type="text/css" rel="stylesheet" /><title>
	
</title></head>
<body>
    <form method="post" action="" id="form1">

    <div class="maincontainer">
        <script type="text/javascript">
            function changeMenusBg(classname, mthis) {
                if ($(mthis).hasClass(classname)) {
                    $(mthis).removeClass(classname);
                    $(mthis).addClass(classname + "hover");
                } else {
                    $(mthis).removeClass(classname + "hover");
                    $(mthis).addClass(classname);
                }
            }
            function changePage(arg0) {
                
            }
        </script>
        <div class="mainmenus">
            <ul style="margin-left:550px;">
                <li class="menu1" onmouseover="changeMenusBg('menu1',this)" onmouseout="changeMenusBg('menu1',this)" onclick="window.parent.frames['content'].showMenu();"></li>
                <li style="margin-left: 30px;" class="menu2" onmouseover="changeMenusBg('menu2',this)" onmouseout="changeMenusBg('menu2',this)" onclick="window.parent.frames['content'].showInfoMenu();"></li>   				
            </ul>
        </div>
        <div class="bannerleft">
            <div class="bannerright">
                <div class="bannermiddle">
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    </form>
</body>
</html>
