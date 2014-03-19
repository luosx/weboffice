<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/web/nanjingBus/framework/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>空气质量预报</title>

    <script src="<%=basePath %>/js/jquery-1.8.1.js" type="text/javascript"></script>
<script src="<%=basePath %>/js/Telerik.Web.UI.WebResource.js" type="text/javascript"></script>
<link href="<%=basePath %>/css/Default.css" type="text/css" rel="stylesheet" /><title>

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
                var urls = ["flexviewer/index.html", "AQIOfHour.aspx", "AQIOfDay.aspx", "RealData.aspx", "APIOfHour.aspx", "APIOfDay.aspx","AQIForecast.aspx","#"];
                window.location.href = urls[arg0] + "?random=" + new Date().getTime();
            }
        </script>
        <div class="mainmenus">
            <ul>
                <li class="menu1" onmouseover="changeMenusBg('menu1',this)" onmouseout="changeMenusBg('menu1',this)" onclick="changePage(0)"></li>
                <li class="menu2" onmouseover="changeMenusBg('menu2',this)" onmouseout="changeMenusBg('menu2',this)" onclick="changePage(1)"></li>
                <li class="menu3" onmouseover="changeMenusBg('menu3',this)" onmouseout="changeMenusBg('menu3',this)" onclick="changePage(2)"></li>
                <li class="menu4" onmouseover="changeMenusBg('menu4',this)" onmouseout="changeMenusBg('menu4',this)" onclick="changePage(3)"></li>
				<li class="menu5" onmouseover="changeMenusBg('menu5',this)" onmouseout="changeMenusBg('menu5',this)" onclick="changePage(4)"></li>
				<li class="menu6" onmouseover="changeMenusBg('menu6',this)" onmouseout="changeMenusBg('menu6',this)" onclick="changePage(5)"></li>
				
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
